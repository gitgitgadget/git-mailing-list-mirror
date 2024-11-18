Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61117C98
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923719; cv=none; b=MPFypo+0WGOaj9FmY6P0LDMr3Kz5Xb0t2//xKEM3vaaAhuJo/nvtLmkB1Lhoa8AvTpjsHu4UWPmDlSl717c++2fnkB8bDCdSy3E2wsTlRkoA05+2xhob3PdJNsL/V8+AC4pCx+TXdk+QKQxZ207lhbu1DttT562Y+jUsFb5HgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923719; c=relaxed/simple;
	bh=681QhZiK+l0PIHqs7WNmA8JGlKrfjBeNzT8JFIQWpN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyvy/l5MYYXm9hYbe23ad9QpOOz173KYZWI2wUbiSubmUpJEHI2GA/S90/3jasZfuG/It2ko0fuyMy6HD7HLUuLUV7laN/3bWxxolqd3gw8fllSHKDso3XKYqKYFndoA7DifEI+vDWVH4rmaLPQ7mWvBWC3PsErzN2An7vgMymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UJ+B0cCR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UJ+B0cCR"
Received: (qmail 22452 invoked by uid 109); 18 Nov 2024 09:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=681QhZiK+l0PIHqs7WNmA8JGlKrfjBeNzT8JFIQWpN8=; b=UJ+B0cCRWasSARelyrBQJETSAiMmqFn4+VZyIa17nBFBEx7K1Bv26zON0mWDs1uXieRR4Npr3QDjeuaJav+92E9RV42K9Ui+N8S3igHO7Nd1JfkdRPQe2xhHpg/JxMAQNcIc2000t1362c+qeJhS+f4CotU+nmoqGBUaovFdDStnYoqfgfQOlV5Xec4qgrj2VWUC9FUhw9JzfmdFnXERfrYz4Tue/60dUzZ4mKXFNY+OapaQU4y8QNEVNrrelTwrmmKObEIYfO1lci1zB0j6FrYxPPI+E6ATRY1yAMpqKnxAGc5BFIIgqG15Go0LwOhr6WINajnDtVXxXJdZ36G8EA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Nov 2024 09:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18318 invoked by uid 111); 18 Nov 2024 09:55:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2024 04:55:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Nov 2024 04:55:15 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: [PATCH 4/6] object-file: drop oid field from find_cached_object()
 return value
Message-ID: <20241118095515.GD3992317@coredump.intra.peff.net>
References: <20241118095423.GA3990835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118095423.GA3990835@coredump.intra.peff.net>

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
index 4d4280543e..67a6731066 100644
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
2.47.0.547.g778689293a

