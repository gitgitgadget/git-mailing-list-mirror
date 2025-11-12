Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5692D97B5
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934740; cv=none; b=AAkG9TrC06uFwOBYbhmPY8ixHXYJC93be8m6p90vv83er5BwDLISNIfNpJydOJuK8E2eStQ/y+n0Yb6BCt9v61YU6CKQZjhhYm3GAOiSPQaOgbWCjqOiJgtaWwWeqNdxanVQKdB1EFjkPGrMsGCy214kiHlJavhxuVi30ioCed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934740; c=relaxed/simple;
	bh=KWmKXv42D1p6ziQx3u23w6cuCNUlepUl1Ixa7c/1EcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzOXk+5vztlf+N+cL95oLTDC3tx7S+KnwYlbgOU0bor3VL94KrX7kWMPEIs1PSwpNUZDXorkL7u3sSPXNAhjWdTveEVGa7CHfX5JSb18LyhII4KffSI7+asHdryMpBS+gsUqj/UMPRM1EJT879pouGt5x6dv9phSymr5bxo0x18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X+883zY/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X+883zY/"
Received: (qmail 495380 invoked by uid 109); 12 Nov 2025 08:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KWmKXv42D1p6ziQx3u23w6cuCNUlepUl1Ixa7c/1EcM=; b=X+883zY/sJfnpQdApzYLxy7cJ5WeFTQN6TWSBhSursz2fvd8yra+hDiMnICn2ngbtYIA05zBrPWGD1+FPO9sUDIj3JnbFnIfnjuxQ4UMB9DPvn5WDUXQBfnA+AXTKNYN2fqvRsH+AeTIL6UQd5c9Ablk2pf8r3uuiSK6gqrP+lUYI0v7CgZAcVL1eIWmpl53CEytIhoiHPoIz/XYd4t78YKLpJX/LdNY40F7e8fnDGTUw5uwbf7m5raLj7lSNvgZuOKS07wjAqv2jO5Vk7WZm9G+hS7K5oHkvX+WGRGxeZJE83B+0EBb3vSU1UR96VApQ5mHkQ0x0JCgu6w31v3L2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:05:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786394 invoked by uid 111); 12 Nov 2025 08:05:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:05:37 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:05:37 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251112080537.GD979063@coredump.intra.peff.net>
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

A cache-tree extension entry in the index looks like this:

  <name> NUL <entry_nr> SPACE <subtree_nr> NEWLINE <binary_oid>

where the "_nr" items are human-readable base-10 ASCII. We parse them
with strtol(), even though we do not have a NUL-terminated string (we'd
generally have an mmap() of the on-disk index file). For a well-formed
entry, this is not a problem; strtol() will stop when it sees the
newline. But there are two problems:

  1. A corrupted entry could omit the newline, causing us to read
     further. You'd mostly get stopped by seeing non-digits in the oid
     field (and if it is likewise truncated, there will still be 20 or
     more bytes of the index checksum). So it's possible, though
     unlikely, to see read off the end of the mmap'd buffer. Of course a
     malicious index file can fake the oid and the index checksum to all
     (ASCII) 0's.

     This is further complicated by the fact that mmap'd buffers tend to
     be zero-padded up to the page boundary. So to run off the end, the
     index size also has to be a multiple of the page size. This is also
     unlikely, though you can construct a malicious index file that
     matches this.

     The security implications aren't too interesting. The index file is
     a local file anyway (so you can't attack somebody by cloning, but
     only if you convince them to operate in a .git directory you made,
     at which point attacking .git/config is much easier). And it's just
     a read overflow via strtol(), which is unlikely to buy you much
     beyond a crash.

  2. ASan has a strict_string_checks option, which tells it to make sure
     that options to string functions (like strtol) have some eventual
     NUL, without regard to what the function would actually do (like
     stopping at a newline here). This option sometimes has false
     positives, but it can point to sketchy areas (like this one) where
     the input we use doesn't exhibit a problem, but different input
     _could_ cause us to misbehave.

