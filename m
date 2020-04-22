Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3209C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D496E20767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDVURC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:17:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:24668 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgDVURC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:17:02 -0400
IronPort-SDR: LLcxo3Lz53BzFaUtsmhvxeSvXJIPdjFkQzVDhkWwJ3hs6iLe3TBBYTMjwHlep1wKEPSl1p5CBx
 loLGQXM7ktmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 13:17:02 -0700
IronPort-SDR: wt4AT0hMEaCn9HcuewjaJLUPfWvUXx3Tc8FuqtxIeRsBK1sAIHGDfMSEiCAOCRH7PE0t/O7Yx7
 nW/4xE/vyMuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="290954471"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2020 13:17:02 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] completion: complete remote branches with switch --track
Date:   Wed, 22 Apr 2020 13:15:42 -0700
Message-Id: <20200422201541.3766173-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If the --track option is supplied to git switch, then a new branch will
be created tracking the specified remote branch.

Fix git completion support so that remote branches will be completed
when --track is enabled.

Add a couple of simple test cases to help cover this new behavior. Note
that ideally completion for --track would only allow remote branches,
and would not complete all refs like HEAD, FETCH_HEAD, etc, so one of
the new tests is a test_expect_failure to capture this.

Fixes: ae36fe694180 ("completion: support switch")
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I wasn't able to figure out how to get completion to ignore things like tags
and similar, but I think this is still an improvement.

 contrib/completion/git-completion.bash |  8 +++++---
 t/t9902-completion.sh                  | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd00..6de341fd1587 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2235,12 +2235,14 @@ _git_switch ()
 		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
 			track_opt='--track'
 		fi
-		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
-			only_local_ref=y
-		else
+		if [ -n "$(__git_find_on_cmdline "-d --detach")" ]; then
 			# --guess --detach is invalid combination, no
 			# dwim will be done when --detach is specified
 			track_opt=
+		elif [ -z "$(__git_find_on_cmdline "--track")" ]; then
+			# if neither --detach or --track are specified then
+			# match only local refs.
+			only_local_ref=y
 		fi
 		if [ $only_local_ref = y -a -z "$track_opt" ]; then
 			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5505e5aa249e..a2478eae6933 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1760,6 +1760,28 @@ do
 	'
 done
 
+test_expect_success 'git switch - default local branches only' '
+	test_completion "git switch m" <<-\EOF
+	master Z
+	master-in-other Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_failure 'git switch - --track remote branches' '
+	test_completion "git switch --track " <<-\EOF
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - --track remote branches partial completion' '
+	test_completion "git switch --track other/master-in" <<-\EOF
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'git config - section' '
 	test_completion "git config br" <<-\EOF
 	branch.Z
-- 
2.25.2

