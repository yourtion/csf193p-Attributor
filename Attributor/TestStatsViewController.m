//
//  TestStatsViewController.m
//  Attributor
//
//  Created by Yourtion on 14-1-19.
//  Copyright (c) 2014年 Yourtion. All rights reserved.
//

#import "TestStatsViewController.h"

@interface TestStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLable;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacterLable;
@end

@implementation TestStatsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test"
                                                         attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
                                                                      NSStrokeWidthAttributeName : @3}];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self updateUI];
}
-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    [self updateUI];
}
-(NSAttributedString *)characterWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index ++;
        }
    }
    return characters;
}
-(void)updateUI
{
    self.colorfulCharactersLable.text = [NSString stringWithFormat:@"%d colorful characters",
                                         [[self characterWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharacterLable.text = [NSString stringWithFormat:@"%d outlined characters",
                                         [[self characterWithAttribute:NSStrokeWidthAttributeName] length]];
}
@end
