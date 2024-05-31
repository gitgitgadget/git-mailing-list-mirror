Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991F8173C
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155091; cv=none; b=CfAXvV6HBi5DLfXisZq52guIiZiKf9FsAx99hpsGJO6+br4T4jRAIQhLJV9mDasjkYhgS0rEl0tJ5Kv3Wa5U/zHmIS1XeAP9ZNQv8yhPDwa7qeTh5SamcEub+gdLa9EEVLBiFr6OwWlLxHRK/rpFKFGlpVap8gy439YQLeViSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155091; c=relaxed/simple;
	bh=ccJK948oiiJHS5e9+I2tmuvv8zkLXwBIaXYLuRRG7iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpjYtniwKgBn6fioM1Sibh6J/Gwvyz7lsx9zlPHz7DFCu4IxBPNGQqY8fSnoGmBgc+NT5l3aolVjILCE8dy9okvy/C8TuGl8LYkOb6mlTJvn+6+fSQ95HuhH+h1e3ea+BTExvK/vzhaPr7Q9Zx3TD4iXzTsLLePU/gtIAcT8eso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22741 invoked by uid 109); 31 May 2024 11:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9320 invoked by uid 111); 31 May 2024 11:31:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:31:28 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:31:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/13] dir.c: always copy input to add_pattern()
Message-ID: <20240531113127.GF428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

The add_pattern() function has a subtle and undocumented gotcha: the
pattern string you pass in must remain valid as long as the pattern_list
is in use (and nor do we take ownership of it). This is easy to get
wrong, causing either subtle bugs (because you free or reuse the string
buffer) or leaks (because you copy the string, but don't track ownership
separately).

All of this "pattern" code was originally the "exclude" mechanism. So
this _usually_ works OK because you add entries in one of two ways:

  1. From the command-line (e.g., "--exclude"), in which case we're
     pointing to an argv entry which remains valid for the lifetime of
     the program.

  2. From a file (e.g., ".gitignore"), in which case we read the whole
     file into a buffer, attach it to the pattern_list's "filebuf"
     entry, then parse the buffer in-place (adding NULs). The strings
     point into the filebuf, which is cleaned up when the whole
     pattern_list goes away.

But other code, like sparse-checkout, reads individual lines from stdin
and passes them one by one to add_pattern(), leaking each. We could fix
this by refactoring it to take in the whole buffer at once, like (2)
above, and stuff it in "filebuf". But given how subtle the interface is,
let's just fix it to always copy the string.

That seems at first like we'd be wasting extra memory, but we can
mitigate that:

  a. The path_pattern struct already uses a FLEXPTR, since we sometimes
     make a copy (when we see "foo/", we strip off the trailing slash,
     requiring a modifiable copy of the string).

     Since we'll now always embed the string inside the struct, we can
     switch to the regular FLEX_ARRAY pattern, saving us 8 bytes of
     pointer. So patterns with a trailing slash and ones under 8 bytes
     actually get smaller.

  b. Now that we don't need the original string to hang around, we can
     get rid of the "filebuf" mechanism entirely, and just free the file
     contents after parsing. Since files are the sources we'd expect to
     have the largest pattern sets, we should mostly break even on
     stuffing the same data into the individual structs.

This patch just adjusts the add_pattern() interface; it doesn't fix any
leaky callers yet.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 15 +++++----------
 dir.h |  3 ++-
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/dir.c b/dir.c
index d812d521b0..8308d167c8 100644
--- a/dir.c
+++ b/dir.c
@@ -925,12 +925,7 @@ void add_pattern(const char *string, const char *base,
 	int nowildcardlen;
 
 	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
-	if (flags & PATTERN_FLAG_MUSTBEDIR) {
-		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);
-	} else {
-		pattern = xmalloc(sizeof(*pattern));
-		pattern->pattern = string;
-	}
+	FLEX_ALLOC_MEM(pattern, pattern, string, patternlen);
 	pattern->patternlen = patternlen;
 	pattern->nowildcardlen = nowildcardlen;
 	pattern->base = base;
@@ -972,7 +967,6 @@ void clear_pattern_list(struct pattern_list *pl)
 	for (i = 0; i < pl->nr; i++)
 		free(pl->patterns[i]);
 	free(pl->patterns);
-	free(pl->filebuf);
 	clear_pattern_entry_hashmap(&pl->recursive_hashmap);
 	clear_pattern_entry_hashmap(&pl->parent_hashmap);
 
@@ -1166,23 +1160,23 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 	}
 
 	add_patterns_from_buffer(buf, size, base, baselen, pl);
+	free(buf);
 	return 0;
 }
 
 static int add_patterns_from_buffer(char *buf, size_t size,
 				    const char *base, int baselen,
 				    struct pattern_list *pl)
 {
+	char *orig = buf;
 	int i, lineno = 1;
 	char *entry;
 
 	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
 
-	pl->filebuf = buf;
-
 	if (skip_utf8_bom(&buf, size))
-		size -= buf - pl->filebuf;
+		size -= buf - orig;
 
 	entry = buf;
 
@@ -1222,6 +1216,7 @@ int add_patterns_from_blob_to_list(
 		return r;
 
 	add_patterns_from_buffer(buf, size, base, baselen, pl);
+	free(buf);
 	return 0;
 }
 
diff --git a/dir.h b/dir.h
index b9e8e96128..c8ff308fae 100644
--- a/dir.h
+++ b/dir.h
@@ -62,7 +62,6 @@ struct path_pattern {
 	 */
 	struct pattern_list *pl;
 
-	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
 	const char *base;
@@ -74,6 +73,8 @@ struct path_pattern {
 	 * and from -1 decrementing for patterns from CLI args.
 	 */
 	int srcpos;
+
+	char pattern[FLEX_ARRAY];
 };
 
 /* used for hashmaps for cone patterns */
-- 
2.45.1.727.ge984192922

