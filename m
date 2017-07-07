Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D935202B1
	for <e@80x24.org>; Fri,  7 Jul 2017 09:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdGGJOL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:14:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:33534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbdGGJOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:14:09 -0400
Received: (qmail 8729 invoked by uid 109); 7 Jul 2017 09:14:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:14:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20822 invoked by uid 111); 7 Jul 2017 09:14:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:14:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:14:07 -0400
Date:   Fri, 7 Jul 2017 05:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 6/7] reflog-walk: stop using fake parents
Message-ID: <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reflog-walk system works by putting a ref's tip into the
pending queue, and then "traversing" the reflog by
pretending that the parent of each commit is the previous
reflog entry.

This causes a number of user-visible oddities, as documented
in t1414 (and the commit message which introduced it). We
can fix all of them in one go by replacing the fake-reflog
system with a much simpler one: just keeping a list of
reflogs to show, and walking through them entry by entry.

The implementation is fairly straight-forward, but there are
a few items to note:

  1. We obviously must skip calling add_parents_to_list()
     when we are traversing reflogs, since we do not want to
     walk the original parents at all.  As a result, we must call
     try_to_simplify_commit() ourselves.

     There are other parts of add_parents_to_list() we skip,
     as well, but none of them should matter for a reflog
     traversal:

       -  We do not allow UNINTERESTING commits, nor
          symmetric ranges (and we bail when these are used
          with "-g").

       - Using --source makes no sense, since we aren't
         traversing. The reflog selector shows the same
         information with more detail.

       - Using --first-parent is still sensible, since you
         may want to see the first-parent diff for each
         entry. But since we're not traversing, we don't
         need to cull the parent list here.

  2. Since we now just walk the reflog entries themselves,
     rather than starting with the ref tip, we now look at
     the "new" field of each entry rather than the "old"
     (i.e., we are showing entries, not faking parents).
     This removes all of the tricky logic around skipping
     past root commits.

     But note that we have no way to show an entry with the
     null sha1 in its "new" field (because such a commit
     obviously does not exist). Normally this would not
     happen, since we delete reflogs along with refs, but
     there is one special case. When we rename the currently
     checked out branch, we write two reflog entries into
     the HEAD log: one where the commit goes away, and
     another where it comes back.

     Prior to this commit, we show both entries with
     identical reflog messages. After this commit, we show
     only the "comes back" entry. See the update in t3200
     which demonstrates this.

     Arguably either is fine, as the whole double-entry
     thing is a bit hacky in the first place. And until a
     recent fix, we truncated the traversal in such a case
     anyway, which was _definitely_ wrong.

  3. We show individual reflogs in order, but choose which
     reflog to show at each stage based on which has the
     most recent timestamp.  This interleaves the output
     from multiple reflogs based on date order, which is
     probably what you'd want with limiting like "-n 30".

     Note that the implementation aims for simplicity. It
     does a linear walk over the reflog queue for each
     commit it pulls, which may perform badly if you
     interleave an enormous number of reflogs. That seems
     like an unlikely use case; if we did want to handle it,
     we could probably keep a priority queue of reflogs,
     ordered by the timestamp of their current tip entry.

Signed-off-by: Jeff King <peff@peff.net>
---
 reflog-walk.c          | 137 ++++++++++++++++++-------------------------------
 reflog-walk.h          |   4 +-
 revision.c             |  27 +++++-----
 t/t1414-reflog-walk.sh |  12 ++---
 t/t3200-branch.sh      |   3 +-
 5 files changed, 75 insertions(+), 108 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 98c2f42de9..fbee9e0126 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -94,45 +94,6 @@ static int get_reflog_recno_by_time(struct complete_reflogs *array,
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
@@ -144,7 +105,8 @@ struct commit_reflog {
 };
 
 struct reflog_walk_info {
-	struct commit_info_lifo reflogs;
+	struct commit_reflog **logs;
+	size_t nr, alloc;
 	struct string_list complete_reflogs;
 	struct commit_reflog *last_commit_reflog;
 };
@@ -233,52 +195,10 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
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
-
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
-		if (!logobj)
-			logobj = parse_object(&reflog->ooid);
-	}
-
-	if (!logobj || logobj->type != OBJ_COMMIT) {
-		commit_info->commit = NULL;
-		commit->parents = NULL;
-		return;
-	}
-	commit_info->commit = (struct commit *)logobj;
+	ALLOC_GROW(info->logs, info->nr + 1, info->alloc);
+	info->logs[info->nr++] = commit_reflog;
 
