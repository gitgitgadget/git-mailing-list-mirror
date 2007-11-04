From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] pretty describe: move library functions to the new file
 describe.c
Date: Sun, 04 Nov 2007 12:48:41 +0100
Message-ID: <472DB199.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodyl-0001E7-Mr
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbXKDLs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbXKDLs6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:48:58 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43774
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159AbXKDLs5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:48:57 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 867F9873BA;
	Sun,  4 Nov 2007 12:48:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63390>

load_commit_names(), describe_commit() et. al. are moved out to their
own file and properly exported.  There are no code changes inside the
functions.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile           |    2 +-
 builtin-describe.c |  202 ---------------------------------------------------
 cache.h            |    5 ++
 describe.c         |  204 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 203 deletions(-)
 create mode 100644 describe.c

diff --git a/Makefile b/Makefile
index 042f79e..afdd847 100644
--- a/Makefile
+++ b/Makefile
@@ -312,7 +312,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o
+	transport.o bundle.o walker.o parse-options.o describe.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-describe.c b/builtin-describe.c
index e68a3d0..fcd93f4 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -1,14 +1,9 @@
 #include "cache.h"
 #include "commit.h"
-#include "tag.h"
-#include "refs.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
 
-#define SEEN		(1u<<0)
-#define MAX_TAGS	(FLAG_BITS - 1)
-
 static const char * const describe_usage[] = {
 	"git-describe [options] <committish>*",
 	NULL
@@ -20,203 +15,6 @@ static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
 
-static const char *prio_names[] = {
-	"head", "lightweight", "annotated",
-};
-
-static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
-	struct object *object;
-	int min_prio = *((int *)cb_data);
-	int prio;
-
-	if (!commit)
-		return 0;
-	object = parse_object(sha1);
-
-	if (!prefixcmp(path, "refs/tags/")) {
-		if (object->type == OBJ_TAG)
-			prio = 2;
-		else
-			prio = 1;
-	}
-	else
-		prio = 0;
-	if (prio < min_prio)
-		return 0;
-
-	if (commit->name) {
-		if (commit->name_prio >= prio)
-			return 0;
-		free(commit->name);
-	}
-	commit->name = xstrdup(path + 5);
-	commit->name_prio = prio;
-
-	return 0;
-}
-
-void load_commit_names(int min_prio)
-{
-	for_each_ref(get_name, &min_prio);
-}
-
-struct possible_tag {
-	char *name;
-	int prio; /* annotated tag = 2, tag = 1, head = 0 */
-	int depth;
-	int found_order;
-	unsigned flag_within;
-};
-
-static int compare_pt(const void *a_, const void *b_)
-{
-	struct possible_tag *a = (struct possible_tag *)a_;
-	struct possible_tag *b = (struct possible_tag *)b_;
-	if (a->prio != b->prio)
-		return b->prio - a->prio;
-	if (a->depth != b->depth)
-		return a->depth - b->depth;
-	if (a->found_order != b->found_order)
-		return a->found_order - b->found_order;
-	return 0;
-}
-
-static unsigned long finish_depth_computation(
-	struct commit_list **list,
-	struct possible_tag *best)
-{
-	unsigned long seen_commits = 0;
-	while (*list) {
-		struct commit *c = pop_commit(list);
-		struct commit_list *parents = c->parents;
-		seen_commits++;
-		if (c->name_flags & best->flag_within) {
-			struct commit_list *a = *list;
-			while (a) {
-				struct commit *i = a->item;
-				if (!(i->name_flags & best->flag_within))
-					break;
-				a = a->next;
-			}
-			if (!a)
-				break;
-		} else
-			best->depth++;
-		while (parents) {
-			struct commit *p = parents->item;
-			parse_commit(p);
-			if (!(p->name_flags & SEEN))
-				insert_by_date(p, list);
-			p->name_flags |= c->name_flags;
-			parents = parents->next;
-		}
-	}
-	return seen_commits;
-}
-
-char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp)
-{
-	struct commit *gave_up_on = NULL;
-	struct commit_list *list;
-	struct possible_tag all_matches[MAX_TAGS];
-	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
-	unsigned long seen_commits = 0;
-
-	if (cmit->name) {
-		*depthp = 0;
-		return cmit->name;
-	}
-
-	if (debug)
-		fprintf(stderr, "searching...\n");
-
-	if (max_candidates < 1)
-		max_candidates = 1;
-	else if (max_candidates > MAX_TAGS)
-		max_candidates = MAX_TAGS;
-
-	list = NULL;
-	cmit->name_flags = SEEN;
-	commit_list_insert(cmit, &list);
-	while (list) {
-		struct commit *c = pop_commit(&list);
-		struct commit_list *parents = c->parents;
-		seen_commits++;
-		if (c->name) {
-			if (match_cnt < max_candidates) {
-				struct possible_tag *t = &all_matches[match_cnt++];
-				t->name = c->name;
-				t->prio = c->name_prio;
-				t->depth = seen_commits - 1;
-				t->flag_within = 1u << match_cnt;
-				t->found_order = match_cnt;
-				c->name_flags |= t->flag_within;
-				if (c->name_prio == 2)
-					annotated_cnt++;
-			}
-			else {
-				gave_up_on = c;
-				break;
-			}
-		}
-		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
-			struct possible_tag *t = &all_matches[cur_match];
-			if (!(c->name_flags & t->flag_within))
-				t->depth++;
-		}
-		if (annotated_cnt && !list) {
-			if (debug)
-				fprintf(stderr, "finished search at %s\n",
-					sha1_to_hex(c->object.sha1));
-			break;
-		}
-		while (parents) {
-			struct commit *p = parents->item;
-			parse_commit(p);
-			if (!(p->name_flags & SEEN))
-				insert_by_date(p, &list);
-			p->name_flags |= c->name_flags;
-			parents = parents->next;
-		}
-	}
-
-	if (!match_cnt) {
-		free_commit_list(list);
-		*depthp = -1;
-		return NULL;
-	}
-
-	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
-
-	if (gave_up_on) {
-		insert_by_date(gave_up_on, &list);
-		seen_commits--;
-	}
-	seen_commits += finish_depth_computation(&list, &all_matches[0]);
-	free_commit_list(list);
-
-	if (debug) {
-		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
-			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-11s %8d %s\n",
-				prio_names[t->prio], t->depth, t->name);
-		}
-		fprintf(stderr, "traversed %lu commits\n", seen_commits);
-		if (gave_up_on) {
-			fprintf(stderr,
-				"more than %i tags found; listed %i most recent\n"
-				"gave up search at %s\n",
-				max_candidates, max_candidates,
-				sha1_to_hex(gave_up_on->object.sha1));
-		}
-	}
-
-	*depthp = all_matches[0].depth;
-	return all_matches[0].name;
-}
-
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
diff --git a/cache.h b/cache.h
index bfffa05..84423a3 100644
--- a/cache.h
+++ b/cache.h
@@ -602,4 +602,9 @@ extern int diff_auto_refresh_index;
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
+/* describe.c */
+struct commit;
+extern void load_commit_names(int min_prio);
+extern char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp);
+
 #endif /* CACHE_H */
