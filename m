Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC44720A28
	for <e@80x24.org>; Wed, 20 Sep 2017 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdITNqo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 09:46:44 -0400
Received: from smtprelay09.ispgateway.de ([134.119.228.115]:9672 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdITNqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 09:46:43 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay09.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dufKn-0006fB-EH; Wed, 20 Sep 2017 15:46:37 +0200
Date:   Wed, 20 Sep 2017 15:46:33 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] add test for bug in git-mv for recursive submodules
Message-ID: <20170920134633.GA89070@book.hvoigt.net>
References: <20170817103413.GA52233@book.hvoigt.net>
 <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
 <20170818160603.GA69414@book.hvoigt.net>
 <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
 <20170915115021.GB76244@book.hvoigt.net>
 <xmqqlgleup78.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaycuiFuB1m0SiyKoZ6UyEBCMiipYXkavN+NNyCZaY1=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaycuiFuB1m0SiyKoZ6UyEBCMiipYXkavN+NNyCZaY1=Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 01:03:32PM -0700, Stefan Beller wrote:
> >> Took a little while but here is a more clean patch creating individual
> >> submodules for the nesting.
> >>
> >> Cheers Heiko
> 
> Thanks for writing this test!

No worries. :)

> > Thanks.  Stefan, does this look good to you now?
> 
> Yes, though there are nits below.
> 
> > It is not quite clear which step is expected to fail with the
> > current code by reading the test or the proposed log message.  Does
> > "mv" refuse to work and we do not get to run "status", or does
> > "status" report a failure, or do we fail well before that?
> 
> git-mv failing seems like a new possibility without incurring
> another process spawn with the new repository object.
> (Though then we could also just fix the recursed submodule)

It is mv that fails to update everything necessary when using it with
recursively nested submodules. So the git-mv command does not report a
failure here. As an interim fix it could maybe report an error when
encountering nested submodules but the real fix would be to teach it to
recursively spawn the appropriate git-mv commands.

> > The log message that only says "This does not work when ..." is not
> > helpful in figuring it out, either.  Something like "This does not
> > work and fails to update the paths for its configurations" or
> > whatever that describes "what actually happens" (in contrast to
> > "what ought to happen", which you described clearly) should be
> > there.
> >
> > Description on how you happened to have discovered the issue feels a
> > lot less relevant compared to that, and it is totally useless if it
> > is unclear what the issue is in the first place.

Sorry about being a bit brief here. How about dropping that information
how I discovered the bug then and change the commit message to something
like this:

    add test for bug in git-mv for recursive submodules

    When using git-mv with a submodule it will detect that and update
    the paths for its configurations (.gitmodules, worktree and
    gitfile). This does not work in case it encounters nested
    submodules. In that case it only updates the configurations for the
    submodule directly underneath the superproject and fails to update
    the paths for the submodules nested more deeply. This in turn leads
    to the symptom that git status reports that it can not chdir to the
    nested submodule in its old location.

    Lets add a test to document.

?

> >>  t/t7001-mv.sh | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> >> index e365d1ff77..cbc5fb37fe 100755
> >> --- a/t/t7001-mv.sh
> >> +++ b/t/t7001-mv.sh
> >> @@ -491,4 +491,29 @@ test_expect_success 'moving a submodule in nested directories' '
> >>       test_cmp actual expect
> >>  '
> >>
> >> +test_expect_failure 'moving nested submodules' '
> >> +     git commit -am "cleanup commit" &&
> >> +     mkdir sub_nested_nested &&
> >> +     (cd sub_nested_nested &&
> 
> We seem to have different styles for nested shell. I prefer
> 
>   outside command &&
>   (
>       first nested command here &&
>       ...
> 
> as that aligns indentation to the nesting level. I have seen
> the style you use a lot in the  test suite, and we do not have
> a guideline in Documentation/CodingGuidelines, so I do not
> complain too loudly. ;)

Yeah we have some different styles it seems ;) So here some reasoning
behind my style:

I actually would agree on your style if 'first nested command' was any
arbitrary command but when I use my style it is always when I use a
nested shell for changing into some directory, doing something there and
then being able to return to the previous directory by closing the nested
shell. So for me the 'cd somewhere' belongs to the brackets similarly
like a condition definition belongs to the if it is used with.

> >> +             touch nested_level2 &&
> >> +             git init &&
> >> +             git add . &&
> >> +             git commit -m "nested level 2"
> >> +     ) &&
> >> +     mkdir sub_nested &&
> >> +     (cd sub_nested &&
> >> +             touch nested_level1 &&
> >> +             git init &&
> >> +             git add . &&
> >> +             git commit -m "nested level 1"
> >> +             git submodule add ../sub_nested_nested &&
> >> +             git commit -m "add nested level 2"
> >> +     ) &&
> >> +     git submodule add ./sub_nested nested_move &&
> >> +     git commit -m "add nested_move" &&
> >> +     git submodule update --init --recursive &&
> 
> So far a nice setup!

Thanks.

> >> +     git mv nested_move sub_nested_moved &&
> 
> This is the offending command that produces the bug,
> as it will break most subsequent commands, such as

Yes.

> >> +     git status
> 
> git-status is one of the basic commands. Without
> status to function, I think it is hard to recover your repo without
> a lot of in-depth knowledge of Git (submodules).
> 
> I wonder if git-status should complain more gracefully
> and fallback to one of --ignore-submodules={dirty, all},
> that actually still works.
> 
> Maybe we could introduce a new default mode for this
> flag, that is "none-except-on-error", though this sounds
> as if we're fixing symptoms instead of the root cause.

I think we should rather fix the root cause. For me git-mv is actually
breaking the repository and as described above one possible interim
solution for me would be for 'git-mv' to error out and tell the user
that it does currently not work on recursively nested submodules.

Cheers Heiko
