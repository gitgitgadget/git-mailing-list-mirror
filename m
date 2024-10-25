Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EE67A0D
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839908; cv=none; b=EsYnnnkX93F44DHhDvIkPS8nsm63JFCp4nc0l4XPW/HGHpvNslZSl9Oqh23B9vwxBo11Jxf/OBON9T/u3cyc8hbGrsF8BxDoOzyHe13g56dTMUDpMEdRPOZ2rkFNRUTzVnjhNavpdj+rALzN27etEpWX78w9ZYs5aqdwt+a/b00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839908; c=relaxed/simple;
	bh=6zxf/GTRXiAvW8ycrg7/fZ5H9l/mjpXa/ODqMDj2Gik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6NUu1KGvjL4y9i23Mz7/jWBU/CvINdYYndepZwlfav6sB/NJkEwr/yNERVAqHFeRJs4gPA2iXUKasKKe58hYZU1ZwSrilseNKzBiuJy8eej+h48I9Y5tLo+4ik1eYH9lAMg1NkRPHx4kw1n4mLAFNKogWvhairGAs2DvGtExHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vt0Wmdbq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vt0Wmdbq"
Received: (qmail 571 invoked by uid 109); 25 Oct 2024 07:05:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6zxf/GTRXiAvW8ycrg7/fZ5H9l/mjpXa/ODqMDj2Gik=; b=Vt0WmdbqFHm37ElhrIP9VHXdC892873DY14JIB9cbTSgG6AXgvrxIpWppB4UoZSl7Na5jMnOzRPSi4YmIZz6TiQp3KscGxfiTIFnCMuNEzgZkyWfwajCnpGyBrlWS6Na3SDF3MfdHj9s11+bXf4tQnjEIJpg/xVoeHIg74JNGYSAUOQ0k7G67mVZKxEeQWdfUmg7KzcLQYOMwVhXt52rawmbGzqNW55CB7qf2vzR/iiz/UvX/kxluGAZXckexrM6BMEGr8cu9f/O3opBXlcJj9U0pmzsXHB5lC9BdTWNO+IGDm4plE/qig/u1VaVdJA/4l+g9HXGQPWQwkgj7JVh/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:05:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12940 invoked by uid 111); 25 Oct 2024 07:05:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:05:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:05:03 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 09/11] packfile: convert find_sha1_pack() to use object_id
Message-ID: <20241025070503.GI2110355@coredump.intra.peff.net>
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

The find_sha1_pack() function has a few problems:

  - it's badly named, since it works with any object hash

  - it takes the hash as a bare pointer rather than an object_id struct

We can fix both of these easily, as all callers actually have a real
object_id anyway.

I also found the existence of this function somewhat confusing, as it is
about looking in an arbitrary set of linked packed_git structs. It's
good for things like dumb-http which are looking in downloaded remote
packs, and not our local packs. But despite the name, it is not a good
way to find the pack which contains a local object (it skips the use of
the midx, the pack mru list, and so on).

So let's also add an explanatory comment above the declaration that may
point people in the right direction.

I suspect the calls in fast-import.c, which use the packed_git list from
the repository struct, could actually just be using find_pack_entry().
But since we'd need to keep it anyway for dumb-http, I didn't dig
further there. If we eventually drop dumb-http support, then it might be
worth examining them to see if we can get rid of the function entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-import.c | 6 ++----
 http-push.c           | 4 ++--
 http-walker.c         | 2 +-
 packfile.c            | 6 +++---
 packfile.h            | 9 +++++++--
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1e7ab67f6e..76d5c20f14 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -966,8 +966,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(oid.hash,
-				  get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1167,8 +1166,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_sha1_pack(oid.hash,
-				  get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/http-push.c b/http-push.c
index aad89f2eab..4d24e6b8d4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -309,7 +309,7 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct http_pack_request *preq;
 
-	target = find_sha1_pack(request->obj->oid.hash, repo->packs);
+	target = find_oid_pack(&request->obj->oid, repo->packs);
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", oid_to_hex(&request->obj->oid));
 		repo->can_update_info_refs = 0;
@@ -681,7 +681,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 		get_remote_object_list(obj->oid.hash[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_sha1_pack(obj->oid.hash, repo->packs);
+	target = find_oid_pack(&obj->oid, repo->packs);
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
diff --git a/http-walker.c b/http-walker.c
index 36dd1f33c0..43cde0ebe5 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -432,7 +432,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
 
 	if (fetch_indices(walker, repo))
 		return -1;
-	target = find_sha1_pack(oid->hash, repo->packs);
+	target = find_oid_pack(oid, repo->packs);
 	if (!target)
 		return -1;
 	close_pack_index(target);
diff --git a/packfile.c b/packfile.c
index 0d4fd2737a..c51eab15a5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2010,13 +2010,13 @@ int is_pack_valid(struct packed_git *p)
 	return !open_packed_git(p);
 }
 
-struct packed_git *find_sha1_pack(const unsigned char *sha1,
-				  struct packed_git *packs)
+struct packed_git *find_oid_pack(const struct object_id *oid,
+				 struct packed_git *packs)
 {
 	struct packed_git *p;
 
 	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(sha1, p))
+		if (find_pack_entry_one(oid->hash, p))
 			return p;
 	}
 	return NULL;
diff --git a/packfile.h b/packfile.h
index ad393be9f1..3baffa940c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,8 +79,13 @@ struct packed_git *get_all_packs(struct repository *r);
  */
 unsigned long repo_approximate_object_count(struct repository *r);
 
-struct packed_git *find_sha1_pack(const unsigned char *sha1,
-				  struct packed_git *packs);
+/*
+ * Find the pack within the "packs" list whose index contains the object "oid".
+ * For general object lookups, you probably don't want this; use
+ * find_pack_entry() instead.
+ */
+struct packed_git *find_oid_pack(const struct object_id *oid,
+				 struct packed_git *packs);
 
 void pack_report(void);
 
-- 
2.47.0.363.g6e72b256be

