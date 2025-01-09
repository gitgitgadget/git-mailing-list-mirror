Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AB13C9C4
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411560; cv=none; b=ViAJHPlKazO51HrRYtA/ij4MxfUFQWmnePDb28FXrxd/xsEjgq8xpZBgSxluXFQoUhjchcX6cjCXAlOUcRHSvbn54EfSerIq9C65aNnsyntIS3MsT+LLKaRwPo41X4ZG3te6xMEfXLGunH0G6IwRkzCloA49R2XKt64bl2nlI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411560; c=relaxed/simple;
	bh=f7BGpA9HF0ZnklvmcMQTt7BR89OAEPdFoVv4hyhI54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1+GP7rz5CJL5dr0AZ9/6qbRNo0svFOt5O6Hfndpp0AYQRaO5qXdW9jX6TmWNAqZgdCWW31hn0xRnEeK/kU8xpzUbImNwwFOihKHhTDyXCtxLC+p2e7mbu6BMFaRps3VEL2ahufLOvSCanSwz55Yg67+SmfTB6hNq7sqTmDQ3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VWre46i0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VWre46i0"
Received: (qmail 25605 invoked by uid 109); 9 Jan 2025 08:32:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f7BGpA9HF0ZnklvmcMQTt7BR89OAEPdFoVv4hyhI54g=; b=VWre46i010dIzERs6k7Meko63eU42utsbwE6UIP+giqLWa0UMwunSQusT6v7RLQo72s2WuVE0v+zbi2y3v2/AZgGusju/9n/euDQaZZg+Q9mt9T5zvYEhNjsFHCzFNmwmEk3IKgQkMzVIvNsQhReR642A3G0us16DGyPHgl4o82PAQPb7Czbg1Me/PiTnTuf7YOaFjmEiHSduLZA6jgwbSag9VqGF8jYnaUSb5t9YjGV/xTV2xzda9I3wjh19f7Lzpv09nemWhi2617nPC6ctVmeZ0dowjizF10hJrIQyyUkfLCn5J1/z27j3BP5ZBHA5Rg/hYnVaQ30vXV5E7cE+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20113 invoked by uid 111); 9 Jan 2025 08:32:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:32:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:32:36 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 02/14] combine-diff: add combine_diff_path_new()
Message-ID: <20250109083236.GB2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

The combine_diff_path struct has variable size, since it embeds both the
memory allocation for the path field as well as a variable-sized parent
array. This makes allocating one a bit tricky.

We have a helper to compute the required size, but it's up to individual
sites to actually initialize all of the fields. Let's provide a
constructor function to make that a little nicer. Besides being shorter,
it also hides away tricky bits like the computation of the "path"
pointer (which is right after the "parent" flex array).

As a bonus, using the same constructor everywhere means that we'll
consistently initialize all parts of the struct. A few code paths left
the parent array unitialized. This didn't cause any bugs, but we'll be
able to simplify some code in the next few patches knowing that the
parent fields have all been zero'd.

This also gets rid of some questionable uses of "int" to store buffer
lengths. Though we do use them to allocate, I don't think there are any
integer overflow vulnerabilities here (the allocation helper promotes
them to size_t and checks arithmetic for overflow, and the actual memcpy
of the bytes is done using the possibly-truncated "int" value).

Sadly we can't use the FLEX_* macros to simplify the allocation here,
because there are two variable-sized parts to the struct (and those
macros only handle one).

Nor can we get stop publicly declaring combine_diff_path_size(). This
patch does not touch the code in path_appendnew() at all, which is not
ready to be moved to our new constructor for a few reasons:

  - path_appendnew() has a memory-reuse optimization where it tries to
    reuse combine_diff_path structs rather than freeing and
    reallocating.

  - path_appendnew() does not create the struct from a single path
    string, but rather allocates and copies into the buffer from
    multiple sources.

