Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF6C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3B22E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbhARXwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:52:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387806AbhARXwD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:52:03 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 218F460820;
        Mon, 18 Jan 2021 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013811;
        bh=iOk2zNQtGOchx4/xFaRbXMeuwZfTKEgGvqnvKg8PJc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KhWx9rFrFSMOAVCV/+G8sIw20vBe64a40eFBsBE47jOuLQzYzr/z7iMnhRQxKLjDz
         fc6hFwZLnSdrO0uBNh4Rk7YqvI1ZbW7rzDjlxMoQdOGJ4lQxnqgu6ywGgbhAZoCdHj
         A3RhXSslbKR2ATgBWjjxIA7b9GQAbkkx5mRgD/fc7maMWtFXC3NoLKdjDUFs3IpuhI
         Msi9F5bUnieCW4fX9pvKrcRLdsc5nTmogEASaioSS4mMxabOjpKYP71b1ip0gdlQ5M
         xkBywqHRidaaoTq3BTyK6ZQSFe1QoO8NfCLTjgs6jILWljF9p9gTMPVWPOgqTI8+WJ
         xgvOcNp+VUJBeb7ZDF9GOSVFfSd5qB5Jc7PvGyn7DSIV+Ggpv1LygbiEvxfiP3Ed3/
         fOhEdchxXAkl7YrmHm3N8I+xWtWUmVNYQQ+n8MfhLjPjVSQF1gwk92AJp2g9kKTpJZ
         Sm+V1w7m48HxqBEm8NOEJ98hP4MghJk6wEah+JyFS97X9UJcUFR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 6/6] gpg-interface: remove other signature headers before verifying
Date:   Mon, 18 Jan 2021 23:49:15 +0000
Message-Id: <20210118234915.2036197-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <20210118234915.2036197-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a multiply signed commit, we need to remove the signature
in the header before verifying the object, since the trailing signature
will not be over both pieces of data.  Do so, and verify that we
validate the signature appropriately.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 gpg-interface.c |  2 ++
 t/t7004-tag.sh  | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index c6274c14af..127aecfc2b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "commit.h"
 #include "config.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -366,6 +367,7 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
 	size_t match = parse_signed_buffer(buf, size);
 	if (match != size) {
 		strbuf_add(payload, buf, match);
+		remove_signature(payload);
 		strbuf_add(signature, buf + match, size - match);
 		return 1;
 	}
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 05f411c821..6fb4e3cf11 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -17,6 +17,13 @@ tag_exists () {
 	git show-ref --quiet --verify refs/tags/"$1"
 }
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOM
+	othersigheader sha1:gpgsig-sha256
+	othersigheader sha256:gpgsig
+	EOM
+'
+
 test_expect_success 'listing all tags in an empty tree should succeed' '
 	git tag -l &&
 	git tag
@@ -1371,6 +1378,24 @@ test_expect_success GPG \
 	'test_config gpg.program echo &&
 	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
+# try to produce invalid signature
+test_expect_success GPG 'git verifies tag is valid with double signature' '
+	git tag -s -m tail tag-gpg-double-sig &&
+	git cat-file tag tag-gpg-double-sig >tag &&
+	othersigheader=$(test_oid othersigheader) &&
+	sed -ne "/^\$/q;p" tag >new-tag &&
+	cat <<-EOM >>new-tag &&
+	$othersigheader -----BEGIN PGP SIGNATURE-----
+	 someinvaliddata
+	 -----END PGP SIGNATURE-----
+	EOM
+	sed -e "1,/^tagger/d" tag >>new-tag &&
+	new_tag=$(git hash-object -t tag -w new-tag) &&
+	git update-ref refs/tags/tag-gpg-double-sig $new_tag &&
+	git verify-tag tag-gpg-double-sig &&
+	git fsck
+'
+
 # try to sign with bad user.signingkey
 test_expect_success GPGSM \
 	'git tag -s fails if gpgsm is misconfigured (bad key)' \
