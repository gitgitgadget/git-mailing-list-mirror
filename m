From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Wed, 24 Sep 2008 02:48:23 +0200
Message-ID: <1222217303-29792-1-git-send-email-trast@student.ethz.ch>
References: <1221692484-21977-1-git-send-email-trast@student.ethz.ch>
Cc: Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 02:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiIa0-0002V2-9E
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 02:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYIXAsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 20:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYIXAsb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 20:48:31 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:45340 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYIXAs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 20:48:29 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Sep 2008 02:48:26 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Sep 2008 02:48:26 +0200
X-Mailer: git-send-email 1.6.0.2.270.g2b207.dirty
In-Reply-To: <1221692484-21977-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Sep 2008 00:48:26.0613 (UTC) FILETIME=[413BF250:01C91DDF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96615>

Replaces the existing simple history search with a more sophisticated
algorithm:

1) Walk history with exponentially increasing stride lengths; i.e.,
   send the 1st commit, then the 2nd after that, then the 4th after
   that, and so on.

2) Bisect the resulting intervals.

Combined with tracking the "outstanding haves" so that we can detect
which sha1s were never ACKed by upload-pack (and hence not common),
this gives O(log(n)) required "have" lines.

Unfortunately this cannot work if the server sends fake ACKs, so we
introduce a capability 'exp-stride' which instructs upload-pack to
disable ok_to_give_up().  (Which incidentally saves the server a lot
of work.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

So, after the resounding success that v1 of this patch was, I went
through and actually made it work, or at least I hope so.

I eventually gave up on trying to understand the exact interaction of
mark_common(), which sometimes pushes, and rev_list_push(), which
sometimes marks, and just rewrote them to each only do one thing.  I
also rewrote the old strategy in terms of the new get_rev_stride
(always keeping stride length at 1) because that was far less work
than integrating the existing code with the new one.

For the timings below, I ran the (new) daemon locally, with two repos:

- a 'clone --mirror' of my own git.git, with a branch 'next' 525
  commits from the above cc185a6

- a 'clone --mirror' of the completely unrelated adps.git, which
  shares no objects with git.git

Some not really statistically sound timings, usually best of 3-5:

  ## A stripped down git.git, with only one branch and no tags
  $ git branch -a
  * master
  $ git tag
  $ git log -1 --pretty=oneline master
  cc185a6a8ac24737a26ec4b40cc401c2db8b2e97 Start draft release notes for 1.6.0.3
  
  ## I still have the old (dashed) forms in /usr/bin from RPMs
  $ /usr/bin/git --version
  git version 1.5.6

  ## (1a) "Updating" from the git.git that is further ahead (OLD)
  $ time /usr/bin/git-fetch-pack -k git://localhost/git next
  [...]
  real    0m1.004s
  user    0m0.228s
  sys     0m0.028s

  ## (1b) "Updating" from the git.git that is further ahead (NEW)
  $ time git fetch-pack -k git://localhost/git next
  [...]
  real    0m0.977s
  user    0m0.208s
  sys     0m0.068s

  ## (2a) Fetching the unrelated repo from scratch (OLD)
  $ time /usr/bin/git-fetch-pack -k git://localhost/adps master
  [...]
  real    0m9.560s
  user    0m0.720s
  sys     0m0.128s

  ## (2b) Fetching the unrelated repo from scratch (NEW)
  $ time git fetch-pack -k git://localhost/adps master
  [...]
  real    0m0.596s
  user    0m0.372s
  sys     0m0.008s

  ## (3a) Fetching over the network from real repo (OLD)
  $ time /usr/bin/git-fetch-pack git://git.kernel.org/pub/scm/git/git.git next
  [...]
  user    0m0.528s
  sys     0m0.136s

  ## (3b) Fetching over the network from real repo (NEW)
  $ time git fetch-pack git://git.kernel.org/pub/scm/git/git.git next
  [...]
  user    0m0.540s
  sys     0m0.180s

  ## Add more refs to make it more interesting
  $ git remote add origin ~/dev/git
  $ git fetch --tags origin

  ## (4a) like 1a, but with lots of tags
  $ time /usr/bin/git-fetch-pack -k git://localhost/git next
  [...]
  real    0m1.075s
  user    0m0.452s
  sys     0m0.048s

  ## (4b) like 1b, but with lots of tags
  $ time git fetch-pack -k git://localhost/git next
  [...]
  real    0m0.837s
  user    0m0.236s
  sys     0m0.040s

Clearly, this approach does solve the issue I mentioned in the
motivation earlier in the thread, where the initial fetch of
completely disjoint repositories takes _ages_.  Somewhat to my own
surprise, it seems to do quite well in _all_ cases even though it
aggressively digs through history.

Note, however, that the timings aren't really solid; the final write
of the pack, which I assume is fsync()ed, seems to have a big impact
on the execution time.  Test (3) obviously depends more on network
performance than anything else; and it uses the old (linear)
algorithm, but in the new implementation.

I'd appreciate testers and eyeballs on the patch.  I'll think about
the ref heads "reduced DAG" again, to possibly shave off some more
(client side cpu) time when I get the time, but that likely won't be
in the next few days.

- Thomas


PS: Thanks drizzd for the discussion of the topic on IRC.

PPS: Junio, enjoy your holidays :-)



 builtin-fetch-pack.c |  477 +++++++++++++++++++++++++++++++++++++++++---------
 upload-pack.c        |    7 +-
 2 files changed, 400 insertions(+), 84 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 4dfef29..721fe08 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -25,6 +25,12 @@ static const char fetch_pack_usage[] =
 #define COMMON_REF	(1U << 2)
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
+#define BISECTED_FW	(1U << 5)
+#define BISECTED_BW	(1U << 6)
+#define NOTCOMMON       (1U << 7)
+#define HAS_INFO        (1U << 8)
+#define CLEAN_MARKS     (COMMON | COMMON_REF | SEEN | POPPED | BISECTED_FW \
+			 | BISECTED_BW | NOTCOMMON)
 
 static int marked;
 
