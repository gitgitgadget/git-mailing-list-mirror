Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028E18C03C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839826; cv=none; b=NvoGM9qnoYFoAWnedHjvtkd0oYzn4dAImsj27rPncm4NdJ7CFd4N2lO+or75l6UpuMFDZT196LDzXT/u208P4FjwV+Z00rlVE+EbuxwGI78EcO/klKK/J03Y/MCKMNjzinzN+/ZPXTHvIFBIAmNlhUk72iH2fKDF8myshP1jJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839826; c=relaxed/simple;
	bh=x51T6HYxO7B25wj82pfZK7lcgjg8rQfanLKBc1VA558=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpBojRKQnDWc+2hMR70FuUuzpcRJiqskW3soFFyNC5DbFa3c8jnhgDgF2iN2EwX01m4iB03mYRlUx2xLBKcoWC4fRIjg7YgqfVSl7E509lqL+RfGEjazjYy8z8Kn9VV2NDTKS3WAeY3turgUb6CB2UyusUCcTC5oTsnVl/12aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SNhu2Z44; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SNhu2Z44"
Received: (qmail 552 invoked by uid 109); 25 Oct 2024 07:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x51T6HYxO7B25wj82pfZK7lcgjg8rQfanLKBc1VA558=; b=SNhu2Z44fROv4UvCpNRPb9ewHdFDjNuFhUPS/qQtb7+PcEyYz5BZxJlMVOWORbP7sviAaxce3oJeSkEtbE1Esa29sTmBwNi74riVBhZy+n2Zi3UgcT6rkZJFZM6ZxQ5enxoxRg0/Ua2/FyzsstiQzGgzNnSu81PIet501x0WV3kT0xEIQN/qYtRQ0w1IxtTGraJnRb348we/rKCRl9yLcDSHfmbMJptFkCBqhaC21iX7N0JYIX+mfmRRYjoT89+T80pKuK2dCJvl9nRaylfu58TNsvyOkeoPLKLHEe2fTUi5xxRQtFN2NnMhv+lDGQRCBWR9xXQMjcS6Cy9hsNa2dQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:03:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12867 invoked by uid 111); 25 Oct 2024 07:03:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:03:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:03:42 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 08/11] http-walker: use object_id instead of bare hash
Message-ID: <20241025070342.GH2110355@coredump.intra.peff.net>
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

We long ago switched most code to using object_id structs instead of
bare "unsigned char *" hashes. This gives us more type safety from the
compiler, and generally makes it easier to understand what we expect in
each parameter.

But the dumb-http code has lagged behind. And indeed, the whole "walker"
subsystem interface has the same problem, though http-walker is the only
user left.

So let's update the walker interface to pass object_id structs (which we
already have anyway at all call sites!), and likewise use those within
the http-walker methods that it calls.

This cleans up the dumb-http code a bit, but will also let us fix a few
more commonly used helper functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c | 25 +++++++++++++------------
 walker.c      |  4 ++--
 walker.h      |  4 ++--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index fb2d86d5e7..36dd1f33c0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -147,14 +147,14 @@ static int fill_active_slot(void *data UNUSED)
 	return 0;
 }
 
-static void prefetch(struct walker *walker, unsigned char *sha1)
+static void prefetch(struct walker *walker, const struct object_id *oid)
 {
 	struct object_request *newreq;
 	struct walker_data *data = walker->data;
 
 	newreq = xmalloc(sizeof(*newreq));
 	newreq->walker = walker;
-	oidread(&newreq->oid, sha1, the_repository->hash_algo);
+	oidcpy(&newreq->oid, oid);
 	newreq->repo = data->alt;
 	newreq->state = WAITING;
 	newreq->req = NULL;
@@ -422,7 +422,8 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	return ret;
 }
 
