Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6BC388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4E208A9
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417581AbgJYRP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 13:15:28 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42547 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbgJYRP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 13:15:27 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kWjc0-0001Gy-Cg; Sun, 25 Oct 2020 17:15:21 +0000
Subject: Re: Feature request: Exponential search in git bisect
To:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Manuel_B=c3=a4renz?= <manuel@enigmage.de>
Cc:     git <git@vger.kernel.org>
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
 <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email>
Date:   Sun, 25 Oct 2020 17:15:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Manuel,

On 10/10/2020 10:22, Christian Couder wrote:
> On Fri, Oct 9, 2020 at 9:35 PM Manuel Bärenz <manuel@enigmage.de> wrote:
>> This feature was requested 8 years ago and briefly discussed:
>> https://public-inbox.org/git/20120318212957.GS1219@chaosreigns.com/
>>
>>
>>   TL;DR
>>
>> Before doing git bisect, I want to use exponential search to
>> automatically find a good commit, in logarithmic time.
> Ok, but the conclusion of the above discussion is that the problem
> with this idea is being able to distinguish between a commit that is
> bad and a commit where the feature that you want to test cannot be
> tested for example because it hasn't been implemented yet.

Does any of the proposed improvement in the "bisect: loosen halfway()
check for a large number of commits"
https://lore.kernel.org/git/20201022103806.26680-1-szeder.dev@gmail.com/
assist in this.

Or is the problem still with the need for a three way test that shows
Too_Old / Good / Bad ?

>
>>   Scenario
>>
>>   * I have a bug in HEAD.
>>   * I strongly suspect that it was introduced some time ago, but I don't
>>     know when exactly.
>>   * I have an automated test that will find the bug if the test can run
>>     properly.
>>   * Most of the commits in the repository are not testable, i.e. the
>>     test doesn't run properly. (E.g. because the feature it tests wasn't
>>     introduced yet, refactoring, etc.)
>>   * I have no idea what a good commit might be, because I don't know
>>     when the first /testable/ good commit is.
> Ok, so your test cannot distinguish between a bad commit and a commit
> where the feature hasn't been implemented.
>
> When you say that most of the commits in the repository are not
> testable, it usually means that the feature has been implemented
> relatively recently compared to the history of the project.
>
>> This sounds like a standard application for git bisect. No matter how
>> big the repo, with binary search we would expect to find the first bad
>> commit in logarithmic time.
> Not necessarily. If you cannot distinguish in any way between a bad
> commit and a commit where the feature hasn't been implemented, then it
> might be very difficult to find a good commit. And you need a good
> commit before you can properly bisect.
>
> Suppose for example that the first bad commit (the commit that
> introduced the bug you are looking for) is a direct child of the
> commit that introduced the feature. Then unless you are very lucky any
> binary search using your script will only test either bad commits or
> commits where the feature hasn't been implemented yet, and it is
> unable to distinguish between them in your scenario.
>
>>   Failed attempt
>>
>> The zeroth idea might be trying to find the good commit by hand, by
>> reading changelogs, by trying some commits, whatever. In some
>> situations, this is not feasible. In fact, such situations occur
>> frequently for me, for example for undocumented features, unversioned
>> rolling releases, incidental complexity leading to older commits not
>> being testable, etc.
> I understand that it's not always easy to find a good commit.
>
>> The first idea that comes to mind - and it was recommended 8 years agos,
>> and I've tried it a few times already - is to simply mark the root
>> commit as good. (Now, there might be several roots, but that's a puzzle
>> you typically only have to figure out once per repo.) This sounds great
>> in theory because binary search should get through the good old commits
>> in logarithmic time.
> It is not necessarily a good idea to do that. And in the thread, what
> was actually suggested by Peff (Jeff King) was to test released
> versions (for example 1.6.0, 1.7.0, etc in the Git code base).
>
>> The problem with this approach is that if most older commits are
>> untestable, I have to git bisect skip them.
> Skipping untestable commits is not always the right thing to do. If
> you know that they are untestable because the feature has not been
> implemented yet, it might be better to mark them as good instead.
>
> This is by the way what an ideal script should do. It should mark
> commits where the feature has not been implemented yet as good, and
> should "skip" only the commits where the feature has already been
> implemented but that are not testable for another reason, like another
> "temporary" bug or "temporary" compile failures.
>
>> This basically kills the
>> logarithmic performance, because bisect skip doesn't do binary search,
>> but something rather random.
> I would say that the actual reason here is that bisect skip is used
> when it shouldn't be used.
>
>> Just yesterday I killed a bisect search
>> that took hours because it kept skipping and didn't find actual good
>> commits.
> Ok.
>
>> You might say that instead of skipping old commits, one should mark them
>> as good.
> Yes, they should be marked as good when the feature has not been
> implemented yet.
>
>> That's problematic because then I might accidentally mark a
>> commit as good that was already untestable bad. Given that bisect has no
>> undo functionality, that can quickly mess up my search. Distinguishing
>> untestable good from untestable bad is really hard automatically. I
>> shouldn't have to do that.
> Sometimes it's not very difficult to test if the feature has been
> implemented yet or not. For example with Git you could check if an
> option for a command has been implemented by just checking if it
> appears in the doc. So the bisection script could first check that and
> exit 0 (which means good) if the option doesn't appear in the doc. If
> it appears in the doc, then it could do the regular test: "skip" if
> untestable, "good" if there is no bug, "bad" otherwise.
>
>> Long story short: Going from the root commit typically isn't feasible.
>> I've tried it.
> It seems that you might not have tried in the best possible way.
>
>>   Proposal: Exponential search
>>
>> Instead of going from the root commit, what I do manually before
>> starting git bisect is this:
>>
>> git checkout HEAD~10
>> ./test.sh # Says: "Bug is present"
>> git checkout HEAD~20
>> ./test.sh # Says: "Bug is still present"
>> git checkout HEAD~40
>> ./test.sh # Says: "Bug is still present"
>> [...] # Proceed exponentially
>> git checkout HEAD~640
>> ./test.sh # Says: "Bug is GONE!"
>> git bisect good
> If your script cannot distinguish between a bad commit and a commit
> where the feature hasn't been implemented, then you were lucky that
> that HEAD~640 was good. If the feature had been introduced between
> HEAD~639 and HEAD~321 then your script would have said  "Bug is still
> present".
>
>> This technique is known as
>> https://en.wikipedia.org/wiki/Exponential_search, and it works very well
>> in practice. I find a good commit long before I enter the "untestable
>> good" region.
> If you are lucky, yes, you find a good commit long before you enter
> the "untestable good" region.
>
>> But it's tedious to do this manually. In this example, I
>> needed to run the script 8 times manually, but of course it can be more
>> often, and compiling and running the test may take time. This is ok for
>> a one-off search, but it's tedious for regular usages.
>>
>> Yes, I could wrap this up in a shell script, but I guess there are
>> caveats that I didn't think of when the history isn't linear. Maybe
>> someone even already has, and I'm unaware of that. But it feels like
>> this could be a proper git bisect feature, and a very useful one.
> I agree that it could be useful. It could be especially useful if
> people have a script that can actually distinguish between a bad
> commit and a commit where the feature hasn't been implemented.
>
> So if someone plans to implement that in Git, particular care in the
> documentation should be taken to explain the issues related to testing
> a feature when it might not be implemented yet.

