Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5091F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeBSL3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:43 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:50048 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeBSL3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:24 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdKeU69H; Mon, 19 Feb 2018 11:29:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039762;
        bh=i3iRIY3nQ8dFWTNCIE6PjoRMR0Sr+KciFgB5VTU+FaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=LacPB476QsNvJcS0hCg072J/F3Uu/pOgSThLy3ZUtP2soIu1FKanyA7YzFQ2Touib
         mdCdFVEg7qfaUaKVmLiro5pa+4VCn6GtFIkmweorc2eKLAKuQwL5sNcvyiUKrIddrj
         lW2vv/kA4VKe7QP/qP2RvS05N56afY0m1CY+jgh8=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=jIkynP5I9sAo3PriuZ8A:9
 a=7BkU3mhJU_E0h05l:21 a=m0uvLEqHA2CHyFm3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/9] t3701: add failing test for pathological context lines
Date:   Mon, 19 Feb 2018 11:29:06 +0000
Message-Id: <20180219112910.24471-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJW/nW9ld++aQnrejQl7lCNHezSaWN1MBPhfM0iCO6orvHTqX6U9pVwXOXJpT3HJtHixLtPIecfUv2gngZ4diRBNu7oRxHYPXuPAjVw6HJls0B/uB67l
 P4Wgnm99S5XTDnuHRyGyh3mZGWBot2Bx3aHelTbHsVRyE3Ngo+ZPj/aH09vUxfIlcJEirCq7TP7G60Pki1/HOEJ4nTKwoGP/yNkHx26PWBs0Sy+6FrIGr/8H
 ksS9GkRcCvmd8qc6mybWUVDuks+uJliwxg2YvsW50mtlUjGMLs2U0CN1xCeB/qlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is skipped by add -i the offsets of subsequent hunks are
not adjusted to account for any missing insertions due to the skipped
hunk. Most of the time this does not matter as apply uses the context
lines to apply the subsequent hunks in the correct place, however in
pathological cases the context lines will match at the now incorrect
offset and the hunk will be applied in the wrong place. The offsets of
hunks following an edited hunk that has had the number of insertions
or deletions changed also need to be updated in the same way. Add
failing tests to demonstrate this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v1:
     - changed edit test to use the existing fake editor and to strip
       the hunk header and some context lines as well as deleting an
       insertion
     - style fixes

 t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 70748393f28c93f4bc5d43b07bd96bd208aba3e9..06c4747f506a1b05ccad0f9387e1fbd69cfd7784 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -511,4 +511,35 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'set up pathological context' '
+	git reset --hard &&
+	test_write_lines a a a a a a a a a a a >a &&
+	git add a &&
+	git commit -m a &&
+	test_write_lines c b a a a a a a a b a a a a >a &&
+	test_write_lines     a a a a a a a b a a a a >expected-1 &&
+	test_write_lines   b a a a a a a a b a a a a >expected-2 &&
+	# check editing can cope with missing header and deleted context lines
+	# as well as changes to other lines
+	test_write_lines +b " a" >patch
+'
+
+test_expect_failure 'add -p works with pathological context lines' '
+	git reset &&
+	printf "%s\n" n y |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-1 actual
+'
+
+test_expect_failure 'add -p patch editing works with pathological context lines' '
+	git reset &&
+	test_set_editor "$FAKE_EDITOR" &&
+	# n q q below is in case edit fails
+	printf "%s\n" e y    n q q |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.16.1

