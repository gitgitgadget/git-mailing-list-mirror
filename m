From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] fetch-pack: log(n)-transmission find_common()
Date: Thu, 18 Sep 2008 01:01:24 +0200
Message-ID: <1221692484-21977-1-git-send-email-trast@student.ethz.ch>
References: <200809180100.32626.trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 01:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg62h-00072b-T2
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 01:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYIQXBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 19:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYIQXBb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 19:01:31 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:36199 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbYIQXBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 19:01:30 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 01:01:28 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 18 Sep 2008 01:01:27 +0200
X-Mailer: git-send-email 1.6.0.2.486.g6890
In-Reply-To: <200809180100.32626.trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Sep 2008 23:01:27.0674 (UTC) FILETIME=[50C515A0:01C91919]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96150>

See thread starter for discussion.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 builtin-fetch-pack.c |  333 +++++++++++++++++++++++++++++++++++++++++++------
 upload-pack.c        |    4 +-
 2 files changed, 294 insertions(+), 43 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 4dfef29..9f010fe 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -25,6 +25,11 @@ static const char fetch_pack_usage[] =
 #define COMMON_REF	(1U << 2)
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
+#define BISECTED_FW	(1U << 5)
+#define BISECTED_BW	(1U << 6)
+#define NOTCOMMON       (1U << 7)
+#define HAS_INFO        (1U << 8)
+#define CLEAN_MARKS     (COMMON | COMMON_REF | SEEN | POPPED | BISECTED_FW | BISECTED_BW | NOTCOMMON)
 
 static int marked;
 
@@ -34,19 +39,78 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct commit_list *rev_list;
+struct work_list
+{
+	struct work_list *next;
+	struct commit *commit;
+	unsigned int stride;    /* current stride length between commits */
+	unsigned int steps;     /* steps left to go before emitting again */
+	unsigned int bisect;
+	unsigned int is_ref :1; /* prioritise refs */
+};
+
+static struct work_list *work_list = NULL;
+
+static struct commit_list *outstanding = NULL; /* list of commits not ACKed yet */
+static struct commit_list *outstanding_end = NULL;
+
+struct commit_info
+{
+	struct commit_list *children;
+};
+
+
 static int non_common_revs, multi_ack, use_sideband;
 
-static void rev_list_push(struct commit *commit, int mark)
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
 {
+	struct work_list **pp = &work_list;
+	struct work_list *p;
+
+	while ((p = *pp)) {
+		if ((work_item->is_ref && (!p->is_ref || p->commit->date < work_item->commit->date))
+		    || (!work_item->bisect && (p->bisect || p->commit->date < work_item->commit->date))
+		    || p->bisect > work_item->bisect)
+			break;
+		pp = &p->next;
+	}
+
+	work_item->next = p;
+	*pp = work_item;
+}
+
+
+static void rev_list_push(struct commit *commit, int mark, unsigned int stride, unsigned int steps, unsigned int is_ref)
+{
+	struct work_list *work_item;
+
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (!(commit->object.parsed))
+		if (!(commit->object.parsed)) {
 			if (parse_commit(commit))
 				return;
+		}
 
-		insert_by_date(commit, &rev_list);
+		work_item = xmalloc(sizeof(struct work_list));
+		work_item->commit = commit;
+		work_item->stride = stride;
+		work_item->steps = steps;
+		work_item->bisect = 0;
+		work_item->is_ref = is_ref;
+		work_list_insert(work_item);
 
 		if (!(commit->object.flags & COMMON))
 			non_common_revs++;
@@ -58,7 +122,7 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
+		rev_list_push((struct commit *)o, SEEN, 1, 1, 1);
 
 	return 0;
 }
@@ -68,8 +132,7 @@ static int clear_marks(const char *path, const unsigned char *sha1, int flag, vo
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		clear_commit_marks((struct commit *)o,
-				   COMMON | COMMON_REF | SEEN | POPPED);
+		clear_commit_marks((struct commit *)o, CLEAN_MARKS);
 	return 0;
 }
 
