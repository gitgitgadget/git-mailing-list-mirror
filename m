Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140951F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967596AbeCAKv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:51:29 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28959 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967570AbeCAKvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:51:21 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLnoeYfgY59cnrLntexaFS; Thu, 01 Mar 2018 10:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901474;
        bh=7KqwL5//njvzOLZORmDM5iaJF/NDvAmy9QxRvu+kBbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jM4wf4kyKbBkm/hLdWrLZYXVqCmPiZbxj9sBjnB0xRN3MnWEjQi4AfEh+Sx64A9bA
         R/mIvY2puPCMiqFZDjgSTpEFTfJKLVcbJ9g0Pw6ZbQSklIuBFgMi4EPn3sdNGRMdxY
         eLdyH/kQFdsILOisXIW23349aNxok/U3UL8ZZ8g8=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=ng1AAPYdEW1HGkko2WIA:9
 a=Fw1IyHYfuTte-oEy:21 a=JpouZheV1uc1INqq:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/9] Correct offsets of hunks when one is skipped
Date:   Thu,  1 Mar 2018 10:50:54 +0000
Message-Id: <20180301105103.24268-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNAYEmlx6fbtWRePVNSoTvbpMgGJ/oCf4gpMnsLuW2iFk7vXG7vhs6BE0YTmJ+5KtemlezB2v8nX9OZoeSJ8Hvcwo4HIYV+o8edUiWGdQrVy820I8rsR
 o4mrnBlmw+VTh9oJBAr/rd3ulgQlMbKYcYghm/63V/03n4TdioFchVrD3xoHU0UGIFX1Kj/4tFDnVxbE9lboBcl9XQoY5JOUH1Nktl3XU8rZ//yPKLUhXarb
 JJL5VaWNw7xT3qlePDWVoS7Tod8rCdUhCA3Uae46WRTnL+bAKCYVSwyZnZUajHUXLCkuzjlsqut63m8fLlEb7RT2gm08EEInPJMuS15w7tE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've fixed the second patch to match what was in pu and added some
extra code to patch 4 to handle zero sha1 hashes where the length
varies.

Cover letter to v1:

While working on a patch series to stage selected lines from a hunk
without having to edit it I got worried that subsequent patches would
be applied in the wrong place which lead to this series to correct the
offsets of hunks following those that are skipped or edited.

Interdiff to v3:

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 05540ee9ef..a9a9478a29 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -15,6 +15,9 @@ diff_cmp () {
 	do
 		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
 		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
+		     -e '/^index/s/ 00*\.\./ 0000000../' \
+		     -e '/^index/s/\.\.00*$/..0000000/' \
+		     -e '/^index/s/\.\.00* /..0000000 /' \
 		     "$x" >"$x.filtered"
 	done
 	test_cmp "$1.filtered" "$2.filtered"
@@ -32,7 +35,7 @@ test_expect_success 'status works (initial)' '
 '
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	new file mode 100644
 	index 0000000..d95f3ad
 	--- /dev/null
@@ -69,7 +72,7 @@ test_expect_success 'status works (commit)' '
 '
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
@@ -93,7 +96,7 @@ test_expect_success 'revert works (commit)' '
 
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	EOF
 '
 
@@ -105,7 +108,7 @@ test_expect_success 'dummy edit works' '
 '
 
 test_expect_success 'setup patch' '
-	cat >patch <<-EOF
+	cat >patch <<-\EOF
 	@@ -1,1 +1,4 @@
 	 this
 	+patch
@@ -129,7 +132,7 @@ test_expect_success 'bad edit rejected' '
 '
 
 test_expect_success 'setup patch' '
-	cat >patch <<-EOF
+	cat >patch <<-\EOF
 	this patch
 	is garbage
 	EOF
@@ -142,7 +145,7 @@ test_expect_success 'garbage edit rejected' '
 '
 
 test_expect_success 'setup patch' '
-	cat >patch <<-EOF
+	cat >patch <<-\EOF
 	@@ -1,0 +1,0 @@
 	 baseline
 	+content
@@ -152,7 +155,7 @@ test_expect_success 'setup patch' '
 '
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	diff --git a/file b/file
 	index b5dd6c9..f910ae9 100644
 	--- a/file
@@ -225,7 +228,7 @@ test_expect_success 'setup again' '
 
 # Write the patch file with a new line at the top and bottom
 test_expect_success 'setup patch' '
-	cat >patch <<-EOF
+	cat >patch <<-\EOF
 	index 180b47c..b6f2c08 100644
 	--- a/file
 	+++ b/file
@@ -242,7 +245,7 @@ test_expect_success 'setup patch' '
 test_expect_success 'setup expected' '
 	echo diff --git a/file b/file >expected &&
 	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
-	cat >expected-output <<-EOF
+	cat >expected-output <<-\EOF
 	--- a/file
 	+++ b/file
 	@@ -1,2 +1,4 @@
@@ -277,7 +280,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first line works' '
 '
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	diff --git a/non-empty b/non-empty
 	deleted file mode 100644
 	index d95f3ad..0000000
@@ -300,7 +303,7 @@ test_expect_success 'deleting a non-empty file' '
 '
 
 test_expect_success 'setup expected' '
-	cat >expected <<-EOF
+	cat >expected <<-\EOF
 	diff --git a/empty b/empty
 	deleted file mode 100644
 	index e69de29..0000000


Phillip Wood (9):
  add -i: add function to format hunk header
  t3701: indent here documents
  t3701: use test_write_lines and write_script
  t3701: don't hard code sha1 hash values
  t3701: add failing test for pathological context lines
  add -p: adjust offsets of subsequent hunks when one is skipped
  add -p: calculate offset delta for edited patches
  add -p: fix counting when splitting and coalescing
  add -p: don't rely on apply's '--recount' option

 git-add--interactive.perl  | 106 +++++++++++++----
 t/t3701-add-interactive.sh | 291 +++++++++++++++++++++++++--------------------
 2 files changed, 243 insertions(+), 154 deletions(-)

-- 
2.16.1

