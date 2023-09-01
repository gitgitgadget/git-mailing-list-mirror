Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC362CA0FE2
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 02:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbjIACJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjIACJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 22:09:32 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CCE6E
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 19:09:29 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AF92C1F406;
        Fri,  1 Sep 2023 02:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1693534168;
        bh=FdaY3lglpGu4jhKC8cyN5XEn9QuNltLR5A4QPSPCX1I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rMVXds49971jBC8aPv63qqk93Mm3ZUgJebFvaDdZBUB/y1kFoM7/d2XWo1P6a5yG8
         LHD7avWyzdYhV4VXd2RKGJqIzrQL51hbjjMoc4FPuOM5S/S4q834uMNNrl8xM6jCdG
         xcZvgp21VXz5TLEBRKO65cDszWGYRWrCxKCfnz9w=
Date:   Fri, 1 Sep 2023 02:09:28 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] treewide: fix various bugs w/ OpenSSL 3+ EVP API
Message-ID: <20230901020928.M610756@dcvr>
References: <ZPCL11k38PXTkFga@debian.me>
 <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
 <20230901005742.M783359@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901005742.M783359@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The OpenSSL 3+ EVP API for SHA-* cannot support our prior use cases
supported by other SHA-* implementations.  It has the following
differences:

1. ->init_fn is required before all use
2. struct assignments don't work and requires ->clone_fn
3. can't support ->update_fn after ->final_*fn

While fixing cases 1 and 2 is merely the matter of calling ->init_fn and
->clone_fn as appropriate, fixing case 3 requires calling ->final_*fn on
a temporary context that's cloned from the primary context.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/ZPCL11k38PXTkFga@debian.me/
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Fixes: 3e440ea0aba0 ("sha256: avoid functions deprecated in OpenSSL 3+")
Fixes: bda9c12073e7 ("avoid SHA-1 functions deprecated in OpenSSL 3+")
Signed-off-by: Eric Wong <e@80x24.org>
---
 Ugh, I wonder if I setup my config.mak incorrectly when testing
 3e440ea0aba0 and bda9c12073e7 :x

 There may be other misuses not exposed by the test suite.  Making
 git_hash_ctx opaque could flush out some of them (but I dislike
 APIs which force heap allocations in the first place).  In any case,
 I really wish git relied less on globals so object lifetimes could be
 more obvious and really wish all C projects could rely on
 gcc/tinycc/clang-supported __attribute__((__cleanup__)) to make
 lifetimes easier-to-manage...

 builtin/fast-import.c    | 1 +
 builtin/index-pack.c     | 5 ++++-
 builtin/unpack-objects.c | 5 ++++-
 bulk-checkin.c           | 1 +
 csum-file.c              | 2 +-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 4dbb10aff3..444f41cf8c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1102,6 +1102,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();
 
+	the_hash_algo->init_fn(&checkpoint.ctx);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 006ffdc9c5..dda94a9f46 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1166,6 +1166,7 @@ static void parse_pack_objects(unsigned char *hash)
 	struct ofs_delta_entry *ofs_delta = ofs_deltas;
 	struct object_id ref_delta_oid;
 	struct stat st;
+	git_hash_ctx tmp_ctx;
 
 	if (verbose)
 		progress = start_progress(
@@ -1202,7 +1203,9 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
-	the_hash_algo->final_fn(hash, &input_ctx);
+	the_hash_algo->init_fn(&tmp_ctx);
+	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
+	the_hash_algo->final_fn(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 32505255a0..fef7423448 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -609,6 +609,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 {
 	int i;
 	struct object_id oid;
+	git_hash_ctx tmp_ctx;
 
 	disable_replace_refs();
 
@@ -669,7 +670,9 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	the_hash_algo->init_fn(&ctx);
 	unpack_all();
 	the_hash_algo->update_fn(&ctx, buffer, offset);
-	the_hash_algo->final_oid_fn(&oid, &ctx);
+	the_hash_algo->init_fn(&tmp_ctx);
+	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
+	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
 	if (strict) {
 		write_rest();
 		if (fsck_finish(&fsck_options))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 73bff3a23d..92b9c8598b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -268,6 +268,7 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
 					  type, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
+	the_hash_algo->init_fn(&checkpoint.ctx);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
diff --git a/csum-file.c b/csum-file.c
index cd01713244..870748e016 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -207,7 +207,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	f->ctx = checkpoint->ctx;
+	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