@@ -89,7 +152,7 @@ static void mark_common(struct commit *commit,
 			o->flags |= COMMON;
 
 		if (!(o->flags & SEEN))
-			rev_list_push(commit, SEEN);
+			rev_list_push(commit, SEEN, 1, 1, 0);
 		else {
 			struct commit_list *parents;
 
@@ -111,49 +174,216 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const unsigned char* get_rev(void)
+
+static void get_rev_queue_parents(struct commit *commit, int mark, unsigned int stride, unsigned int steps)
+{
+	struct commit_list *parents = commit->parents;
+
+	while (parents) {
+		struct commit_info *info = get_commit_info(parents->item);
+		struct commit_list *entry;
+		for (entry = info->children; entry; entry = entry->next)
+			if (entry->item == commit)
+				break;
+		if (!entry)
+			commit_list_insert(commit, &(info->children));
+		if (!(parents->item->object.flags & SEEN))
+			rev_list_push(parents->item, mark, stride, steps, 0);
+		if (mark & COMMON)
+			mark_common(parents->item, 1, 0);
+		parents = parents->next;
+	}
+}
+
+
+static struct commit* get_rev_stride_skip(struct work_list *work_item)
+{
+	get_rev_queue_parents(work_item->commit, SEEN, work_item->stride,
+			      work_item->steps + 1);
+
+	free(work_item);
+	return NULL;
+}
+
+static void setup_bisect(struct commit *commit, int depth)
+{
+	struct work_list *work_item = xmalloc(sizeof(struct work_list));
+
+	work_item->commit = commit;
+	work_item->bisect = 1+depth;
+	work_item->is_ref = 0;
+	work_list_insert(work_item);
+}
+
+static void setup_bisect_all (struct commit_list* list, int depth)
+{
+	while (list) {
+		setup_bisect(list->item, depth);
+		list = list->next;
+	}
+}
+
+static struct commit* get_rev_stride_emit(struct work_list *work_item)
+{
+	struct commit *commit = work_item->commit;
+	unsigned int mark;
+
+	commit->object.flags |= POPPED;
+
+	/* This one got hit by our walk! */
+	if (!(commit->object.flags & COMMON))
+		non_common_revs--;
+
+	if (commit->object.flags & COMMON) {
+		/* do not send "have", and ignore ancestors */
+		commit = NULL;
+		mark = COMMON | SEEN;
+	} else if (commit->object.flags & COMMON_REF) {
+		/* send "have", and ignore ancestors */
+		mark = COMMON | SEEN;
+	} else {
+		/* send "have", also for its ancestors */
+		mark = SEEN;
+		setup_bisect(commit, 0);
+	}
+
+	if (commit)
+		get_rev_queue_parents(commit, mark, work_item->stride*2, 0);
+
+	free(work_item);
+
+	return commit;
+}
+
+static struct commit* get_rev_bisect(struct work_list *work_item)
+{
+	struct commit *full;
+	struct commit *half;
+	int half_step;
+	struct commit_info *info;
+	unsigned int flags = work_item->commit->object.flags;
+
+	if (flags & NOTCOMMON) {
+		/* we inferred that this side of the bisection is not
+		 * interesting any longer */
+		free(work_item);
+		return NULL;
+	}
+
+
+	if (!(flags & (COMMON|BISECTED_BW))) {
+		/* Server does not have this. Search backward in history */
+
+		full = work_item->commit;
+		full->object.flags |= BISECTED_BW;
+		half = work_item->commit;
+		half_step = 0;
+
+		while (full && full->parents) {
+			setup_bisect_all(full->parents->next, work_item->bisect);
+			full = full->parents->item;
+			half_step ^= 1;
+			if (half_step)
+				half = half->parents->item;
+			if (full->object.flags & (POPPED|COMMON))
+				break;
+		}
+
+		/* also insert the same bisection again so we can try forward too */
+		work_list_insert(work_item);
+
+		if (full->object.flags & POPPED
+		    && !(full->object.flags & NOTCOMMON)
+		    && !(half->object.flags & (COMMON|POPPED))) {
+			setup_bisect(half, work_item->bisect);
+			half->object.flags |= POPPED;
+			info = get_commit_info(half);
+			return half;
+		} else {
+			return NULL;
+		}
+	}
+
+	if (!(flags & (NOTCOMMON|BISECTED_FW))) {
+		/* We have not seen this yet when bisecting, search forward */
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
+		}
+
+		if (full->object.flags & POPPED
+		    && !(full->object.flags & COMMON)
+		    && !(half->object.flags & POPPED)) {
+			setup_bisect(half, work_item->bisect);
+			half->object.flags |= POPPED;
+			info = get_commit_info(half);
+			free(work_item);
+			return half;
+		}
+	}
+
+	free(work_item);
+	return NULL;
+}
+
+
+static void mark_not_common(struct commit *commit)
+{
+	struct commit_info *info = get_commit_info(commit);
+	struct commit_list *child;
+
+	if (commit->object.flags & COMMON)
+		/* this has already been acked earlier */
+		return;
+
+	commit->object.flags |= NOTCOMMON;
+
+	for (child = info->children; child; child = child->next)
+		mark_not_common(child->item);
+}
+
+static struct commit *get_rev(void)
 {
 	struct commit *commit = NULL;
 
 	while (commit == NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
+		struct work_list *work_item = NULL;
 
-		if (rev_list == NULL || non_common_revs == 0)
+		if (work_list == NULL || non_common_revs == 0)
 			return NULL;
 
-		commit = rev_list->item;
-		if (!commit->object.parsed)
+		work_item = work_list;
+		work_list = work_item->next;
+
+		commit = work_item->commit;
+
+		if (commit && !commit->object.parsed)
 			parse_commit(commit);
-		parents = commit->parents;
 
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
+		if (work_item->bisect) {
+			commit = get_rev_bisect(work_item);
+		} else if (work_item->steps >= work_item->stride-1
+			   || (commit && !commit->parents)) {
+			commit = get_rev_stride_emit(work_item);
+		} else {
+			commit = get_rev_stride_skip(work_item);
 		}
-
-		rev_list = rev_list->next;
 	}
 
-	return commit->object.sha1;
+	return commit;
 }
 
 static int find_common(int fd[2], unsigned char *result_sha1,
@@ -161,6 +391,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 {
 	int fetching;
 	int count = 0, flushes = 0, retval;
+	struct commit *commit;
 	const unsigned char *sha1;
 	unsigned in_vain = 0;
 	int got_continue = 0;
@@ -243,11 +474,21 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 
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
 
@@ -274,6 +515,16 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 				} else if (ack == 2) {
 					struct commit *commit =
 						lookup_commit(result_sha1);
+					struct commit_list *item;
+					while (commit != outstanding->item) {
+						mark_not_common(commit);
+						item = outstanding;
+						outstanding = item->next;
+						free(item);
+					}
+					item = outstanding;
+					outstanding = item->next;
+					free(item);
 					mark_common(commit, 0, 1);
 					retval = 0;
 					in_vain = 0;
@@ -445,7 +696,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 			continue;
 
 		if (!(o->flags & SEEN)) {
-			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+			rev_list_push((struct commit *)o, COMMON_REF | SEEN, 1, 1, 1);
 
 			mark_common((struct commit *)o, 1, 1);
 		}
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..c6dfb32 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -414,9 +414,9 @@ static int get_common_commits(void)
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-				if (multi_ack && ok_to_give_up())
+/*				if (multi_ack && ok_to_give_up())
 					packet_write(1, "ACK %s continue\n",
-						     sha1_to_hex(sha1));
+					sha1_to_hex(sha1));*/
 				break;
 			default:
 				memcpy(hex, sha1_to_hex(sha1), 41);
-- 
tg: (1293c95..) t/fetch-pack-speedup (depends on: origin/master)
