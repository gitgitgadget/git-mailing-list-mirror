Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99A35F61E
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103277; cv=none; b=vCBTh5nSJDmNFrYgbINCG3GKYxnpW53nWpQROcK9SfuW1LLZIQhvPvBhikkp2SGtS/tu6N2btzsGL19QYncl3QjGTOAqZ3fCG+Xc3CREM9Ki+Jv8/NnMziB7NBbVjsWrCY7dX8nak6gaNlJdGm6o3s3CCyqO2TGoK3A9cavFHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103277; c=relaxed/simple;
	bh=hFy1SiiwrqwGYUtLuLZbJZ4QEWPFewh70SzJhn7sad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+mFGB7yj7NQjLHTIrUgUH1Rado5D7j7qLYmMNcBEx3SGb/VYMMonMwyHjdg3JtNnBidh17tPDfW68gXh0R8a6QfIwS9mYUNPyOxZALeJIEkS5j8ukkOEnkITokO/U+R49bA+cEKb4XIMgrJ9NyeCq7doJFEC9h06Q1sn46U1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H50mWNhv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H50mWNhv"
Received: (qmail 218752 invoked by uid 106); 2 Apr 2026 04:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hFy1SiiwrqwGYUtLuLZbJZ4QEWPFewh70SzJhn7sad0=; b=H50mWNhvgoKQVgBlCb3eJKv4ZnOpjhcxO+xJVTd+cnQfhIBjuTvKr9CEPVEQ3xZx/hSYbMWcHutWYhTf16rlnSI4Az8s9hIzvwTdiTbtW1BtFTM428oqdc3o+OVey3C2NsHDQ5g1Oqw/EoVh1jA1k3iLczNwsjxW4F7i23GznpcYxwYSQVi+2eagyu+OYz1E9vJL80NvoqCUBO8rqdJ/qg2epXp/baNugH3WTtAkBPSGNtFXNTysn4zh1ze8qufBbX30akZ2ic2P81k6euOq3c6bw2AmqShQfrWs4+d51VxkIVFcZZBrz6ZDezs55PczwBbYWna7QbdmkRxwOs7Y3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349682 invoked by uid 111); 2 Apr 2026 04:14:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:14:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:14:33 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 0/12] fixing the remainder of the C23 strchr warnings
Message-ID: <20260402041433.GA3501120@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:38:57PM -0400, Jeff King wrote:

> This series fixes the rest of the warnings you might see on recent glibc
> or other C23 libc where:
> [...]

And here's a v2 with some minor changes based on review of round 1:

  - move cast in patch 4 to split_cmdline(); note that this makes the
    patch totally different from range-diff's perspective

  - fix NULL/NUL typo

  - use _impl() suffix consistently for wrapped functions. I also
    reordered the macro definitions a bit for readability. Patch 8 also
    does not show up in range-diff (unlike patch 4, you can convince it
    to show it with "--creation-factor=80", but the result is not very
    readable anyway).

  [01/12]: convert: add const to fix strchr() warnings
  [02/12]: http: add const to fix strchr() warnings
  [03/12]: transport-helper: drop const to fix strchr() warnings
  [04/12]: pager: explicitly cast away strchr() constness
  [05/12]: run-command: explicitly cast away constness when assigning to void
  [06/12]: find_last_dir_sep(): convert inline function to macro
  [07/12]: pseudo-merge: fix disk reads from find_pseudo_merge()
  [08/12]: skip_prefix(): check const match between in and out params
  [09/12]: pkt-line: make packet_reader.line non-const
  [10/12]: range-diff: drop const to fix strstr() warnings
  [11/12]: http: drop const to fix strstr() warning
  [12/12]: refs/files-backend: drop const to fix strchr() warning

 builtin/receive-pack.c |  7 ++++---
 convert.c              |  3 ++-
 git-compat-util.h      | 33 ++++++++++++++++++++++++---------
 hex.c                  |  6 +++---
 hex.h                  |  6 ++++--
 http-push.c            |  2 +-
 http.c                 |  4 ++--
 pager.c                |  5 +++--
 pkt-line.h             |  2 +-
 pseudo-merge.c         | 32 +++++++++++++++++++-------------
 range-diff.c           |  2 +-
 refs/files-backend.c   |  2 +-
 run-command.c          |  4 ++--
 send-pack.c            |  7 ++++---
 transport-helper.c     |  3 ++-
 15 files changed, 73 insertions(+), 45 deletions(-)

 1:  4b149037ed =  1:  785b9cd5c0 convert: add const to fix strchr() warnings
 2:  65eb42692e =  2:  6e4b0b2e50 http: add const to fix strchr() warnings
 3:  659dde8201 !  3:  42ee9437c2 transport-helper: drop const to fix strchr() warnings
    @@ Commit message
         which causes compilation with some C23 versions of libc (notably recent
         glibc) to complain.
     
    -    We need "p" to remain writable, since we assign NULL over the space we
    +    We need "p" to remain writable, since we assign NUL over the space we
         found. We can solve this by also making "key" writable. This works
         because it comes from a strbuf, which is itself a writable string.
     
 4:  66018b5ccf <  -:  ---------- pager: explicitly cast away strchr() constness
 -:  ---------- >  4:  856a72ded8 pager: explicitly cast away strchr() constness
 5:  a696a8a4d9 =  5:  8181dcb941 run-command: explicitly cast away constness when assigning to void
 6:  32bba4d607 =  6:  2a0830a807 find_last_dir_sep(): convert inline function to macro
 7:  ddd0798d19 =  7:  e5b8820cf0 pseudo-merge: fix disk reads from find_pseudo_merge()
 8:  d736d1e070 <  -:  ---------- skip_prefix(): check const match between in and out params
 -:  ---------- >  8:  e87d8b70e2 skip_prefix(): check const match between in and out params
 9:  22c8d65229 =  9:  ed84dc926b pkt-line: make packet_reader.line non-const
