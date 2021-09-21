Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4229CC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E00B60F23
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 07:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhIUHfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:35:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:36269 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhIUHfc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 03:35:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210381587"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210381587"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 00:34:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="532606716"
Received: from twallyn-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.83.37])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 00:34:03 -0700
Date:   Tue, 21 Sep 2021 00:34:02 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG REPORT] split-index behavior during interactive rebase
Message-ID: <20210921073402.cf4y3gp7yyfirfnq@ldmartin-desk2>
References: <20210916055057.GT3389343@mdroper-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210916055057.GT3389343@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 10:50:57PM -0700, Matt Roper wrote:
>What did you do before the bug happened? (Steps to reproduce your issue)
>
>  I activated split index mode on a repo ("git config core.splitIndex
>  true"), performed an interactive rebase, modified a commit earlier in
>  the history.
>
>  The steps can be reproduced via a sequence of:
>      $ mkdir tmp && cd tmp && git init
>      $ git config core.splitIndex true
>      $ for x in `seq 20`; do echo $x >> count; git add count; git commit -m "Commit $x"; done
>      $ git rebase -i HEAD~10
>
>      ## Add "x git commit --amend --no-edit" as the first command of
>      ## the todo list.
>
>What did you expect to happen? (Expected behavior)
>
>  My expectation was that there would still only be a single shared index
>  file in the .git directory upon completion of the rebase.
>
>What happened instead? (Actual behavior)
>
>  A large number of distinct sharedindex.* files were generated in the .git
>  directory during the rebase.

Probably relevant to the debug, but I still didn't figure out the cause. This
works ok and only one .sharedindex is created

	git config core.splitIndex true
	git am 000[123].patch
	git config core.splitIndex false

Prepare test:
	git config core.splitIndex false
	git update-index --no-split-index
	rm .git/sharedindex.*
	git reset --hard HEAD~3

	git -c core.splitIndex=true am 000[123].patch

This will create 4 .git/sharedindex.* files.

Then it will create 1 .git/shareindex.* file per call to status if the
current head doesn't match the previous and the splitIndex doesn't match
the previous. This keeps increasing:

	git reset --hard ORIG_HEAD; git -c core.splitIndex=true status; ls -l .git/sharedindex.* | wc -l
	...
	4
	git reset --hard ORIG_HEAD; git -c core.splitIndex=true status; ls -l .git/sharedindex.* | wc -l
	...
	5
	...

note that if I pass -c core.splitIndex=true to git reset, this behavior
goes away. It seems that somehow the setting splitindex is getting reset
during git-am with multiple patches (or during rebase)... ?

Lucas De Marchi

>
>What's different between what you expected and what actually happened?
>
>  Rather than a single shared index file, I wound up with a huge number of
>  large shared index files.  The real repository I was working with (a Linux
>  kernel source tree) had a shared index file size of about 7MB, and I was
>  modifying a commit several hundred back in history (in case it
>  matters, these were all linear commits, no merges), so the resulting
>  collection of shared index files consumed a surprising amount of disk
>  space.
>
>Anything else you want to add:
>
>  As an experiment, I tried setting splitIndex.sharedIndexExpire=now to see
>  if it would avoid the explosion of shared index files, but it appears the
>  stale index files are still not being removed during the rebase, and I
>  still wind up with a huge number at the end of the rebase.  If I manually
>  run "git update-index --split-index" after the rebase completes it will
>  properly delete all of the stale ones at that point.
>
>  Rebases that do not actually modify the history do _not_ trigger the
>  explosion of shared index files (e.g., "git rebase -i HEAD~10 --exec 'echo
>  foo'").
>
>  If I do not set the core.splitIndex setting on the repository, but only
>  activate split index manually via "git update-index --split-index" there
>  is only one shared index file at the end of the rebase, but based on the
>  file size it appears the repository is no longer operating in split index
>  mode.
>
>  Before:
>  $ ll .git | grep index
>  -rw-rw-r--   1 mdroper mdroper   149165 Sep 15 22:21 index
>  -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:21 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4
>
>  After (just amending HEAD~1 in this case):
>  $ ls -l .git | grep index
>  -rw-rw-r--   1 mdroper mdroper  7445145 Sep 15 22:22 index
>  -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:22 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4
>
>
>[System Info]
>git version:
>git version 2.33.0
>cpu: x86_64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>uname: Linux 5.8.18-100.fc31.x86_64 #1 SMP Mon Nov 2 20:32:55 UTC 2020 x86_64
>compiler info: gnuc: 9.3
>libc info: glibc: 2.30
>$SHELL (typically, interactive shell): /bin/bash
>
>
>[Enabled Hooks]
>
>-- 
>Matt Roper
>Graphics Software Engineer
>VTT-OSGC Platform Enablement
>Intel Corporation
>(916) 356-2795
