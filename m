Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE721F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfIZSGG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:06:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:32976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727934AbfIZSGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:06:05 -0400
Received: (qmail 17808 invoked by uid 109); 26 Sep 2019 18:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 18:06:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2316 invoked by uid 111); 26 Sep 2019 18:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 14:08:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 14:06:04 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] promisor-remote: skip move_to_tail when n=1
Message-ID: <20190926180604.GA5162@sigill.intra.peff.net>
References: <20190925213718.231231-1-emilyshaffer@google.com>
 <20190926075535.GC20653@sigill.intra.peff.net>
 <20190926175308.GA223193@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926175308.GA223193@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 10:53:08AM -0700, Emily Shaffer wrote:

> > should probably just see if we're already at the end, which also covers
> > the single-element case. Like:
> > 
> >   if (!r->next)
> > 	return; /* we're already at the end */
> 
> Hmm, I guess I wasn't familiar enough on the lifetime of a
> promisor_remote - I suppose I was expecting
> promisor_remote_move_to_tail() could be used for a first-time insert,
> too, although it looks like promisor_remote_new() actually does the
> insert for us every time.

Right, having to call move_to_tail at all is itself a special case, for
when partialclone points to a remote which doesn't have its
"remote.*.promisor" config set. I haven't followed the details of this
promisor stuff enough to know what it means, but presumably that's what
the non-multi-promisor case looks like.

> > or possibly:
> > 
> >   if (promisors_tail == &r->next)
> > 	return; /* we're already at the end */
> 
> With the above concern I initially feel a little more comfortable with
> this, although now that I'm thinking through the case when 'r' isn't
> already in the list, I think it would replace the entire list by taking
> the 'else' branch, having a nulled r->next, and therefore replacing the
> head pointer 'promisors' with itself.

Yeah, I agree things get weird there.

> > I also can't help but think this would all be a lot simpler using the
> > implementation in list.h. Then we don't have to pass this weird
> > "previous" pointer around (because it's a doubly-linked list). And
> > functions like this one could go away in favor of list_move(). But
> > that's obviously a bigger change.
> 
> Agreed. I joked to my team that this was the first time I've needed to
> understand linked list manipulation outside of an interview setting,
> ever ;)

I was curious how this would look, so I sketched it out. One of the
annoying things about list.h is that there's a little extra boilerplate
when iterating, since you have to cast back to the original type with
list_entry() (in the kernel they use typeof() to avoid this, but it's
not portable enough for us).

The result _is_ shorter by lines. I don't know if it's worth the churn.

---
 promisor-remote.c | 75 ++++++++++++++++++++++++-------------------------------
 promisor-remote.h |  4 ++-
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 9bc296cdde..a158ac44e0 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -50,8 +50,7 @@ static int fetch_objects(const char *remote_name,
 	return fetch_refs(remote_name, ref);
 }
 
-static struct promisor_remote *promisors;
-static struct promisor_remote **promisors_tail = &promisors;
+static LIST_HEAD(promisors);
 
 static struct promisor_remote *promisor_remote_new(const char *remote_name)
 {
@@ -64,40 +63,24 @@ static struct promisor_remote *promisor_remote_new(const char *remote_name)
 	}
 
 	FLEX_ALLOC_STR(r, name, remote_name);
-
-	*promisors_tail = r;
-	promisors_tail = &r->next;
-
+	list_add_tail(&r->list, &promisors);
 	return r;
 }
 
-static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
-						      struct promisor_remote **previous)
+static struct promisor_remote *promisor_remote_lookup(const char *remote_name)
 {
-	struct promisor_remote *r, *p;
+	struct list_head *pos;
 
-	for (p = NULL, r = promisors; r; p = r, r = r->next)
-		if (!strcmp(r->name, remote_name)) {
-			if (previous)
-				*previous = p;
+	list_for_each(pos, &promisors) {
+		struct promisor_remote *r =
+			list_entry(pos, struct promisor_remote, list);
+		if (!strcmp(r->name, remote_name))
 			return r;
-		}
+	}
 
 	return NULL;
 }
 
