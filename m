Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B14C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FCE2067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k057Xg3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgG2XPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgG2XPA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6AF3E6101B;
        Wed, 29 Jul 2020 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064495;
        bh=SKmevPO4Qq7QYramn02QZyP5LKBU8aJMKfHO8ZFyktw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=k057Xg3v1VMRakKqq7GH0F9FnvRGs1bFV+C2+8zdrwjDPu+4az62v48T1spfS6/+E
         P6mhQUfwngFcOT/FolXJMM6+EbpojhUpX4DOlrGIciSP/4OvOmSA/HH6E3MAvLHXM5
         fhf3UqsS3vDD+0N/hsYGvZoB0lwoHsFIpxQ25EJf1U78EY1edRDUaEnZSN/yrXa4zu
         i3WWVMvNOJmg7oAS9IXpjMk4RUw3ZNz+omlfc3yXKsWiSWFgtxkHxWcAFzSt7RgmMP
         kMrKBP0QdlSULkSi3Q2oHqRZGwt7R280lGrIsFdt6eV9kgIl8gclaPEXQ/6k3ah+OW
         CXMLl14b8u5nBcuiY7gNRO9UJm/CBPuUn6j69/GmzhNPl5WQefjh/0SZaJJ8fs/sQh
         mNJwHzu9FYlqDKU7M+j27jG+vtrmhtQ9YFBE1Rn0XvljV6/Rgc5lUDx6FcDqIU5vTc
         qL5LZoTT7o1uWVNvASCv8ZAfPA712uzutZq1grPJkzhfYDNLc2U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 21/39] t9300: abstract away SHA-1-specific constants
Date:   Wed, 29 Jul 2020 23:14:10 +0000
Message-Id: <20200729231428.3658647-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.  In addition, use cut to filter out the object
IDs and verify only the information that we're really interested in.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9300-fast-import.sh | 108 ++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e151df81c0..f2d2cb06ad 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -284,8 +284,9 @@ test_expect_success 'A: verify pack' '
 '
 
 test_expect_success 'A: verify diff' '
+	copy=$(git rev-parse --verify master:file2) &&
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
+	:000000 100755 0000000000000000000000000000000000000000 $copy A	copy-of-file2
 	EOF
 	git diff-tree -M -r master verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
@@ -528,6 +529,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 test_expect_success 'C: incremental import create pack from stdin' '
 	newf=$(echo hi newf | git hash-object -w --stdin) &&
 	oldf=$(git rev-parse --verify master:file2) &&
+	thrf=$(git rev-parse --verify master:file3) &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/branch
@@ -570,10 +572,11 @@ test_expect_success 'C: verify commit' '
 '
 
 test_expect_success 'C: validate rename result' '
+	zero=$ZERO_OID &&
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2	file2/oldf
-	:100644 000000 0d92e9f3374ae2947c23aa477cbc68ce598135f1 0000000000000000000000000000000000000000 D	file3
+	:000000 100755 $zero $newf A	file2/newf
+	:100644 100644 $oldf $oldf R100	file2	file2/oldf
+	:100644 000000 $thrf $zero D	file3
 	EOF
 	git diff-tree -M -r master branch >actual &&
 	compare_diff_raw expect actual
@@ -614,9 +617,11 @@ test_expect_success 'D: verify pack' '
 '
 
 test_expect_success 'D: validate new files added' '
