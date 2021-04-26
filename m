Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F6DC43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C52611CA
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhDZBEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41834 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhDZBEn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE9AB60790;
        Mon, 26 Apr 2021 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399012;
        bh=9ZAn54+fAcZjKJEA/xFlfWTiGUvNgcmeVuZYG/DPAmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NuI+uF/5+vORI3+jHKY4t9V1nVE5GwmHxUQcZnlKgPDJS5tZ5LdDVwGPzfF6tV44g
         D8Mv29X9mAoDyo9lRMY8hHG3QlBS/o9Q2KC+YAe1i8sQ2vtYWz+sg9ewNERZvihXUa
         32bFYiKYZ9L3EgQeDeGJfndoKlRlBiUZPuD9YfZ9lijdV232traJA2cafwLCmf+65d
         f7Jlt6PAJvCD2pCB2QGkeaVoMul7LDgfONU6pM9i8jmMdgnpj/W8OIK/SoU/OeRrYo
         ddoFHiWI4MlgaGQs81sFKeUQiAZbXXNy+yW8dmFTWA81l09MYJ0MnRg5GM4v0IidAe
         TnuzabilaPN+ExRHnlJp5FM2iNlpC5QvNtJBh4i8KEKwZVDystFbtKLSFshxMTLoQM
         Ru/xA35jvMaUvPSw95aK6j+TxQslnYhwgvxW9sioi/dimDfNzWeAC8Y/GA4wpQCqBv
         BiToSQJiVL12se37qm7BNuqhlSX5bcPm0rgzga0XYoKgdZ7O/1R
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/13] Use the final_oid_fn to finalize hashing of object IDs
Date:   Mon, 26 Apr 2021 01:02:53 +0000
Message-Id: <20210426010301.1093562-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're hashing a value which is going to be an object ID, we want to
zero-pad that value if necessary.  To do so, use the final_oid_fn
instead of the final_fn anytime we're going to create an object ID to
ensure we perform this operation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fast-import.c    | 4 ++--
 builtin/index-pack.c     | 2 +-
 builtin/unpack-objects.c | 2 +-
 bulk-checkin.c           | 2 +-
 diff.c                   | 2 +-
 http.c                   | 2 +-
 object-file.c            | 8 ++++----
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9d2a058a66..20406f6775 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -940,7 +940,7 @@ static int store_object(
 	the_hash_algo->init_fn(&c);
 	the_hash_algo->update_fn(&c, hdr, hdrlen);
 	the_hash_algo->update_fn(&c, dat->buf, dat->len);
-	the_hash_algo->final_fn(oid.hash, &c);
+	the_hash_algo->final_oid_fn(&oid, &c);
 	if (oidout)
 		oidcpy(oidout, &oid);
 
@@ -1136,7 +1136,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		}
 	}
 	git_deflate_end(&s);
-	the_hash_algo->final_fn(oid.hash, &c);
+	the_hash_algo->final_oid_fn(&oid, &c);
 
 	if (oidout)
 		oidcpy(oidout, &oid);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 41e2c240b8..3fbc5d7077 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -489,7 +489,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
 	if (oid)
-		the_hash_algo->final_fn(oid->hash, &c);
+		the_hash_algo->final_oid_fn(oid, &c);
 	return buf == fixed_buf ? NULL : buf;
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a8b73ecf43..6ac90dc5f7 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -576,7 +576,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	the_hash_algo->init_fn(&ctx);
 	unpack_all();
 	the_hash_algo->update_fn(&ctx, buffer, offset);
-	the_hash_algo->final_fn(oid.hash, &ctx);
+	the_hash_algo->final_oid_fn(&oid, &ctx);
 	if (strict) {
 		write_rest();
 		if (fsck_finish(&fsck_options))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6f3c97cd34..127312acd1 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -238,7 +238,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_fn(result_oid->hash, &ctx);
+	the_hash_algo->final_oid_fn(result_oid, &ctx);
 	if (!idx)
 		return 0;
 
diff --git a/diff.c b/diff.c
index 4acccd9d7e..97c62f47df 100644
--- a/diff.c
+++ b/diff.c
@@ -6234,7 +6234,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	}
 
 	if (!stable)
-		the_hash_algo->final_fn(oid->hash, &ctx);
+		the_hash_algo->final_oid_fn(oid, &ctx);
 
 	return 0;
 }
diff --git a/http.c b/http.c
index 406410f884..c83bc33a5f 100644
--- a/http.c
+++ b/http.c
@@ -2576,7 +2576,7 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_inflate_end(&freq->stream);
-	the_hash_algo->final_fn(freq->real_oid.hash, &freq->c);
+	the_hash_algo->final_oid_fn(&freq->real_oid, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
diff --git a/object-file.c b/object-file.c
index ef1eb984c8..1d8c82fa99 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1054,7 +1054,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			break;
 		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	r->hash_algo->final_fn(real_oid.hash, &c);
+	r->hash_algo->final_oid_fn(&real_oid, &c);
 	close_istream(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
@@ -1755,7 +1755,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	algo->init_fn(&c);
 	algo->update_fn(&c, hdr, *hdrlen);
 	algo->update_fn(&c, buf, len);
-	algo->final_fn(oid->hash, &c);
+	algo->final_oid_fn(oid, &c);
 }
 
 /*
@@ -1927,7 +1927,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
-	the_hash_algo->final_fn(parano_oid.hash, &c);
+	the_hash_algo->final_oid_fn(&parano_oid, &c);
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
@@ -2508,7 +2508,7 @@ static int check_stream_oid(git_zstream *stream,
 		return -1;
 	}
 
-	the_hash_algo->final_fn(real_oid.hash, &c);
+	the_hash_algo->final_oid_fn(&real_oid, &c);
 	if (!oideq(expected_oid, &real_oid)) {
 		error(_("hash mismatch for %s (expected %s)"), path,
 		      oid_to_hex(expected_oid));
