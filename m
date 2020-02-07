Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE82C352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574020838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SECx9Hfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGAxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55546 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBGAxf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:35 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 609F260456;
        Fri,  7 Feb 2020 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036814;
        bh=WLjgqN2esEpcT1vh2z6VDQ+nQ6v3NyDvQpsQeaNWli0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SECx9HfrySjz21MnTry5lEgaz82eYXYSA+vau4ktzlt1ZBqHZ3L0AGANf1dNnQbQV
         1AwWkl1TPhE5+c7QUYURWEqGzJevD5f/C1kVDcAANA3oSwkLGV9bouzxtP5ewi/rPo
         YPmP/gSkMfLkgJP+1pc9b2OFeH8R0qdoYddaE3bwwLGWSCMq1jgWX9g3oXWwuGbq4y
         kuVvYoe+VcAXkECAfK0Wt5A3Pbd4yhVaRqV/EeQjqId8KJos125hXTDBuu6lV5ca2/
         EzmM3EKpPc1JrdbosEcDWYrZ2YM3ln6uiAbabDLGJSzLs0OnCqeqLDvP+yZi1qVw9e
         fuc+GoePNZmvOIExmzjPuuQSpXPKopKi+qZdzOOtiNrN+0wH0gQp611HlN27KQCrVS
         AJuuOl2SJmhMU/8/phgZsK92X5hAzBcaG+oXqrRJ4xfLWRHKBWooj4W6asocxDlj4P
         q48u0wlTvEfzp1+gg389gfKFvtX/qSraNowSgwG+qPdJYBRWCO7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/21] t3311: make test work with SHA-256
Date:   Fri,  7 Feb 2020 00:52:39 +0000
Message-Id: <20200207005254.1495851-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the hard-coded SHA-1 constants with the use of test_oid to look
up an appropriate constant for each hash algorithm.  In addition, adjust
the fanout checks to look for either zero or one slashes in the filename
without needing to check for an explicit length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3311-notes-merge-fanout.sh | 60 ++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 37151a3adc..5b675417e9 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -29,15 +29,10 @@ verify_fanout () {
 	git ls-tree -r --name-only "refs/notes/$notes_ref" |
 	while read path
 	do
-		case "$path" in
-		??/??????????????????????????????????????)
-			: true
-			;;
-		*)
+		echo "$path" | grep "^../[0-9a-f]*$" || {
 			echo "Invalid path \"$path\"" &&
-			return 1
-			;;
-		esac
+			return 1;
+		}
 	done
 }
 
@@ -48,15 +43,10 @@ verify_no_fanout () {
 	git ls-tree -r --name-only "refs/notes/$notes_ref" |
 	while read path
 	do
-		case "$path" in
-		????????????????????????????????????????)
-			: true
-			;;
-		*)
+		echo "$path" | grep -v "^../.*" || {
 			echo "Invalid path \"$path\"" &&
-			return 1
-			;;
-		esac
+			return 1;
+		}
 	done
 }
 
@@ -67,7 +57,27 @@ test_expect_success 'setup a few initial commits with notes (notes ref: x)' '
 	do
 		test_commit "commit$i" >/dev/null &&
 		git notes add -m "notes for commit$i" || return 1
-	done
+	done &&
+
+	git log --format=oneline &&
+
+	test_oid_cache <<-EOF
+	hash05a sha1:aed91155c7a72c2188e781fdf40e0f3761b299db
+	hash04a sha1:99fab268f9d7ee7b011e091a436c78def8eeee69
+	hash03a sha1:953c20ae26c7aa0b428c20693fe38bc687f9d1a9
+	hash02a sha1:6358796131b8916eaa2dde6902642942a1cb37e1
+	hash01a sha1:b02d459c32f0e68f2fe0981033bb34f38776ba47
+	hash03b sha1:9f506ee70e20379d7f78204c77b334f43d77410d
+	hash02b sha1:23a47d6ea7d589895faf800752054818e1e7627b
+
+	hash05a sha256:3aae5d26619d96dba93795f66325716e4cbc486884f95a6adee8fb0615a76d12
+	hash04a sha256:07e43dd3d89fe634d3252e253b426aacc7285a995dcdbcf94ac284060a1122cf
+	hash03a sha256:26fb52eaa7f4866bf735254587be7b31209ec10e525912ffd8e8ba549ba892ff
+	hash02a sha256:b57ebdf23634e750dcbc4b9a37991d70f90830d568a0e4529ce9de0a3f8d605c
+	hash01a sha256:377903b1572bd5117087a5518fcb1011b5053cccbc59e3c7c823a8615204173b
+	hash03b sha256:04e7b392fda7c185bfa17c9179b56db732edc2dc2b3bf887308dcaabb717270d
+	hash02b sha256:66099aaaec49a485ed990acadd9a9b81232ea592079964113d8f581ff69ef50b
+	EOF
 '
 
 commit_sha1=$(git rev-parse commit1^{commit})
@@ -77,11 +87,11 @@ commit_sha4=$(git rev-parse commit4^{commit})
 commit_sha5=$(git rev-parse commit5^{commit})
 
 cat <<EOF | sort >expect_notes_x
-aed91155c7a72c2188e781fdf40e0f3761b299db $commit_sha5
-99fab268f9d7ee7b011e091a436c78def8eeee69 $commit_sha4
-953c20ae26c7aa0b428c20693fe38bc687f9d1a9 $commit_sha3
-6358796131b8916eaa2dde6902642942a1cb37e1 $commit_sha2
-b02d459c32f0e68f2fe0981033bb34f38776ba47 $commit_sha1
+$(test_oid hash05a) $commit_sha5
+$(test_oid hash04a) $commit_sha4
+$(test_oid hash03a) $commit_sha3
+$(test_oid hash02a) $commit_sha2
+$(test_oid hash01a) $commit_sha1
 EOF
 
 cat >expect_log_x <<EOF
@@ -145,9 +155,9 @@ test_expect_success 'Fast-forward merge (y => x)' '
 '
 
 cat <<EOF | sort >expect_notes_z
-9f506ee70e20379d7f78204c77b334f43d77410d $commit_sha3
-23a47d6ea7d589895faf800752054818e1e7627b $commit_sha2
-b02d459c32f0e68f2fe0981033bb34f38776ba47 $commit_sha1
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02b) $commit_sha2
+$(test_oid hash01a) $commit_sha1
 EOF
 
 cat >expect_log_z <<EOF