10:  5cca7c109c = 10:  ff425ef7c3 range-diff: drop const to fix strstr() warnings
11:  30e7b35073 ! 11:  f01ba0616f http: drop const to fix strstr() warning
    @@ Commit message
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## git-compat-util.h ##
    -@@ git-compat-util.h: static inline bool skip_iprefix(const char *str, const char *prefix,
    - 	return false;
    - }
    - 
    +@@ git-compat-util.h: static inline size_t xsize_t(off_t len)
    +  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
    +  * locale-specific conversions).
    +  */
    +-static inline bool skip_iprefix(const char *str, const char *prefix,
    +-			       const char **out)
     +#define skip_iprefix(str, prefix, out) \
    -+	skip_iprefix((str), (prefix), CONST_OUTPARAM((str), (out)))
    -+
    - /*
    -  * Like skip_prefix_mem, but compare case-insensitively. Note that the
    -  * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
    ++	skip_iprefix_impl((str), (prefix), CONST_OUTPARAM((str), (out)))
    ++static inline bool skip_iprefix_impl(const char *str, const char *prefix,
    ++				     const char **out)
    + {
    + 	do {
    + 		if (!*prefix) {
     
      ## http.c ##
     @@ http.c: static int has_proxy_cert_password(void)
12:  317436aca5 ! 12:  d5c971cf26 refs/files-backend: drop const to fix strchr() warning
    @@ Commit message
         But there's a catch. We derive that source pointer by parsing the line
         with parse_oid_hex_algop(), which requires a const pointer for its
         out-parameter. We can work around that by teaching it to use our
    -    CONST_OUTPARAM() trick, just like skip_prefix(). Note that unlike
    -    skip_prefix(), the function is not inline, so we can't just wrap it
    -    using the same name (otherwise the actual definition would expand the
    -    macro, which breaks compilation). So we rename the actual function with
    -    an "_impl" suffix, and callers will all use the macro.
    +    CONST_OUTPARAM() trick, just like skip_prefix().
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    @@ hex.h: char *oid_to_hex(const struct object_id *oid);						/* same static buffer
       */
     -int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
     -			const struct git_hash_algo *algo);
    -+int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid, const char **end,
    -+			     const struct git_hash_algo *algo);
     +#define parse_oid_hex_algop(hex, oid, end, algo) \
     +	parse_oid_hex_algop_impl((hex), (oid), CONST_OUTPARAM((hex), (end)), (algo))
    ++int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid, const char **end,
    ++			     const struct git_hash_algo *algo);
      
      /*
       * These functions work like get_oid_hex and parse_oid_hex, but they will parse