diff --git a/describe.c b/describe.c
new file mode 100644
index 0000000..18c7abc
--- /dev/null
+++ b/describe.c
@@ -0,0 +1,204 @@
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "refs.h"
+
+#define SEEN		(1u<<0)
+#define MAX_TAGS	(FLAG_BITS - 1)
+
+static const char *prio_names[] = {
+	"head", "lightweight", "annotated",
+};
+
+static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct object *object;
+	int min_prio = *((int *)cb_data);
+	int prio;
+
+	if (!commit)
+		return 0;
+	object = parse_object(sha1);
+
+	if (!prefixcmp(path, "refs/tags/")) {
+		if (object->type == OBJ_TAG)
+			prio = 2;
+		else
+			prio = 1;
+	}
+	else
+		prio = 0;
+	if (prio < min_prio)
+		return 0;
+
+	if (commit->name) {
+		if (commit->name_prio >= prio)
+			return 0;
+		free(commit->name);
+	}
+	commit->name = xstrdup(path + 5);
+	commit->name_prio = prio;
+
+	return 0;
+}
+
+void load_commit_names(int min_prio)
+{
+	for_each_ref(get_name, &min_prio);
+}
+
+struct possible_tag {
+	char *name;
+	int prio; /* annotated tag = 2, tag = 1, head = 0 */
+	int depth;
+	int found_order;
+	unsigned flag_within;
+};
+
+static int compare_pt(const void *a_, const void *b_)
+{
+	struct possible_tag *a = (struct possible_tag *)a_;
+	struct possible_tag *b = (struct possible_tag *)b_;
+	if (a->prio != b->prio)
+		return b->prio - a->prio;
+	if (a->depth != b->depth)
+		return a->depth - b->depth;
+	if (a->found_order != b->found_order)
+		return a->found_order - b->found_order;
+	return 0;
+}
+
+static unsigned long finish_depth_computation(
+	struct commit_list **list,
+	struct possible_tag *best)
+{
+	unsigned long seen_commits = 0;
+	while (*list) {
+		struct commit *c = pop_commit(list);
+		struct commit_list *parents = c->parents;
+		seen_commits++;
+		if (c->name_flags & best->flag_within) {
+			struct commit_list *a = *list;
+			while (a) {
+				struct commit *i = a->item;
+				if (!(i->name_flags & best->flag_within))
+					break;
+				a = a->next;
+			}
+			if (!a)
+				break;
+		} else
+			best->depth++;
+		while (parents) {
+			struct commit *p = parents->item;
+			parse_commit(p);
+			if (!(p->name_flags & SEEN))
+				insert_by_date(p, list);
+			p->name_flags |= c->name_flags;
+			parents = parents->next;
+		}
+	}
+	return seen_commits;
+}
+
+char *describe_commit(struct commit *cmit, int max_candidates, int debug, int *depthp)
+{
+	struct commit *gave_up_on = NULL;
+	struct commit_list *list;
+	struct possible_tag all_matches[MAX_TAGS];
+	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
+	unsigned long seen_commits = 0;
+
+	if (cmit->name) {
+		*depthp = 0;
+		return cmit->name;
+	}
+
+	if (debug)
+		fprintf(stderr, "searching...\n");
+
+	if (max_candidates < 1)
+		max_candidates = 1;
+	else if (max_candidates > MAX_TAGS)
+		max_candidates = MAX_TAGS;
+
+	list = NULL;
+	cmit->name_flags = SEEN;
+	commit_list_insert(cmit, &list);
+	while (list) {
+		struct commit *c = pop_commit(&list);
+		struct commit_list *parents = c->parents;
+		seen_commits++;
+		if (c->name) {
+			if (match_cnt < max_candidates) {
+				struct possible_tag *t = &all_matches[match_cnt++];
+				t->name = c->name;
+				t->prio = c->name_prio;
+				t->depth = seen_commits - 1;
+				t->flag_within = 1u << match_cnt;
+				t->found_order = match_cnt;
+				c->name_flags |= t->flag_within;
+				if (c->name_prio == 2)
+					annotated_cnt++;
+			}
+			else {
+				gave_up_on = c;
+				break;
+			}
+		}
+		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t = &all_matches[cur_match];
+			if (!(c->name_flags & t->flag_within))
+				t->depth++;
+		}
+		if (annotated_cnt && !list) {
+			if (debug)
+				fprintf(stderr, "finished search at %s\n",
+					sha1_to_hex(c->object.sha1));
+			break;
+		}
+		while (parents) {
+			struct commit *p = parents->item;
+			parse_commit(p);
+			if (!(p->name_flags & SEEN))
+				insert_by_date(p, &list);
+			p->name_flags |= c->name_flags;
+			parents = parents->next;
+		}
+	}
+
+	if (!match_cnt) {
+		free_commit_list(list);
+		*depthp = -1;
+		return NULL;
+	}
+
+	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
+
+	if (gave_up_on) {
+		insert_by_date(gave_up_on, &list);
+		seen_commits--;
+	}
+	seen_commits += finish_depth_computation(&list, &all_matches[0]);
+	free_commit_list(list);
+
+	if (debug) {
+		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t = &all_matches[cur_match];
+			fprintf(stderr, " %-11s %8d %s\n",
+				prio_names[t->prio], t->depth, t->name);
+		}
+		fprintf(stderr, "traversed %lu commits\n", seen_commits);
+		if (gave_up_on) {
+			fprintf(stderr,
+				"more than %i tags found; listed %i most recent\n"
+				"gave up search at %s\n",
+				max_candidates, max_candidates,
+				sha1_to_hex(gave_up_on->object.sha1));
+		}
+	}
+
+	*depthp = all_matches[0].depth;
+	return all_matches[0].name;
+}
-- 
1.5.3.5.529.ge3d6d