-static void promisor_remote_move_to_tail(struct promisor_remote *r,
-					 struct promisor_remote *previous)
-{
-	if (previous)
-		previous->next = r->next;
-	else
-		promisors = r->next ? r->next : r;
-	r->next = NULL;
-	*promisors_tail = r;
-	promisors_tail = &r->next;
-}
-
 static int promisor_remote_config(const char *var, const char *value, void *data)
 {
 	const char *name;
@@ -119,7 +102,7 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 
 		remote_name = xmemdupz(name, namelen);
 
-		if (!promisor_remote_lookup(remote_name, NULL))
+		if (!promisor_remote_lookup(remote_name))
 			promisor_remote_new(remote_name);
 
 		free(remote_name);
@@ -129,7 +112,7 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 		struct promisor_remote *r;
 		char *remote_name = xmemdupz(name, namelen);
 
-		r = promisor_remote_lookup(remote_name, NULL);
+		r = promisor_remote_lookup(remote_name);
 		if (!r)
 			r = promisor_remote_new(remote_name);
 
@@ -155,26 +138,27 @@ static void promisor_remote_init(void)
 	git_config(promisor_remote_config, NULL);
 
 	if (repository_format_partial_clone) {
-		struct promisor_remote *o, *previous;
+		struct promisor_remote *o;
 
-		o = promisor_remote_lookup(repository_format_partial_clone,
-					   &previous);
-		if (o)
-			promisor_remote_move_to_tail(o, previous);
-		else
+		o = promisor_remote_lookup(repository_format_partial_clone);
+		if (o) {
+			list_del(&o->list);
+			list_add_tail(&o->list, &promisors);
+		} else
 			promisor_remote_new(repository_format_partial_clone);
 	}
 }
 
 static void promisor_remote_clear(void)
 {
-	while (promisors) {
-		struct promisor_remote *r = promisors;
-		promisors = promisors->next;
+	struct list_head *pos, *tmp;
+
+	list_for_each_safe(pos, tmp, &promisors) {
+		struct promisor_remote *r =
+			list_entry(pos, struct promisor_remote, list);
+		list_del(pos);
 		free(r);
 	}
-
-	promisors_tail = &promisors;
 }
 
 void promisor_remote_reinit(void)
@@ -189,9 +173,11 @@ struct promisor_remote *promisor_remote_find(const char *remote_name)
 	promisor_remote_init();
 
 	if (!remote_name)
-		return promisors;
+		return list_empty(&promisors) ?
+		       NULL :
+		       list_first_entry(&promisors, struct promisor_remote, list);
 
-	return promisor_remote_lookup(remote_name, NULL);
+	return promisor_remote_lookup(remote_name);
 }
 
 int has_promisor_remote(void)
@@ -235,15 +221,18 @@ int promisor_remote_get_direct(struct repository *repo,
 			       const struct object_id *oids,
 			       int oid_nr)
 {
-	struct promisor_remote *r;
+	struct list_head *pos;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
 	int res = -1;
 
 	promisor_remote_init();
 
-	for (r = promisors; r; r = r->next) {
+	list_for_each(pos, &promisors) {
+		struct promisor_remote *r =
+			list_entry(pos, struct promisor_remote, list);
+
 		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
 			if (remaining_nr == 1)
 				continue;
diff --git a/promisor-remote.h b/promisor-remote.h
index 8200dfc940..e3ddc329ba 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+#include "list.h"
+
 struct object_id;
 
 /*
@@ -10,7 +12,7 @@ struct object_id;
  * from extensions.partialclone or core.partialclonefilter.
  */
 struct promisor_remote {
-	struct promisor_remote *next;
+	struct list_head list;
 	const char *partial_clone_filter;
 	const char name[FLEX_ARRAY];
 };
