Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E11A267
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508567; cv=none; b=J0dRfri7KqNLmYYQQyU5I8oL0/8IRVMOSVJxsMf64XTe+AN2Nkjpd4i5BEE0HRhZjkOAeKPUGgAZQsQKVYPyx9gd/gK0gnnDJGheAigdfzzTwK8lWjV8cJnJbsI0bInFtT45uWLZCzBHGlMHqPhYbBx9n/ZdxXjkVilCVz4tplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508567; c=relaxed/simple;
	bh=ddnqzc0zzFUpFysYzoIc8IB2+L4TFwEYHvK5t8P44II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeOZgCsUnERb2Azh44UYly3La0nDbDa/wbgJuLQiJt7i/u1yjptrjmbNOGrTOClGywDeu+BGcVRK1rYZTes+tnYGjtStLcBlMOYd2i+w0/tz9NLvwTrQwawINhe5naG1CDGI4HfOWgPSlj/5fH8k3O+vMHsttus007SriLLfDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E+Nn8cGz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E+Nn8cGz"
Received: (qmail 170882 invoked by uid 109); 30 Nov 2025 13:16:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ddnqzc0zzFUpFysYzoIc8IB2+L4TFwEYHvK5t8P44II=; b=E+Nn8cGzxBsgR2txW6mkwFiSHEU5ZaQD/WEkgY6Zd9oZRrP9nmCgP/5qIrMyB5C1h8tVZEyk2UZ7z81o7IdkZ3D2CAYBCbdhD68/1T0n0/Cyu0V9LWGCh2gyxPaTxscFOm6kc44fz9F+R1H6MsGKS62M7bX+3MHwmKbsc/YFrY8NhJwRqzE/0BZIWgGqqVj9a2GfpHftSN3gfYjyGdOn0keaObXlKzsbIl6YkgHvjBTp9Vr/BOb/NZFYMEMG0j/hPZhUioTHXwHNBvyZePHuCj4MeP2Xntxjjw+zPGb2+8nq/5EcqKf9hLanltU8GiYxphMWEvbFkVXlT5sLp7AApg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:16:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 254807 invoked by uid 111); 30 Nov 2025 13:16:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:16:03 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:16:02 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/4] fsck: use parse_unsigned_from_buf() for parsing timestamp
Message-ID: <20251130131602.GD199335@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130131351.GA198697@coredump.intra.peff.net>

In 5a993593b2 (fsck: avoid parse_timestamp() on buffer that isn't
NUL-terminated, 2025-11-18), we added a wrapper that copies the
timestamp into a buffer before calling parse_timestamp().

Now that we have a more robust helper for parsing from a buffer, we can
drop our wrapper and switch to that. We could just do so inline, but the
choice of "unsigned" vs "signed" depends on the typedef of timestamp_t.
So we'll wrap that in a macro that is defined alongside the rest of the
timestamp abstraction.

The resulting function is almost a drop-in replacement, but the new
interface means we need to hold the result in a separate timestamp_t,
rather than returning it directly from one function into the parameter
of another. The old one did still detect overflow errors by returning
TIME_MAX, since date_overflows() checks for that, but now we'll see it
more directly from the return of parse_timestamp_from_buf(). The
behavior should be the same.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/posix.h |  2 ++
 fsck.c         | 20 +++-----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b..d2dbc3e2a5 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -253,6 +253,8 @@ char *gitdirname(char *);
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
+#define parse_timestamp_from_buf(buf, len, ep, result) \
+	parse_unsigned_from_buf((buf), (len), (ep), (result), TIME_MAX)
 #define TIME_MAX UINTMAX_MAX
 #define TIME_MIN 0
 
diff --git a/fsck.c b/fsck.c
index 8e8083e7c6..68a23ae628 100644
--- a/fsck.c
+++ b/fsck.c
@@ -860,28 +860,13 @@ static int verify_headers(const void *data, unsigned long size,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
-static timestamp_t parse_timestamp_from_buf(const char **start, const char *end)
-{
-	const char *p = *start;
-	char buf[24]; /* big enough for 2^64 */
-	size_t i = 0;
-
-	while (p < end && isdigit(*p)) {
-		if (i >= ARRAY_SIZE(buf) - 1)
-			return TIME_MAX;
-		buf[i++] = *p++;
-	}
-	buf[i] = '\0';
-	*start = p;
-	return parse_timestamp(buf, NULL, 10);
-}
-
 static int fsck_ident(const char **ident, const char *ident_end,
 		      const struct object_id *oid, enum object_type type,
 		      struct fsck_options *options)
 {
 	const char *p = *ident;
 	const char *nl;
+	timestamp_t timestamp;
 
 	nl = memchr(p, '\n', ident_end - p);
 	if (!nl)
@@ -933,7 +918,8 @@ static int fsck_ident(const char **ident, const char *ident_end,
 			      "invalid author/committer line - bad date");
 	if (*p == '0' && p[1] != ' ')
 		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(parse_timestamp_from_buf(&p, ident_end)))
+	if (!parse_timestamp_from_buf(p, ident_end - p, &p, &timestamp) ||
+	    date_overflows(timestamp))
 		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if (*p != ' ')
 		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
-- 
2.52.0.413.gf695cdb9bd
