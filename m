Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E76C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 19:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C2B239E5
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 19:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAITVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 14:21:36 -0500
Received: from colin.muc.de ([193.149.48.1]:24805 "HELO mail.muc.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
        id S1725978AbhAITVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 14:21:35 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jan 2021 14:21:35 EST
Received: (qmail 82766 invoked by uid 3782); 9 Jan 2021 19:14:13 -0000
Received: from acm.muc.de (p4fe15721.dip0.t-ipconnect.de [79.225.87.33]) by
        colin.muc.de (tmda-ofmipd) with ESMTP;
        Sat, 09 Jan 2021 20:14:13 +0100
Received: (qmail 26235 invoked by uid 1000); 9 Jan 2021 19:14:13 -0000
Date:   Sat, 9 Jan 2021 19:14:13 +0000
To:     git@vger.kernel.org
Subject: Difficulties of scripting git
Message-ID: <X/oAhdZlLwcFRCrR@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
From:   Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, git.

I want to write a bash script (more precisely, correct an existing
script) which uses git, and it is DIFFICULT!!!

I need a git pull in the script.  Fine, but how does the script know if
it's worked or not?  I couldn't find any description of a return code in
the git-pull man page (or in the git-merge man page).

The big problem is when I have modified, uncommitted files in the target
repo, and those same files are to be updated in commits coming from the
source repo.  Sadly, git is unable to merge these changes.  It just
fails, putting an error message onto stderr, but doesn't tell the
calling script in any way that I can see.

One idea would be always to call git stash before doing the pull, then
git stash pop afterwards.  Trouble is, git stash is unreliable - it
doesn't always add a new stash entry, so the stash pop at the end would
sometimes/often pop off an entry it shouldn't.  git stash doesn't have a
--force argument.  git stash doesn't set a result code, either, that I
can see.  One way around this would be to do

    $ git stash list | wc -l

both before and after the git stash and compare the answers, but really?

So, next idea, feed the output from git status --porcelain through grep
before and after the git pull, so as to find out whether there are any
modified files before the git pull (thus making a stash necessary) and
any files with conflicts after the git stash pop.  Shouldn't be too
difficult.

Except, how does one recognise a file with conflicts from this git
status output?  The man page says that

    "   For paths with merge conflicts, `X' and `Y' show the modification
    states of each side of the merge.  For paths that do not have merge
    conflicts, `X' shows the status of the index, and `Y' shows the status
    of the work tree.  For untracked paths, `XY' are `??'.  Other status
    codes can be interpreted as follows:  ...."

I've spent nearly an hour trying to make sense of this bit of man page.
How is one meant to distinguish an XY of a merge conflict from the XY of
an index/work tree entry?  I can't find that key bit of information
anywhere.

What am I missing?  Why does writing scripts using git have to be so
hard?

-- 
Alan Mackenzie (Nuremberg, Germany).
