Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5668C1F51C
	for <e@80x24.org>; Mon, 21 May 2018 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeEUUnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 16:43:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33600 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeEUUns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 16:43:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id a20-v6so7644429pfo.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0eN1qDZJhScCkBHoIEn0ClXl7ctSwkCa2R30Z2arjAQ=;
        b=ALP1zd/pPR3eePX1Z6fjlTo9IFHAEq9+cfX7DBxSWI6bkR/jrDxTIRyoKDW/SyJMPu
         qG9PqCG+wTIPOZoktcSLRCGf4m0/R6WCayLfCNLAr8CkSLkKeKSObFmxZXzEdNOuSgIk
         MHTdgKe7FFLjN/q8QzdfEfgdyGIkuD68S7VLw+ZLooCBdsaqIc+QG2sf7TpiyctToVAY
         T15no+kYWwJtZP/ID+PeLgHxhPEk8aqQbtuHNY3qRnnuffB3CitxPKyd5LblfVEZh73m
         TO3rUfln5FuCDu8ypWlauR03hWTViJZeRZ94oKxJyyA/ZT5HYI5pLWheIjuLk4q0/oBl
         i+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0eN1qDZJhScCkBHoIEn0ClXl7ctSwkCa2R30Z2arjAQ=;
        b=kOqxiLx6liJqtejmoiD05qAQHMkdPFBHr3oHbHQC3t0PilT88FQZDLjXo3SechESmG
         s+0G5e+895fOia91hCF6ER0HIoY1fPg9YgIl51hslqm8KN2ezp94V4sbfQAB2lRWby2p
         qwBbDd/ioILEwaZFeMPaB1srCTgGAX55Nuyh0/8i2dYGeKiIHBF8byOEDqqjUEExhIAB
         lEpLhJ0yi2AUOXn/HbRsnSl5ZA/Fo4XhuV80YQcouL1O5wSwwMavwnmGy5QVuV2qIy9p
         yKWYnvNAuCto9ePoopLodhhRhIkevRnP9I71oeXkGDGHihesH3fHAgiZlPzu+wVRqW38
         3q4g==
X-Gm-Message-State: ALKqPwe18ZAOYu4xOmEnCnxFZwTY30H6yFELXN4PnMEAEX3YIy8mZCcu
        8j1RjJBJ1AQMu4h6bcxkwX2v3pbEQag=
X-Google-Smtp-Source: AB8JxZpjMCFUoKRpa26tUvLNZZfuMqP86VxAXAkBBwKWlBJwKdJCY2D5DC85T8J/rymWLg15DIBRYA==
X-Received: by 2002:a62:d352:: with SMTP id q79-v6mr21735561pfg.45.1526935426955;
        Mon, 21 May 2018 13:43:46 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id d186-v6sm25393999pfa.79.2018.05.21.13.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 13:43:45 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
Date:   Mon, 21 May 2018 13:43:40 -0700
Message-Id: <20180521204340.260572-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.628.g38aae093f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was thinking about fetch negotiation in some non-ideal situations
(specifically, when the client repo contains two or more independent
branches that meet only somewhere far in the past) and thought about
skipping over intermediate commits, using exponentially larger skips as
we proceed, when generating "have" lines. This is in the hope of
reducing the bandwidth and roundtrips needed when fetching, and does not
require a modification to the server.

I'm not sure if this is the best way, however, so I'm wrapping up and
writing what I have now. I'll talk about (1) the implementation that I
have, (2) possible future work for my implementation, and (3) other,
possibly better, ways that negotiation could be improved instead.

(1) The implementation that I have

This patch contains some drop-in code that passes all existing tests,
but the new negotiation algorithm is not tested.

To mitigate the effect of skipping, I included functionality wherein
the client will retry the commits in a skip if the server ACKs the
destination of the skip, but this is currently imperfect - in
particular, the server might end the negotiation early, and the commits
retried in my current implementation are a superset due to the fact that
I didn't store the commits in the skip.

(2) Possible future work for my implementation

Since each sent commit maintains pointers to sent descendants and sent
ancestors (strictly speaking, only the "close" ones - to find all of
them, you need the transitive closure), this can be used for some sort
of error correction when, during a stateless RPC negotiation, the server
(which may be a group of eventually consistent servers behind a load
balancer) reports that it no longer has a commit that it said it had.
For example, we could in this case mark that commit as "they_have=NO"
and for all its closest ancestors, set it to "they_have=YES" unless they
in turn have a descendant with "they_have=YES" or
"they_have=HAVE_DESCENDANT".

