Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34930DED4
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457153; cv=none; b=At7FD6eUMS+o5valKHhSgSqw+C6ePANpGvLeR3wefA9oto7FuW3DybXUwFSapDPL7GGWfE6V+fTLwbrBw4NHkhq3xbH2VxPo+kTwc2c0WkPQnQ/xUSzydY1NI714qztSfcXSpscJBcTGuLYxSkvu5TeS/8zXD7fALArd1VAtgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457153; c=relaxed/simple;
	bh=WlHE0YYNKusOGl6kBq/hO4uS83rZj50TU+0+yztBUw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY5rzE+ycr7CGUVBqjqGXCkmTUveoyYo7PF4shaxQ7JOhF4Yl28szr30H6akDGaLRgXddfoK3uAnJ2eqHMxLooJzPRHb/r7Np7R3WCTplyXtf50je6mAf4eZMfGzz2SDPKiTZKP+QVY5Exr9c+7F8uPU6sK/Dtw5yu6PwbqvLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JhvxY3hr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JhvxY3hr"
Received: (qmail 19825 invoked by uid 109); 18 Nov 2025 09:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WlHE0YYNKusOGl6kBq/hO4uS83rZj50TU+0+yztBUw8=; b=JhvxY3hrY1jA5yqFL0wkYdQXTZDGuTBc8Ju8eW8WhUWaB25jLXs149wdNrLVo8dJwHuA4uJXwdhj9r9eSHnX/27K/L4EOd5/Sa2RInE6/7bEm4uIx5C0HMri94zr/zE3X373naGeP4X4GYVipj6YB4ISU8rU88I14iXz8jeStG3TiwareoAyrJkDc7hn/JwApoOrKpnwskP8wZgpen4GSWplwoaoDbpv8uG4VOCaLp8auw18jFOxjc0f0p3ryKt9oRk5gNuv6paVlWlyRIdw319c2Njl77oFdNhovNq0LIZBSwPC+b6uk4d1/nkZtGuLkuAmGkH+e1sjZBVibzUh5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27423 invoked by uid 111); 18 Nov 2025 09:12:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:33 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:28 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 8/9] fsck: avoid parse_timestamp() on buffer that isn't
 NUL-terminated
Message-ID: <20251118091228.GH529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

In fsck_ident(), we parse the timestamp with parse_timestamp(), which is
really an alias for strtoumax(). But since our buffer may not be
NUL-terminated, this can trigger a complaint from ASan's
strict_string_checks mode. This is a false positive, since we know that
the buffer contains a trailing newline (which we checked earlier in the
function), and that strtoumax() would stop there.

But it is worth working around ASan's complaint. One is because that
will let us turn on strict_string_checks by default, which has helped
catch other real problems. And two is that the safety of the current
code is very hard to reason about (it subtly depends on distant code
which could change).

One option here is to just parse the number left-to-right ourselves. But
we care about the size of a timestamp_t and detecting overflow, since
that's part of the point of these checks. And doing that correctly is
tricky. So we'll instead just pull the digits into a separate,
NUL-terminated buffer, and use that to call parse_timestamp().

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 266c965cec..8e8083e7c6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -860,13 +860,28 @@ static int verify_headers(const void *data, unsigned long size,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
+static timestamp_t parse_timestamp_from_buf(const char **start, const char *end)
+{
+	const char *p = *start;
+	char buf[24]; /* big enough for 2^64 */
+	size_t i = 0;
+
+	while (p < end && isdigit(*p)) {
+		if (i >= ARRAY_SIZE(buf) - 1)
+			return TIME_MAX;
+		buf[i++] = *p++;
+	}
+	buf[i] = '\0';
+	*start = p;
+	return parse_timestamp(buf, NULL, 10);
+}
+
 static int fsck_ident(const char **ident, const char *ident_end,
 		      const struct object_id *oid, enum object_type type,
 		      struct fsck_options *options)
 {
 	const char *p = *ident;
 	const char *nl;
-	char *end;
 
 	nl = memchr(p, '\n', ident_end - p);
 	if (!nl)
@@ -918,11 +933,11 @@ static int fsck_ident(const char **ident, const char *ident_end,
 			      "invalid author/committer line - bad date");
 	if (*p == '0' && p[1] != ' ')
 		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(parse_timestamp(p, &end, 10)))
+	if (date_overflows(parse_timestamp_from_buf(&p, ident_end)))
 		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
-	if (*end != ' ')
+	if (*p != ' ')
 		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
-	p = end + 1;
+	p++;
 	if ((*p != '+' && *p != '-') ||
 	    !isdigit(p[1]) ||
 	    !isdigit(p[2]) ||
-- 
2.52.0.278.gadc6434dc3

