Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1511A9F82
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482758; cv=none; b=mbcuEmuOZNjhLe9m2hCSUeZx77gpUOtQ9ls4tKGxpEZ7AryuojSErG+0VHjU+Vn3BRIDI85AnvhXBiIHCcuT0K//XtPYIiSl+Lud7LCsamffF7BJa1EfkNoFlFUBBE3fIIJ9hlUF8Zy2kcAFuZ3A6bQEX2kyyzcLDwajp1ep5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482758; c=relaxed/simple;
	bh=HS8a80hh515obgzi8XMMG4ayklsSIZpKtce1UZPrjCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT27CZQsoDijyXEw5i4V0mGc8tZX3sMNsRjjE+qWYu1YziA+YjQGa0oP5CS3Pn7VWYE55sMRLcALvPEAuqk9NApfumOBvXIeO3P708suHkBPj8cwyCFn6MwUKq6TpNJEia0+ultdyR/8bMLoaWipPkqRqsSIewjcFS0VfyicEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GTwJhabj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GTwJhabj"
Received: (qmail 25388 invoked by uid 106); 8 Jul 2026 03:52:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HS8a80hh515obgzi8XMMG4ayklsSIZpKtce1UZPrjCA=; b=GTwJhabjbZdERrpCa6Q7hv4wuNJFFKb0Ek2KntOKDqEW5ydCrKlQ9eCP5QjYGwcM+ZRbUVE5HV4x5pSOpKwYxqlm6N6ZTB85kGTBwFERzEKDqH7dSk3hteDTE+YhLaPRxF4f2ko0vNADyNdJC/toNErC0QhrOVONsIC2wjfc3CsrtLVi9HDPATF2Qp9uuOr6b7Q+uzSpQ9fdRI227HWHWt2cVciIu8QbaLO8jYgqeIbq5BQNvSir5FPvlTJ3r280p2J7CmwcmrY2AFmBjPjSdkrpWo7peQj9whp+iaHLUMH/0Sk6k8LWAhzuUoOGrYBMy445vNEFPLkueEU1l/Nt/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:52:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 40968 invoked by uid 111); 8 Jul 2026 03:52:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:52:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:52:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] git_hash_*() quality-of-life improvements
Message-ID: <20260708035235.GA41491@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707045556.GA1288172@coredump.intra.peff.net>

On Tue, Jul 07, 2026 at 12:55:57AM -0400, Jeff King wrote:

> This implements the "idempotent git_hash_discard()" discussed in this
> subthread:
> 
>   https://lore.kernel.org/git/20260702080707.GG2029434@coredump.intra.peff.net/
> 
> with associated cleanups.

Here's a v2 addressing the comments so far. Mostly minor changes:

  - fixed typos noticed by Patrick

  - dropped extra braces added by coccinelle

  - dropped a trailing blank line from patch 1 (this gets fixed in a
    later patch as we add more content after the blank line, but I
    noticed "git apply" complaining)

  - a bit more explanation in patch 7 about why we don't support
    idempotent final() calls

Patch list below, followed by range diff.

  [1/7]: hash: use git_hash_init() consistently
  [2/7]: hash: convert remaining direct function calls
  [3/7]: hash: document function pointers and wrappers
  [4/7]: hash: make git_hash_discard() idempotent
  [5/7]: csum-file: use idempotent git_hash_discard()
  [6/7]: http: use idempotent git_hash_discard()
  [7/7]: hash: check ctx->active flag in all wrapper functions

 builtin/fast-import.c       |  4 +--
 builtin/index-pack.c        |  6 ++--
 builtin/patch-id.c          |  2 +-
 builtin/receive-pack.c      |  6 ++--
 builtin/submodule--helper.c | 10 +++---
 builtin/unpack-objects.c    |  4 +--
 csum-file.c                 | 23 +++++---------
 diff.c                      |  4 +--
 hash.c                      | 16 ++++++++++
 hash.h                      | 44 +++++++++++++++++++-------
 http-push.c                 |  2 +-
 http.c                      |  9 ++----
 http.h                      |  1 -
 object-file.c               | 14 ++++-----
 pack-check.c                |  2 +-
 pack-write.c                |  6 ++--
 read-cache.c                |  6 ++--
 rerere.c                    |  2 +-
 t/helper/test-hash-speed.c  |  2 +-
 t/helper/test-hash.c        |  2 +-
 t/helper/test-synthesize.c  | 33 ++++++++++---------
 t/unit-tests/u-hash.c       |  2 +-
 tools/coccinelle/hash.cocci | 63 +++++++++++++++++++++++++++++++++++++
 trace2/tr2_sid.c            |  2 +-
 24 files changed, 177 insertions(+), 88 deletions(-)
 create mode 100644 tools/coccinelle/hash.cocci


