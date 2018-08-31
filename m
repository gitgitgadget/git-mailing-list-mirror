Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E8A1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHaWWF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Aug 2018 18:22:05 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:57573 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeHaWWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:22:05 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831181326.OXIU4163.fed1rmfepo203.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:13:26 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id VuDR1y00459yGBo01uDRmb; Fri, 31 Aug 2018 14:13:25 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5B898545.0086,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Ip1uSP3g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=8nJEP1OIZ-IA:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=pGLkceISAAAA:8
 a=zqwwZkKUgpcNzaop1tYA:9 a=wPNLvfGTeEIA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 0F56829A00EF;
        Fri, 31 Aug 2018 11:13:25 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] wt-status.c: Set the commitable flag in the collect phase.
Date:   Fri, 31 Aug 2018 11:13:24 -0700
Message-ID: <1863304.0psXOz24iy@thunderbird>
Organization: Personal
References: <20180831053921.8083-1-ischis2@cox.net> <87a7p3c83g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 31, 2018 9:54:50 AM MST Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >> Leave the setting of the commitable flag in show_merge_in_progress. If
> >> a check for merged commits is moved to the collect phase then other
> >> --dry-run tests fail.
> 
> "Some tests fail" is not a good explanation why you keep the setting
> of commitable bit in the "show" codepath.  The test coverage may not
> be thorough, and the tests that fail might be expecting wrong things.
> 
I didn't figure it was, but I haven't yet figured out how to explain what what 
I saw last evening.   I wanted to send something out to get feedback from 
someone who may know the code far better than I.

> The change in this patch makes the internal "diff-index" invocation
> responsible for setting the commitable bit.  This is better for non
> merge commits than the current code because the current code only
> sets the commitable bit when longstatus is asked for (and the code
> to show the longstatus detects changes to be committed), so the
> short-form will not have chance to set the bit, but the internal
> "diff-index" is what determines if the resulting commit would have
> difference relative to the HEAD, so it is a better place to make
> that decision.
> 
> Merge commits need to be allowed even when the resulting commit
> records a tree that is identical to that of the current HEAD
> (i.e. we merged a side branch, but we already had all the necessary
> changes done on it).  So it is insufficient to let "diff-index"
> invocation to set the committable bit.  Is that why "other --dry-run
> tests fail"?  What I am getting at is to have a reasonable "because
> ..."  to explain why "other --dry-run tests fail" after it, to make
> it clear to the readers that the failure is not because tests are
> checking wrong things but because a specific condition 
thatwt_status_collect(), isYes
> expeted from the code gets violated if we change the code in
> show_merge_in_progress() function.
Agreed.  I'm just green at this code base, and so don't quite know what I 
should see as opposed to what I do see.

> 
> That brings us to another point.  Is there a case where we want to
> see s->commitable bit set correctly but we do not make any call to
> show_merge_in_progress() function?  It is conceivable to have a new
> "git commit --dry-run --quiet [[--] <pathspec>]" mode that is
> totally silent but reports if what we have is committable with the
> exit status, and for that we would not want to call any show_*
> functions.  That leads me to suspect that ideally we would want to
> see wt_status_collect_changes_index() to be the one that is setting
> the commitable bit.  Or even its caller wt_status_collect(), which
> would give us a better chance of being correct even during the
> initial commit.  For the "during merge" case, we would need to say
> something like
> 
> 	if (state->merge_in_progress && !has_unmerged(s))
> 		s->commitable = 1;
> 
I placed the following  in wt_status_collect() last evening, and received 
errors from three early tests in 7501-commit.sh.   Thanks for a hint.

	if (!has_unmerged(s))
		s->commitable = 1;

Maybe the missing first condition was what I needed.

Which leads me to asking:  Do you want a preparatory patch moving 
has_unmerged() further up in the file before adding a reference to 
has_unmerged() in wt_status_collect().  

> but the "state" thing is passed around only among the "print/show"
> level of functions in the current code.  We might need to merge that
> into the wt_status structure to pass it down to the "collect" phase
> at the lower level before/while doing so.  I dunno.
Would you explain what you  are thinking for passing moving the "stat" think 
into wt_status.    I haven't figured out how the "collect" sequence, relates 
to the "print/show" squence.

> 
> Thanks for working on this.
I decided sometime back to work on something I didn't know using a process I 
don't normally use to broaden my experience.   I'm enjoying this and hope you 
don't mind lots of questions from someone new.

sps



