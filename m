From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize rename detection for a huge diff
Date: Wed, 13 Feb 2008 19:00:07 -0800
Message-ID: <7vprv0medk.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
 <20080128055933.GA13521@coredump.intra.peff.net>
 <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
 <20080129222007.GA3985@coredump.intra.peff.net>
 <7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
 <7vwspskynz.fsf@gitster.siamese.dyndns.org>
 <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org>
 <7vodalqj0s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 04:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPULK-0000XC-1J
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 04:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYBNDAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 22:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbYBNDAW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 22:00:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYBNDAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 22:00:20 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AFE427CC;
	Wed, 13 Feb 2008 22:00:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 BC73627C8; Wed, 13 Feb 2008 22:00:09 -0500 (EST)
In-Reply-To: <7vodalqj0s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 13 Feb 2008 01:53:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73843>

Junio C Hamano <gitster@pobox.com> writes:

> With a bit of tweak, now I am getting these numbers to the
> rename detection that used to spend 800MB (the peak I observed
> was somewhere around 430MB).
>
> (after patch, in the kernel repository, master at 96b5a46)
> $ /usr/bin/time git-diff -M -l0 --name-status d19fbe8a7 master >/var/tmp/3
> 157.20user 1.03system 2:38.72elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (32major+237315minor)pagefaults 0swaps
>
> (before patch, same diff)
> $ /usr/bin/time git-diff -M -l0 --name-status d19fbe8a7 master >/var/tmp/4
> 174.00user 2.73system 3:09.55elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (6106major+459314minor)pagefaults 0swaps
>
> So it is not that much of an improvement, but it seems to help
> somewhat.
> ...
> We would need to see where the remaining 400MB is going and try
> to shrink it, but this would be an improvement so I'll soon be
> moving this to 'next'.

I noticed that massif reported diff_queue() very high in the
list, so came up with this patch on top of the previous ones.

162.75user 1.92system 2:45.22elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+215490minor)pagefaults 0swaps

Still not much of an improvement (10%, judging from the minor
fault counts?), and it risks crashing if there is an unconvered
free() that frees a diff_filepair that was obtained from the
bulk allocator.

---
 alloc.c               |   33 ++++++++++++++++++++
 builtin-diff-tree.c   |    2 +-
 builtin-rev-parse.c   |    2 +-
 builtin-send-pack.c   |    2 +-
 builtin-show-branch.c |    2 +-
 cache.h               |    4 ++
 commit.c              |   14 ++++----
 diff.c                |    4 +-
 diffcore-break.c      |   12 ++++---
 diffcore-rename.c     |   80 +++++++++++++++++++++++++++++++++++-------------
 diffcore.h            |    4 ++
 http-push.c           |    2 +-
 revision.c            |    6 ++--
 upload-pack.c         |    2 +-
 14 files changed, 124 insertions(+), 45 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..08c2591 100644
--- a/alloc.c
+++ b/alloc.c
@@ -15,6 +15,8 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "diff.h"
+#include "diffcore.h"
 
 #define BLOCKING 1024
 
@@ -51,6 +53,35 @@ DEFINE_ALLOCATOR(commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
+#define DEFINE_FREEABLE_ALLOCATOR(name, type)			\
+DEFINE_ALLOCATOR(name, type)					\
+union freeable_##name {						\
+	union freeable_##name *next;				\
+	type body;						\
+};								\
+static union freeable_##name *name##_freepool;			\
+type *alloc_freeable_##name##_node(void)			\
+{								\
+	if (name##_freepool) {					\
+		union freeable_##name *one = name##_freepool;	\
+		name##_freepool = one->next;			\
+		memset(one, 0, sizeof(*one));			\
+		return &(one->body);				\
+	}							\
+	return alloc_##name##_node();				\
+}								\
+void free_##name##_node(type *it_)				\
+{								\
+	union freeable_##name *it = (union freeable_##name *)it_; \
+	if (it) {						\
+		it->next = name##_freepool;			\
+		name##_freepool = it;				\
+	}							\
+}
+
+DEFINE_FREEABLE_ALLOCATOR(commit_list, struct commit_list)
+DEFINE_FREEABLE_ALLOCATOR(diff_filepair, struct diff_filepair)
+
 #ifdef NO_C99_FORMAT
 #define SZ_FMT "%u"
 #else
@@ -73,4 +104,6 @@ void alloc_report(void)
 	REPORT(tree);
 	REPORT(commit);
 	REPORT(tag);
+	REPORT(commit_list);
 }
+
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 832797f..04f93f5 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -36,7 +36,7 @@ static int diff_tree_stdin(char *line)
 		/* Free the real parent list */
 		for (parents = commit->parents; parents; ) {
 			struct commit_list *tmp = parents->next;
-			free(parents);
+			free_commit_list_node(parents);
 			parents = tmp;
 		}
 		commit->parents = NULL;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index b9af1a5..580ec51 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -227,7 +227,7 @@ static int try_difference(const char *arg)
 				struct commit_list *n = exclude->next;
 				show_rev(REVERSED,
 					 exclude->item->object.sha1,NULL);
