Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289AC55179
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD0B22210
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764664AbgJXVjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 17:39:37 -0400
Received: from crypt.org ([89.187.75.214]:42214 "EHLO crypt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764583AbgJXVjh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 17:39:37 -0400
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Oct 2020 17:39:36 EDT
Received: from crypt.org (crypt.org [127.0.0.1])
        by crypt.org (8.11.6/8.11.2) with ESMTP id 09OKJTP13180;
        Sat, 24 Oct 2020 21:19:29 +0100
Message-Id: <202010242019.09OKJTP13180@crypt.org>
To:     git@vger.kernel.org
cc:     hv@crypt.org
Subject: safer git?
Date:   Sat, 24 Oct 2020 21:19:29 +0100
From:   hv@crypt.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, due to a hardware or firmware issue, my machine is currently crashing
rather a lot. If that happens around the time I'm performing any git
activity, it seems quite likely to cause substantial corruption of the
git state.

I've responded both by running sync(1) every 60 seconds and by pushing
work to github more frequently, but the latter isn't appropriate for
everything; twice recently I've lost a fair bit of work as a result.

Q: Is there a mode in which I can run git that would make it a bit more
robust against crashes, at the cost of being a bit slower?


The primary symptom is that files modified shortly before a crash show
up existing but zero-length after the crash. For source files I mostly
know what to do in that situation, but `git fsck` shows a lot of files
under '.git/objects' that are empty, which seems to make things hard
to recover:

% git fsck
error: object file .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533 is empty
error: unable to mmap .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533: No such file or directory
error: 0ef31631726cea2e9bf89d7bbe7b924b5282d533: object corrupt or missing: .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533
[... a dozen similar entries ...]
error: object file .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5 is empty
error: unable to mmap .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: No such file or directory
error: f5a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: object corrupt or missing: .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5
Checking object directories: 100% (256/256), done.
Checking objects: 100% (1577/1577), done.
error: refs/stash: invalid sha1 pointer 0000000000000000000000000000000000000000
error: bad ref for .git/logs/refs/stash
dangling commit 1c0ea4e6159952501957012d2b9db7d68b52d107
% 

Last time I checked out the previous state from github in a new
directory and was able to find and copy over most of my work before
continuing. On this occasion I did a `git stash save` shortly before
the crash, and I'm not sure how to get that back. I see René Scharfe's
suggestion of:
  git fsck --unreachable |
  grep commit | cut -d\  -f3 |
  xargs git log --merges --no-walk --grep=WIP
from a recent message, but that is only showing me an older stash item.

Thanks in advance for any suggestions,

Hugo van der Sanden
