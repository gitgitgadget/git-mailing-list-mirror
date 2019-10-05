Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970FB1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfJEVMZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfJEVMZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69B1C61C71;
        Sat,  5 Oct 2019 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309943;
        bh=v+qOBlhknk2JmCEKxVPu22ZOeyUBzrkh2PeLVzN8pEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xAKbrkDKlTtiGnJw4RBsOTXPjxwbcgIzRAsvijFJZN0Xxdpu9cKW5pJ+q1oXFW3xP
         4gX/6kniLb0AaAF2DTK9jjGV65h0/8J8z+UgoLVmHT3PbY65sACtKluW9H8YcqvjNk
         /M4Gvk2XlBsqx/KfwGqjkFNvesSsqndp+hGkJsrncexDAbRca5P4KGmuMFhBNgIvXx
         nBL625tgWuqiaKrYCNqAGZSk6o+h3Msut1lGFmiHcPYFJFDWCfOLYteq/K4NOtG+AR
         gxQSaYDKrbvKAbMcpweRgHRIF3nPbaW4+3XrsRogVrncU/Zr6xLnnx4QSxGVfFe2g5
         GxLw3K1Jyuq7rrX+AMradScSQRBv9XDnAqBcRihnnpA2S/Ob+/oVSWBjAjifpDURRx
         HCkyIJaSIxzl/hOJfCwLOPkTpe8Vvc4wOxT1riZBkFfn6AqBjusKYjEo9GZ93cWdON
         LMTBnJ2q/JijRfxzg+eahzm2XimTr0fAX4sP3I6MJEcPYsLyaMN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 15/15] t4048: abstract away SHA-1-specific constants
Date:   Sat,  5 Oct 2019 21:12:09 +0000
Message-Id: <20191005211209.18237-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4048-diff-combined-binary.sh | 58 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index 87a8949500..7f9ad9fa3d 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -9,24 +9,27 @@ test_expect_success 'setup binary merge conflict' '
 	git commit -m one &&
 	echo twoQ2 | q_to_nul >binary &&
 	git commit -a -m two &&
+	two=$(git rev-parse --short HEAD:binary) &&
 	git checkout -b branch-binary HEAD^ &&
 	echo threeQ3 | q_to_nul >binary &&
 	git commit -a -m three &&
+	three=$(git rev-parse --short HEAD:binary) &&
 	test_must_fail git merge master &&
 	echo resolvedQhooray | q_to_nul >binary &&
-	git commit -a -m resolved
+	git commit -a -m resolved &&
+	res=$(git rev-parse --short HEAD:binary)
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --git a/binary b/binary
-index 7ea6ded..9563691 100644
+index $three..$res 100644
 Binary files a/binary and b/binary differ
 resolved
 
 diff --git a/binary b/binary
-index 6197570..9563691 100644
+index $two..$res 100644
 Binary files a/binary and b/binary differ
 EOF
 test_expect_success 'diff -m indicates binary-ness' '
@@ -34,11 +37,11 @@ test_expect_success 'diff -m indicates binary-ness' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --combined binary
-index 7ea6ded,6197570..9563691
+index $three,$two..$res
 Binary files differ
 EOF
 test_expect_success 'diff -c indicates binary-ness' '
@@ -46,11 +49,11 @@ test_expect_success 'diff -c indicates binary-ness' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --cc binary
-index 7ea6ded,6197570..9563691
+index $three,$two..$res
 Binary files differ
 EOF
 test_expect_success 'diff --cc indicates binary-ness' '
@@ -62,23 +65,26 @@ test_expect_success 'setup non-binary with binary attribute' '
 	git checkout master &&
 	test_commit one text &&
 	test_commit two text &&
+	two=$(git rev-parse --short HEAD:text) &&
 	git checkout -b branch-text HEAD^ &&
 	test_commit three text &&
+	three=$(git rev-parse --short HEAD:text) &&
 	test_must_fail git merge master &&
 	test_commit resolved text &&
+	res=$(git rev-parse --short HEAD:text) &&
 	echo text -diff >.gitattributes
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --git a/text b/text
-index 2bdf67a..2ab19ae 100644
+index $three..$res 100644
 Binary files a/text and b/text differ
 resolved
 
 diff --git a/text b/text
-index f719efd..2ab19ae 100644
+index $two..$res 100644
 Binary files a/text and b/text differ
 EOF
 test_expect_success 'diff -m respects binary attribute' '
@@ -86,11 +92,11 @@ test_expect_success 'diff -m respects binary attribute' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --combined text
-index 2bdf67a,f719efd..2ab19ae
+index $three,$two..$res
 Binary files differ
 EOF
 test_expect_success 'diff -c respects binary attribute' '
@@ -98,11 +104,11 @@ test_expect_success 'diff -c respects binary attribute' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --cc text
-index 2bdf67a,f719efd..2ab19ae
+index $three,$two..$res
 Binary files differ
 EOF
 test_expect_success 'diff --cc respects binary attribute' '
@@ -115,11 +121,11 @@ test_expect_success 'setup textconv attribute' '
 	git config diff.upcase.textconv "tr a-z A-Z <"
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --git a/text b/text
-index 2bdf67a..2ab19ae 100644
+index $three..$res 100644
 --- a/text
 +++ b/text
 @@ -1 +1 @@
@@ -128,7 +134,7 @@ index 2bdf67a..2ab19ae 100644
 resolved
 
 diff --git a/text b/text
-index f719efd..2ab19ae 100644
+index $two..$res 100644
 --- a/text
 +++ b/text
 @@ -1 +1 @@
@@ -140,11 +146,11 @@ test_expect_success 'diff -m respects textconv attribute' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --combined text
-index 2bdf67a,f719efd..2ab19ae
+index $three,$two..$res
 --- a/text
 +++ b/text
 @@@ -1,1 -1,1 +1,1 @@@
@@ -157,11 +163,11 @@ test_expect_success 'diff -c respects textconv attribute' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 resolved
 
 diff --cc text
-index 2bdf67a,f719efd..2ab19ae
+index $three,$two..$res
 --- a/text
 +++ b/text
 @@@ -1,1 -1,1 +1,1 @@@
@@ -174,9 +180,9 @@ test_expect_success 'diff --cc respects textconv attribute' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 diff --combined text
-index 2bdf67a,f719efd..2ab19ae
+index $three,$two..$res
 --- a/text
 +++ b/text
 @@@ -1,1 -1,1 +1,1 @@@
@@ -190,9 +196,9 @@ test_expect_success 'diff-tree plumbing does not respect textconv' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 diff --cc text
-index 2bdf67a,f719efd..0000000
+index $three,$two..0000000
 --- a/text
 +++ b/text
 @@@ -1,1 -1,1 +1,5 @@@