-static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
+			   const struct object_id *oid)
 {
 	struct packed_git *target;
 	int ret;
@@ -431,7 +432,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (fetch_indices(walker, repo))
 		return -1;
-	target = find_sha1_pack(sha1, repo->packs);
+	target = find_sha1_pack(oid->hash, repo->packs);
 	if (!target)
 		return -1;
 	close_pack_index(target);
@@ -440,7 +441,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 		fprintf(stderr, "Getting pack %s\n",
 			hash_to_hex(target->hash));
 		fprintf(stderr, " which contains %s\n",
-			hash_to_hex(sha1));
+			oid_to_hex(oid));
 	}
 
 	preq = new_http_pack_request(target->hash, repo->base);
@@ -477,17 +478,17 @@ static void abort_object_request(struct object_request *obj_req)
 	release_object_request(obj_req);
 }
 
-static int fetch_object(struct walker *walker, unsigned char *hash)
+static int fetch_object(struct walker *walker, const struct object_id *oid)
 {
-	char *hex = hash_to_hex(hash);
+	char *hex = oid_to_hex(oid);
 	int ret = 0;
 	struct object_request *obj_req = NULL;
 	struct http_object_request *req;
 	struct list_head *pos, *head = &object_queue_head;
 
 	list_for_each(pos, head) {
 		obj_req = list_entry(pos, struct object_request, node);
-		if (hasheq(obj_req->oid.hash, hash, the_repository->hash_algo))
+		if (oideq(&obj_req->oid, oid))
 			break;
 	}
 	if (!obj_req)
@@ -548,20 +549,20 @@ static int fetch_object(struct walker *walker, unsigned char *hash)
 	return ret;
 }
 
-static int fetch(struct walker *walker, unsigned char *hash)
+static int fetch(struct walker *walker, const struct object_id *oid)
 {
 	struct walker_data *data = walker->data;
 	struct alt_base *altbase = data->alt;
 
-	if (!fetch_object(walker, hash))
+	if (!fetch_object(walker, oid))
 		return 0;
 	while (altbase) {
-		if (!http_fetch_pack(walker, altbase, hash))
+		if (!http_fetch_pack(walker, altbase, oid))
 			return 0;
 		fetch_alternates(walker, data->alt->base);
 		altbase = altbase->next;
 	}
-	return error("Unable to find %s under %s", hash_to_hex(hash),
+	return error("Unable to find %s under %s", oid_to_hex(oid),
 		     data->alt->base);
 }
 
diff --git a/walker.c b/walker.c
index 807a7a3881..5ea7e5b392 100644
--- a/walker.c
+++ b/walker.c
@@ -157,7 +157,7 @@ static int process(struct walker *walker, struct object *obj)
 	else {
 		if (obj->flags & COMPLETE)
 			return 0;
-		walker->prefetch(walker, obj->oid.hash);
+		walker->prefetch(walker, &obj->oid);
 	}
 
 	object_list_insert(obj, process_queue_end);
@@ -186,7 +186,7 @@ static int loop(struct walker *walker)
 		 * the queue because we needed to fetch it first.
 		 */
 		if (! (obj->flags & TO_SCAN)) {
-			if (walker->fetch(walker, obj->oid.hash)) {
+			if (walker->fetch(walker, &obj->oid)) {
 				stop_progress(&progress);
 				report_missing(obj);
 				return -1;
diff --git a/walker.h b/walker.h
index d40b016bab..25aaa3631c 100644
--- a/walker.h
+++ b/walker.h
@@ -6,8 +6,8 @@
 struct walker {
 	void *data;
 	int (*fetch_ref)(struct walker *, struct ref *ref);
-	void (*prefetch)(struct walker *, unsigned char *sha1);
-	int (*fetch)(struct walker *, unsigned char *sha1);
+	void (*prefetch)(struct walker *, const struct object_id *oid);
+	int (*fetch)(struct walker *, const struct object_id *oid);
 	void (*cleanup)(struct walker *);
 	int get_verbosely;
 	int get_progress;
-- 
2.47.0.363.g6e72b256be