-				free(exclude);
+				free_commit_list_node(exclude);
 				exclude = n;
 			}
 		}
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8afb1d0..6a83258 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -82,7 +82,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 		struct commit_list *temp = list;
 		temp->item->object.flags &= ~mark;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 019abd3..0d7cf89 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -38,7 +38,7 @@ static struct commit *pop_one_commit(struct commit_list **list_p)
 	list = *list_p;
 	commit = list->item;
 	*list_p = list->next;
-	free(list);
+	free_commit_list_node(list);
 	return commit;
 }
 
diff --git a/cache.h b/cache.h
index 3867ba7..196a0d7 100644
--- a/cache.h
+++ b/cache.h
@@ -667,6 +667,10 @@ extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
 extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
+
+extern struct commit_list *alloc_freeable_commit_list_node(void);
+extern void free_commit_list_node(struct commit_list *);
+
 extern void alloc_report(void);
 
 /* trace.c */
diff --git a/commit.c b/commit.c
index 8b8fb04..6696968 100644
--- a/commit.c
+++ b/commit.c
@@ -333,7 +333,7 @@ int parse_commit(struct commit *item)
 
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
-	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
+	struct commit_list *new_list = alloc_freeable_commit_list_node();
 	new_list->item = item;
 	new_list->next = *list_p;
 	*list_p = new_list;
@@ -345,11 +345,11 @@ void free_commit_list(struct commit_list *list)
 	while (list) {
 		struct commit_list *temp = list;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
-struct commit_list * insert_by_date(struct commit *item, struct commit_list **list)
+struct commit_list *insert_by_date(struct commit *item, struct commit_list **list)
 {
 	struct commit_list **pp = list;
 	struct commit_list *p;
@@ -381,7 +381,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 	struct commit_list *old = *list;
 
 	*list = (*list)->next;
-	free(old);
+	free_commit_list_node(old);
 
 	while (parents) {
 		struct commit *commit = parents->item;
@@ -423,7 +423,7 @@ struct commit *pop_commit(struct commit_list **stack)
 
 	if (top) {
 		*stack = top->next;
-		free(top);
+		free_commit_list_node(top);
 	}
 	return item;
 }
@@ -568,7 +568,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 
 		commit = list->item;
 		n = list->next;
-		free(list);
+		free_commit_list_node(list);
 		list = n;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
@@ -599,7 +599,7 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 		struct commit_list *n = list->next;
 		if (!(list->item->object.flags & STALE))
 			insert_by_date(list->item, &result);
-		free(list);
+		free_commit_list_node(list);
 		list = n;
 	}
 	return result;
diff --git a/diff.c b/diff.c
index cd8bc4d..63ac8db 100644
--- a/diff.c
+++ b/diff.c
@@ -2433,7 +2433,7 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
-	struct diff_filepair *dp = xcalloc(1, sizeof(*dp));
+	struct diff_filepair *dp = alloc_freeable_diff_filepair_node();
 	dp->one = one;
 	dp->two = two;
 	if (queue)
@@ -2445,7 +2445,7 @@ void diff_free_filepair(struct diff_filepair *p)
 {
 	free_filespec(p->one);
 	free_filespec(p->two);
-	free(p);
+	free_diff_filepair_node(p);
 }
 
 /* This is different from find_unique_abbrev() in that
diff --git a/diffcore-break.c b/diffcore-break.c
index 31cdcfe..debd26d 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -205,9 +205,11 @@ void diffcore_break(int break_score)
 				dp->score = score;
 				dp->broken_pair = 1;
 
-				free(p); /* not diff_free_filepair(), we are
-					  * reusing one and two here.
-					  */
+				/*
+				 * not diff_free_filepair(), we are
+				 * reusing one and two here.
+				 */
+				free_diff_filepair_node(p);
 				continue;
 			}
 		}
@@ -243,8 +245,8 @@ static void merge_broken(struct diff_filepair *p,
 	dp->score = p->score;
 	diff_free_filespec_data(d->two);
 	diff_free_filespec_data(c->one);
-	free(d);
-	free(c);
+	free_diff_filepair_node(d);
+	free_diff_filepair_node(c);
 }
 
 void diffcore_merge_broken(void)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d37725..5974362 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -112,8 +112,8 @@ static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
-	int score;
-	int name_score;
+	unsigned short score;
+	short name_score;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
@@ -223,6 +223,12 @@ static int score_compare(const void *a_, const void *b_)
 {
 	const struct diff_score *a = a_, *b = b_;
 
+	/* sink the unused ones to the bottom */
+	if (a->dst < 0)
+		return (0 <= b->dst);
+	else if (b->dst < 0)
+		return -1;
+
 	if (a->score == b->score)
 		return b->name_score - a->name_score;
 
@@ -387,6 +393,22 @@ static int find_exact_renames(void)
 	return i;
 }
 
