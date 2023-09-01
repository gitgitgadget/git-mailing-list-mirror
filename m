Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8ACCA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 00:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347982AbjIAA5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbjIAA5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 20:57:46 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D18E57
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 17:57:43 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D48061F406;
        Fri,  1 Sep 2023 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1693529862;
        bh=5cf63VQfCyev2ZfimwJAoOI7Jc2kiAqU+GiSuQ3/40k=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CuAKu1pEhSZnAL4XTntKqiobZDn/Kf9oqo6QRo9xZgXrP5SiTcjra2+CMzIQ4nKtX
         h6cgeDuURQ5LYKTXCiiyEQ28u1kyKMjexw3oQRD0HqekdPIPM7Mn0QHmXwznzaZ5M8
         fuaoIY4sdH76VZBAS7MbuCJ+CBAPruVDKc+qdHuI=
Date:   Fri, 1 Sep 2023 00:57:42 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [REGRESSION] Can't clone GitHub repos (fetch-pack error) due to
 avoiding deprecated OpenSSL SHA-1 routines
Message-ID: <20230901005742.M783359@dcvr>
References: <ZPCL11k38PXTkFga@debian.me>
 <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> Hopefully this gives someone a good push in the right direction on
> solving the problem.

Thanks.  Here's my WIP which fixes clones on SHA-1 and SHA-256
 <https://80x24.org/sha256test.git> and also t1050-large.sh, but
t1514-rev-parse-push.sh is still broken...

That said, I don't much understand some of the code I'm modifying
and just poking at it until tests pass and valgrind is happy :x

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
