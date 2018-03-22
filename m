Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA811F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeCVJqw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 05:46:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:38566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751599AbeCVJqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 05:46:52 -0400
Received: (qmail 6265 invoked by uid 109); 22 Mar 2018 09:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 09:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18122 invoked by uid 111); 22 Mar 2018 09:47:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 05:47:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 05:46:49 -0400
Date:   Thu, 22 Mar 2018 05:46:49 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180322094649.GA32698@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322093212.GB28907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 05:32:12AM -0400, Jeff King wrote:

> So 27% of the total heap goes away if you switch to a separate rev-list.
> Though it's mostly just going to a different process, it does help peak
> because that process would have exited by the time we get to the
> revindex bits.
> 
> I suspect you could get the same effect by just teaching pack-objects to
> clear obj_hash and all of the allocated object structs. I think that
> should be safe to do as long as we clear _all_ of the objects, so there
> are no dangling pointers.

The patch below tries that. It's kind of hacky, but it drops my peak
heap for packing linux.git from 1336MB to 1129MB.

That's not quite as exciting as 27%, because it just moves our peak
earlier, to when we do have all of the object structs in memory (so the
savings are really just that we're not holding the revindex, etc at the
same time as the object structs).

But we also hold that peak for a lot shorter period, because we drop the
memory before we do any delta compression (which itself can be memory
hungry[1]), and don't hold onto it during the write phase (which can be
network-limited when serving a fetch). So during that write phase we're
holding only ~900MB instead of ~1250MB.

-Peff

[1] All of my timings are on noop repacks of a single pack, so there's
    no actual delta compression. On average, it will use something like
    "nr_threads * window * avg_blob_size". For a "normal" repo, that's
    only a few megabytes. But the peak will depend on the large blobs,
    so it could have some outsize cases. I don't know if it's worth
    worrying about too much for this analysis.

---
Here's the patch. It's probably asking for trouble to have this kind of
clearing interface, as a surprising number of things may hold onto
pointers to objects (see the comment below about the bitmap code).

So maybe the separate process is less insane.

diff --git a/alloc.c b/alloc.c
index 12afadfacd..50d444a3b0 100644
--- a/alloc.c
+++ b/alloc.c
@@ -30,15 +30,23 @@ struct alloc_state {
 	int count; /* total number of nodes allocated */
 	int nr;    /* number of nodes left in current allocation */
 	void *p;   /* first free node in current allocation */
+
+	/* book-keeping for clearing */
+	void *start;
+	struct alloc_state *prev;
 };
 
-static inline void *alloc_node(struct alloc_state *s, size_t node_size)
+static inline void *alloc_node(struct alloc_state **sp, size_t node_size)
 {
+	struct alloc_state *s = *sp;
 	void *ret;
 
-	if (!s->nr) {
+	if (!s || !s->nr) {
+		s = xmalloc(sizeof(*s));
 		s->nr = BLOCKING;
-		s->p = xmalloc(BLOCKING * node_size);
+		s->start = s->p = xmalloc(BLOCKING * node_size);
+		s->prev = *sp;
+		*sp = s;
 	}
 	s->nr--;
 	s->count++;
@@ -48,7 +56,7 @@ static inline void *alloc_node(struct alloc_state *s, size_t node_size)
 	return ret;
 }
 
-static struct alloc_state blob_state;
+static struct alloc_state *blob_state;
 void *alloc_blob_node(void)
 {
 	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
@@ -56,7 +64,7 @@ void *alloc_blob_node(void)
 	return b;
 }
 
-static struct alloc_state tree_state;
+static struct alloc_state *tree_state;
 void *alloc_tree_node(void)
 {
 	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
@@ -64,7 +72,7 @@ void *alloc_tree_node(void)
 	return t;
 }
 
-static struct alloc_state tag_state;
+static struct alloc_state *tag_state;
 void *alloc_tag_node(void)
 {
 	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
@@ -72,7 +80,7 @@ void *alloc_tag_node(void)
 	return t;
 }
 
-static struct alloc_state object_state;
+static struct alloc_state *object_state;
 void *alloc_object_node(void)
 {
 	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
@@ -80,7 +88,7 @@ void *alloc_object_node(void)
 	return obj;
 }
 
-static struct alloc_state commit_state;
+static struct alloc_state *commit_state;
 
 unsigned int alloc_commit_index(void)
 {
@@ -103,7 +111,7 @@ static void report(const char *name, unsigned int count, size_t size)
 }
 
 #define REPORT(name, type)	\
-    report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
+    report(#name, name##_state->count, name##_state->count * sizeof(type) >> 10)
 
 void alloc_report(void)
 {
@@ -113,3 +121,22 @@ void alloc_report(void)
 	REPORT(tag, struct tag);
 	REPORT(object, union any_object);
 }
+
+static void alloc_clear(struct alloc_state **sp)
+{
+	while (*sp) {
+		struct alloc_state *s = *sp;
+		*sp = s->prev;
+		free(s->start);
+		free(s);
+	}
+}
+
+void alloc_clear_all(void)
+{
+	alloc_clear(&blob_state);
+	alloc_clear(&tree_state);
+	alloc_clear(&commit_state);
+	alloc_clear(&tag_state);
+	alloc_clear(&object_state);
+}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4406af640f..7ba8ab07a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2959,6 +2959,13 @@ static void get_object_list(int ac, const char **av)
 				     record_recent_object, NULL);
 	}
 
+	/*
+	 * The bitmap code actually stores the commit pointers for future
+	 * reference, so we can't use this memory optimization there.
+	 */
+	if (!write_bitmap_index)
+		free_all_objects();
+
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
 	if (pack_loose_unreachable)
diff --git a/cache.h b/cache.h
index b90feb3802..605bab31de 100644
--- a/cache.h
+++ b/cache.h
@@ -1872,6 +1872,8 @@ extern void *alloc_object_node(void);
 extern void alloc_report(void);
 extern unsigned int alloc_commit_index(void);
 
+void alloc_clear_all(void);
+
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
 
diff --git a/object.c b/object.c
index 9e6f9ff20b..6530d6fbde 100644
--- a/object.c
+++ b/object.c
@@ -445,3 +445,12 @@ void clear_commit_marks_all(unsigned int flags)
 			obj->flags &= ~flags;
 	}
 }
+
+void free_all_objects(void)
+{
+	alloc_clear_all();
+	free(obj_hash);
+	obj_hash = NULL;
+	obj_hash_size = 0;
+	nr_objs = 0;
+}
diff --git a/object.h b/object.h
index 8ce294d6ec..3eb85215c2 100644
--- a/object.h
+++ b/object.h
@@ -153,4 +153,6 @@ void clear_object_flags(unsigned flags);
  */
 extern void clear_commit_marks_all(unsigned int flags);
 
+void free_all_objects(void);
+
 #endif /* OBJECT_H */