(3) Other ways of improving negotiation

If we're prepared to commit-walk a significant part of the entire local
repo (as we are, in the situation I described in the first paragraph),
and if we have access to corresponding remote-tracking information,
one other way of improving negotiation might be to limit the "have"s we
sent to ancestors or descendants of the corresponding remote-tracking
tips.

This can be done simultaneously with the approach in this patch, but if
we were to evaluate only one first, the
ancestor-or-descendant-of-remote-tracking-tip approach might be the
better one to do first.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile           |   1 +
 fetch-negotiator.c | 309 +++++++++++++++++++++++++++++++++++++++++++++
 fetch-negotiator.h |  40 ++++++
 fetch-pack.c       | 174 ++++++-------------------
 object.h           |   1 +
 5 files changed, 392 insertions(+), 133 deletions(-)
 create mode 100644 fetch-negotiator.c
 create mode 100644 fetch-negotiator.h

diff --git a/Makefile b/Makefile
index ad880d1fc5..8bbedfa521 100644
--- a/Makefile
+++ b/Makefile
@@ -859,6 +859,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
+LIB_OBJS += fetch-negotiator.o
 LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
new file mode 100644
index 0000000000..58975e1c37
--- /dev/null
+++ b/fetch-negotiator.c
@@ -0,0 +1,309 @@
+#include "cache.h"
+#include "commit.h"
+#include "fetch-negotiator.h"
+
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
+
+/* Remember to update object flag allocation in object.h */
+/*
+ * This commit entered the "candidates" priority queue (and may still be in
+ * it).
+ */
+#define SEEN (1u << 6)
+/*
+ * This commit was returned from fetch_negotiator_next().
+ */
+#define EMITTED (1u << 7)
+
+enum they_have {
+	/*
+	 * We do not know if the server has this commit, or we know that the
+	 * server does not have this commit.
+	 */
+	NO,
+
+	/*
+	 * The server has this commit, and we do not know (or did not keep
+	 * track of) whether it has any of its descendants.
+	 */
+	YES,
+
+	/*
+	 * The server has at least one of this commit's descendants, and that
+	 * descendant is marked with YES. When resending "have" lines, we do
+	 * not need to resend this commit, because doing so is redundant.
+	 */
+	HAVE_DESCENDANT
+};
+
+struct sent_commit {
+	struct commit *commit;
+	enum they_have they_have;
+
+	/*
+	 * To obtain all sent ancestors of this commit, calculate the
+	 * transitive closure obtained by following these pointers.
+	 */
+	struct sent_commit **sent_ancestors;
+	size_t sent_ancestor_nr, sent_ancestor_alloc;
+
+	/*
+	 * To obtain all sent descendants of this commit, calculate the
+	 * transitive closure obtained by following these pointers.
+	 */
+	struct sent_commit **sent_descendants;
+	size_t sent_descendant_nr, sent_descendant_alloc;
+};
+
+struct candidate {
+	struct commit *commit;
+
+	/*
+	 * If edges_left is not 0, whenever parents of this candidate's
+	 * commit are pushed as candidates, they are pushed with one
+	 * less edges_left.
+	 *
+	 * Otherwise, this candidate's commit will be returned
+	 * by fetch_negotiator_next() when this candidate is popped from
+	 * the queue. The edges_left of the parents of this candidates'
+	 * commit are determined by total_edges (see the documentation
+	 * of total_edges below).
+	 */
+	uint32_t edges_left;
+
+	/*
+	 * If total_edges is 0, this shows that this candidate was added
+	 * during the second round where we emit (from
+	 * fetch_negotiator_next()) every commit encountered.
+	 *
+	 * If not, when edges_left is 0, total_edges is used when
+	 * pushing the parents of this candidate's commit as candidates
+	 * to determine what their edges_left and total_edges should be.
+	 */
+	uint32_t total_edges;
+
+	struct sent_commit **sent_descendants;
+	size_t sent_descendant_nr, sent_descendant_alloc;
+};
+
+static int compare_by_commit_date(const void *a_, const void *b_, void *unused)
+{
+	const struct candidate *a = a_, *b = b_;
+	return compare_commits_by_commit_date(a->commit, b->commit, NULL);
+}
+
+static struct candidate *push_candidate(struct prio_queue *candidates,
+					struct commit *commit,
+					const struct candidate *template)
+{
+	struct candidate *ca = xmemdupz(template, sizeof(*template));
+	ca->commit = commit;
+	if (ca->sent_descendants) {
+		ca->sent_descendants = xmemdupz(ca->sent_descendants,
+						ca->sent_descendant_nr *
+						sizeof(*ca->sent_descendants));
+		ca->sent_descendant_alloc = ca->sent_descendant_nr;
+	}
+	commit->object.flags |= SEEN;
+	prio_queue_put(candidates, ca);
+	return ca;
+}
+
+void fetch_negotiator_init(struct fetch_negotiator *n, struct commit **tips,
+			   int tip_nr)
+{
+	static struct candidate template = { NULL, 0, 1 };
+	int i;
+	memset(n, 0, sizeof(*n));
+	n->candidates.compare = compare_by_commit_date;
+	for (i = 0; i < tip_nr; i++) {
+		if (!(tips[i]->object.flags & SEEN))
+			push_candidate(&n->candidates, tips[i], &template);
+	}
+}
+
+static struct candidate *find_candidate(struct prio_queue *candidates,
+					const struct commit *commit)
+{
+	int i;
+	for (i = 0; i < candidates->nr; i++) {
+		struct candidate *c = candidates->array[i].data;
+		if (c->commit == commit)
+			return c;
+	}
+	return NULL;
+}
+
+static void merge_candidates(struct candidate *target,
+			     const struct candidate *other)
+{
+	int i;
+	if (target->total_edges == 0) {
+		/* do nothing */
+	} else if (other->total_edges == 0) {
+		target->edges_left = 0;
+		target->total_edges = 0;
+	} else if (target->total_edges > other->total_edges) {
+		/* do nothing */
+	} else if (target->total_edges < other->total_edges) {
+		target->edges_left = other->edges_left;
+		target->total_edges = other->total_edges;
+	} else {
+		target->edges_left = (target->edges_left > other->edges_left)
+			? target->edges_left : other->edges_left;
+	}
+
+	ALLOC_GROW(target->sent_descendants,
+		   target->sent_descendant_nr + other->sent_descendant_nr,
+		   target->sent_descendant_alloc);
+	for (i = 0; i < other->sent_descendant_nr; i++) {
+		target->sent_descendants[target->sent_descendant_nr++] =
+			other->sent_descendants[i];
+	}
+}
+
+static void free_candidate(struct candidate *ca)
+{
+	free(ca->sent_descendants);
+	free(ca);
+}
+
+static struct candidate *propagate(struct prio_queue *candidates,
+				   struct commit_list *commits,
+				   struct candidate *template, int second_round)
+{
+	struct commit_list *cl;
+	int propagated = 0;
+	int template_consumed = 0;
+
+	for (cl = commits; cl; cl = cl->next) {
+		if (cl->item->object.flags & EMITTED)
+			continue;
+		if (cl->item->object.flags & SEEN) {
+			struct candidate *existing = find_candidate(candidates,
+								    cl->item);
+			if (existing) {
+				merge_candidates(existing, template);
+				propagated = 1;
+			} else if (!second_round) {
+				continue;
+			}
+		}
+
+		if (template_consumed) {
+			push_candidate(candidates, cl->item, template);
+		} else {
+			template->commit = cl->item;
+			template->commit->object.flags |= SEEN;
+			prio_queue_put(candidates, template);
+			template_consumed = 1;
+		}
+		propagated = 1;
+	}
+
+	if (propagated && !template_consumed)
+		free_candidate(template);
+	return propagated ? NULL : template;
+}
+
+struct commit *fetch_negotiator_next(struct fetch_negotiator *n)
+{
+	struct candidate *ca;
+	struct commit *c;
+	struct sent_commit *sc;
+	while ((ca = prio_queue_get(&n->candidates))) {
+		int i;
+		int they_have_descendant = 0;
+		for (i = 0; i < ca->sent_descendant_nr; i++) {
+			if (ca->sent_descendants[i]->they_have != NO) {
+				they_have_descendant = 1;
+				break;
+			}
+		}
+		if (they_have_descendant)
+			continue;
+
+		c = ca->commit;
+		parse_commit(c);
+		if (!ca->edges_left)
+			goto emit;
+		ca->edges_left--;
+		ca = propagate(&n->candidates, c->parents, ca, 0);
+		if (ca)
+			goto emit;
+	}
+	return NULL;
+
+emit:
+	sc = xcalloc(1, sizeof(*sc));
+	sc->commit = c;
+	sc->sent_descendants = ca->sent_descendants;
+	sc->sent_descendant_nr = ca->sent_descendant_nr;
+	sc->sent_descendant_alloc = ca->sent_descendant_alloc;
+	ALLOC_GROW(n->sent_commits,
+		   n->sent_commit_nr + 1,
+		   n->sent_commit_alloc);
+	n->sent_commits[n->sent_commit_nr++] = sc;
+
+	ca->sent_descendants = xmalloc(sizeof(*ca->sent_descendants));
+	ca->sent_descendants[0] = sc;
+	ca->sent_descendant_nr = 1;
+	ca->sent_descendant_alloc = 1;
+	if (ca->total_edges) {
+		ca->total_edges = ca->total_edges * 3 / 2 + 1;
+		ca->edges_left = ca->total_edges;
+	}
+	ca = propagate(&n->candidates, c->parents, ca, 1);
+	if (ca)
+		free_candidate(ca);
+	c->object.flags |= EMITTED;
+	return c;
+}
+
+static void propagate_have_descendant(struct sent_commit *sc)
+{
+	int i;
+	if (sc->they_have == HAVE_DESCENDANT)
+		return;
+	sc->they_have = HAVE_DESCENDANT;
+	for (i = 0; i < sc->sent_ancestor_nr; i++)
+		propagate_have_descendant(sc->sent_ancestors[i]);
+}
+
+void fetch_negotiator_ack(struct fetch_negotiator *n,
+			  const struct commit *commit)
+{
+	struct sent_commit *sc = NULL;
+	int i;
+	for (i = 0; i < n->sent_commit_nr; i++) {
+		if (n->sent_commits[i]->commit == commit) {
+			sc = n->sent_commits[i];
+			break;
+		}
+	}
+	if (!sc)
+		BUG("was passed commit that wasn't sent");
+	if (sc->they_have != NO)
+		return;
+	sc->they_have = YES;
+	for (i = 0; i < sc->sent_ancestor_nr; i++)
+		propagate_have_descendant(sc->sent_ancestors[i]);
+	for (i = 0; i < sc->sent_descendant_nr; i++) {
+		struct commit_list *parents =
+			sc->sent_descendants[i]->commit->parents;
+		struct candidate *ca = xcalloc(1, sizeof(*ca));
+		ca = propagate(&n->candidates, parents, ca, 1);
+		free(ca);
+	}
+}
+
+void fetch_negotiator_for_each_acked_commit(const struct fetch_negotiator *n,
+					    void cb(struct commit *, void *),
+					    void *data)
+{
+	int i;
+	for (i = 0; i < n->sent_commit_nr; i++) {
+		if (n->sent_commits[i]->they_have == YES)
+			cb(n->sent_commits[i]->commit, data);
+	}
+}
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
new file mode 100644
index 0000000000..c51d52a0d2
--- /dev/null
+++ b/fetch-negotiator.h
@@ -0,0 +1,40 @@
+#ifndef FETCH_NEGOTIATOR_H
+#define FETCH_NEGOTIATOR_H
+
+#include "prio-queue.h"
+
+struct sent_commit;
+
+struct fetch_negotiator {
+	struct sent_commit **sent_commits;
+	size_t sent_commit_nr, sent_commit_alloc;
+	struct prio_queue candidates;
+};
+
+void fetch_negotiator_init(struct fetch_negotiator *n, struct commit **tips,
+			   int tip_nr);
+
+struct commit *fetch_negotiator_next(struct fetch_negotiator *n);
+
+/*
+ * Indicate that the server has this commit. The commits passed to this function
+ * should be in order of their return from fetch_negotiator_next().
+ *
+ * Invocations of this function on the same commit after the first time have no
+ * effect.
+ */
+void fetch_negotiator_ack(struct fetch_negotiator *n,
+			  const struct commit *commit);
+
+/*
+ * Iterate through the commits invoked with fetch_negotiator_ack. The negotiator
+ * makes an effort to remove redundant commits from the list.
+ *
+ * This is useful for stateless connections, in which information about what the
+ * client knows needs to be replayed in every request.
+ */
+void fetch_negotiator_for_each_acked_commit(const struct fetch_negotiator *n,
+					    void cb(struct commit *, void *),
+					    void *data);
+
+#endif /* FETCH_NEGOTIATOR_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index f93723fec4..b8ddd9176b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,6 +19,7 @@
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "fetch-negotiator.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -50,14 +51,16 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband;
+static int multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
 #define ALLOW_REACHABLE_SHA1	02
 static unsigned int allow_unadvertised_object_request;
 
