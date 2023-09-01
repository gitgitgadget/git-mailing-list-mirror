Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F80CA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 05:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbjIAFcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 01:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbjIAFcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 01:32:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DBE7E
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 22:32:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92EB6234B1;
        Fri,  1 Sep 2023 01:32:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=XEw9PsR419x4q4uyofbvb62WU2Jxg46GhDmNME
        5A9F4=; b=q0Ix+gNXiyMRDC4VR9Y2oHbCwLjBwg4Enp8UBphHWwrIPxkPVTUpTp
        nmR4p3WoH4zt5s001E8mnBV9EKbQLKPIvrdcu7v0CpMADo6O5Lx2/pL4YF/Nx5d1
        8lF0x8bEUJFS7L0dQqPM9fqiSatgaAoxY/f00ZdKmWTEazVdrj2tw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D4B9234B0;
        Fri,  1 Sep 2023 01:32:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FEFB234AF;
        Fri,  1 Sep 2023 01:32:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] treewide: fix various bugs w/ OpenSSL 3+ EVP API
In-Reply-To: <20230901020928.M610756@dcvr> (Eric Wong's message of "Fri, 1 Sep
        2023 02:09:28 +0000")
References: <ZPCL11k38PXTkFga@debian.me>
        <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
        <20230901005742.M783359@dcvr> <20230901020928.M610756@dcvr>
Date:   Thu, 31 Aug 2023 22:32:06 -0700
Message-ID: <xmqqledqsbl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E43861CA-4888-11EE-8703-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> The OpenSSL 3+ EVP API for SHA-* cannot support our prior use cases
> supported by other SHA-* implementations.  It has the following
> differences:
>
> 1. ->init_fn is required before all use
> 2. struct assignments don't work and requires ->clone_fn
> 3. can't support ->update_fn after ->final_*fn
>
> While fixing cases 1 and 2 is merely the matter of calling ->init_fn and
> ->clone_fn as appropriate, fixing case 3 requires calling ->final_*fn on
> a temporary context that's cloned from the primary context.
>
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Link: https://lore.kernel.org/ZPCL11k38PXTkFga@debian.me/
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Fixes: 3e440ea0aba0 ("sha256: avoid functions deprecated in OpenSSL 3+")
> Fixes: bda9c12073e7 ("avoid SHA-1 functions deprecated in OpenSSL 3+")
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  Ugh, I wonder if I setup my config.mak incorrectly when testing
>  3e440ea0aba0 and bda9c12073e7 :x

The third kind looks like a fun one to diagnoise and fix.

Thanks.  Will queue.

>  There may be other misuses not exposed by the test suite.  Making
>  git_hash_ctx opaque could flush out some of them (but I dislike
>  APIs which force heap allocations in the first place).  In any case,
>  I really wish git relied less on globals so object lifetimes could be
>  more obvious and really wish all C projects could rely on
>  gcc/tinycc/clang-supported __attribute__((__cleanup__)) to make
>  lifetimes easier-to-manage...
>
>  builtin/fast-import.c    | 1 +
>  builtin/index-pack.c     | 5 ++++-
>  builtin/unpack-objects.c | 5 ++++-
>  bulk-checkin.c           | 1 +
>  csum-file.c              | 2 +-
>  5 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 4dbb10aff3..444f41cf8c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1102,6 +1102,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
>  		cycle_packfile();
>  
> +	the_hash_algo->init_fn(&checkpoint.ctx);
>  	hashfile_checkpoint(pack_file, &checkpoint);
>  	offset = checkpoint.offset;
>  
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 006ffdc9c5..dda94a9f46 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1166,6 +1166,7 @@ static void parse_pack_objects(unsigned char *hash)
>  	struct ofs_delta_entry *ofs_delta = ofs_deltas;
>  	struct object_id ref_delta_oid;
>  	struct stat st;
> +	git_hash_ctx tmp_ctx;
>  
>  	if (verbose)
>  		progress = start_progress(
> @@ -1202,7 +1203,9 @@ static void parse_pack_objects(unsigned char *hash)
>  
>  	/* Check pack integrity */
>  	flush();
> -	the_hash_algo->final_fn(hash, &input_ctx);
> +	the_hash_algo->init_fn(&tmp_ctx);
> +	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
> +	the_hash_algo->final_fn(hash, &tmp_ctx);
>  	if (!hasheq(fill(the_hash_algo->rawsz), hash))
>  		die(_("pack is corrupted (SHA1 mismatch)"));
>  	use(the_hash_algo->rawsz);
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 32505255a0..fef7423448 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -609,6 +609,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
>  {
>  	int i;
>  	struct object_id oid;
> +	git_hash_ctx tmp_ctx;
>  
>  	disable_replace_refs();
>  
> @@ -669,7 +670,9 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
>  	the_hash_algo->init_fn(&ctx);
>  	unpack_all();
>  	the_hash_algo->update_fn(&ctx, buffer, offset);
> -	the_hash_algo->final_oid_fn(&oid, &ctx);
> +	the_hash_algo->init_fn(&tmp_ctx);
> +	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
> +	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
>  	if (strict) {
>  		write_rest();
>  		if (fsck_finish(&fsck_options))
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 73bff3a23d..92b9c8598b 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -268,6 +268,7 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
>  					  type, size);
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
> +	the_hash_algo->init_fn(&checkpoint.ctx);
>  
>  	/* Note: idx is non-NULL when we are writing */
>  	if ((flags & HASH_WRITE_OBJECT) != 0)
> diff --git a/csum-file.c b/csum-file.c
> index cd01713244..870748e016 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -207,7 +207,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
>  	    lseek(f->fd, offset, SEEK_SET) != offset)
>  		return -1;
>  	f->total = offset;
> -	f->ctx = checkpoint->ctx;
> +	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
>  	f->offset = 0; /* hashflush() was called in checkpoint */
>  	return 0;
>  }
