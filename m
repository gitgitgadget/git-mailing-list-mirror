Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473151DED5C
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402050; cv=none; b=NU8OOG019hCIg7QgFx4p4HnfivQx1v0+oQPf79r+5mLDhHgS4yRnXkioAulUZpJfHkHY50y5jtStHL8Ia2+27ijN+zb2aCvIMpDh6sMGeK/4IfRHxM2cWCiWDIjL4d0v5BSmmf7kJhM8i/MH4NC8DPasspjkjVWT+Btxyu8qfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402050; c=relaxed/simple;
	bh=H+DFS8RqdmhWCNuUBppd9JiUP7Fs9iAGWx4IIEm2Ib0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bui+X4zHLX4VYRIE+KRALXaMzqbNRAdDRoEmhyrCPWz13HM/cjnhTBcErLjU6rJCD8g7AUAacAU4T1pDzTfHJgzWzUHpDVGtyNCi8EvIqQvmj0dBoRcN+sUDtOCTfQel8Q2BEKDyMsvi/ZJ+8gpDjvNtvsB2RgALb2SlIq3810c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aj1d6nsg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aj1d6nsg"
Received: (qmail 212078 invoked by uid 109); 14 Oct 2025 00:34:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=H+DFS8RqdmhWCNuUBppd9JiUP7Fs9iAGWx4IIEm2Ib0=; b=aj1d6nsgRd2OUZwa94te/y9+v3TOfSQwTJwQRK5nPvpeW13k3X9RgH3TX3mw3JUOQQdUBGduh3mCEGSB/JsNsWtY66XnEXgzWOJH2tu/N2yd4boxnq4L24doFVWqf4tM3OHGokKJ3FJcPabbQ1Bbz240DgQyzRg0T7ACvYsOY4JFVpZsduXEEyrNnwTWGfnia024QTzOgSSsylICj1QI5vMqntkLDLtqmw8n/Z5au4lRBYA5OFHaWI+ka4J9NcqWAcKcSo+mzoIfvVoCYsRSGofVkPMKuYsvH4MmcSud7eOCE4ov0Lpc2o2ynbcS52QR4CGYquIWbYo7yV8R1KlYMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Oct 2025 00:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 341964 invoked by uid 111); 14 Oct 2025 00:34:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Oct 2025 20:34:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Oct 2025 20:34:04 -0400
From: Jeff King <peff@peff.net>
To: Sruteesh Kumar <sruteesh.oss@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251014003404.GC1507@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>

On Fri, Oct 10, 2025 at 02:57:07PM +0000, Sruteesh Kumar wrote:

> Look at the first scenario in the above link. Git is matching the path
> foobar with the pattern foo**/bar which is against the git's official
> documentation (Look at the last point in the double asterisk section
> at the URL https://git-scm.com/docs/gitignore#_pattern_format). 
> 
> Is this an issue with the code or the documentation?

I think the code is buggy. Here's a patch which would fix it, but I've
marked it as RFC because:

  1. I haven't entirely convinced myself that there aren't more
     complicated variants of the same problem.

  2. It's kind of a disgusting hack.

-- >8 --
Subject: match_pathname(): give fnmatch one char of prefix context

In match_pathname(), which we use for matching .gitignore and
.gitattribute patterns, we are comparing paths with with fnmatch
patterns (actually our extended wildmatch, which will be important).
There's an extra optimization there: we pre-compute the number of
non-wildcard characters at the beginning of the pattern and do an
fspathncmp() on that prefix.

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

In the case that there are no wildcards at all (i.e., the whole prefix
matches), we'll continue to return without running fnmatch at all. We
just need to account for the extra byte in our adjusted lengths.

Signed-off-by: Jeff King <peff@peff.net>
---
I wonder how much this prefix-matching buys us in practice. There are
two cases that are helped:

  1. When there is no wildcard in the pattern at all, we skip fnmatch
     entirely.

  2. We do a raw match of the prefix chars, shrinking the size of what
     is passed to fnmatch.

My suspicion is that most of the improvement comes from (1), and it
would be very easy to retain that case and get rid of (2). But I haven't
done any measuring.

 dir.c              |  9 ++++++++-
 t/t0008-ignores.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 0a67a99cb3..764400d9c5 100644
--- a/dir.c
+++ b/dir.c
@@ -1360,6 +1360,13 @@ int match_pathname(const char *pathname, int pathlen,
 
 		if (fspathncmp(pattern, name, prefix))
 			return 0;
+
+		/*
+		 * Retain one character of the prefix to
+		 * pass to fnmatch, which lets it distinguish
+		 * the start of a directory component correctly.
+		 */
+		prefix--;
 		pattern += prefix;
 		patternlen -= prefix;
 		name    += prefix;
@@ -1370,7 +1377,7 @@ int match_pathname(const char *pathname, int pathlen,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (patternlen == 1 && namelen == 1)
 			return 1;
 	}
 
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
2.51.0.754.gd4f5ded95f

