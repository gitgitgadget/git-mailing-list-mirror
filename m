Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C403C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 00:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJLAGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 20:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLAGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 20:06:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D6696CB
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665533199; x=1697069199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6/DxfcLRbTJRAQUFf00OLf50FvTwRWq23jkEA2g5Jfc=;
  b=NMs2FnR8T1KDpsJd7rWkm8YVpO1pwtum1cCJYLs6LV8ian+JmZjrQTzK
   qEtHwRmP0WB22GPT1W7mprUomj7DF6IZXpdpqUmyujxCD5VgFQmFBS12v
   uLQW8zKUKsQSF8acD5za1UNdF23hDdYDEXdBbz7o2iVIQGz/36FHPrOoZ
   PaoUfbgp9LMsKYTQx+X52tmiMY8ZCdDQmj3pGslG9Rz5PYNp885AGe6Jg
   80kJvu1YPhYLRZ2p95B6JBbo1Jr2Io1fAD9gxChf6m8YKLD0kpTmcmnB/
   znUGdOUHFlufT0v0KNm7iFIR8trfDx+MzfYTY5GWQRtn/LPDcUUGUt+3s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="306283561"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="306283561"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:06:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="751926291"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="751926291"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 17:06:38 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] tests: add test highlighting submodule remote breakage
Date:   Tue, 11 Oct 2022 17:06:30 -0700
Message-Id: <20221012000630.1442340-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.38.0.83.gd420dda05763
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If a user renames the "origin" remote of a submodule, recursive fetching
can sometimes fail with an error similar to:

  From git/git/t/trash directory.t5526-fetch-submodules/.
     210db27..1fc7e77  super      -> origin/super
  Fetching submodule submodule
  fatal: 'origin' does not appear to be a git repository
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.
  Errors during submodule fetch:
          submodule

This occurs because of the way that recursive submodule fetch tries to
guess the remote name. It will fall back to the origin term even if that
remote doesn't exist.

Add a test which sets up this environment and shows the failure. The
problem only exists if there are multiple remotes, so add both a test
for a single remote and a test for multiple remotes which is marked as
test_expect_failure.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t5526-fetch-submodules.sh | 54 ++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a301b56db894..1c45f1d72c94 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -10,16 +10,21 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
-write_expected_sub () {
-	NEW_HEAD=$1 &&
-	SUPER_HEAD=$2 &&
+write_expected_sub_remote () {
+	REMOTE=$1 &&
+	NEW_HEAD=$2 &&
+	SUPER_HEAD=$3 &&
 	cat >"$pwd/expect.err.sub" <<-EOF
 	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
 	From $pwd/submodule
-	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
+	   OLD_HEAD..$NEW_HEAD  sub        -> $REMOTE/sub
 	EOF
 }
 
+write_expected_sub () {
+	write_expected_sub_remote origin $1 $2
+}
+
 write_expected_sub2 () {
 	NEW_HEAD=$1 &&
 	SUPER_HEAD=$2 &&
@@ -718,6 +723,47 @@ test_expect_success 'fetching submodules respects parallel settings' '
 	)
 '
 
+test_expect_success 'fetching submodules works after remote rename' '
+	test_when_finished "git -C downstream/submodule remote rename upstream origin" &&
+	add_submodule_commits &&
+	add_superproject_commits &&
+	(
+		cd submodule &&
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_sub_remote upstream $new_head
+	) &&
+	(
+		cd downstream &&
+		git -C submodule remote rename origin upstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	verify_fetch_result actual.err
+'
+
+test_expect_failure 'fetching submodules works after remote rename with multiple remotes' '
+	test_when_finished "git -C downstream/submodule remote rename upstream origin" &&
+	test_when_finished "git -C downstream/submodule remote rm other" &&
+	add_submodule_commits &&
+	add_superproject_commits &&
+	(
+		cd submodule &&
+		new_head=$(git rev-parse --short HEAD) &&
+		write_expected_sub_remote upstream $new_head
+	) &&
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git remote rename origin upstream &&
+			git remote add other http://other.invalid
+		) &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	verify_fetch_result actual.err
+'
+
 test_expect_success 'fetching submodule into a broken repository' '
 	# Prepare src and src/sub nested in it
 	git init src &&
-- 
2.38.0.83.gd420dda05763

