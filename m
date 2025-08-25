Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8611FF7C7
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109631; cv=none; b=qkAy7RmfmIf71zIPfkyuMfzbBrBLneLaNTxHg3HOVIQN4Yf+ZIpGd+Fa5+BIRzPaiJI7T+JoxkNjOIpq1WC83TzYZUehc6CJCE7okjh7KAEH97JLAE3v5BxltXGw2+ZwxuKSKHuS7i7dRnbZ48gAqsa+XGCLCgZHscZLd8N8JBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109631; c=relaxed/simple;
	bh=WJ+x6EqAqPigt5ct49ag4tgmpw/jimI4zlHziCXP634=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpdjUlZH+B4tik5ylHjzHLxhmjY6I/zRUzYZ0Bb09o6jmjGBdYwBXHXoLx76SExhn8YkuH8K8G2Mol+hcnVXcsD/3/Sfy/9Js8T1ml80gDqMJk13nwlotGtthERY/YNtN6o7XKSIaekYM3jEwDL9mR6mSn5hUpIPmqPDf0qpWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gPULLv0K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gPULLv0K"
Received: (qmail 73489 invoked by uid 109); 25 Aug 2025 08:13:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WJ+x6EqAqPigt5ct49ag4tgmpw/jimI4zlHziCXP634=; b=gPULLv0KwqMfPMe105TvKJOVdFETGWs17bO1Y1WmXq8OrKQVYxYuC9gqWb8BQnGz1N1eYzyPE5kMxf7XXAS5LSfu/gOWzk2rFsyA9584L0/QB4fYHc4cLdBlbnkJhOKfeRAfufcp4k1OTgA9r/LDe8LPINYoGxrFAsAM77tmkpcodlQfqaNFrGqXPs+VzlboRiquw0cNIlfjKsHEhdQOWtCNYWR2tm7tbFwaIe9BbyUXXp3PmHQKt1OHu4opvt2CmnH6ZA62QVmvoZyZ9igJrWi2ou77k+24EAYa7cZmeXTfXk3+ldxt5rQGnDWbYJBkkRx2UEGo/qTg5H1BqOx69A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Aug 2025 08:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 150509 invoked by uid 111); 25 Aug 2025 08:13:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Aug 2025 04:13:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Aug 2025 04:13:45 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250825081345.GA352784@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825073403.GA332447@coredump.intra.peff.net>

On Mon, Aug 25, 2025 at 03:34:03AM -0400, Jeff King wrote:

> > The nice thing about commit-slabs is the lack of required maintenance.
> > They just allocate as needed and never give anything back, never need to
> > rehash.  And they don't need to store the keys anywhere.  They should be
> > good alternatives to object flags used during full history traversal
> > without flagging non-commits.
> > 
> > Off-the-shelf hash tables like khash might be slower in these cases,
> > though not far off, I expect.
> 
> Yeah, maybe. I've never really loved the drawbacks of commit-slab, and
> your numbers made me wonder if we could be getting away with hashes in
> more places. Though one of the drawbacks I find with commit-slab is the
> grossness of instantiating a giant mess of macros. That is not much
> better with khash. ;) And certainly oidmap, though it does not use
> macros, is no picnic to use either.

So out of curiosity I tried replacing a slab that should be pretty
densely filled, using a khash based on oidhash/ptr along with some
quality-of-life wrappers.  Patch is below.

It performs...very badly. Not sure if I've screwed something up, but
it's about 7x slower to run "git rev-list --author-date-order HEAD" in
the kernel. So maybe slabs really are worth it overall.

-Peff

