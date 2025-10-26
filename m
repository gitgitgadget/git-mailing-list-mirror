Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5D27713
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493345; cv=none; b=qSNLerJVnNVPJymVWGxI7FFoEqJEm2VplhToL7CdW+vBc2H71dI9bKn3rrkhVI31EGDIuLZqJ8EduaWFjiy0Aor+aAAKHt4teae0eP/SuWcRME9RqcPliRbn2tRNciwCmj49uX28o2MJ6qdMxUYF29Lb11ZjowPSBOt8oBmWTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493345; c=relaxed/simple;
	bh=o+xYtRd+sk274nrRs0ec2MYcqa75cSdxCfj3wmjPtks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N45gDv2MZoFEHVf3Xc0DVJuHCHK5hMoZ8z9D7Bv8wQ/b4+QxHdbjLnrH8SF4OfqpzlfIhZrOP2VaYV1/5q46mX4lXv5Tzj8FzFPwRJJKfy1cCc6JOJ/a2hpKqI5leLFOFQgfe1C1dpLDHw+12/qpaGiS3BQL0m8CubS0Rkhe2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ASKqM1+z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ASKqM1+z"
Received: (qmail 346944 invoked by uid 109); 26 Oct 2025 15:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o+xYtRd+sk274nrRs0ec2MYcqa75cSdxCfj3wmjPtks=; b=ASKqM1+zLGiwcUnTGOYb00HbJbjYffiWdLMDQu/9unQvJG+cqm2G6E1nfLA4fmjNTrUXLnsCIqxx53ybRmtJr5My0zfaH5jiJT+Dsku7mwC5FR5wuUMxS+FJliRynjYHwes4dd+bOKX39dwW/BAKWJHOx65eptltRWqJ6h6ym+oRMLMYrfxcAGgThj7DvylG2QoxNBDnnxmOYvaVoMKjXwZtYRbMv1Atlu7m84Si+knFfeJAFwbSoovgvHkImJjffcHPgMhnqANDYUM6kRyLXgDALGGD5zxVMetHMJM1R4upSlYaSctrGpRNE2YtdHfb69af72JGPC8nxY9Eo2np0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:42:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542529 invoked by uid 111); 26 Oct 2025 15:42:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:42:23 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:42:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 2/2] match_pathname(): give fnmatch one char of prefix
 context
Message-ID: <20251026154222.GB2728835@coredump.intra.peff.net>
References: <20251026154036.GA2173430@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026154036.GA2173430@coredump.intra.peff.net>

In match_pathname(), which we use for matching .gitignore and
.gitattribute patterns, we are comparing paths with fnmatch patterns
(actually our extended wildmatch, which will be important).  There's an
extra optimization there: we pre-compute the number of non-wildcard
characters at the beginning of the pattern and do an fspathncmp() on
that prefix.

That lets us avoid fnmatch entirely on patterns without wildcards, and
shrinks the amount of work we hand off to fnmatch. For a pattern like
"foo*.txt" and a path "foobar.txt", we'd cut away the matching "foo"
prefix and just pass "*.txt" and "bar.txt" to fnmatch().

But this misses a subtle corner case. In fnmatch(), we'll think
"bar.txt" is the start of the path, but it's not. This doesn't matter
for the pattern above, but consider the wildmatch pattern "foo**/bar"
and the path "foobar". These two should not match, because there is no
file named "bar", and the "**" applies only to the containing directory
name. But after removing the "foo" prefix, fnmatch will get "**/bar" and
"bar", which it does consider a match, because "**/" can match zero
directories.

We can solve this by giving fnmatch a bit more context. As long as it
has one byte of the matched prefix, then it will know that "bar" is not
the start of the path. In this example it would get "o**/bar" and
"obar", and realize that they cannot match.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c              |  7 ++++++-
 t/t0008-ignores.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index bbc2bf289d..22fe595f3f 100644
--- a/dir.c
+++ b/dir.c
@@ -1360,7 +1360,6 @@ int match_pathname(const char *pathname, int pathlen,
 
 		if (fspathncmp(pattern, name, prefix))
 			return 0;
-
 		/*
 		 * If the whole pattern did not have a wildcard,
 		 * then our prefix match is all we need; we
@@ -1369,6 +1368,12 @@ int match_pathname(const char *pathname, int pathlen,
 		if (patternlen == prefix && namelen == prefix)
 			return 1;
 
+		/*
+		 * Retain one character of the prefix to
+		 * pass to fnmatch, which lets it distinguish
+		 * the start of a directory component correctly.
+		 */
+		prefix--;
 		pattern += prefix;
 		patternlen -= prefix;
 		name    += prefix;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 273d71411f..db8bde280e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -847,6 +847,17 @@ test_expect_success 'directories and ** matches' '
 	test_cmp expect actual
 '
 
+test_expect_success '** not confused by matching leading prefix' '
+	cat >.gitignore <<-\EOF &&
+	foo**/bar
+	EOF
+	git check-ignore foobar foo/bar >actual &&
+	cat >expect <<-\EOF &&
+	foo/bar
+	EOF
+	test_cmp expect actual
+'
+
 ############################################################################
 #
 # test whitespace handling
-- 
2.51.1.840.g23b87c0a58