-	commit->parents = xcalloc(1, sizeof(struct commit_list));
-	commit->parents->item = commit_info->commit;
+	return 0;
 }
 
 void get_reflog_selector(struct strbuf *sb,
@@ -368,5 +288,50 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 
 int reflog_walk_empty(struct reflog_walk_info *info)
 {
-	return !info || !info->reflogs.nr;
+	return !info || !info->nr;
+}
+
+static struct commit *next_reflog_commit(struct commit_reflog *log)
+{
+	for (; log->recno >= 0; log->recno--) {
+		struct reflog_info *entry = &log->reflogs->items[log->recno];
+		struct object *obj = parse_object(&entry->noid);
+
+		if (obj && obj->type == OBJ_COMMIT)
+			return (struct commit *)obj;
+	}
+	return NULL;
+}
+
+static timestamp_t log_timestamp(struct commit_reflog *log)
+{
+	return log->reflogs->items[log->recno].timestamp;
+}
+
+struct commit *next_reflog_entry(struct reflog_walk_info *walk)
+{
+	struct commit_reflog *best = NULL;
+	struct commit *best_commit = NULL;
+	size_t i;
+
+	for (i = 0; i < walk->nr; i++) {
+		struct commit_reflog *log = walk->logs[i];
+		struct commit *commit = next_reflog_commit(log);
+
+		if (!commit)
+			continue;
+
+		if (!best || log_timestamp(log) > log_timestamp(best)) {
+			best = log;
+			best_commit = commit;
+		}
+	}
+
+	if (best) {
+		best->recno--;
+		walk->last_commit_reflog = best;
+		return best_commit;
+	}
+
+	return NULL;
 }
diff --git a/reflog-walk.h b/reflog-walk.h
index af32361072..373388cd14 100644
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
@@ -22,4 +20,6 @@ extern void get_reflog_selector(struct strbuf *sb,
 
 extern int reflog_walk_empty(struct reflog_walk_info *walk);
 
+struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
+
 #endif
diff --git a/revision.c b/revision.c
index 4019e8cf23..587199739a 100644
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
@@ -3112,16 +3110,18 @@ static void track_linear(struct rev_info *revs, struct commit *commit)
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	while (1) {
-		struct commit *commit = pop_commit(&revs->commits);
+		struct commit *commit;
+
+		if (revs->reflog_info)
+			commit = next_reflog_entry(revs->reflog_info);
+		else
+			commit = pop_commit(&revs->commits);
 
 		if (!commit)
 			return NULL;
 
-		if (revs->reflog_info) {
-			save_parents(revs, commit);
-			fake_reflog_parent(revs->reflog_info, commit);
+		if (revs->reflog_info)
 			commit->object.flags &= ~(ADDED | SEEN | SHOWN);
-		}
 
 		/*
 		 * If we haven't done the list limiting, we need to look at
@@ -3132,7 +3132,10 @@ static struct commit *get_revision_1(struct rev_info *revs)
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
-			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+
+			if (revs->reflog_info)
+				try_to_simplify_commit(revs, commit);
+			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 289c502725..c4c53bd209 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -34,19 +34,19 @@ test_expect_success 'reflog walk shows expected logs' '
 	test_cmp expect.all actual
 '
 
-test_expect_failure 'reflog can limit with --no-merges' '
+test_expect_success 'reflog can limit with --no-merges' '
 	grep -v merge expect.all >expect &&
 	do_walk --no-merges >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'reflog can limit with pathspecs' '
+test_expect_success 'reflog can limit with pathspecs' '
 	grep two expect.all >expect &&
 	do_walk -- two.t >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'pathspec limiting handles merges' '
+test_expect_success 'pathspec limiting handles merges' '
 	# we pick up:
 	#   - the initial commit of one
 	#   - the checkout back to commit one
@@ -56,14 +56,14 @@ test_expect_failure 'pathspec limiting handles merges' '
 	test_cmp expect actual
 '
 
-test_expect_failure '--parents shows true parents' '
+test_expect_success '--parents shows true parents' '
 	# convert newlines to spaces
 	echo $(git rev-parse HEAD HEAD^1 HEAD^2) >expect &&
 	git rev-list -g --parents -1 HEAD >actual &&
 	test_cmp expect actual
 '
 
-test_expect_failure 'walking multiple reflogs shows all' '
+test_expect_success 'walking multiple reflogs shows all' '
 	# We expect to see all entries for all reflogs, but interleaved by
 	# date, with order no the command line breaking ties. We
 	# can use "sort" on the separate lists to generate this,
@@ -91,7 +91,7 @@ test_expect_success 'date-limiting does not interfere with other logs' '
 	test_cmp expect.all actual
 '
 
-test_expect_failure 'walk prefers reflog to ref tip' '
+test_expect_success 'walk prefers reflog to ref tip' '
 	head=$(git rev-parse HEAD) &&
 	one=$(git rev-parse one) &&
 	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd37ac47c5..9d707d2a40 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -166,10 +166,9 @@ test_expect_success 'resulting reflog can be shown by log -g' '
 	oid=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 	HEAD@{0} $oid $msg
-	HEAD@{1} $oid $msg
 	HEAD@{2} $oid checkout: moving from foo to baz
 	EOF
-	git log -g --format="%gd %H %gs" -3 HEAD >actual &&
+	git log -g --format="%gd %H %gs" -2 HEAD >actual &&
 	test_cmp expect actual
 '
 
-- 
2.13.2.1000.g8590c1af5d

