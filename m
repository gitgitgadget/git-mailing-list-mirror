Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82374C43464
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555832065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m8m9Qf3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGZTz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728072AbgGZTzW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B0D7E61017;
        Sun, 26 Jul 2020 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793290;
        bh=k6HkAOwRB3MgcFC631NNuy/NpwHjAGw248j4K1mxfKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m8m9Qf3h5BQGH6bSZ8lfb52JyhXPbAAKPTYMCMO4B3qC1/+q4tZwPGbRdCw8QCJm3
         JLeGt7Z4rbCPNhKJyat0qIm1mjloPgRDofdtFFrIX2S3Q11Rz3fAsh5sS23vwDFD/9
         Obq4xnvZyxR+dZmL9RBske/DKlh4hpfHM/m0tR7Wz7FqP24dEuUbGpL1Z51CCLo1X7
         CNYhcFynDmdFauIeUgL7Snm8e63vQmPqLG5uJoGTKyp02g3WsmDTxDHvvR2PoOpz7c
         S5bosgKEgjeP+Sy2dRxsJTYWdMjDApLKw3cm9DxjMaRIvKKG3QothkRRrx2ENys4w6
         0EV8xhBG6xlrYMimQGA1x3BeR9fSd1fqaQ+PQ+9PPga9mACQss/jozg2tIdMwwXFDe
         NOkNP4Y5nr58u7vh+Ut71ENa1EW7af0shumpRUb6UHbhCGTmMWjpc1IKUGQ1DU36P0
         oCGtj6zX+KxuxgDPTL8q7LUALIi7ReDRq9OdpBZ+r++Hv9zSGe8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 21/39] t9300: abstract away SHA-1-specific constants
Date:   Sun, 26 Jul 2020 19:54:06 +0000
Message-Id: <20200726195424.626969-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
 t/t9300-fast-import.sh | 107 ++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 49 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e151df81c0..69d6fa4127 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -285,7 +285,7 @@ test_expect_success 'A: verify pack' '
 
 test_expect_success 'A: verify diff' '
 	cat >expect <<-EOF &&
-	:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
+	:000000 100755 0000000000000000000000000000000000000000 $(git rev-parse --verify master:file2) A	copy-of-file2
 	EOF
 	git diff-tree -M -r master verify--import-marks >actual &&
 	compare_diff_raw expect actual &&
@@ -528,6 +528,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 test_expect_success 'C: incremental import create pack from stdin' '
 	newf=$(echo hi newf | git hash-object -w --stdin) &&
 	oldf=$(git rev-parse --verify master:file2) &&
+	thrf=$(git rev-parse --verify master:file3) &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/branch
@@ -570,10 +571,11 @@ test_expect_success 'C: verify commit' '
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
@@ -614,9 +616,11 @@ test_expect_success 'D: verify pack' '
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
@@ -779,12 +783,13 @@ test_expect_success 'H: verify pack' '
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
@@ -935,14 +940,15 @@ test_expect_success 'L: verify internal tree sorting' '
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
@@ -1004,7 +1010,7 @@ test_expect_success 'M: rename file in same subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
+	:100755 100755 $newf $newf R100	file2/newf	file2/n.e.w.f
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M1^ M1 >actual &&
@@ -1025,7 +1031,7 @@ test_expect_success 'M: rename file to new subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
+	:100755 100755 $newf $newf R100	file2/newf	i/am/new/to/you
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M2^ M2 >actual &&
@@ -1046,7 +1052,7 @@ test_expect_success 'M: rename subdirectory to new subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
+	:100755 100755 $newf $newf R100	i/am/new/to/you	other/sub/am/new/to/you
 	EOF
 	git fast-import <input &&
 	git diff-tree -M -r M3^ M3 >actual &&
@@ -1067,11 +1073,11 @@ test_expect_success 'M: rename root to subdirectory' '
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
@@ -1097,7 +1103,7 @@ test_expect_success 'N: copy file in same subdirectory' '
 	INPUT_END
 
 	cat >expect <<-EOF &&
-	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
+	:100755 100755 $newf $newf C100	file2/newf	file2/n.e.w.f
 	EOF
 	git fast-import <input &&
 	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
@@ -1129,9 +1135,9 @@ test_expect_success 'N: copy then modify subdirectory' '
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
@@ -1162,9 +1168,9 @@ test_expect_success 'N: copy dirty subdirectory' '
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
@@ -1183,9 +1189,9 @@ test_expect_success 'N: copy directory by id' '
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
@@ -1254,9 +1260,9 @@ test_expect_success PIPE 'N: empty directory reads as missing' '
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
@@ -1275,12 +1281,12 @@ test_expect_success 'N: copy root directory by tree hash' '
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
@@ -1340,10 +1346,10 @@ test_expect_success 'N: delete directory by copying' '
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
@@ -3117,6 +3123,9 @@ test_expect_success 'U: initialize for U tests' '
 
 	INPUT_END
 
+	f7id=$(echo "blob 1" | git hash-object --stdin) &&
+	f8id=$(echo "sleep well" | git hash-object --stdin) &&
+	f9id=$(echo "au revoir" | git hash-object --stdin) &&
 	git fast-import <input
 '
 
@@ -3137,7 +3146,7 @@ test_expect_success 'U: filedelete file succeeds' '
 
 test_expect_success 'U: validate file delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
+	:100644 000000 $f8id $ZERO_OID D	good/night.txt
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
@@ -3162,7 +3171,7 @@ test_expect_success 'U: filedelete directory succeeds' '
 
 test_expect_success 'U: validate directory delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
+	:100644 000000 $f9id $ZERO_OID D	good/bye.txt
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
@@ -3187,7 +3196,7 @@ test_expect_success 'U: filedelete root succeeds' '
 
 test_expect_success 'U: validate root delete result' '
 	cat >expect <<-EOF &&
-	:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
+	:100644 000000 $f7id $ZERO_OID D	hello.c
 	EOF
 
 	git diff-tree -M -r U^1 U >actual &&
