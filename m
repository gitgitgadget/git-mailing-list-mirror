Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098E3081D0
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457141; cv=none; b=dLg2mFBTYXAZRbAieXOzM5P7p+K9XPmYPMoT/au/uuytOj8gyb347gK82nRyV0zcKUU/lej6fwXyGxn3mW8LKSbxey+LC9d7yBMQY1SXPadNQlmZxxbbZPV8e9hR56SW/CFRrYRQhPQPHnrYP/5HHeLM2BsEuDBjEQviG/mu4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457141; c=relaxed/simple;
	bh=LEVVfI/ekeBCsKsUB3IEkTCH6XDpfLTS7wvvHtll/R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0/UiKTAA/wOWYQNiagdRFmj/bwZqi17bTWdW190JkZbvkreZMlBZzqZKOTpAQJfd9TUOOJXkLt4qWTeT497ctKtmg+roLJsMUBngaXVU5bFJw/9obwKrSaeE6TjrPOPU8xfnys5P777iGwOwSDyH3rc7QaI+zDkI94M6ISm4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NuacEd1t; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NuacEd1t"
Received: (qmail 19778 invoked by uid 109); 18 Nov 2025 09:12:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LEVVfI/ekeBCsKsUB3IEkTCH6XDpfLTS7wvvHtll/R4=; b=NuacEd1tuptvBCWRvPQSasL9/LAG5lc63qaCUKQiLYWMmaMKLeQEun03Z+VJx21jRcQz6Ror6Dw9PmInelTE8cyhEpDSQ0tC4aUfdKwOCh+ANyapHJCOTeDJXB1E8PbSs2rjXXQXfI9bcSYTvgUFfIVjWqMoCseoCbNqlTk3ck7rD1GRmoy38Nhnp4FBvVozXJxLgH2GPoW1x3HEzmQDlSKR2s35Yb3a1Nt0yWdvAbHzDC6ROBs1Mg2hOYX8bH2TUX+dthNHO4MoyvttOHo22oa0evwtrDBWq6wHCN5G/bEUg2RAQUj7jxQ2REmJHr58u6AuMWT5iwf88QMpJrkZFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27397 invoked by uid 111); 18 Nov 2025 09:12:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:23 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:18 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251118091218.GD529192@coredump.intra.peff.net>
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
     unlikely, to read off the end of the mmap'd buffer. Of course a
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
 cache-tree.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2aba47060e..2d8947b518 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -548,12 +548,41 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 	trace2_region_leave("cache_tree", "write", the_repository);
 }
 
+static int parse_int(const char **ptr, unsigned long *len_p, int *out)
+{
+	const char *s = *ptr;
+	unsigned long len = *len_p;
+	int ret = 0;
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
+
+	if (s == *ptr)
+		return -1;
+
+	*ptr = s;
+	*len_p = len;
+	*out = sign * ret;
+	return 0;
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
@@ -569,19 +598,14 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	buf++; size--;
 	it = cache_tree();
 
-	cp = buf;
-	it->entry_count = strtol(cp, &ep, 10);
-	if (cp == ep)
+	if (parse_int(&buf, &size, &it->entry_count) < 0)
 		goto free_return;
-	cp = ep;
-	subtree_nr = strtol(cp, &ep, 10);
-	if (cp == ep)
+	if (!size || *buf != ' ')
 		goto free_return;
-	while (size && *buf && *buf != '\n') {
-		size--;
-		buf++;
-	}
-	if (!size)
+	buf++; size--;
+	if (parse_int(&buf, &size, &subtree_nr) < 0)
+		goto free_return;
+	if (!size || *buf != '\n')
 		goto free_return;
 	buf++; size--;
 	if (0 <= it->entry_count) {
-- 
2.52.0.278.gadc6434dc3