+#define NUM_CANDIDATE_PER_DST 4
+static void record_if_better(struct diff_score m[], struct diff_score *o)
+{
+	int i, worst;
+
+	/* find the worst one */
+	worst = 0;
+	for (i = 1; i < NUM_CANDIDATE_PER_DST; i++)
+		if (score_compare(&m[i], &m[worst]) > 0)
+			worst = i;
+
+	/* is it better than the worst one? */
+	if (score_compare(&m[worst], o) > 0)
+		m[worst] = *o;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -473,47 +495,61 @@ void diffcore_rename(struct diff_options *options)
 	if (num_create * num_src > rename_limit * rename_limit)
 		goto cleanup;
 
-	mx = xmalloc(sizeof(*mx) * num_create * num_src);
+	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-		int base = dst_cnt * num_src;
 		struct diff_filespec *two = rename_dst[i].two;
+		struct diff_score *m;
+
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+
+		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
+		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
+			m[j].dst = -1;
+
 		for (j = 0; j < rename_src_nr; j++) {
 			struct diff_filespec *one = rename_src[j].one;
-			struct diff_score *m = &mx[base+j];
-			m->src = j;
-			m->dst = i;
-			m->score = estimate_similarity(one, two,
-						       minimum_score);
-			m->name_score = basename_same(one, two);
+			struct diff_score this_src;
+			this_src.score = estimate_similarity(one, two,
+							     minimum_score);
+			this_src.name_score = basename_same(one, two);
+			this_src.dst = i;
+			this_src.src = j;
+			record_if_better(m, &this_src);
 			diff_free_filespec_blob(one);
 		}
 		/* We do not need the text anymore */
 		diff_free_filespec_blob(two);
 		dst_cnt++;
 	}
+
 	/* cost matrix sorted by most to least similar pair */
-	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
-	for (i = 0; i < num_create * num_src; i++) {
-		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
-		struct diff_filespec *src;
+	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
+
+	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+		struct diff_rename_dst *dst;
+
+		if ((mx[i].dst < 0) ||
+		    (mx[i].score < minimum_score))
+			break; /* there is no more usable pair. */
+		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
-		src = rename_src[mx[i].src].one;
-		if (src->rename_used)
+		if (rename_src[mx[i].src].one->rename_used)
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		rename_count++;
 	}
-	for (i = 0; i < num_create * num_src; i++) {
-		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
+
+	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+		struct diff_rename_dst *dst;
+
+		if ((mx[i].dst < 0) ||
+		    (mx[i].score < minimum_score))
+			break; /* there is no more usable pair. */
+		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		rename_count++;
 	}
diff --git a/diffcore.h b/diffcore.h
index cc96c20..00aef4c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -118,4 +118,8 @@ extern int diffcore_count_changes(struct diff_filespec *src,
 				  unsigned long *src_copied,
 				  unsigned long *literal_added);
 
+/* alloc.c */
+extern struct diff_filepair *alloc_freeable_diff_filepair_node(void);
+extern void free_diff_filepair_node(struct diff_filepair *);
+
 #endif
diff --git a/http-push.c b/http-push.c
index b2b410d..314141f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1817,7 +1817,7 @@ static void unmark_and_free(struct commit_list *list, unsigned int mark)
 		struct commit_list *temp = list;
 		temp->item->object.flags &= ~mark;
 		list = temp->next;
-		free(temp);
+		free_commit_list_node(temp);
 	}
 }
 
diff --git a/revision.c b/revision.c
index 6e85aaa..df9b062 100644
--- a/revision.c
+++ b/revision.c
@@ -571,7 +571,7 @@ static int limit_list(struct rev_info *revs)
 		show_early_output_fn_t show;
 
 		list = list->next;
-		free(entry);
+		free_commit_list_node(entry);
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
@@ -752,7 +752,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	while (bases) {
 		struct commit *it = bases->item;
 		struct commit_list *n = bases->next;
-		free(bases);
+		free_commit_list_node(bases);
 		bases = n;
 		it->object.flags |= UNINTERESTING;
 		add_pending_object(revs, &it->object, "(merge-base)");
@@ -1472,7 +1472,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		struct commit *commit = entry->item;
 
 		revs->commits = entry->next;
-		free(entry);
+		free_commit_list_node(entry);
 
 		if (revs->reflog_info)
 			fake_reflog_parent(revs->reflog_info, commit);
diff --git a/upload-pack.c b/upload-pack.c
index 51e3ec4..86a4e7e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -331,7 +331,7 @@ static int reachable(struct commit *want)
 	while (work) {
 		struct commit_list *list = work->next;
 		struct commit *commit = work->item;
-		free(work);
+		free_commit_list_node(work);
 		work = list;
 
 		if (commit->object.flags & THEY_HAVE) {
