Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9610420802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdFVUVs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:21:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:49286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751202AbdFVUVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:21:48 -0400
Received: (qmail 20384 invoked by uid 109); 22 Jun 2017 20:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 20:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5368 invoked by uid 111); 22 Jun 2017 20:21:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 16:21:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 16:21:46 -0400
Date:   Thu, 22 Jun 2017 16:21:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
 <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 12:03:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think this is quite right, though. We've decremented "recno"
> > after assigning the old pointer to "reflog". So in the existing code,
> > "reflog" in that second conditional pointing to the _next_ entry (or
> > previous, really, since we are going in reverse order).
> >
> > So I think you'd need to look at commit->reflog again (after checking
> > that we didn't go past the start of the array).
> 
> Perhaps.  I did the illustration that way simply because I was not
> sure if the current "the entry was NULL from something new, so skip
> and look at the previous entry's new" was correct to begin with.

I'm not sure it makes sense for an entry to have its "after" state as
its own parent. On the other hand, I'm not sure it makes sense to
consider this fake parentage in the first place.

I think in the old days we used truly rewrite the parents, and traversal
like "git log -g -p" would show the diff between reflog entries. But
that changed in 838f9a156 (log: use true parents for diff when walking
reflogs, 2013-08-03). Given that we disable reflog-walking with things
like "--graph" that show the relationship, are the fake parents actually
accomplishing anything anymore? The parents we show via "log -g
--parents" seem like nonsense, and I'm not sure how we would do any
history simplification based no the munged values.

So I'd be tempted to just ditch the whole thing and teach
get_revision_1() to just walk through the list of logs, rather than this
weird "add a pending commit and then try to figure out which reflog it
referred to". For instance, right now:

  git log -g HEAD $(git symbolic-ref HEAD)

only shows _one_ reflog. The patch below is the direction I'm thinking.
It fails two tests, but haven't dug yet.

---
 reflog-walk.c | 112 +++++++++--------------------------
 reflog-walk.h |   4 +-
 revision.c    |  24 ++++----
 3 files changed, 43 insertions(+), 97 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index ed99437ad..77170a3cb 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -78,45 +78,6 @@ static int get_reflog_recno_by_time(struct complete_reflogs *array,
 	return -1;
 }
 