---
diff --git a/commit.c b/commit.c
index 16d91b2bfc..0678932ab8 100644
--- a/commit.c
+++ b/commit.c
@@ -822,9 +822,7 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
-define_commit_slab(author_date_slab, timestamp_t);
-
-void record_author_date(struct author_date_slab *author_date,
+void record_author_date(kh_obj_timestamp_t *author_date,
 			struct commit *commit)
 {
 	const char *buffer = repo_get_commit_buffer(the_repository, commit,
@@ -845,7 +843,7 @@ void record_author_date(struct author_date_slab *author_date,
 	date = parse_timestamp(ident.date_begin, &date_end, 10);
 	if (date_end != ident.date_end)
 		goto fail_exit; /* malformed date */
-	*(author_date_slab_at(author_date, commit)) = date;
+	obj_timestamp_put(author_date, &commit->object, date);
 
 fail_exit:
 	repo_unuse_commit_buffer(the_repository, commit, buffer);
@@ -855,9 +853,9 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 				   void *cb_data)
 {
 	const struct commit *a = a_, *b = b_;
-	struct author_date_slab *author_date = cb_data;
-	timestamp_t a_date = *(author_date_slab_at(author_date, a));
-	timestamp_t b_date = *(author_date_slab_at(author_date, b));
+	kh_obj_timestamp_t *author_date = cb_data;
+	timestamp_t a_date = obj_timestamp_get(author_date, &a->object);
+	timestamp_t b_date = obj_timestamp_get(author_date, &b->object);
 
 	/* newer commits with larger date first */
 	if (a_date < b_date)
@@ -910,7 +908,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	struct indegree_slab indegree;
 	struct prio_queue queue;
 	struct commit *commit;
-	struct author_date_slab author_date;
+	kh_obj_timestamp_t author_date;
 
 	if (!orig)
 		return;
@@ -927,7 +925,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 		queue.compare = compare_commits_by_commit_date;
 		break;
 	case REV_SORT_BY_AUTHOR_DATE:
-		init_author_date_slab(&author_date);
+		memset(&author_date, 0, sizeof(author_date));
 		queue.compare = compare_commits_by_author_date;
 		queue.cb_data = &author_date;
 		break;
@@ -1011,7 +1009,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	clear_indegree_slab(&indegree);
 	clear_prio_queue(&queue);
 	if (sort_order == REV_SORT_BY_AUTHOR_DATE)
-		clear_author_date_slab(&author_date);
+		kh_release_obj_timestamp(&author_date);
 }
 
 struct rev_collect {
diff --git a/commit.h b/commit.h
index 1d6e0c7518..f49531ab8b 100644
--- a/commit.h
+++ b/commit.h
@@ -334,8 +334,8 @@ int remove_signature(struct strbuf *buf);
 int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
 /* record author-date for each commit object */
-struct author_date_slab;
-void record_author_date(struct author_date_slab *author_date,
+struct kh_obj_timestamp_t;
+void record_author_date(kh_obj_timestamp_t *author_date,
 			struct commit *commit);
 
 int compare_commits_by_author_date(const void *a_, const void *b_, void *unused);
diff --git a/object.h b/object.h
index 8c3c1c46e1..14718051f2 100644
--- a/object.h
+++ b/object.h
@@ -2,6 +2,7 @@
 #define OBJECT_H
 
 #include "hash.h"
+#include "khash.h"
 
 struct buffer_slab;
 struct repository;
@@ -340,4 +341,33 @@ void clear_object_flags(struct repository *repo, unsigned flags);
  */
 void repo_clear_commit_marks(struct repository *r, unsigned int flags);
 
+/*
+ * This would all probably go into its own header file...
+ */
+static inline unsigned int obj_ptr_hash(const struct object *obj)
+{
+	return oidhash(&obj->oid);
+}
+
+static inline int obj_ptr_eq(const struct object *a, const struct object *b)
+{
+	return a == b;
+}
+
+#define OBJHASH_INIT(name, value_type, sentinel) \
+KHASH_INIT(name, const struct object *, value_type, 1, obj_ptr_hash, obj_ptr_eq); \
+static inline void name##_put(kh_##name##_t *map, const struct object *obj, value_type v) \
+{ \
+	int hash_ret; \
+	khiter_t pos = kh_put_##name(map, obj, &hash_ret); \
+	kh_value(map, pos) = v; \
+} \
+static inline value_type name##_get(kh_##name##_t *map, const struct object *obj) \
+{ \
+	khiter_t pos = kh_get_##name(map, obj); \
+	return pos == kh_end(map) ? sentinel : kh_value(map, pos); \
+}
+
+OBJHASH_INIT(obj_timestamp, timestamp_t, 0);
+
 #endif /* OBJECT_H */
diff --git a/revision.c b/revision.c
index 6ba8f67054..e67cf2249a 100644
--- a/revision.c
+++ b/revision.c
@@ -3622,15 +3622,14 @@ static int mark_uninteresting(const struct object_id *oid,
 }
 
 define_commit_slab(indegree_slab, int);
-define_commit_slab(author_date_slab, timestamp_t);
 
 struct topo_walk_info {
 	timestamp_t min_generation;
 	struct prio_queue explore_queue;
 	struct prio_queue indegree_queue;
 	struct prio_queue topo_queue;
 	struct indegree_slab indegree;
-	struct author_date_slab author_date;
+	kh_obj_timestamp_t author_date;
 };
 
 static int topo_walk_atexit_registered;
@@ -3755,7 +3754,7 @@ static void release_revisions_topo_walk_info(struct topo_walk_info *info)
 	clear_prio_queue(&info->indegree_queue);
 	clear_prio_queue(&info->topo_queue);
 	clear_indegree_slab(&info->indegree);
-	clear_author_date_slab(&info->author_date);
+	kh_release_obj_timestamp(&info->author_date);
 	free(info);
 }
 
@@ -3789,7 +3788,7 @@ static void init_topo_walk(struct rev_info *revs)
 		info->topo_queue.compare = compare_commits_by_commit_date;
 		break;
 	case REV_SORT_BY_AUTHOR_DATE:
-		init_author_date_slab(&info->author_date);
+		memset(&info->author_date, 0, sizeof(info->author_date));
 		info->topo_queue.compare = compare_commits_by_author_date;
 		info->topo_queue.cb_data = &info->author_date;
 		break;