@@ -34,133 +40,412 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct commit_list *rev_list;
-static int non_common_revs, multi_ack, use_sideband;
+struct work_list
+{
+	struct work_list *next;
+	struct commit *commit;
+	unsigned int stride;    /* current stride length between commits */
+	unsigned int steps;     /* steps left to go before emitting again */
+	unsigned int depth;     /* sideline depth */
+	unsigned int bisect;
+};
+
+/* "recursion stack" of our strategy of choosing sha1s to transmit */
+static struct work_list *work_list = NULL;
 
-static void rev_list_push(struct commit *commit, int mark)
+/* list of commits not ACKed yet */
+static struct commit_list *outstanding = NULL;
+static struct commit_list *outstanding_end = NULL;
+
+struct commit_info
 {
-	if (!(commit->object.flags & mark)) {
-		commit->object.flags |= mark;
+	struct commit_list *children;
+};
 
-		if (!(commit->object.parsed))
-			if (parse_commit(commit))
-				return;
 
-		insert_by_date(commit, &rev_list);
+static int non_common_revs = 1, multi_ack, use_sideband, exp_stride_algorithm;
 
-		if (!(commit->object.flags & COMMON))
-			non_common_revs++;
+static struct commit_info *get_commit_info(struct commit *commit)
+{
+	if (commit->object.flags & HAS_INFO)
+		return commit->util;
+
+	struct commit_info *info = xmalloc(sizeof(struct commit_info));
+	info->children = NULL;
+	commit->util = info;
+	commit->object.flags |= HAS_INFO;
+	return info;
+}
+
+static void work_list_insert(struct work_list *work_item)
+{
+	struct work_list **pp = &work_list;
+	struct work_list *p;
+
+	while ((p = *pp)) {
+		if (p->bisect || work_item->bisect) {
+			if (p->bisect > work_item->bisect)
+				break;
+		} else {
+			if (p->depth > work_item->depth)
+				break;
+			else if (p->commit->date < work_item->commit->date)
+				break;
+		}
+
+		pp = &p->next;
 	}
+
+	work_item->next = p;
+	*pp = work_item;
 }
 
-static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static void add_child(struct commit *parent, struct commit *child)
+{
+	struct commit_info *info = get_commit_info(parent);
+	struct commit_list *item;
+	for (item = info->children; item; item = item->next)
+		if (item->item == child)
+			break;
+	if (!item)
+		commit_list_insert(child, &(info->children));
+}
+
+
+/*
+  Marks all (known) children of this commit NOTCOMMON.  We call this
+  for all sha1s the server did not ACK.
+*/
+
+static void mark_not_common(struct commit *commit)
+{
+	struct commit_info *info = get_commit_info(commit);
+	struct commit_list *child;
+
+	assert(!(commit->object.flags & COMMON));
+
+	if (commit->object.flags & NOTCOMMON)
+		return;
+
+	commit->object.flags |= NOTCOMMON;
+
+	for (child = info->children; child; child = child->next)
+		mark_not_common(child->item);
+}
+
+
+static void check_parsed_and_mark(struct commit *commit)
+{
+	struct commit_list *parent;
+
+	if (!commit && commit->object.parsed)
+		return;
+
+	parse_commit(commit);
+
+	for (parent = commit->parents; parent; parent = parent->next) {
+		add_child(parent->item, commit);
+		if (parent->item->object.flags & NOTCOMMON)
+			mark_not_common(commit);
+	}
+}
+
+
+static void rev_list_push(struct commit *commit, unsigned int stride,
+			  unsigned int steps, unsigned int depth)
+{
+	struct work_list *work_item;
+
+	check_parsed_and_mark(commit);
+
+	work_item = xmalloc(sizeof(struct work_list));
+	work_item->commit = commit;
+	work_item->stride = stride;
+	work_item->steps = steps;
+	work_item->depth = depth;
+	work_item->bisect = 0;
+	work_list_insert(work_item);
+}
+
+static int rev_list_insert_ref(const char *path, const unsigned char *sha1,
+			       int flag, void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
-	if (o && o->type == OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
+	if (o && o->type == OBJ_COMMIT && !(o->flags & SEEN))
+		rev_list_push((struct commit *)o, 1, 1, 0);
 
 	return 0;
 }
 
-static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int clear_marks(const char *path, const unsigned char *sha1, int flag,
+		       void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		clear_commit_marks((struct commit *)o,
-				   COMMON | COMMON_REF | SEEN | POPPED);
+		clear_commit_marks((struct commit *)o, CLEAN_MARKS);
 	return 0;
 }
 
+
 /*
-   This function marks a rev and its ancestors as common.
-   In some cases, it is desirable to mark only the ancestors (for example
-   when only the server does not yet know that they are common).
+  Mark commits backwards through history as COMMON.
 */
 
-static void mark_common(struct commit *commit,
-		int ancestors_only, int dont_parse)
+static void mark_common(struct commit *commit, int ancestors_only, int dont_parse)
 {
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
-		struct object *o = (struct object *)commit;
+	struct commit_list *parents;
+	struct object *o;
 
-		if (!ancestors_only)
-			o->flags |= COMMON;
+	if (commit == NULL || commit->object.flags & (COMMON_REF|COMMON))
+		return;
 
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
+	if (!dont_parse && !(commit->object.parsed))
+		check_parsed_and_mark(commit);
+
+	o = (struct object *)commit;
+
+	if (!ancestors_only)
+		o->flags |= COMMON;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		add_child(parents->item, commit);
+		mark_common(parents->item, 0, dont_parse);
 	}
 }
 
+
+
 /*
-  Get the next rev to send, ignoring the common.
+  Queue all revs in the list for simple backward search. Does not
+  requeue already SEEN commits.
 */
 
-static const unsigned char* get_rev(void)
+static void queue_list(struct commit *child, struct commit_list *list,
+		       unsigned int stride, unsigned int steps,
+		       unsigned int depth)
 {
-	struct commit *commit = NULL;
+	while (list) {
+		add_child(list->item, child);
+		if (!(list->item->object.flags & SEEN))
+			rev_list_push(list->item, stride, steps, depth);
+		list = list->next;
+	}
+}
+
+
+/*
+  Queues a commit for bisection
+*/
+
+static void setup_bisect(struct commit *commit, int depth)
+{
+	struct work_list *work_item = xmalloc(sizeof(struct work_list));
+
+	work_item->commit = commit;
+	work_item->bisect = 1+depth;
+	work_item->depth = 0;
+	work_list_insert(work_item);
+}
+
+
+/*
+  Queues a list of commits for bisection
+*/
+
+static void setup_bisect_all (struct commit_list* list, int depth)
+{
+	while (list) {
+		setup_bisect(list->item, depth);
+		list = list->next;
+	}
+}
+
+
+/*
+  Backwards search. If we use exp_stride_algorithm, it takes
+  exponential strides between commits chosen.
+*/
+
+static struct commit* get_rev_stride(struct work_list *work_item)
+{
+	struct commit *commit = work_item->commit;
+	unsigned int steps = work_item->steps;
+
+	while (steps++ < work_item->stride-1 && commit->parents
+	       && !(commit->object.flags & (SEEN|COMMON|COMMON_REF))) {
+		/* all but the first parent line are queued for later */
+		if (commit->parents)
+			queue_list(commit, commit->parents->next,
+				   work_item->stride, steps,
+				   work_item->depth+1);
+
+		/* follow the first parent line directly */
+		commit->object.flags |= SEEN;
+		add_child(commit->parents->item, commit);
+		commit = commit->parents->item;
+		check_parsed_and_mark(commit);
+	}
+
+	if (commit->object.flags & (SEEN|COMMON)) {
+		/* already been here! */
+		commit = NULL;
+	} else if (commit->object.flags & COMMON_REF) {
+		/* this came from a ref; we stop here, but need to
+		 * emit it so the server knows too */
+		commit->object.flags |= POPPED|SEEN|BISECTED_BW;
+		if (exp_stride_algorithm)
+			setup_bisect(commit, 0);
+	} else {
+		/* usual case: this is news to us, so we scan further
+		 * back.  note that the first-depth bisection only
+		 * needs to go forward */
+		commit->object.flags |= POPPED|SEEN|BISECTED_BW;
+		queue_list(commit, commit->parents,
+			   exp_stride_algorithm ? work_item->stride*2 : 1,
+			   0, work_item->depth);
+		if (exp_stride_algorithm)
+			setup_bisect(commit, 0);
+	}
+
+	free(work_item);
+
+	return commit;
+}
 
-	while (commit == NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
 
-		if (rev_list == NULL || non_common_revs == 0)
+/*
+  Bisection state of the exponential stride algorithm: scans forward
+  (backward) for a non-common/already-sent (common/already-sent,
+  resp.) commit, then emits the middle of that range, and re-queues.
+
+  This means we bisect the discovered range in log(n) transmissions,
+  although we do make O(n) steps through history.
+*/
+
+static struct commit* get_rev_bisect(struct work_list *work_item)
+{
+	struct commit *full;
+	struct commit *half;
+	int half_step;
+	struct commit_info *info;
+	unsigned int flags = work_item->commit->object.flags;
+
+	if (!(flags & (COMMON|BISECTED_BW))) {
+		/* We don't know anything about the history _backward_
+		 * from this, so search it */
+
+		full = work_item->commit;
+		full->object.flags |= BISECTED_BW;
+		half = work_item->commit;
+		half_step = 0;
+
+		while (full && full->parents) {
+			full = full->parents->item;
+			half_step ^= 1;
+			if (half_step)
+				half = half->parents->item;
+			if (full->object.flags & (POPPED|COMMON))
+				break;
+		}
+
+		/* also insert the same bisection again so we can try
+		 * forward too */
+		work_list_insert(work_item);
+
+		if (full->object.flags & POPPED
+		    && !(full->object.flags & NOTCOMMON)
+		    && !(half->object.flags & (COMMON|POPPED))) {
+			setup_bisect(half, work_item->bisect);
+			half->object.flags |= POPPED;
+			return half;
+		} else {
 			return NULL;
+		}
+	}
 
-		commit = rev_list->item;
-		if (!commit->object.parsed)
-			parse_commit(commit);
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
+	if (!(flags & (NOTCOMMON|BISECTED_FW))) {
+		/* We don't know anything about the history _forward_
+		 * from this, so search it */
+
+		full = work_item->commit;
+		full->object.flags |= BISECTED_FW;
+		half = work_item->commit;
+		half_step = 0;
+
+		while (full && (info=get_commit_info(full))->children) {
+			setup_bisect_all(info->children->next, work_item->bisect);
+			full = info->children->item;
+			half_step ^= 1;
+			if (half_step) {
+				info = get_commit_info(half);
+				half = info->children->item;
+			}
+			if (full->object.flags & (POPPED|NOTCOMMON))
+				break;
 		}
 
-		rev_list = rev_list->next;
+		if (full->object.flags & POPPED
+		    && !(full->object.flags & COMMON)
+		    && !(half->object.flags & (NOTCOMMON|POPPED))) {
+			setup_bisect(half, work_item->bisect);
+			half->object.flags |= POPPED;
+			free(work_item);
+			return half;
+		}
 	}
 
-	return commit->object.sha1;
+	free(work_item);
+	return NULL;
 }
 
+
+/*
+  Get the next revision to send.
+*/
+
+static struct commit *get_rev(void)
+{
+	struct commit *commit = NULL;
+
+	while (commit == NULL && work_list) {
+		struct work_list *work_item = NULL;
+
+		work_item = work_list;
+		/* we update the pointer early so the get_rev
+		 * functions can free() or reuse the work_item as
+		 * required */
+		work_list = work_item->next;
+
+		commit = work_item->commit;
+
+		check_parsed_and_mark(commit);
+
+		if (work_item->bisect) {
+			commit = get_rev_bisect(work_item);
+		} else {
+			commit = get_rev_stride(work_item);
+		}
+	}
+
+	return commit;
+}
+
+static void pop_outstanding()
+{
+	struct commit_list *item = outstanding;
+	outstanding = item->next;
+	free(item);
+}
+
+
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
 	int count = 0, flushes = 0, retval;
+	struct commit *commit;
 	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
@@ -192,7 +477,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
@@ -200,6 +485,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				     (args.use_thin_pack ? " thin-pack" : ""),
 				     (args.no_progress ? " no-progress" : ""),
 				     (args.include_tag ? " include-tag" : ""),
+				     (exp_stride_algorithm ? " exp-stride" : ""),
 				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
@@ -243,13 +529,25 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 
 	flushes = 0;
 	retval = -1;
-	while ((sha1 = get_rev())) {
+	while ((commit = get_rev())) {
+		sha1 = commit->object.sha1;
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
 		if (args.verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		in_vain++;
+
+		if (outstanding) {
+			commit_list_insert(commit, &(outstanding_end->next));
+			outstanding_end = outstanding_end->next;
+		} else {
+			commit_list_insert(commit, &outstanding);
+			outstanding_end = outstanding;
+		}
+
 		if (!(31 & ++count)) {
 			int ack;
+			int unwound = 0;
+			struct commit_list *item;
 
 			packet_flush(fd[1]);
 			flushes++;
@@ -274,12 +572,23 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				} else if (ack == 2) {
 					struct commit *commit =
 						lookup_commit(result_sha1);
+					while (commit != outstanding->item) {
+						mark_not_common(outstanding->item);
+						pop_outstanding();
+						unwound++;
+					}
+					pop_outstanding();
+					unwound++;
 					mark_common(commit, 0, 1);
 					retval = 0;
 					in_vain = 0;
 					got_continue = 1;
 				}
 			} while (ack);
+			while (unwound++ < 32) {
+				mark_not_common(outstanding->item);
+				pop_outstanding();
+			}
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
 				if (args.verbose)
@@ -445,9 +754,8 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 			continue;
 
 		if (!(o->flags & SEEN)) {
-			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
-
-			mark_common((struct commit *)o, 1, 1);
+			rev_list_push((struct commit *)o, 1, 0, 0);
+			o->flags |= COMMON_REF;
 		}
 	}
 
@@ -597,6 +905,11 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband = 1;
 	}
+	if (server_supports("exp-stride")) {
+		if (args.verbose)
+			fprintf(stderr, "Server supports exp-stride\n");
+		exp_stride_algorithm = 1;
+	}
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
 		goto all_done;
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..14012ee 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -37,6 +37,7 @@ static unsigned int timeout;
  */
 static int use_sideband;
 static int debug_fd;
+static int exp_stride_algorithm;
 
 static void reset_timeout(void)
 {
@@ -414,7 +415,7 @@ static int get_common_commits(void)
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-				if (multi_ack && ok_to_give_up())
+				if (multi_ack && !exp_stride_algorithm && ok_to_give_up())
 					packet_write(1, "ACK %s continue\n",
 						     sha1_to_hex(sha1));
 				break;
@@ -501,6 +502,8 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (strstr(line+45, "include-tag"))
 			use_include_tag = 1;
+		if (strstr(line+45, "exp-stride"))
+			exp_stride_algorithm = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -573,7 +576,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag";
+		" include-tag exp-stride";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
tg: (1293c95..) t/fetch-pack-speedup (depends on: origin/master)
