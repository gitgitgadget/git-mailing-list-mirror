Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EF1AF0CD
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839970; cv=none; b=CEir8wkXNiQa2fCGNZ66qZ2R05H/gBgzMAh8uX9XKBPAHzV+7X6imk8EHvof1whZf9A1BN2jX5r3ZiLbo1HB7eTkLdKgtHpOZzjhv4wvD16wFucn4dxt4UmaQoYHymjwaqEz/qvq10vSO3Wo/aJKWSsdD5f1nVZVkhV2mOd24AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839970; c=relaxed/simple;
	bh=eJT1jyDZR/MRlz3PheptSkUjERDORmD07nUiXDNXu1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9+yc+nAGp2V4OlYDSk8kB9vzKI4TGvQPyIH9zhPASu+OL8N+2uGUQZuIj9OHLGsL17vbUGkCPB1dfB8UMXcb7iShGI+St3whGyfh31+uhpH7Iafy07uIUz2HFkIYQ5kUgfRpPA3inUVtNVbqLPR9MSXizh6yZD/IUOHo2o7oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=beruCH7v; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="beruCH7v"
Received: (qmail 583 invoked by uid 109); 25 Oct 2024 07:06:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eJT1jyDZR/MRlz3PheptSkUjERDORmD07nUiXDNXu1Q=; b=beruCH7vvt25Pqvv8Aaeeka6Ci+FGXPOSPpGtL9GuqNC4ow/3nWvlshYHPrvA/qLMpwY89N9VXVche8Cafu53KjCqrDSlet8ibeFZiAor85r9a4Nxyu5IiM5iFiA3JcETKS58OstI764ByGXZOJbZ1oZizKwpUJwRing+o/Q0uVz6wFDP9DhtKFSEQhEZ4GMInIEp7In5nr8Onlk1HGOfRJmkGnVxJw9unv/4vT2dXyTuPQK9XW6XiXGgg5H/CHqa4XsWezQNlM/Y4OpBpW3HU3oLLAd+hrmIiXy8zQW84FuK0GA7j8UPh/x6vkV1NUZlGj7OePjYDvivmKGHHo0Tg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12947 invoked by uid 111); 25 Oct 2024 07:06:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:06:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:06:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 10/11] packfile: use object_id in find_pack_entry_one()
Message-ID: <20241025070606.GJ2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

The main function we use to search a pack index for an object is
find_pack_entry_one(). That function still takes a bare pointer to the
hash, despite the fact that its underlying bsearch_pack() function needs
an object_id struct. And so we end up making an extra copy of the hash
into the struct just to do a lookup.

As it turns out, all callers but one already have such an object_id. So
we can just take a pointer to that struct and use it directly. This
avoids the extra copy and provides a more type-safe interface.