1:  2f1c8cbc98 ! 1:  911cf0dfcd hash: use git_hash_init() consistently
    @@ object-file.c: static int start_loose_object_common(struct odb_source_loose *loo
      	stream->next_out = buf;
      	stream->avail_out = buflen;
     -	algo->init_fn(c);
    --	if (compat && compat_c)
    --		compat->init_fn(compat_c);
     +	git_hash_init(c, algo);
    -+	if (compat && compat_c) {
    + 	if (compat && compat_c)
    +-		compat->init_fn(compat_c);
     +		git_hash_init(compat_c, compat);
    -+	}
      
      	/*  Start to feed header to zlib stream */
      	stream->next_in = (unsigned char *)hdr;
    @@ read-cache.c: static size_t read_eoie_extension(const char *mmap, size_t mmap_si
     
      ## rerere.c ##
     @@ rerere.c: static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
    - 	struct git_hash_ctx ctx;
      	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
      	int has_conflicts = 0;
    --	if (hash)
    + 	if (hash)
     -		the_hash_algo->init_fn(&ctx);
    -+	if (hash) {
     +		git_hash_init(&ctx, the_hash_algo);
    -+	}
      
      	while (!io->getline(&buf, io)) {
      		if (is_cmarker(buf.buf, '<', marker_size)) {
    @@ tools/coccinelle/hash.cocci (new)
     +- ALGO->init_fn(CTX);
     ++ git_hash_init(CTX, ALGO);
     +  ...>}
    -+
     
      ## trace2/tr2_sid.c ##
     @@ trace2/tr2_sid.c: static void tr2_sid_append_my_sid_component(void)
2:  cf88edda3f ! 2:  879962bf47 hash: convert remaining direct function calls
    @@ t/helper/test-synthesize.c: static int generate_pack_with_large_object(const cha
     
      ## tools/coccinelle/hash.cocci ##
     @@ tools/coccinelle/hash.cocci: struct git_hash_ctx *CTX;
    + - ALGO->init_fn(CTX);
      + git_hash_init(CTX, ALGO);
        ...>}
    - 
    ++
     +@@
     +identifier f != git_hash_clone;
     +expression ALGO;
3:  3c302bbe74 ! 3:  f06387a467 hash: document function pointers and wrappers
    @@ hash.h: struct git_hash_algo {
      
     +/*
     + * Prepare an uninitialized hash context for use. You must eventually release
    -+ * the context with with git_hash_final() (or final_oid()) or by calling
    ++ * the context with git_hash_final() (or final_oid()) or by calling
     + * git_hash_discard().
     + */
      void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop);
4:  e8b50b164a = 4:  2d876c17b1 hash: make git_hash_discard() idempotent
5:  5488debdae = 5:  3d3d5d2c63 csum-file: use idempotent git_hash_discard()
6:  15fd04f519 = 6:  91bda10e58 http: use idempotent git_hash_discard()
7:  5370cd31a8 ! 7:  2b366bc79b hash: check ctx->active flag in all wrapper functions
    @@ Commit message
         context onto the heap). Checking the flag lets us catch problems
         consistently on every build.
     
    -    Note that we can't do the same for git_init_hash(). Even though it would
    +    Note that we can't do the same for git_hash_init(). Even though it would
         cause a leak to call it twice (without an intervening final/discard),
         the point of the function is that the contents of the struct are
         undefined before the call. But calling it twice is an even less likely
         error to make, so not covering it is OK.
     
    +    We leave git_hash_discard() alone, as its idempotent behavior is
    +    convenient for callers. We _could_ try to do something similar for
    +    git_hash_final(), allowing:
    +
    +      git_hash_final(result, &ctx);
    +      git_hash_final(other_result, &ctx);
    +
    +    but it does not make much sense. After the first final() call we have
    +    thrown away the state, so we cannot produce the same output. We could
    +    come up with some sensible output (the null hash, or the empty hash),
    +    but double-calls like this are more likely a bug, so our best bet is to
    +    complain loudly (whereas the current code produces either nonsense
    +    output or undefined behavior, depending on the backend).
    +
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## hash.c ##
