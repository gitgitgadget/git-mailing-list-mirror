Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19840C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CDC2074A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438464AbgJQQVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 12:21:16 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43329 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409937AbgJQQVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 12:21:16 -0400
X-Originating-IP: 103.82.80.232
Received: from localhost (unknown [103.82.80.232])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 36DE620004;
        Sat, 17 Oct 2020 16:21:13 +0000 (UTC)
Date:   Sat, 17 Oct 2020 21:51:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Why does git diff-index show intent-to-add file as "Added"?
Message-ID: <20201017162111.gvisfz2daqvhnjmb@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been trying to wrap my head around intent-to-add files to add 
support for them in git-gui and one point really confuses me.

Say I do:

  $ git add -N foo

git-gui uses `git diff-index --cached HEAD` to find out the status of 
the "staged changes" and `git diff-files` to find out the status of 
"unstaged changes".

In this case, running diff-files gives:

  :000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	foo

which tells git-gui that the file is "added" thanks to the 'A'. Makes 
sense. We can infer that the file in intent-to-add because untracked 
files are not listed by diff-files.

Running diff-index gives:

  :000000 100644 0000000000000000000000000000000000000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 A	foo

which tells git-gui that the file is added to the index thanks to the 
'A'. This makes less sense. The file has not been staged yet so why 
should it be listed as such?

This causes problems because we then end up showing the file in both the 
"Unstaged Changes" and the "Staged Changes" sections, even though the 
file has no staged changes at all. And `git status` says the same. It 
only lists foo in unstaged changes.

In addition, this makes it much more complicated to determine if a file 
marked as intent-to-add has some parts staged and some others unstaged. 
To determine that, I have to look at what diff-files says about the 
file. If it says 'A', then the file has no changes staged. If it says 
'M' then it does. This means I have to look at the status of the 
"unstaged changes" section to find out information about the "staged 
changes" section. This makes it much harder to write clean, isolated 
routines.

Is there something wrong with the mental model I'm using here? How does 
git-status figure these things out? Or is it really a design mistake? If 
so, what can we do to fix it?

-- 
Regards,
Pratyush Yadav
