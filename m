Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D82C0F8C
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103320; cv=none; b=JQ5GHWtZ+HRIv2BqP5zTDSyfRLgSygSFhjA2G3OmFBQ3og62XEEiPJuAuBZzdHUn+GYACdT77m6/FMfOSBsx+9cTCc2iun96YZGPB8deD8n5feh6u+bBOE8pwzV9tSNTCXi5M3t8Rh9l+3PmO+u9WJxpyRFEBf3eco9VWTBfVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103320; c=relaxed/simple;
	bh=lWhYJTTg2zfBCEJRGk8l1w+l3Gi0kKeRglOmurh1rTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASksnZ521HMsTMSacla5BTZo+3AwXc9xbfi1X6KRpwBYHwUW4GN9PuVB2VvOJB07l1KK5JVD/W1hYgQSE5h6s4Ch8xFilPeLQfJ44G+2jedRcFew8gvMOPsoXJp5rb9OYuMOCZUmJY6Gx3y7OxlVPE/azlnkfx9yh+S7ucuYekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EaqYqBbI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EaqYqBbI"
Received: (qmail 218943 invoked by uid 106); 2 Apr 2026 04:15:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lWhYJTTg2zfBCEJRGk8l1w+l3Gi0kKeRglOmurh1rTY=; b=EaqYqBbIvCFhS9mnsUAL69QsaCV/LGzs83pyN5OnXVWw/x0CeNyEuzUIXHnLfuo1PtPjNoShD7H5JS8tIn6qGkP298BVwAyYxW4podRvnrkw+sx02CyGpFahl0dGJO1VhQkjzn9SNxomJYzzk2m0SRCG+ZZtHzPRiJBHHAIyovAonG/SBDfZtw+aPJSjlWAiSF8UKm77+CR2pZNS3ZFPQWEwei+yv9V0gtNIgcSp0Q0V3HCwJtSlYQmDfLUNPDAKrD7zrDtvwFIHVuRCjWS9iZpf1n/xTM68bTLhhZhCIPC5YKIfTwnUeKGmcSwpVPqXqDDZ8cV0Y2CFsVHYCVtooQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349795 invoked by uid 111); 2 Apr 2026 04:15:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 12/12] refs/files-backend: drop const to fix strchr()
 warning
Message-ID: <20260402041516.GL3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

In show_one_reflog_ent(), we're fed a writable strbuf buffer, which we
parse into the various reflog components. We write a NUL over email_end
to tie off one of the fields, and thus email_end must be non-const.

But with a C23 implementation of libc, strchr() will now complain when
assigning the result to a non-const pointer from a const one. So we can
fix this by making the source pointer non-const.

But there's a catch. We derive that source pointer by parsing the line
with parse_oid_hex_algop(), which requires a const pointer for its
out-parameter. We can work around that by teaching it to use our
CONST_OUTPARAM() trick, just like skip_prefix().

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
index e9ccb54065..1e9a65d83a 100644
--- a/hex.h
+++ b/hex.h
@@ -40,8 +40,10 @@ char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
  * other invalid character.  end is only updated on success; otherwise, it is
  * unmodified.
  */
-int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
-			const struct git_hash_algo *algo);
+#define parse_oid_hex_algop(hex, oid, end, algo) \
+	parse_oid_hex_algop_impl((hex), (oid), CONST_OUTPARAM((hex), (end)), (algo))
+int parse_oid_hex_algop_impl(const char *hex, struct object_id *oid, const char **end,
+			     const struct git_hash_algo *algo);
 
 /*
  * These functions work like get_oid_hex and parse_oid_hex, but they will parse
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0537a72b2a..b3b0c25f84 100644
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
2.53.0.1172.ge9e20b5838
