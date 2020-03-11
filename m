Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 473C27D918
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgCKQHd (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:07:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729921AbgCKQHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:07:33 -0400
Received: (qmail 1957 invoked by uid 109); 11 Mar 2020 16:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 16:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20034 invoked by uid 111); 11 Mar 2020 16:16:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 12:16:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 12:07:32 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-slab: clarify slabname##_peek()'s return value
Message-ID: <20200311160732.GA26869@coredump.intra.peff.net>
References: <20200310153049.3482-1-szeder.dev@gmail.com>
 <20200310175446.GB549010@coredump.intra.peff.net>
 <20200310180748.GC549010@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310180748.GC549010@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/20200311160732.GA26869@coredump.intra.peff.net/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Tue, Mar 10, 2020 at 02:07:49PM -0400, Jeff King wrote:

> I was a little curious how it would look. Code-wise it's not too bad,
> but if anybody ever wrote to the dummy entry, that would cause confusing
> bugs. Possibly peek() could return a pointer-to-const.

I was also curious about this, but it gets ugly really quickly. So I
think this is a dead end, but read on if you're interested.

The first issue is that implicit const conversions are tricky around
pointers-to-pointers. So the actual commit-slab change ends up with
this:

diff --git a/commit-slab-decl.h b/commit-slab-decl.h
index 4b951e7b2f..2f67b08aa6 100644
--- a/commit-slab-decl.h
+++ b/commit-slab-decl.h
@@ -35,7 +35,7 @@ void init_ ##slabname(struct slabname *s);				\
 void clear_ ##slabname(struct slabname *s);				\
 elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
 elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
-elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
+const elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
 
 #define define_shared_commit_slab(slabname, elemtype) \
 	declare_commit_slab(slabname, elemtype); \
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 505c21599a..f2d6ef97a2 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -72,10 +72,14 @@ scope elemtype *slabname## _at(struct slabname *s,			\
 	return slabname##_at_peek(s, c, 1);				\
 }									\
 									\
-scope elemtype *slabname## _peek(struct slabname *s,			\
+scope const elemtype *slabname## _peek(struct slabname *s,		\
 					     const struct commit *c)	\
 {									\
-	return slabname##_at_peek(s, c, 0);				\
+	/*								\
+	 * The cast is necessary here to handle pointer elemtypes.	\
+	 * E.g., (int **) cannot implicitly become (const int **).	\
+	 */								\
+	return (const elemtype *)slabname##_at_peek(s, c, 0);		\
 }									\
 									\
 struct slabname

Gross, but at least it's contained. The bigger problem, though, is that
many of the callers _do_ want to peek and then modify the result if it
exists and isn't set to zero. So in blame, for example, we might try to
do:

diff --git a/blame.c b/blame.c
index 3ae42a1edd..ef0526c100 100644
--- a/blame.c
+++ b/blame.c
@@ -13,7 +13,7 @@
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
 
-struct blame_origin *get_blame_suspects(struct commit *commit)
+const struct blame_origin *get_blame_suspects(struct commit *commit)
 {
 	return *blame_suspects_peek(&blame_suspects, commit);
 }
@@ -24,11 +24,12 @@ static void set_blame_suspects(struct commit *commit, struct blame_origin *origi
 }
 
 void blame_origin_decref(struct blame_origin *o)
 {
 	if (o && --o->refcnt <= 0) {
-		struct blame_origin *p, *l = NULL;
+		const struct blame_origin *p;
+		struct blame_origin *l = NULL;
 		if (o->previous)
 			blame_origin_decref(o->previous);
 		free(o->file.ptr);
 		/* Should be present exactly once in commit chain */
 		for (p = get_blame_suspects(o->commit); p; l = p, p = p->next) {

But that loop at the end of the context won't work, because we're using
a non-const pointer "l" to iterate. And that "l" has to be non-const,
because we actually modify its next pointer.

And here's an even more straightforward example, with an actual solution
to make it compile:

diff --git a/commit.c b/commit.c
index 49d86435a5..ee36a47db2 100644
--- a/commit.c
+++ b/commit.c
@@ -319,17 +319,19 @@ void repo_unuse_commit_buffer(struct repository *r,
 			      const struct commit *commit,
 			      const void *buffer)
 {
-	struct commit_buffer *v = buffer_slab_peek(
+	const struct commit_buffer *v = buffer_slab_peek(
 		r->parsed_objects->buffer_slab, commit);
 	if (!(v && v->buffer == buffer))
 		free((void *)buffer);
 }
 
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 {
-	struct commit_buffer *v = buffer_slab_peek(
+	const struct commit_buffer *cv = buffer_slab_peek(
 		pool->buffer_slab, commit);
-	if (v) {
+	if (cv->buffer) {
+		/* we know this isn't a dummy because it has a real buffer */
+		struct commit_buffer *v = (struct commit_buffer *)cv;
 		FREE_AND_NULL(v->buffer);
 		v->size = 0;
 	}

The first hunk is straight-forward, because we really are treating the
slab value as read-only. But in the second we're trying to free the
value it points to.  Using peek there makes sense, since we wouldn't
want to allocate a slab entry just to see that it points to no buffer at
all. And the code is correct even without const, because the writing we
do is a noop in the case that the buffer struct was already empty. But
C's type system doesn't know that, of course.

So the workarounds we have to do here and elsewhere are much worse than
the few lines of "if (v)" that we got rid of by simplifying peek().

-Peff
