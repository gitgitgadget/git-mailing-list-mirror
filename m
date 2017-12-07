Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE4F20954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdLGTLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:11:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:3356 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdLGTLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:11:15 -0500
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Dec 2017 14:11:15 EST
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2017 11:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,374,1508828400"; 
   d="scan'208";a="9979538"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.177.172])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2017 11:01:42 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] diff: add tests for --relative without optional prefix value
Date:   Thu,  7 Dec 2017 11:01:35 -0800
Message-Id: <20171207190135.28660-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.15.1.478.ga1e07cd25f8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

We already have tests for --relative, but they currently only test when
a prefix has been provided. This fails to test the case where --relative
by itself should use the current directory as the prefix.

Teach the check_$type functions to take a directory argument to indicate
which subdirectory to run the git commands in. Add a new test which uses
this to test --relative without a prefix value.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t4045-diff-relative.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f5034d31..7d68a6e2a536 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -13,6 +13,7 @@ test_expect_success 'setup' '
 '
 
 check_diff() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 diff --git a/$expect b/$expect
@@ -24,50 +25,54 @@ index 0000000..25c05ef
 +other content
 EOF
 test_expect_success "-p $*" "
-	git diff -p $* HEAD^ >actual &&
+	git -C '$dir' diff -p $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 check_numstat() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 1	0	$expect
 EOF
 test_expect_success "--numstat $*" "
 	echo '1	0	$expect' >expected &&
-	git diff --numstat $* HEAD^ >actual &&
+	git -C '$dir' diff --numstat $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 check_stat() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
  $expect | 1 +
  1 file changed, 1 insertion(+)
 EOF
 test_expect_success "--stat $*" "
-	git diff --stat $* HEAD^ >actual &&
+	git -C '$dir' diff --stat $* HEAD^ >actual &&
 	test_i18ncmp expected actual
 "
 }
 
 check_raw() {
+dir=$1; shift
 expect=$1; shift
 cat >expected <<EOF
 :000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
 EOF
 test_expect_success "--raw $*" "
-	git diff --no-abbrev --raw $* HEAD^ >actual &&
+	git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
 	test_cmp expected actual
 "
 }
 
 for type in diff numstat stat raw; do
-	check_$type file2 --relative=subdir/
-	check_$type file2 --relative=subdir
-	check_$type dir/file2 --relative=sub
+	check_$type . file2 --relative=subdir/
+	check_$type . file2 --relative=subdir
+	check_$type . dir/file2 --relative=sub
+	check_$type subdir file2 --relative
 done
 
 test_done
-- 
2.15.1.478.ga1e07cd25f8b

