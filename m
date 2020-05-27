Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3731C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB0620888
	for <git@archiver.kernel.org>; Wed, 27 May 2020 11:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgE0Lis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 07:38:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:3343 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgE0Lig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 07:38:36 -0400
IronPort-SDR: /zBeaFpDqe4fQ9pQcWpYHtDqhWXfjsj6qkfv+ycDcf5HxcDZ6l7IP7vNOFsMlpKU9aJJWpdK98
 GT+R4T+1z4bw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 04:38:34 -0700
IronPort-SDR: /LDSV9MZae240sa6HIrFzWOXBE9H13naiG+dk6f8isMu7k5klN47FwI/zIpkvOpo3PowVzWo2P
 48iwPWI1195w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="302431800"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2020 04:38:34 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 6/9] completion: improve handling of --detach in checkout
Date:   Wed, 27 May 2020 04:38:28 -0700
Message-Id: <20200527113831.3294409-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200527113831.3294409-1-jacob.e.keller@intel.com>
References: <20200527113831.3294409-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Just like git switch, we should not complete DWIM remote branch names
if --detach has been specified. To avoid this, refactor _git_checkout in
a similar way to _git_switch.

Note that we don't simply clear dwim_opt when we find -d or --detach, as
we will be adding other modes and checks, making this flow easier to
follow.

Add new tests for the expected --detach behavior for both git switch and
git checkout.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash |  7 +++-
 t/t9902-completion.sh                  | 44 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 53afd72d0e4e..38b5a5a0d874 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1489,7 +1489,12 @@ _git_checkout ()
 		;;
 	*)
 		local dwim_opt="$(__git_checkout_default_dwim_mode)"
-		__git_complete_refs $dwim_opt
+
+		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+			__git_complete_refs --mode="refs"
+		else
+			__git_complete_refs $dwim_opt --mode="refs"
+		fi
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ec9437688cd7..5b1868e43632 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1360,6 +1360,50 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	EOF
 '
 
+test_expect_success 'git switch - with --detach, complete all references' '
+	test_completion "git switch --detach " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with --detach, complete only references' '
+	test_completion "git checkout --detach " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with -d, complete all references' '
+	test_completion "git switch -d " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -d, complete only references' '
+	test_completion "git checkout -d " <<-\EOF
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

