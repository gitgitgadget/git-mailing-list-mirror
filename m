Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720C61FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbcHWVqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:46:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:14975 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcHWVq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:46:29 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP; 23 Aug 2016 14:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,567,1464678000"; 
   d="scan'208";a="870104307"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2016 14:46:23 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
Date:   Tue, 23 Aug 2016 14:46:20 -0700
Message-Id: <20160823214620.28624-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.259.g83512d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Change the default behavior of git-format-patch to generate numbered
sequence of 0/1 and 1/1 when generating both a cover-letter and a single
patch. This standardizes the cover letter to have 0/N which helps
distinguish the cover letter from the patch itself. Since the behavior
is easily changed via configuration as well as the use of -n and -N this
should be acceptable default behavior.

Add tests for the new default behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/log.c                    |  8 ++++----
 t/t4021-format-patch-numbered.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34dcb0cc..49aa534f4a01 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1676,16 +1676,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* nothing to do */
 		return 0;
 	total = nr;
-	if (!keep_subject && auto_number && total > 1)
-		numbered = 1;
-	if (numbered)
-		rev.total = total + start_number - 1;
 	if (cover_letter == -1) {
 		if (config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
 		else
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
+	if (!keep_subject && auto_number && (total > 1 || cover_letter))
+		numbered = 1;
+	if (numbered)
+		rev.total = total + start_number - 1;
 
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 886494b58f67..ea0a388f0191 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -36,6 +36,11 @@ test_no_numbered() {
 	test_num_no_numbered $1 2
 }
 
+test_single_cover_letter_numbered() {
+	grep "^Subject: \[PATCH 0/1\]" $1 &&
+	grep "^Subject: \[PATCH 1/1\]" $1
+}
+
 test_single_numbered() {
 	grep "^Subject: \[PATCH 1/1\]" $1
 }
@@ -50,6 +55,11 @@ test_expect_success 'single patch defaults to no numbers' '
 	test_single_no_numbered patch0.single
 '
 
+test_expect_success 'single patch with cover-letter defaults to numbers' '
+	git format-patch --cover-letter --stdout HEAD~1 >patch0.single &&
+	test_single_cover_letter_numbered patch0.single
+'
+
 test_expect_success 'multiple patch defaults to numbered' '
 
 	git format-patch --stdout HEAD~2 >patch0.multiple &&
@@ -64,6 +74,11 @@ test_expect_success 'Use --numbered' '
 
 '
 
+test_expect_success 'Use --no-numbered and --cover-letter single patch' '
+	git format-patch --no-numbered --stdout --cover-letter HEAD~1 >patch1 &&
+	test_no_numbered patch1
+'
+
 test_expect_success 'format.numbered = true' '
 
 	git config format.numbered true &&
-- 
2.10.0.rc0.259.g83512d9