+	f5id=$(echo "$file5_data" | git hash-object --stdin) &&
+	f6id=$(echo "$file6_data" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 e74b7d465e52746be2b4bae983670711e6e66657 A	newdir/exec.sh
-	:000000 100644 0000000000000000000000000000000000000000 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 A	newdir/interesting
+	:000000 100755 0000000000000000000000000000000000000000 $f6id A	newdir/exec.sh
+	:000000 100644 0000000000000000000000000000000000000000 $f5id A	newdir/interesting
 	EOF
 	git diff-tree -M -r branch^ branch >actual &&
 	compare_diff_raw expect actual
@@ -779,12 +784,13 @@ test_expect_success 'H: verify pack' '
 '
 
 test_expect_success 'H: validate old files removed, new files added' '
+	f4id=$(git rev-parse HEAD:file4) &&
 	cat >expect <<-EOF &&
-	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file2/newf
-	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file2/oldf
-	:100755 000000 85df50785d62d3b05ab03d9cbf7e4a0b49449730 0000000000000000000000000000000000000000 D	file4
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	h/e/l/lo
-	:100755 000000 e74b7d465e52746be2b4bae983670711e6e66657 0000000000000000000000000000000000000000 D	newdir/exec.sh
+	:100755 000000 $newf $zero D	file2/newf
+	:100644 000000 $oldf $zero D	file2/oldf
+	:100755 000000 $f4id $zero D	file4
+	:100644 100644 $f5id $f5id R100	newdir/interesting	h/e/l/lo
+	:100755 000000 $f6id $zero D	newdir/exec.sh
 	EOF
 	git diff-tree -M -r H^ H >actual &&
 	compare_diff_raw expect actual
@@ -935,14 +941,15 @@ test_expect_success 'L: verify internal tree sorting' '
 	INPUT_END
 
 	cat >expect <<-EXPECT_END &&
-	:100644 100644 4268632... 55d3a52... M	b.
-	:040000 040000 0ae5cac... 443c768... M	b
-	:100644 100644 4268632... 55d3a52... M	ba
+	:100644 100644 M	b.
+	:040000 040000 M	b
+	:100644 100644 M	ba
 	EXPECT_END
 
 	git fast-import <input &&
 	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
-	test_cmp expect output
+	cut -d" " -f1,2,5 output >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'L: nested tree copy does not corrupt deltas' '
@@ -1004,7 +1011,7 @@ test_expect_success 'M: rename file in same subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
+	:100755 100755 $newf $newf R100	file2/newf	file2/n.e.w.f
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M1^ M1 >actual &&
@@ -1025,7 +1032,7 @@ test_expect_success 'M: rename file to new subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
+	:100755 100755 $newf $newf R100	file2/newf	i/am/new/to/you
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M2^ M2 >actual &&
@@ -1046,7 +1053,7 @@ test_expect_success 'M: rename subdirectory to new subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
+	:100755 100755 $newf $newf R100	i/am/new/to/you	other/sub/am/new/to/you
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M3^ M3 >actual &&
@@ -1067,11 +1074,11 @@ test_expect_success 'M: rename root to subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 R100	file2/oldf	sub/file2/oldf
-	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 R100	file4	sub/file4
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	sub/i/am/new/to/you
-	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 R100	newdir/exec.sh	sub/newdir/exec.sh
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 R100	newdir/interesting	sub/newdir/interesting
+	:100644 100644 $oldf $oldf R100	file2/oldf	sub/file2/oldf
+	:100755 100755 $f4id $f4id R100	file4	sub/file4
+	:100755 100755 $newf $newf R100	i/am/new/to/you	sub/i/am/new/to/you
+	:100755 100755 $f6id $f6id R100	newdir/exec.sh	sub/newdir/exec.sh
+	:100644 100644 $f5id $f5id R100	newdir/interesting	sub/newdir/interesting
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M4^ M4 >actual &&
@@ -1097,7 +1104,7 @@ test_expect_success 'N: copy file in same subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
+	:100755 100755 $newf $newf C100	file2/newf	file2/n.e.w.f
 	EOF
 	git fast-import <input &&
 	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
@@ -1129,9 +1136,9 @@ test_expect_success 'N: copy then modify subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	:100644 100644 $f5id $f5id C100	newdir/interesting	file3/file5
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	git fast-import <input &&
 	git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
@@ -1162,9 +1169,9 @@ test_expect_success 'N: copy dirty subdirectory' '
 '
 
 test_expect_success 'N: copy directory by id' '
-	cat >expect <<-\EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
 	cat >input <<-INPUT_END &&
@@ -1183,9 +1190,9 @@ test_expect_success 'N: copy directory by id' '
 '
 
 test_expect_success PIPE 'N: read and copy directory' '
-	cat >expect <<-\EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	git update-ref -d refs/heads/N4 &&
 	rm -f backflow &&
@@ -1254,9 +1261,9 @@ test_expect_success PIPE 'N: empty directory reads as missing' '
 '
 
 test_expect_success 'N: copy root directory by tree hash' '
-	cat >expect <<-\EOF &&
-	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
-	:100644 000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 0000000000000000000000000000000000000000 D	file3/oldf
+	cat >expect <<-EOF &&
+	:100755 000000 $newf $zero D	file3/newf
+	:100644 000000 $oldf $zero D	file3/oldf
 	EOF
 	root=$(git rev-parse refs/heads/branch^0^{tree}) &&
 	cat >input <<-INPUT_END &&
@@ -1275,12 +1282,12 @@ test_expect_success 'N: copy root directory by tree hash' '
 '
 
 test_expect_success 'N: copy root by path' '
-	cat >expect <<-\EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	oldroot/file2/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	oldroot/file2/oldf
-	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	oldroot/file4
-	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	oldroot/newdir/exec.sh
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	oldroot/newdir/interesting
+	cat >expect <<-EOF &&
+	:100755 100755 $newf $newf C100	file2/newf	oldroot/file2/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	oldroot/file2/oldf
+	:100755 100755 $f4id $f4id C100	file4	oldroot/file4
+	:100755 100755 $f6id $f6id C100	newdir/exec.sh	oldroot/newdir/exec.sh
+	:100644 100644 $f5id $f5id C100	newdir/interesting	oldroot/newdir/interesting
 	EOF
 	cat >input <<-INPUT_END &&
 	commit refs/heads/N-copy-root-path
@@ -1340,10 +1347,10 @@ test_expect_success 'N: delete directory by copying' '
 '
 
 test_expect_success 'N: modify copied tree' '
-	cat >expect <<-\EOF &&
-	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
-	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	cat >expect <<-EOF &&
+	:100644 100644 $f5id $f5id C100	newdir/interesting	file3/file5
+	:100755 100755 $newf $newf C100	file2/newf	file3/newf
+	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
 	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
 	cat >input <<-INPUT_END &&
@@ -3117,6 +3124,9 @@ test_expect_success 'U: initialize for U tests' '
 
 	INPUT_END
 
+	f7id=$(echo "blob 1" | git hash-object --stdin) &&
+	f8id=$(echo "sleep well" | git hash-object --stdin) &&
+	f9id=$(echo "au revoir" | git hash-object --stdin) &&
 	git fast-import <input
 '
 
@@ -3137,7 +3147,7 @@ test_expect_success 'U: filedelete file succeeds' '
 
 test_expect_success 'U: validate file delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
+	:100644 000000 $f8id $ZERO_OID D	good/night.txt
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
@@ -3162,7 +3172,7 @@ test_expect_success 'U: filedelete directory succeeds' '
 
 test_expect_success 'U: validate directory delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
+	:100644 000000 $f9id $ZERO_OID D	good/bye.txt
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
@@ -3187,7 +3197,7 @@ test_expect_success 'U: filedelete root succeeds' '
 
 test_expect_success 'U: validate root delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
+	:100644 000000 $f7id $ZERO_OID D	hello.c
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
