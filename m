Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDDA1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfF1W7m (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfF1W7l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0F9061008;
        Fri, 28 Jun 2019 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762780;
        bh=7lJMNO+gsrUtYNoF58wVY9SRsifBXhCjtnC7ymzrUwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KmqKjrvKjDJG8llltDVc3o+DB/y47yWYoHVKMPwYeuYZ3EzI5c5HVf/G64ovoESPE
         LBJVKl0wAhIggYZAfH5zoErTeRjFAmwNG0GowJ0gYhSSPt1uh3Fcn4lzb85gbMhtD0
         s+wzj4Laxw9cnZTXbNPrXEyje3Hbmo1+jOEsnefKjv2I4PqKWAxcvLCdQFBEan2g52
         B1fgzvTBrrE/xpicnxSfpjGFDs8PhKgcM5Unqdr32s9NQil0iUYESwE4PypYYanpx7
         Tn/g+7TsSK6hy5ai8NZnjU2ZTAdGVe5eS2EyDZOJpMRDX9V8m38IuESI8eqPVMwOCg
         d7AEPiUDrB+VfmtZi31K+GAwOjgb9vgVkkfWEiem9JhoF1WFGvb6uf6Nl/f3HuEGhg
         fgSPa8omUpj5mZBN8HOr58qVwKasOfAx2LeYD7jVYXLGXrzODrZm/xaD/RiWs1Kctn
         n1IllSuOf8qVX5GUDFzzvxybTSKrwOKtx+tVVNV295tjcWuESmP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/10] t1450: make hash size independent
Date:   Fri, 28 Jun 2019 22:59:21 +0000
Message-Id: <20190628225928.622372-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190628225928.622372-1-sandals@crustytoothpaste.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace several hard-coded full and partial object IDs with variables or
computed values.  Create junk data to stuff inside an invalid tree that
can be either 20 or 32 bytes long.  Compute a binary all-zeros object ID
instead of hard-coding a 20-byte length.

Additionally, compute various object IDs by using test_oid and
$EMPTY_BLOB so that this test works with multiple hash algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1450-fsck.sh | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f268a3664..b36e0528d0 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -9,6 +9,7 @@ test_description='git fsck random collection of tests
 . ./test-lib.sh
 
 test_expect_success setup '
+	test_oid_init &&
 	git config gc.auto 0 &&
 	git config i18n.commitencoding ISO-8859-1 &&
 	test_commit A fileA one &&
@@ -54,8 +55,8 @@ test_expect_success 'setup: helpers for corruption tests' '
 
 test_expect_success 'object with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
-	old=$(echo $sha | sed "s+^..+&/+") &&
-	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
+	old=$(test_oid_to_path "$sha") &&
+	new=$(dirname $old)/$(test_oid ff_2) &&
 	sha="$(dirname $new)$(basename $new)" &&
 	mv .git/objects/$old .git/objects/$new &&
 	test_when_finished "remove_object $sha" &&
@@ -84,7 +85,7 @@ test_expect_success 'branch pointing to non-commit' '
 test_expect_success 'HEAD link pointing at a funny object' '
 	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
 	mv .git/HEAD .git/SAVED_HEAD &&
-	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
 	cat out &&
@@ -244,10 +245,16 @@ test_expect_success 'tree object with duplicate entries' '
 '
 
 test_expect_success 'unparseable tree object' '
+	test_oid_cache <<-\EOF &&
+	junk sha1:twenty-bytes-of-junk
+	junk sha256:twenty-bytes-of-junk-twelve-more
+	EOF
+
 	test_when_finished "git update-ref -d refs/heads/wrong" &&
 	test_when_finished "remove_object \$tree_sha1" &&
 	test_when_finished "remove_object \$commit_sha1" &&
-	tree_sha1=$(printf "100644 \0twenty-bytes-of-junk" | git hash-object -t tree --stdin -w --literally) &&
+	junk=$(test_oid junk) &&
+	tree_sha1=$(printf "100644 \0$junk" | git hash-object -t tree --stdin -w --literally) &&
 	commit_sha1=$(git commit-tree $tree_sha1) &&
 	git update-ref refs/heads/wrong $commit_sha1 &&
 	test_must_fail git fsck 2>out &&
@@ -275,8 +282,9 @@ test_expect_success 'tree entry with type mismatch' '
 '
 
 test_expect_success 'tag pointing to nonexistent' '
-	cat >invalid-tag <<-\EOF &&
-	object ffffffffffffffffffffffffffffffffffffffff
+	badoid=$(test_oid deadbeef) &&
+	cat >invalid-tag <<-EOF &&
+	object $badoid
 	type commit
 	tag invalid
 	tagger T A Gger <tagger@example.com> 1234567890 -0000
@@ -386,8 +394,8 @@ test_expect_success 'rev-list --verify-objects' '
 
 test_expect_success 'rev-list --verify-objects with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
-	old=$(echo $sha | sed "s+^..+&/+") &&
-	new=$(dirname $old)/ffffffffffffffffffffffffffffffffffffff &&
+	old=$(test_oid_to_path $sha) &&
+	new=$(dirname $old)/$(test_oid ff_2) &&
 	sha="$(dirname $new)$(basename $new)" &&
 	mv .git/objects/$old .git/objects/$new &&
 	test_when_finished "remove_object $sha" &&
@@ -402,7 +410,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
 	cat out &&
-	test_i18ngrep -q "error: hash mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
 '
 
 test_expect_success 'force fsck to ignore double author' '
@@ -417,13 +425,12 @@ test_expect_success 'force fsck to ignore double author' '
 '
 
 _bz='\0'
-_bz5="$_bz$_bz$_bz$_bz$_bz"
-_bz20="$_bz5$_bz5$_bz5$_bz5"
+_bzoid=$(printf $ZERO_OID | sed -e 's/00/\\0/g')
 
 test_expect_success 'fsck notices blob entry pointing to null sha1' '
 	(git init null-blob &&
 	 cd null-blob &&
-	 sha=$(printf "100644 file$_bz$_bz20" |
+	 sha=$(printf "100644 file$_bz$_bzoid" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
 	  cat out &&
@@ -434,7 +441,7 @@ test_expect_success 'fsck notices blob entry pointing to null sha1' '
 test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	(git init null-commit &&
 	 cd null-commit &&
-	 sha=$(printf "160000 submodule$_bz$_bz20" |
+	 sha=$(printf "160000 submodule$_bz$_bzoid" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
 	  cat out &&
@@ -586,7 +593,7 @@ test_expect_success 'fsck --connectivity-only' '
 		# its type. That lets us see that --connectivity-only is
 		# not actually looking at the contents, but leaves it
 		# free to examine the type if it chooses.
-		empty=.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+		empty=.git/objects/$(test_oid_to_path $EMPTY_BLOB) &&
 		blob=$(echo unrelated | git hash-object -w --stdin) &&
 		mv -f $(sha1_file $blob) $empty &&
 
@@ -631,10 +638,12 @@ test_expect_success 'fsck --name-objects' '
 
 test_expect_success 'alternate objects are correctly blamed' '
 	test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
+	name=$(test_oid numeric) &&
+	path=$(test_oid_to_path "$name") &&
 	git init --bare alt.git &&
 	echo "../../alt.git/objects" >.git/objects/info/alternates &&
-	mkdir alt.git/objects/12 &&
-	>alt.git/objects/12/34567890123456789012345678901234567890 &&
+	mkdir alt.git/objects/$(dirname $path) &&
+	>alt.git/objects/$(dirname $path)/$(basename $path) &&
 	test_must_fail git fsck >out 2>&1 &&
 	test_i18ngrep alt.git out
 '
