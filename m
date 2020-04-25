Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB07AC55194
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E5D2084D
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgDYCVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:21:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:47707 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgDYCUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:55 -0400
IronPort-SDR: CtXXB9QJ+4zXTwZfvBpq62YzmHkO2oqql4xWl7i+77kkG0fvEeuG/Os31G4RlckJbeM/LMcCLv
 3yKwRQsot+2w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:52 -0700
IronPort-SDR: NPpqY1YvuGtB+JDCR38m2CkWMa1koj7u/zuu091L8WX7QVlbq4FcNgznX4YldUoF6K/6w6Wy5I
 vaVsK2DZW7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056780"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:52 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
Date:   Fri, 24 Apr 2020 19:20:38 -0700
Message-Id: <20200425022045.1089291-6-jacob.e.keller@intel.com>
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

git switch with the --orphan option is used to create a new branch that
is not connected to any history and is instead based on the empty tree.

It does not make sense for completion to return anything in this case,
because there is nothing to complete. Check for --orphan, and if it's
found, immediately return from _git_switch() without completing
anything.

Add a test case which documents this expected behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 t/t9902-completion.sh                  |  7 +++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd00..08d3406cf3e4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2223,9 +2223,18 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
+		local track_opt="--track" only_local_ref=n
+
+		# --orphan is used to create a branch disconnected from the
+		# current history, based on the empty tree. Since the only
+		# option required is the branch name, it doesn't make sense to
+		# complete anything here.
+		if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
+			return
+		fi
+
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
-		local track_opt="--track" only_local_ref=n
 		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
 		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
 			track_opt=''
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a134a8791076..9d02de167219 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1351,6 +1351,13 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
 	EOF
 '
 
+# TODO: completion does not yet recognize --orphan
+test_expect_failure 'git switch - with --orphan, do not complete anything' '
+	test_completion "git switch --orphan " <<-\EOF
+
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

