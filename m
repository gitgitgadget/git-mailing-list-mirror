Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F67BC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6489320888
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgE0Lig (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:3342 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgE0Lie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:34 -0400
IronPort-SDR: OP0V3CcISFPGieZMsZoh4Mh3gbLAlV5O3c6hHYyTZ/3d4wBffFfitaeIkiayTwsJQeJapRHzmK
 WJuiE/GbZ2tA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: MsG71OzLoB/lEnkA9Fmzau98XRgBHMqPw8iJLouc1Dj/0eiM/jbvFHI4qRUGHswUDI3lMWao8i
 aQ1FnNPPHy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431794"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 0/9] refactor completion for switch and checkout
Date:   Wed, 27 May 2020 04:38:22 -0700
Message-Id: <20200527113831.3294409-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

completion support for git switch is subpar for a number of cases. Most
notable is difference in behavior between these two completions:

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
additional test cases that cover the new behavior implemented in the various
patches.

This is a rework of a previous series posted, available at the following URL:
https://lore.kernel.org/git/20200425022045.1089291-1-jacob.e.keller@intel.com/

Note that although I've marked this as a v2, I did not find the range-diff
to be satisfying or useful and have not included it. Besides not being very
useful, not many folks seem to have reviewed the original anyways.

The most notable change in behavior since v1 is how we handle the -c/-C
options. It makes sense to complete the argument of -c differently than how
we handle the start-point after we already have a completed branch name. The
exact requirements of *how* we complete branch names is easily modified if
anyone has a better suggestion.

Finally, I also applied many of the same improvements to checkout where
appropriate, and have included many more additional tests for both git
switch and git checkout.

Jacob Keller (9):
  completion: replace overloaded track term for __git_complete_refs
  completion: improve handling of DWIM mode for switch/checkout
  completion: extract function __git_dwim_remote_heads
  completion: perform DWIM logic directly in __git_complete_refs
  completion: improve completion for git switch with no options
  completion: improve handling of --detach in checkout
  completion: improve handling of --track in switch/checkout
  completion: improve handling of -c/-C and -b/-B in switch/checkout
  completion: improve handling of --orphan option of switch/checkout

 contrib/completion/git-completion.bash | 252 +++++++++++---
 t/t9902-completion.sh                  | 455 +++++++++++++++++++++++++
 2 files changed, 668 insertions(+), 39 deletions(-)

-- 
2.25.2