The one exception is get_delta_base() in packfile.c, when we are chasing
a REF_DELTA from inside the pack (and thus we have a pointer directly to
the mmap'd pack memory, not a struct). We can just bump the hashcpy()
from inside find_pack_entry_one() to this one caller that needs it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c    |  4 ++--
 connected.c               |  4 ++--
 midx.c                    |  2 +-
 pack-bitmap.c             |  4 ++--
 packfile.c                | 16 ++++++++--------
 packfile.h                |  4 ++--
 t/helper/test-find-pack.c |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b40..0800714267 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1556,7 +1556,7 @@ static int want_object_in_pack_one(struct packed_git *p,
 	if (p == *found_pack)
 		offset = *found_offset;
 	else
-		offset = find_pack_entry_one(oid->hash, p);
+		offset = find_pack_entry_one(oid, p);
 
 	if (offset) {
 		if (!*found_pack) {
@@ -3984,7 +3984,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
 				p->pack_keep_in_core) &&
-			find_pack_entry_one(oid->hash, p)) {
+			find_pack_entry_one(oid, p)) {
 			last_found = p;
 			return 1;
 		}
diff --git a/connected.c b/connected.c
index 87cc4b57a1..a9e2e13995 100644
--- a/connected.c
+++ b/connected.c
@@ -78,7 +78,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			for (p = get_all_packs(the_repository); p; p = p->next) {
 				if (!p->pack_promisor)
 					continue;
-				if (find_pack_entry_one(oid->hash, p))
+				if (find_pack_entry_one(oid, p))
 					goto promisor_pack_found;
 			}
 			/*
@@ -144,7 +144,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * are sure the ref is good and not sending it to
 		 * rev-list for verification.
 		 */
-		if (new_pack && find_pack_entry_one(oid->hash, new_pack))
+		if (new_pack && find_pack_entry_one(oid, new_pack))
 			continue;
 
 		if (fprintf(rev_list_in, "%s\n", oid_to_hex(oid)) < 0)
diff --git a/midx.c b/midx.c
index 479812cb9b..e82d4f2e65 100644
--- a/midx.c
+++ b/midx.c
@@ -987,7 +987,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		}
 
 		m_offset = e.offset;
-		p_offset = find_pack_entry_one(oid.hash, e.p);
+		p_offset = find_pack_entry_one(&oid, e.p);
 
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 32b222a7af..4fa9dfc771 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -935,7 +935,7 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
 	uint32_t pos;
-	off_t offset = find_pack_entry_one(oid->hash, bitmap_git->pack);
+	off_t offset = find_pack_entry_one(oid, bitmap_git->pack);
 	if (!offset)
 		return -1;
 
@@ -1609,7 +1609,7 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
 				return 1;
 		} else {
-			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
+			if (find_pack_entry_one(&object->oid, bitmap_git->pack) > 0)
 				return 1;
 		}
 	}
diff --git a/packfile.c b/packfile.c
index c51eab15a5..005ca670b4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1239,7 +1239,9 @@ off_t get_delta_base(struct packed_git *p,
 		*curpos += used;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
-		base_offset = find_pack_entry_one(base_info, p);
+		struct object_id oid;
+		hashcpy(oid.hash, base_info, the_repository->hash_algo);
+		base_offset = find_pack_entry_one(&oid, p);
 		*curpos += the_hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
@@ -1971,20 +1973,18 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+off_t find_pack_entry_one(const struct object_id *oid,
+			  struct packed_git *p)
 {
 	const unsigned char *index = p->index_data;
-	struct object_id oid;
 	uint32_t result;
 
 	if (!index) {
 		if (open_pack_index(p))
 			return 0;
 	}
 
-	hashcpy(oid.hash, sha1, the_repository->hash_algo);
-	if (bsearch_pack(&oid, p, &result))
+	if (bsearch_pack(oid, p, &result))
 		return nth_packed_object_offset(p, result);
 	return 0;
 }
@@ -2016,7 +2016,7 @@ struct packed_git *find_oid_pack(const struct object_id *oid,
 	struct packed_git *p;
 
 	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(oid->hash, p))
+		if (find_pack_entry_one(oid, p))
 			return p;
 	}
 	return NULL;
@@ -2033,7 +2033,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	    oidset_contains(&p->bad_objects, oid))
 		return 0;
 
-	offset = find_pack_entry_one(oid->hash, p);
+	offset = find_pack_entry_one(oid, p);
 	if (!offset)
 		return 0;
 
diff --git a/packfile.h b/packfile.h
index 3baffa940c..08f88a7ff5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -154,10 +154,10 @@ int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
 off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 /*
- * If the object named sha1 is present in the specified packfile,
+ * If the object named by oid is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 14b2b0c12c..85a69a4e55 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -40,7 +40,7 @@ int cmd__find_pack(int argc, const char **argv)
 		die("cannot parse %s as an object name", argv[0]);
 
 	for (p = get_all_packs(the_repository); p; p = p->next)
-		if (find_pack_entry_one(oid.hash, p)) {
+		if (find_pack_entry_one(&oid, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
 		}
-- 
2.47.0.363.g6e72b256be

