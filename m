Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92FC1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 12:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfGKMZ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 08:25:28 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:14020 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfGKMZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 08:25:28 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C58F454363;
        Thu, 11 Jul 2019 14:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id TSClNAe-vzUm; Thu, 11 Jul 2019 14:25:00 +0200 (CEST)
Date:   Thu, 11 Jul 2019 14:24:52 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
Message-ID: <20190711122452.GC65621@book.hvoigt.net>
References: <20190704080907.GA45656@book.hvoigt.net>
 <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
 <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
 <20190710075835.GB65621@book.hvoigt.net>
 <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 10, 2019 at 11:40:50AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > behavior. How about '--all-include-head'. Then e.g.
> >
> >     git rev-parse --all-include-head --all --not origin/master
> >
> > would include the head ref like you proposed below?
> >
> > What do you think? Or would you rather go the route of changing
> > rev-parse behavior?
> 
> Depends on what you mean by the above.  Do you mean that now the end
> user needs to say
> 
> 	gitk --all-include-head --not origin/master
> 
> to get a rough equivalent of
> 
> 	git log --graph --oneline --all --not origin/master
> 
> due to the discrepancy between how "rev-parse" and "rev-list" treat
> their "--all" option?  Or do you mean that the end user still says
> "--all", and after (reliably by some means) making sure that "--all"
> given by the end-user is a request for "all refs and HEAD", we turn
> that into the above internal rev-parse call?

Sorry for being not specific enough. I would be aiming for the latter
and gitk would prepend --all-include-head to its rev-parse call. To have some
code to talk about something like this (based on your pointer and also not
compile tested):

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f8bbe6d47e..03928ee566 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -585,6 +585,7 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
        int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+       int all_include_head = 0;
        int did_repo_setup = 0;
        int has_dashdash = 0;
        int output_prefix = 0;
@@ -764,8 +765,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
                                }
                                continue;
                        }
+                       if (!strcmp(arg, "--all-include-head")) {
+                               all_include_head = 1;
+                               continue;
+                       }
                        if (!strcmp(arg, "--all")) {
                                for_each_ref(show_reference, NULL);
+                               if (all_include_head)
+                                       head_ref(show_reference, NULL);
                                clear_ref_exclusion(&ref_excludes);
                                continue;
                        }
diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b2..ddd1de5377 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -294,8 +294,8 @@ proc parseviewrevs {view revs} {
 
     if {$revs eq {}} {
        set revs HEAD
-    } elseif {[lsearch -exact $revs --all] >= 0} {
-       lappend revs HEAD
+    } else {
+       linsert revs 0 --all-include-head
     }
     if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
        # we get stdout followed by stderr in $err

> If the former, then quite honestly, we shouldn't doing anything,
> perhaps other than reverting 4d5e1b1319.  The users can type
> 
> 	$ gitk --all HEAD --not origin/master
> 	$ gitk $commit --not --all HEAD
> 
> themselves, instead of --all-include-head.

Yes the former would not make anything better.

> If the latter, I am not sure what the endgame should be.  

Please see the diff above.

> It certainly *is* safer not to unconditionallyl and unilaterally
> change the behaviour of "rev-parse --all", so I am all for starting
> with small and fully backward compatible change, but wouldn't
> scripts other than gitk want the same behaviour?  

Yes probably, but in my experience, if some behavior is around for a long time,
someone will rely on it and rev-parse seems like a candidate that might get
used in scripts for CIs or similar. E.g. in a bare repo someone might
explicitely want to omit HEAD.

> To put it the other way around, what use case would we have that we
> want to enumerate all refs but not HEAD, *and* exclude HEAD only
> when HEAD is detached?  I can see the use of "what are commits
> reachable from the current HEAD but not reachable from any of the
> refs/*?" and that would be useful whether HEAD is detached or is on
> a concrete branch, so "rev-parse --all" that does not include
> detached HEAD alone does not feel so useful at least to me.

What about my example. My use case is: Show me everything that is not merged
into a stable branch (i.e. origin/master). For a human viewer it does not
really matter if an extra detachted HEAD is shown, but for a CI script it
might. Ok this might be quite artificial, what do you think?

> I am reasonably sure that back when "rev-parse --all" was invented,
> the use of detached HEAD was not all that prevalent (I would not be
> surprised if it hadn't been invented yet), so it being documented to
> enumerate all refs does not necessarily contradict to include HEAD
> if it is different from any of the ref tips (i.e. detached).

I just dug up the old discussion to this to find some reasoning why this was
not changed. So you have changed your mind about this? [1]

> And if we cannot commit to changing the "rev-parse --all" (and I am
> not sure I can at this point---I am wary of changes), as we know
> where "--all" appeared on the command line, inserting HEAD immediately
> after it at the script level is probably the change with the least
> potential damage we can make, without changing anything else.

Well this should be better than the current solution. But there is still your
point about not taking -- into account. So how about my backwards compatible
suggestion above, what do you think?

Cheers Heiko

[1] https://public-inbox.org/git/xmqqsika2c2i.fsf@gitster.dls.corp.google.com/
