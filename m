Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AC2F5302
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935044; cv=none; b=iekgdiYRB+cP6GiGe2TKpOYlQMRzj4UI3JqPPtXKq1ojLuSqErRJQ/8MHmc9Rt9IbTzLwuJcO3wMZa5sUkNMk85a3PFrEhWV1/EkqLvkPFhbNVDh+QljLFyYvLAGrt3iqtvLzo0Hq7sJ0nCc2dyVNVk5Hzzd+Zmnu4Mu130nVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935044; c=relaxed/simple;
	bh=KO+7DvSVhuKFNZA5tYyAqbQCASQsfSVfWnb8/Aei0JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxE5HEQ97mujfMeykkKQ4okGyVet/9cz7FgtgRoDJe+xOEFmAbjakYXSZh6nLvF3TN4pOncPXWzWcejmlds0lRo9rLRAehpeiOMJax7E6rKvAqQ/f96DyjtHB/oMWxyFDGp5YtdeICVYH5Fc25b7LbFS5k1RYZMgKbnVZQQFtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YaE604Rd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YaE604Rd"
Received: (qmail 495493 invoked by uid 109); 12 Nov 2025 08:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KO+7DvSVhuKFNZA5tYyAqbQCASQsfSVfWnb8/Aei0JQ=; b=YaE604RdDY06roivzCoRwIcGecp2fWnPj6nL0TONVTQiEeZyArnNxHiCcoVv7UnkaBlLJN1is6d5FIVD/sdynJOOOE27nSiWieSX734VjlVSRQa4m98OmSDLEpbJluVzNhOefyOrNQJ3sYtszjYCn7m/jz70wwuw2kUTlnA9U4Kxgy3gOxcFXTg6mhYWTaBWcnF74LFZco+YzgqlV2rbm9kiO4odUXToSknrmM5pr/4DknGpQwAk1Lnmyq2fOPn0zP3VI9m2swF2GkSTctR+ZGOOkERxc0QZ3sRit138x7BqB7GJedIuqTX6RW13o1HVmf4szKLcCQZhw3/fUKceGA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786491 invoked by uid 111); 12 Nov 2025 08:10:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:10:40 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:10:40 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 8/9] fsck: avoid parse_timestamp() on buffer that isn't
 NUL-terminated
Message-ID: <20251112081040.GH979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

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
There's one step we could take after this commit, which is to annotate
all of the spots that look at "p" to do:

  -if (*p != ' ')
  +if (p >= ident_end || *p != ' ')
	return report(..., "expected space");

or similar. And then I think it would be safe to call fsck_ident() with
a buffer that is not NUL-terminated (and does not have our "safety"
newline). I stopped short for this series because we are just trying to
appease ASan (and not fixing real bugs), and because the result gets
rather unwieldy. But it might be worth it in the long run. We could
always do it later on top.

Again, I find the strto*() wrapping to be gross. Here we use the
extra-buffer trick. But we still don't get away with avoiding custom
logic (for example, if we ever want to support negative timestamps, the
fsck code will have to recognize "-" signs). But it feels like the best
we can do for now.

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
2.52.0.rc1.260.g3e4993586f