Let's fix it by just parsing the values ourselves with a helper function
that is careful not to go past the end of the buffer. There are a few
behavior changes here that should not matter:

  - We do not consider overflow, as strtol() would. But nor did the
    original code. However, we don't trust the value we get from the
    on-disk file, and if it says to read 2^30 entries, we would notice
    that we do not have that many and bail before reading off the end of
    the buffer.

  - Our helper does not skip past extra leading whitespace as strtol()
    would, but according to gitformat-index(5) there should not be any.

  - The original quit parsing at a newline or a NUL byte, but now we
    insist on a newline (which is what the documentation says, and what
    Git has always produced).

Since we are providing our own helper function, we can tweak the
interface a bit to make our lives easier. The original code does not use
strtol's "end" pointer to find the end of the parsed data, but rather
uses a separate loop to advance our "buf" pointer to the trailing
newline. We can instead provide a helper that advances "buf" as it
parses, letting us read strictly left-to-right through the buffer.

I didn't add a new test here. It's surprisingly difficult to construct
an index of exactly the right size due to the way we pad entries. But it
is easy to trigger the problem in existing tests when using ASan's
strict string checking, coupled with a recent change to use NO_MMAP with
ASan builds. So:

  make SANITIZE=address
  cd t
  ASAN_OPTIONS=strict_string_checks=1 ./t0090-cache-tree.sh

triggers it reliably. Technically it is not deterministic because there
is ~8% chance (it's 1-(255/256)^20, or ^32 for sha256) that the trailing
checksum hash has a NUL byte in it. But we compute enough cache-trees in
the course of that script that we are very likely to hit the problem in
one of them.

We can look at making strict_string_checks the default for ASan builds,
but there are some other cases we'd want to fix first.

Reported-by: correctmost <cmlists@sent.com>
Signed-off-by: Jeff King <peff@peff.net>
---
It feels gross to reimplement strtol(), just because there are so many
weird corner cases (signs, leading whitespace, overflow, and so on).
The alternative is reading into a buffer, NUL-terminating it, and
calling strtol() there. But that has its own hazards (you have to decide
when to stop reading, which means reimplementing those same rules to
soak up whitespace, etc).

We can take some shortcuts here because we know what our one caller
looks like. It might be worth having a carefully written "strntol()"
that can be used everywhere. But there aren't _that_ many call sites
that would use it, so maybe this ad-hoc approach is better?

 cache-tree.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2aba47060e..ab20ffe863 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -548,12 +548,36 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 	trace2_region_leave("cache_tree", "write", the_repository);
 }
 
+static long parse_long(const char **ptr, unsigned long *len_p)
+{
+	const char *s = *ptr;
+	unsigned long len = *len_p;
+	long ret = 0;
+	int sign = 1;
+
+	while (len && *s == '-') {
+		sign *= -1;
+		s++;
+		len--;
+	}
+
+	while (len) {
+		if (!isdigit(*s))
+			break;
+		ret *= 10;
+		ret += *s - '0';
+		s++;
+		len--;
+	}
+	*ptr = s;
+	*len_p = len;
+	return sign * ret;
+}
+
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 {
 	const char *buf = *buffer;
 	unsigned long size = *size_p;
-	const char *cp;
-	char *ep;
 	struct cache_tree *it;
 	int i, subtree_nr;
 	const unsigned rawsz = the_hash_algo->rawsz;
@@ -569,19 +593,12 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	buf++; size--;
 	it = cache_tree();
 
-	cp = buf;
-	it->entry_count = strtol(cp, &ep, 10);
-	if (cp == ep)
+	it->entry_count = parse_long(&buf, &size);
+	if (!size || *buf != ' ')
 		goto free_return;
-	cp = ep;
-	subtree_nr = strtol(cp, &ep, 10);
-	if (cp == ep)
-		goto free_return;
-	while (size && *buf && *buf != '\n') {
-		size--;
-		buf++;
-	}
-	if (!size)
+	buf++; size--;
+	subtree_nr = parse_long(&buf, &size);
+	if (!size || *buf != '\n')
 		goto free_return;
 	buf++; size--;
 	if (0 <= it->entry_count) {
-- 
2.52.0.rc1.260.g3e4993586f

