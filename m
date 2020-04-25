Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC2C2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE12084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDYCVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:21:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:47707 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgDYCU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:56 -0400
IronPort-SDR: sXPxsS9CAJRvm4Z9108CKJ3CKqSEUfgMqzpwF2+XtlIdkYuNcQjmhSwRs8Y11JMKZ3iwG3COL+
 Omxex+jFIrgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:53 -0700
IronPort-SDR: V1UkxnZJnCpC5Hc7q8L8kKq/JsQDmYWHl5LxuBqt3bwgk3zLmYwGNmnneG/cukZiTJZfe9vEcR
 SHuwK+myQopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056791"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:53 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 10/11] completion: recognize -c/-C when completing for git switch
Date:   Fri, 24 Apr 2020 19:20:44 -0700
Message-Id: <20200425022045.1089291-12-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If a user wants to create a new branch using git switch, we should be
able to complete any starting point reference. Additionally, DWIM logic
will not work.

Add -c and -C to the list of options for disabling --dwim and for
choosing the --refs mode.

This fixes several known breakages, so update these tests accordingly.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash |  4 ++--
 t/t9902-completion.sh                  | 18 +++++-------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0384b136763a..f9be0dabb03e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2291,7 +2291,7 @@ _git_switch ()
 
 		# Certain combinations of options also disable this DWIM mode,
 		# so we should not complete such names in these cases.
-		if [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess -d --detach")" ]; then
+		if [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess -d --detach -c -C")" ]; then
 			dwim_opt=''
 		fi
 
@@ -2299,7 +2299,7 @@ _git_switch ()
 		# local branches, or DWIM with remote branch names. However,
 		# certain options for creating branches or detaching should
 		# complete all references.
-		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
+		if [ -n "$(__git_find_on_cmdline "-d --detach -c -C")" ]; then
 			mode="refs"
 		fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cfd27e4857b7..68296d79a3e9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1284,11 +1284,7 @@ test_expect_success 'git switch - with --no-track, complete only local branch na
 	EOF
 '
 
-# TODO: git switch completion does not yet support checking for -c, but it
-# should be able to complete all possible references. Based on a quick
-# examination of the switch/checkout code, -c will disable DWIM logic and thus
-# we should not complete unique remote branch names with -c or -C either.
-test_expect_failure 'git switch - with -c, complete all references' '
+test_expect_success 'git switch - with -c, complete all references' '
 	test_completion "git switch -c new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1299,7 +1295,7 @@ test_expect_failure 'git switch - with -c, complete all references' '
 	EOF
 '
 
-test_expect_failure 'git switch - with -c, complete all references' '
+test_expect_success 'git switch - with -c, complete all references' '
 	test_completion "git switch -C new-branch " <<-\EOF
 	HEAD Z
 	master Z
@@ -1310,8 +1306,7 @@ test_expect_failure 'git switch - with -c, complete all references' '
 	EOF
 '
 
-# TODO: ensure that the completion rules for -c override --track
-test_expect_failure 'git switch - with -c and --track, complete all references' '
+test_expect_success 'git switch - with -c and --track, complete all references' '
 	test_completion "git switch -c new-branch --track " <<-EOF
 	HEAD Z
 	master Z
@@ -1322,10 +1317,7 @@ test_expect_failure 'git switch - with -c and --track, complete all references'
 	EOF
 '
 
-# TODO: git switch with -c and --no-track should allow creating a branch using
-# any reference as a starting point. Because completion support does not
-# recognize -c or -C, this doesn't work yet.
-test_expect_failure 'git switch - with -c and --no-track, complete all references' '
+test_expect_success 'git switch - with -c and --no-track, complete all references' '
 	test_completion "git switch -c new-branch --no-track " <<-\EOF
 	HEAD Z
 	master Z
@@ -1336,7 +1328,7 @@ test_expect_failure 'git switch - with -c and --no-track, complete all reference
 	EOF
 '
 
-test_expect_failure 'git switch - with -C and --no-track, complete all references' '
+test_expect_success 'git switch - with -C and --no-track, complete all references' '
 	test_completion "git switch -C new-branch --no-track " <<-\EOF
 	HEAD Z
 	master Z
-- 
2.25.2

