Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC94C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B398F64EDF
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBKCJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:09:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhBKCJp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Feb 2021 21:09:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0910460DE3;
        Thu, 11 Feb 2021 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613009302;
        bh=cM8VAcsryztCeluStcbS2q6jd24g6y1lJSwvI36NJr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YHycIUlR3Wf4uFArSsKH32BAjFSV974D861tL7Qxw3FXfBs8CZTMSLsz0LU80yrvh
         9iacO6W8iYgLkOJfk2JxeLSkocgt2dpw/5BR8j7fRP1hLZsyN6AKPJvJNy3zwI9TxZ
         NHqlRX1KtzgZ10PpMIqZpCW71BmsHlMfNuLHNM/vO676hV/7LQhvQX6vtdzEyvnc+M
         wyK4JURX8VPXkj5VNQDQW7VAikfiXeNWFh0gDkHZ7fj2dBOLB2TyDRtVqm8znFqMVR
         G2Z26aTD/1v9w+14VZB876POzYc30NmqxZrezHW6PdhlSHZPI89z3NznZSerPLcfsO
         e4IQrC2/ZEQdnJSV+dfYRT00Dqovog1tiaaf8vwAq+0AKH2AlbU3qg852t0iMZESu0
         BSUV4gbv5lMB5G6gZfovJkLvHUCGFuJcij9l4FixBazSFosoYsXTtWCzepNKsberob
         KYw6uSEMw+AK8Txaub5MvfXaWF5ExxmVll9ZR/JeR0POa54ZcrC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 6/6] gpg-interface: remove other signature headers before verifying
Date:   Thu, 11 Feb 2021 02:08:06 +0000
Message-Id: <20210211020806.288523-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210211020806.288523-1-sandals@crustytoothpaste.net>
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
 <20210211020806.288523-1-sandals@crustytoothpaste.net>
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
index 943a7d5c1d..400b83a49e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -20,6 +20,13 @@ tag_exists () {
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
@@ -1374,6 +1381,24 @@ test_expect_success GPG \
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
