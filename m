Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFFDC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E74207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405715AbgE1SLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:20263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405705AbgE1SLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:14 -0400
IronPort-SDR: s7wyLyBZCnQBYOSQfJES8qP4NxjlkMgb3JtdcXxfccVF1BWRRGh7yNmYiP1jK2GoyVR6+V2a8/
 uQcXbS4Rg9JQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: w8dOi99/YjMsfAdvi9cTOJB4xw7cBkgUDHnFKQuJfmNMtm0XKnLyIjHC6JSoTxNmmF7sGecQbt
 ltUQNlvQW5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301346"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 02/16] completion: add tests showing subpar DWIM logic for switch/checkout
Date:   Thu, 28 May 2020 11:10:34 -0700
Message-Id: <20200528181048.3509470-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200528181048.3509470-1-jacob.e.keller@intel.com>
References: <20200528181048.3509470-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When provided with a single argument that is the name of a remote branch
that does not yet exist locally, both git switch and git checkout can
interpret this as a request to create a local branch that tracks that
remote branch. We call this behavior "Do What I Mean", or DWIM for
short.

To aid in using this DWIM, it makes sense for completion to list these
unique remote branch names when completing possible arguments for git
switch and git checkout. Indeed, both _git_checkout and _git_switch
implement support for completing such DWIM branch names.

In other words, in addition to the usual completions provided for git
switch, this "DWIM" logic means completion will include the names of
branches on remotes that are unique and thus there can be no ambiguity
of which remote to track when creating the local branch.

However, the DWIM logic is not always active. Many options, such as
--no-guess, --no-track, and --track disable this DWIM logic, as they
cause git switch and git checkout to behave in different modes.

Additionally, some completion users do not wish to have tab completion
include these remote names by default, and thus introduced
GIT_COMPLETION_CHECKOUT_NO_GUESS as an optional way to configure the
completion support to disable this feature of completion support.

For this reason, _git_checkout and _git_switch have many rules about
when to enable or disable completing of these remote refs. The two
commands follow similar but not identical rules.

Set aside the question of command modes that do not accept this DWIM
logic (--track, -c, --orphan, --detach) for now. Thinking just about the
main mode of git checkout and git switch, the following guidelines will
help explain the basic rules we ought to support when deciding whether
to list the remote branches for DWIM in completion.

1.  if --guess is enabled, we should list DWIM remote branch names, even
    if something else would disable it
2.  if --no-guess, --no-track or GIT_COMPLETION_CHECKOUT_NO_GUESS=1,
    then we should disable listing DWIM remote branch names.
3.  Since the '--guess' option is a boolean option, a later --guess
    should override --no-guess, and a later --no-guess should override
    --guess.

Putting all of these together, add some tests that highlight the
expected behavior of this DWIM logic.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 105 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8f25fd24b43e..ff234dee4da9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1263,6 +1263,111 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
 	EOF
 '
 
+test_expect_success 'git switch - with --no-guess, complete only local branches' '
+	test_completion "git switch --no-guess " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete only local branches' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: --guess/--no-guess ordering is not taken into account
+#TODO: git switch completion includes unexpected references
+test_expect_failure 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: --guess/--no-guess ordering is not taken into account
+#TODO: git switch completion includes unexpected references
+test_expect_failure 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
+	test_completion "git switch --no-guess --guess " <<-\EOF
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	EOF
+'
+
+#TODO: --guess/--no-guess ordering is not taken into account
+test_expect_failure 'git switch - a later --no-guess overrides previous --guess, complete only local branches' '
+	test_completion "git switch --guess --no-guess " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only completes refs' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: git checkout does not override variable when --guess is provided
+test_expect_failure 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
+	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --no-guess, only completes refs' '
+	test_completion "git checkout --no-guess " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: --guess/--no-guess ordering is not taken into account
+test_expect_failure 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
+	test_completion "git checkout --no-guess --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --no-guess overrides previous --guess, complete only refs' '
+	test_completion "git checkout --guess --no-guess " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