-struct commit_info_lifo {
-	struct commit_info {
-		struct commit *commit;
-		void *util;
-	} *items;
-	int nr, alloc;
-};
-
-static struct commit_info *get_commit_info(struct commit *commit,
-		struct commit_info_lifo *lifo, int pop)
-{
-	int i;
-	for (i = 0; i < lifo->nr; i++)
-		if (lifo->items[i].commit == commit) {
-			struct commit_info *result = &lifo->items[i];
-			if (pop) {
-				if (i + 1 < lifo->nr)
-					memmove(lifo->items + i,
-						lifo->items + i + 1,
-						(lifo->nr - i) *
-						sizeof(struct commit_info));
-				lifo->nr--;
-			}
-			return result;
-		}
-	return NULL;
-}
-
-static void add_commit_info(struct commit *commit, void *util,
-		struct commit_info_lifo *lifo)
-{
-	struct commit_info *info;
-	ALLOC_GROW(lifo->items, lifo->nr + 1, lifo->alloc);
-	info = lifo->items + lifo->nr;
-	info->commit = commit;
-	info->util = util;
-	lifo->nr++;
-}
-
 struct commit_reflog {
 	int recno;
 	enum selector_type {
@@ -128,7 +89,8 @@ struct commit_reflog {
 };
 
 struct reflog_walk_info {
-	struct commit_info_lifo reflogs;
+	struct commit_reflog **logs;
+	size_t nr, alloc, cur;
 	struct string_list complete_reflogs;
 	struct commit_reflog *last_commit_reflog;
 };
@@ -226,50 +188,10 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	commit_reflog->selector = selector;
 	commit_reflog->reflogs = reflogs;
 
-	add_commit_info(commit, commit_reflog, &info->reflogs);
-	return 0;
-}
-
-void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
-{
-	struct commit_info *commit_info =
-		get_commit_info(commit, &info->reflogs, 0);
-	struct commit_reflog *commit_reflog;
-	struct object *logobj;
-	struct reflog_info *reflog;
-
-	info->last_commit_reflog = NULL;
-	if (!commit_info)
-		return;
+	ALLOC_GROW(info->logs, info->nr + 1, info->alloc);
+	info->logs[info->nr++] = commit_reflog;
 
-	commit_reflog = commit_info->util;
-	if (commit_reflog->recno < 0) {
-		commit->parents = NULL;
-		return;
-	}
-	info->last_commit_reflog = commit_reflog;
-
-	do {
-		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
-		commit_reflog->recno--;
-		logobj = parse_object(&reflog->ooid);
-	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
-
-	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {
-		/* a root commit, but there are still more entries to show */
-		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
-		logobj = parse_object(&reflog->noid);
-	}
-
-	if (!logobj || logobj->type != OBJ_COMMIT) {
-		commit_info->commit = NULL;
-		commit->parents = NULL;
-		return;
-	}
-	commit_info->commit = (struct commit *)logobj;
-
-	commit->parents = xcalloc(1, sizeof(struct commit_list));
-	commit->parents->item = commit_info->commit;
+	return 0;
 }
 
 void get_reflog_selector(struct strbuf *sb,
@@ -356,3 +278,27 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		strbuf_release(&selector);
 	}
 }
+
+struct commit *next_entry_in_log(struct commit_reflog *log)
+{
+	while (log->recno >= 0) {
+		struct reflog_info *entry = &log->reflogs->items[log->recno--];
+		struct object *obj = parse_object(&entry->noid);
+
+		if (obj && obj->type == OBJ_COMMIT)
+			return (struct commit *)obj;
+	}
+	return NULL;
+}
+
+struct commit *next_reflog_entry(struct reflog_walk_info *walk)
+{
+	for (; walk->cur < walk->nr; walk->cur++) {
+		struct commit *ret = next_entry_in_log(walk->logs[walk->cur]);
+		if (ret) {
+			walk->last_commit_reflog = walk->logs[walk->cur];
+			return ret;
+		}
+	}
+	return NULL;
+}
diff --git a/reflog-walk.h b/reflog-walk.h
index 27886f793..5cc6b7bd4 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -8,8 +8,6 @@ struct reflog_walk_info;
 extern void init_reflog_walk(struct reflog_walk_info **info);
 extern int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
-extern void fake_reflog_parent(struct reflog_walk_info *info,
-		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
 				const struct date_mode *, int force_date);
 extern void get_reflog_message(struct strbuf *sb,
@@ -20,4 +18,6 @@ extern void get_reflog_selector(struct strbuf *sb,
 		const struct date_mode *dmode, int force_date,
 		int shorten);
 
+struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
+
 #endif
diff --git a/revision.c b/revision.c
index 12eb33235..675247cd9 100644
--- a/revision.c
+++ b/revision.c
@@ -148,16 +148,14 @@ static void add_pending_object_with_path(struct rev_info *revs,
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
 		int len = interpret_branch_name(name, 0, &buf, 0);
-		int st;
 
 		if (0 < len && name[len] && buf.len)
 			strbuf_addstr(&buf, name + len);
-		st = add_reflog_for_walk(revs->reflog_info,
-					 (struct commit *)obj,
-					 buf.buf[0] ? buf.buf: name);
+		add_reflog_for_walk(revs->reflog_info,
+				    (struct commit *)obj,
+				    buf.buf[0] ? buf.buf: name);
 		strbuf_release(&buf);
-		if (st)
-			return;
+		return; /* do not add the commit itself */
 	}
 	add_object_array_with_path(obj, name, &revs->pending, mode, path);
 }
@@ -3114,18 +3112,20 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 
 static struct commit *get_revision_1(struct rev_info *revs)
 {
+	if (revs->reflog_info) {
+		struct commit *commit = next_reflog_entry(revs->reflog_info);
+		if (commit) {
+			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
+			return commit;
+		}
+	}
+
 	if (!revs->commits)
 		return NULL;
 
 	do {
 		struct commit *commit = pop_commit(&revs->commits);
 
-		if (revs->reflog_info) {
-			save_parents(revs, commit);
-			fake_reflog_parent(revs->reflog_info, commit);
-			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
-		}
-
 		/*
 		 * If we haven't done the list limiting, we need to look at
 		 * the parents here. We also need to do the date-based limiting
