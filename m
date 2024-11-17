Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B861FFE
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834630; cv=none; b=kryqTnT8EkepFj/CAWzLPeizuQ4UUIRLBwQI8oOQu15x4V+zoJQsKKi89GM4RoS+sdtFZKMEfEyCMZn+xahuYgIQRW7b43ZSkPoXngPKiwyJjut261qwnacBbL+PrOk9m2MmUgKz3MNh8hn9BjcLy+ncKXoZl1yj4XbXB0XKULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834630; c=relaxed/simple;
	bh=3uQ1jGO4XE8zvqME6/PceDXJw+pFeOZg8jLm3jGp89Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxIU4GO3jXr7Xlopr+nC4V2148oU7x5SFdInVTN0XJ0gfUlrfyro4bYPxCOeq/lL5TampOktUbJmJ69ib0KIsqcOosOOdo0RmoeRjdyAf8ckUEFGhou5iMzSToRgVKtglo87Cby7rGhDQ7p10OXwOhlXZdeKFOqgKp2bv4I6KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DtEON139; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DtEON139"
Received: (qmail 9294 invoked by uid 109); 17 Nov 2024 09:10:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3uQ1jGO4XE8zvqME6/PceDXJw+pFeOZg8jLm3jGp89Q=; b=DtEON139Bv+C+FM9+7yeNAG1qzr/NEnZiutdGRPjlLR0qoqjgDI8RJ9o/1xyFrAylmRLwi2bRdmLmjUY7IbxGnymFS7XkRrJGEVZHLO1iz2OjplzviW2DwBqBKU66pCidVeE++NCWJlhis2yv5rT3phCW9IcYd7JylHgkEyVEPTloqS+zDGEFYNxE4j+pZzAT/idaJKSJ8SJxqNn1mfCydMWkmjCaFfpiXtoLeD9YJNSbZewtlWENhXZp3V7XeH/oPc02r55KrhejK5i41LoHcvpEmbKCVrDXX3N84WJys/pZRb+3RVs4XmC/F1x2n+iIsAzaNn1vdYR/6CZBur1Jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:10:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2273 invoked by uid 111); 17 Nov 2024 09:10:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:10:29 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:10:24 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 4/5] object-file: drop oid field from find_cached_object()
 return value
Message-ID: <20241117091024.GD3409496@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

The pretend_object_file() function adds to an array mapping oids to
object contents, which are later retrieved with find_cached_object().
We naturally need to store the oid for each entry, since it's the lookup
key.

But find_cached_object() also returns a hard-coded empty_tree object.
There we don't care about its oid field and instead compare against
the_hash_algo->empty_tree. The oid field is left as all-zeroes.

This all works, but it means that the cached_object struct we return
from find_cached_object() may or may not have a valid oid field, depend
whether it is the hard-coded tree or came from pretend_object_file().

Nobody looks at the field, so there's no bug. But let's future-proof it
by returning only the object contents themselves, not the oid. We'll
continue to call this "struct cached_object", and the array entry
mapping the key to those contents will be a "cached_object_entry".

This would also let us swap out the array for a better data structure
(like a hashmap) if we chose, but there's not much point. The only code
that adds an entry is git-blame, which adds at most a single entry per
process.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5fadd470c1..e461e351ca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -317,27 +317,28 @@ int hash_algo_by_length(int len)
  * to write them into the object store (e.g. a browse-only
  * application).
  */
-static struct cached_object {
+static struct cached_object_entry {
 	struct object_id oid;
-	enum object_type type;
-	const void *buf;
-	unsigned long size;
+	struct cached_object {
+		enum object_type type;
+		const void *buf;
+		unsigned long size;
+	} value;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object *find_cached_object(const struct object_id *oid)
 {
 	static struct cached_object empty_tree = {
-		/* no oid needed; we'll look it up manually based on the_hash_algo */
 		.type = OBJ_TREE,
 		.buf = "",
 	};
 	int i;
-	struct cached_object *co = cached_objects;
+	struct cached_object_entry *co = cached_objects;
 
 	for (i = 0; i < cached_object_nr; i++, co++) {
 		if (oideq(&co->oid, oid))
-			return co;
+			return &co->value;
 	}
 	if (oideq(oid, the_hash_algo->empty_tree))
 		return &empty_tree;
@@ -1850,7 +1851,7 @@ int oid_object_info(struct repository *r,
 int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid)
 {
-	struct cached_object *co;
+	struct cached_object_entry *co;
 	char *co_buf;
 
 	hash_object_file(the_hash_algo, buf, len, type, oid);
@@ -1859,11 +1860,11 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
-	co->size = len;
-	co->type = type;
+	co->value.size = len;
+	co->value.type = type;
 	co_buf = xmalloc(len);
 	memcpy(co_buf, buf, len);
-	co->buf = co_buf;
+	co->value.buf = co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
-- 
2.47.0.541.ge258d9a1f8

