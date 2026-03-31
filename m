Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED03BED2D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001224; cv=none; b=UhqCCiwuetKHM2UKPS3Q6qZOO7GM4pQOSvwED8L0OGt4ntxXEpUB7rgUKoszgpCBjW+c4ZBDlX7wmsj0gXXpnyBy8VIoOiU39Z0AXaRNHU6hiXNAE2p2uWsPv9V6O6HI8Zb3WXoHOKqb21ZqsPZQ5zfzdLV9k1S9ZTTPHyuv42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001224; c=relaxed/simple;
	bh=iNGcTXyKs635Q0Cp2CTvR7uqvQD7SW7c49l79sdgWXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG+XBP+00R0fWgBzumi/O/JN9fJYjtanmCPF5yZP19zfufL3oVIqA0mPKMHb7BsZhHDJ5AOoYDOJBrsWbAN/hMPYUFVR3pg7eDvUCJgPn1GOE6+8bysjRFDEF7K28GEN2fseT6nZG7qpShGhtgh/2gzUh9bIXtz3bifqzfCJAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XpTlz510; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XpTlz510"
Received: (qmail 206730 invoked by uid 106); 31 Mar 2026 23:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iNGcTXyKs635Q0Cp2CTvR7uqvQD7SW7c49l79sdgWXA=; b=XpTlz510Ee5gTY+LHmL/TeojTXIInwL97RnsQuILQtAnUHTEE0+IFfL0GHbbEnpyrhlVKrD40be7mTpZ5vuBjL9b5YbXsyZgvJxz2qeLov8v559s3k4r5JcsbOjwLrv/edPh+vF9xahwrnQ1POKLnaOOuT4RXGP0cQL65ic7SfXfn9dNt9ZScekqnPRQcHDmukg+Cg7ZGQ3gJ6p3CnlOHiHKDAqS2liIoyL4Fnx4F8+uGT3KuFddWehaGXTiz9DL/sM0LfSrZ/yc5iwwm2XHoXjVTlVkzu6Tn2/6Rj+OkqZyJcoL91b0yP3k0KYqNJO65VHtQttUccJSTiQhfi6zcA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:53:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326622 invoked by uid 111); 31 Mar 2026 23:53:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:53:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:53:41 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 12/12] refs/files-backend: drop const to fix strchr() warning
Message-ID: <20260331235341.GL2328529@coredump.intra.peff.net>
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

In show_one_reflog_ent(), we're fed a writable strbuf buffer, which we
parse into the various reflog components. We write a NUL over email_end
to tie off one of the fields, and thus email_end must be non-const.

But with a C23 implementation of libc, strchr() will now complain when
assigning the result to a non-const pointer from a const one. So we can
fix this by making the source pointer non-const.

But there's a catch. We derive that source pointer by parsing the line
with parse_oid_hex_algop(), which requires a const pointer for its
out-parameter. We can work around that by teaching it to use our
CONST_OUTPARAM() trick, just like skip_prefix(). Note that unlike
skip_prefix(), the function is not inline, so we can't just wrap it
using the same name (otherwise the actual definition would expand the
macro, which breaks compilation). So we rename the actual function with
an "_impl" suffix, and callers will all use the macro.

Signed-off-by: Jeff King <peff@peff.net>
---
 hex.c                | 6 +++---
 hex.h                | 6 ++++--
 refs/files-backend.c | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hex.c b/hex.c
index 865a232167..bc756722ca 100644
--- a/hex.c
+++ b/hex.c
@@ -54,9 +54,9 @@ int get_oid_hex(const char *hex, struct object_id *oid)
 	return get_oid_hex_algop(hex, oid, the_hash_algo);
 }
 
-int parse_oid_hex_algop(const char *hex, struct object_id *oid,
-			const char **end,
-			const struct git_hash_algo *algop)
+int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid,
+			     const char **end,
+			     const struct git_hash_algo *algop)
 {
 	int ret = get_oid_hex_algop(hex, oid, algop);
 	if (!ret)
diff --git a/hex.h b/hex.h
index e9ccb54065..db7882bd17 100644
--- a/hex.h
+++ b/hex.h
@@ -40,8 +40,10 @@ char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
  * other invalid character.  end is only updated on success; otherwise, it is
  * unmodified.
  */
-int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
-			const struct git_hash_algo *algo);
+int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid, const char **end,
+			     const struct git_hash_algo *algo);
+#define parse_oid_hex_algop(hex, oid, end, algo) \
+	parse_oid_hex_algop_impl((hex), (oid), CONST_OUTPARAM((hex), (end)), (algo))
 
 /*
  * These functions work like get_oid_hex and parse_oid_hex, but they will parse
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ce0d57478..ad543ad751 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2190,7 +2190,7 @@ static int show_one_reflog_ent(struct files_ref_store *refs,
 	char *email_end, *message;
 	timestamp_t timestamp;
 	int tz;
-	const char *p = sb->buf;
+	char *p = sb->buf;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
 	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
-- 
2.53.0.1136.gd760fbd4a0