+static struct commit **tips;
+static size_t tip_nr, tip_alloc;
+
 __attribute__((format (printf, 2, 3)))
 static inline void print_verbose(const struct fetch_pack_args *args,
 				 const char *fmt, ...)
@@ -108,27 +111,14 @@ static void for_each_cached_alternate(void (*cb)(struct object *))
 		cb(cache.items[i]);
 }
 
-static void rev_list_push(struct commit *commit, int mark)
-{
-	if (!(commit->object.flags & mark)) {
-		commit->object.flags |= mark;
-
-		if (parse_commit(commit))
-			return;
-
-		prio_queue_put(&rev_list, commit);
-
-		if (!(commit->object.flags & COMMON))
-			non_common_revs++;
-	}
-}
-
 static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
 	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
-	if (o && o->type == OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
+	if (o && o->type == OBJ_COMMIT) {
+		ALLOC_GROW(tips, tip_nr + 1, tip_alloc);
+		tips[tip_nr++] = (struct commit *) o;
+	}
 
 	return 0;
 }
@@ -150,86 +140,6 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-/*
-   This function marks a rev and its ancestors as common.
-   In some cases, it is desirable to mark only the ancestors (for example
-   when only the server does not yet know that they are common).
-*/
-
-static void mark_common(struct commit *commit,
-		int ancestors_only, int dont_parse)
-{
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
-		struct object *o = (struct object *)commit;
-
-		if (!ancestors_only)
-			o->flags |= COMMON;
-
-		if (!(o->flags & SEEN))
-			rev_list_push(commit, SEEN);
-		else {
-			struct commit_list *parents;
-
-			if (!ancestors_only && !(o->flags & POPPED))
-				non_common_revs--;
-			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
-					return;
-
-			for (parents = commit->parents;
-					parents;
-					parents = parents->next)
-				mark_common(parents->item, 0, dont_parse);
-		}
-	}
-}
-
-/*
-  Get the next rev to send, ignoring the common.
-*/
-
-static const struct object_id *get_rev(void)
-{
-	struct commit *commit = NULL;
-
-	while (commit == NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
-
-		if (rev_list.nr == 0 || non_common_revs == 0)
-			return NULL;
-
-		commit = prio_queue_get(&rev_list);
-		parse_commit(commit);
-		parents = commit->parents;
-
-		commit->object.flags |= POPPED;
-		if (!(commit->object.flags & COMMON))
-			non_common_revs--;
-
-		if (commit->object.flags & COMMON) {
-			/* do not send "have", and ignore ancestors */
-			commit = NULL;
-			mark = COMMON | SEEN;
-		} else if (commit->object.flags & COMMON_REF)
-			/* send "have", and ignore ancestors */
-			mark = COMMON | SEEN;
-		else
-			/* send "have", also for its ancestors */
-			mark = SEEN;
-
-		while (parents) {
-			if (!(parents->item->object.flags & SEEN))
-				rev_list_push(parents->item, mark);
-			if (mark & COMMON)
-				mark_common(parents->item, 1, 0);
-			parents = parents->next;
-		}
-	}
-
-	return &commit->object.oid;
-}
-
 enum ack_type {
 	NAK = 0,
 	ACK,
@@ -321,6 +231,11 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
+static void write_have(struct commit *commit, void *req_buf)
+{
+	packet_buf_write(req_buf, "have %s\n", oid_to_hex(&commit->object.oid));
+}
+
 static int find_common(struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
@@ -333,6 +248,8 @@ static int find_common(struct fetch_pack_args *args,
 	int got_ready = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
+	struct fetch_negotiator negotiator;
+	struct commit *cmt;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
@@ -459,13 +376,19 @@ static int find_common(struct fetch_pack_args *args,
 	retval = -1;
 	if (args->no_dependents)
 		goto done;
-	while ((oid = get_rev())) {
+	fetch_negotiator_init(&negotiator, tips, tip_nr);
+	while ((cmt = fetch_negotiator_next(&negotiator))) {
+		oid = &cmt->object.oid;
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
 		if (flush_at <= ++count) {
 			int ack;
 
+			if (args->stateless_rpc) {
+				/* replay because it's stateless */
+				fetch_negotiator_for_each_acked_commit(&negotiator, write_have, &req_buf);
+			}
 			packet_buf_flush(&req_buf);
 			send_request(args, fd[1], &req_buf);
 			strbuf_setlen(&req_buf, state_len);
@@ -501,13 +424,6 @@ static int find_common(struct fetch_pack_args *args,
 					if (args->stateless_rpc
 					 && ack == ACK_common
 					 && !(commit->object.flags & COMMON)) {
-						/* We need to replay the have for this object
-						 * on the next RPC request so the peer knows
-						 * it is in common with us.
-						 */
-						const char *hex = oid_to_hex(result_oid);
-						packet_buf_write(&req_buf, "have %s\n", hex);
-						state_len = req_buf.len;
 						/*
 						 * Reset in_vain because an ack
 						 * for this commit has not been
@@ -517,11 +433,10 @@ static int find_common(struct fetch_pack_args *args,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(commit, 0, 1);
+					fetch_negotiator_ack(&negotiator, commit);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready) {
-						clear_prio_queue(&rev_list);
 						got_ready = 1;
 					}
 					break;
@@ -805,9 +720,9 @@ static int everything_local(struct fetch_pack_args *args,
 				continue;
 
 			if (!(o->flags & SEEN)) {
-				rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+				//rev_list_push((struct commit *)o, COMMON_REF | SEEN);
 
-				mark_common((struct commit *)o, 1, 1);
+				//mark_common((struct commit *)o, 1, 1);
 			}
 		}
 	}
@@ -1127,24 +1042,14 @@ static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 	}
 }
 
-static void add_common(struct strbuf *req_buf, struct oidset *common)
-{
-	struct oidset_iter iter;
-	const struct object_id *oid;
-	oidset_iter_init(common, &iter);
-
-	while ((oid = oidset_iter_next(&iter))) {
-		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
-	}
-}
-
-static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
+static int add_haves(struct fetch_negotiator *negotiator, struct strbuf *req_buf, int *haves_to_send, int *in_vain)
 {
 	int ret = 0;
 	int haves_added = 0;
-	const struct object_id *oid;
+	struct commit *cmt;
 
-	while ((oid = get_rev())) {
+	while ((cmt = fetch_negotiator_next(negotiator))) {
+		const struct object_id *oid = &cmt->object.oid;
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1163,7 +1068,7 @@ static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
 	return ret;
 }
 
-static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out, const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
 {
@@ -1195,10 +1100,10 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 	add_wants(wants, &req_buf);
 
 	/* Add all of the common commits we've found in previous rounds */
-	add_common(&req_buf, common);
+	fetch_negotiator_for_each_acked_commit(negotiator, write_have, &req_buf);
 
 	/* Add initial haves */
-	ret = add_haves(&req_buf, haves_to_send, in_vain);
+	ret = add_haves(negotiator, &req_buf, haves_to_send, in_vain);
 
 	/* Send request */
 	packet_buf_flush(&req_buf);
@@ -1234,7 +1139,7 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct packet_reader *reader, struct oidset *common)
+static int process_acks(struct fetch_negotiator *negotiator, struct packet_reader *reader, struct oidset *common)
 {
 	/* received */
 	int received_ready = 0;
@@ -1253,13 +1158,13 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(commit, 0, 1);
+				fetch_negotiator_ack(negotiator, commit);
 			}
 			continue;
 		}
 
 		if (!strcmp(reader->line, "ready")) {
-			clear_prio_queue(&rev_list);
+			//clear_prio_queue(&rev_list);
 			received_ready = 1;
 			continue;
 		}
@@ -1332,8 +1237,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
+	struct fetch_negotiator negotiator;
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
+	fetch_negotiator_init(&negotiator, tips, tip_nr);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
@@ -1361,7 +1269,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_SEND_REQUEST;
 			break;
 		case FETCH_SEND_REQUEST:
-			if (send_fetch_request(fd[1], args, ref, &common,
+			if (send_fetch_request(&negotiator, fd[1], args, ref, &common,
 					       &haves_to_send, &in_vain))
 				state = FETCH_GET_PACK;
 			else
@@ -1369,7 +1277,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&reader, &common)) {
+			switch (process_acks(&negotiator, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
diff --git a/object.h b/object.h
index b8e70e5519..342e9a3568 100644
--- a/object.h
+++ b/object.h
@@ -30,6 +30,7 @@ struct object_array {
  * object flag allocation:
  * revision.h:               0---------10                                26
  * fetch-pack.c:             0----5
+ * fetch-negotiator.c:             67
  * walker.c:                 0-2
  * upload-pack.c:                4       11----------------19
  * builtin/blame.c:                        12-13
-- 
2.17.0.628.g38aae093f

