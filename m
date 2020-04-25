Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEAC2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3052084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDYCUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:20:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:47707 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgDYCUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:52 -0400
IronPort-SDR: NIms1jm2I20f3vek5bjXgr9CII7vuihAFrpuz3hJnkgoMsNp4LsdWWD8qceyR8MwQvY5Cc6Hnw
 625TUagjIXqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:52 -0700
IronPort-SDR: Q7qjv5aD3anpZwYEf6FPCLVpY4ykfiOnU89ZxmMEYw+YfA/wbHo0gf40sNPePyD+ETuT1/CQ9Q
 0lSUxeTIT6qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056774"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:51 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 00/11] refactor git switch completion
Date:   Fri, 24 Apr 2020 19:20:33 -0700
Message-Id: <20200425022045.1089291-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

completion support for git switch is subpar for a number of cases. Most
notable is difference between these two completions:

  $git switch <TAB>
  Display all 784 possibilities? (y or n)
  <list of all references and DWIM remotes>

  $git switch --track<TAB>
  jk-refactor-git-switch-completion master`

If --track is provided, tab completion becomes almost useless, because we
would expect to complete remote references, but instead can only complete
local branches!

This series was motivated by a desire to fix the completion for the above
two cases, but I noticed several other issues on the way, including some
issues understanding what the current logic did.

This series aims to improve the completion support, and comes with many
additional test cases that should help highlight the buggy behavior and
hopefully prevent future regressions.

The first few commits just add new test cases, most of which currently fail.

Following this is a commit to change __git_complete_refs so that it uses
"--dwim" instead of "--track", since this made reading _git_checkout() and
_git_switch() difficult to read. "--track" was both used as the "enable DWIM
remote branch names" and also the option name for --track.

Following this are some patches to extract displaying DWIM remote branch
names from __git_refs() and refactoring __git_complete_refs to take a mode
argument that switches between calling __git_heads, __git_refs, and a new
__git_remotes.

By doing this, it becomes easier to do things like complete DWIM remote
branches in addition to just regular branches, rather than all references.

With this series applied, completion for git switch behaves more like the
following examples:

  $git switch <TAB>
  HEAD                                master         todo
  jk-refactor-git-switch-completion   next
  maint                               pu

  $git switch --track <TAB>
  origin/HEAD     origin/maint    origin/master   origin/next     origin/pu
  origin/todo

Jacob Keller (11):
  completion: add some simple test cases for git switch completion
  completion: add test showing subpar git switch completion
  completion: add test highlighting subpar git switch --track completion
  completion: add tests showing lack of support for  git switch -c/-C
  completion: remove completion for git switch --orphan
  completion: rename --track option of __git_complete_refs
  completion: extract function __git_dwim_remote_heads
  completion: perform DWIM logic directly in __git_complete_refs
  completion: fix completion for git switch with no options
  completion: recognize -c/-C when completing for git switch
  completion: complete remote branches for git switch --track

 contrib/completion/git-completion.bash | 146 +++++++++++++++++++------
 t/t9902-completion.sh                  | 103 +++++++++++++++++
 2 files changed, 215 insertions(+), 34 deletions(-)

-- 
2.25.2