These can be addressed by some refactoring, but let's leave it as-is for
now.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c | 40 ++++++++++++++++++++++++++--------------
 diff-lib.c     | 29 ++++++-----------------------
 diff.h         |  5 +++++
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 641bc92dbd..45548fd438 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -47,22 +47,13 @@ static struct combine_diff_path *intersect_paths(
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
-			int len;
-			const char *path;
 			if (diff_unmodified_pair(q->queue[i]))
 				continue;
-			path = q->queue[i]->two->path;
-			len = strlen(path);
-			p = xmalloc(combine_diff_path_size(num_parent, len));
-			p->path = (char *) &(p->parent[num_parent]);
-			memcpy(p->path, path, len);
-			p->path[len] = 0;
-			p->next = NULL;
-			memset(p->parent, 0,
-			       sizeof(p->parent[0]) * num_parent);
-
-			oidcpy(&p->oid, &q->queue[i]->two->oid);
-			p->mode = q->queue[i]->two->mode;
+			p = combine_diff_path_new(q->queue[i]->two->path,
+						  strlen(q->queue[i]->two->path),
+						  q->queue[i]->two->mode,
+						  &q->queue[i]->two->oid,
+						  num_parent);
 			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
@@ -1667,3 +1658,24 @@ void diff_tree_combined_merge(const struct commit *commit,
 	diff_tree_combined(&commit->object.oid, &parents, rev);
 	oid_array_clear(&parents);
 }
+
+struct combine_diff_path *combine_diff_path_new(const char *path,
+						size_t path_len,
+						unsigned int mode,
+						const struct object_id *oid,
+						size_t num_parents)
+{
+	struct combine_diff_path *p;
+
+	p = xmalloc(combine_diff_path_size(num_parents, path_len));
+	p->path = (char *)&(p->parent[num_parents]);
+	memcpy(p->path, path, path_len);
+	p->path[path_len] = 0;
+	p->next = NULL;
+	p->mode = mode;
+	oidcpy(&p->oid, oid);
+
+	memset(p->parent, 0, sizeof(p->parent[0]) * num_parents);
+
+	return p;
+}
diff --git a/diff-lib.c b/diff-lib.c
index 85b8f1fa59..471ef99614 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -153,7 +153,6 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			struct diff_filepair *pair;
 			unsigned int wt_mode = 0;
 			int num_compare_stages = 0;
-			size_t path_len;
 			struct stat st;
 
 			changed = check_removed(ce, &st);
@@ -167,18 +166,8 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				wt_mode = 0;
 			}
 
-			path_len = ce_namelen(ce);
-
-			dpath = xmalloc(combine_diff_path_size(5, path_len));
-			dpath->path = (char *) &(dpath->parent[5]);
-
-			dpath->next = NULL;
-			memcpy(dpath->path, ce->name, path_len);
-			dpath->path[path_len] = '\0';
-			oidclr(&dpath->oid, the_repository->hash_algo);
-			dpath->mode = wt_mode;
-			memset(&(dpath->parent[0]), 0,
-			       sizeof(struct combine_diff_parent)*5);
+			dpath = combine_diff_path_new(ce->name, ce_namelen(ce),
+						      wt_mode, null_oid(), 5);
 
 			while (i < entries) {
 				struct cache_entry *nce = istate->cache[i];
@@ -405,16 +394,10 @@ static int show_modified(struct rev_info *revs,
 	if (revs->combine_merges && !cached &&
 	    (!oideq(oid, &old_entry->oid) || !oideq(&old_entry->oid, &new_entry->oid))) {
 		struct combine_diff_path *p;
-		int pathlen = ce_namelen(new_entry);
-
-		p = xmalloc(combine_diff_path_size(2, pathlen));
-		p->path = (char *) &p->parent[2];
-		p->next = NULL;
-		memcpy(p->path, new_entry->name, pathlen);
-		p->path[pathlen] = 0;
-		p->mode = mode;
-		oidclr(&p->oid, the_repository->hash_algo);
-		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
+
+		p = combine_diff_path_new(new_entry->name,
+					  ce_namelen(new_entry),
+					  mode, null_oid(), 2);
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new_entry->ce_mode;
 		oidcpy(&p->parent[0].oid, &new_entry->oid);
diff --git a/diff.h b/diff.h
index 6e6007c17b..5cddd5a870 100644
--- a/diff.h
+++ b/diff.h
@@ -486,6 +486,11 @@ struct combine_diff_path {
 #define combine_diff_path_size(n, l) \
 	st_add4(sizeof(struct combine_diff_path), (l), 1, \
 		st_mult(sizeof(struct combine_diff_parent), (n)))
+struct combine_diff_path *combine_diff_path_new(const char *path,
+						size_t path_len,
+						unsigned int mode,
+						const struct object_id *oid,
+						size_t num_parents);
 
 void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			struct rev_info *);
-- 
2.48.0.rc2.413.gc1c80375a3

