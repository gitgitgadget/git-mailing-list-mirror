From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] pretty describe: add name info to struct commit
Date: Sun, 04 Nov 2007 12:48:22 +0100
Message-ID: <472DB186.9030909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodyL-000187-TF
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXKDLsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbXKDLsl
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:48:41 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:43764
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752160AbXKDLsk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 06:48:40 -0500
Received: from [10.0.1.201] (p57B7FCFB.dip.t-dialin.net [87.183.252.251])
	by neapel230.server4you.de (Postfix) with ESMTP id 6111B873BA;
	Sun,  4 Nov 2007 12:48:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63387>

This patch prepares the lib'ification of git-describe.  As a library
function, it can't use commit marks or the util field, as they might
already be used by the caller.

Convert all usage of commit marks and the util field to use the three
new members of struct commit (name, name_flags, name_prio) instead.
A new function, clear_commit_name_flags(), should be used to clear
them after the work is done.

add_to_known_names() is merged into get_name(); struct commit_name is
merged into struct possible_tag; loading the name is done once before
describe() is called instead of doing it inside, but protected by a
static variable.

The name unconditionally has the prefix "refs/" cut from it, but not
more, so a prefix of "tags/" remains for names found under
"refs/tags/".  This is dealt with when displaying.  Together with the
change to pass a minimum name "priority" via the cb_data pointer,
this cleans get_name() from any use of global variables, making it
ready to serve as a library function (or rather its wrapper, the new
function load_commit_names()).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-describe.c |  103 ++++++++++++++++++++++------------------------------
 commit.c           |   21 +++++++++++
 commit.h           |    4 ++
 3 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 6eeb9b5..82c25c3 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -20,42 +20,21 @@ static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
 
-struct commit_name {
-	int prio; /* annotated tag = 2, tag = 1, head = 0 */
-	char path[FLEX_ARRAY]; /* more */
-};
 static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
-static void add_to_known_names(const char *path,
-			       struct commit *commit,
-			       int prio)
-{
-	struct commit_name *e = commit->util;
-	if (!e || e->prio < prio) {
-		size_t len = strlen(path)+1;
-		free(e);
-		e = xmalloc(sizeof(struct commit_name) + len);
-		e->prio = prio;
-		memcpy(e->path, path, len);
-		commit->util = e;
-	}
-}
-
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	struct object *object;
+	int min_prio = *((int *)cb_data);
 	int prio;
 
 	if (!commit)
 		return 0;
 	object = parse_object(sha1);
-	/* If --all, then any refs are used.
-	 * If --tags, then any tags are used.
-	 * Otherwise only annotated tags are used.
-	 */
+
 	if (!prefixcmp(path, "refs/tags/")) {
 		if (object->type == OBJ_TAG)
 			prio = 2;
@@ -64,19 +43,28 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	}
 	else
 		prio = 0;
+	if (prio < min_prio)
+		return 0;
 
-	if (!all) {
-		if (!prio)
-			return 0;
-		if (!tags && prio < 2)
+	if (commit->name) {
+		if (commit->name_prio >= prio)
 			return 0;
+		free(commit->name);
 	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
+	commit->name = xstrdup(path + 5);
+	commit->name_prio = prio;
+
 	return 0;
 }
 
+void load_commit_names(int min_prio)
+{
+	for_each_ref(get_name, &min_prio);
+}
+
 struct possible_tag {
-	struct commit_name *name;
+	char *name;
+	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	int depth;
 	int found_order;
 	unsigned flag_within;
@@ -86,8 +74,8 @@ static int compare_pt(const void *a_, const void *b_)
 {
 	struct possible_tag *a = (struct possible_tag *)a_;
 	struct possible_tag *b = (struct possible_tag *)b_;
-	if (a->name->prio != b->name->prio)
-		return b->name->prio - a->name->prio;
+	if (a->prio != b->prio)
+		return b->prio - a->prio;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
 	if (a->found_order != b->found_order)
@@ -104,11 +92,11 @@ static unsigned long finish_depth_computation(
 		struct commit *c = pop_commit(list);
 		struct commit_list *parents = c->parents;
 		seen_commits++;
-		if (c->object.flags & best->flag_within) {
+		if (c->name_flags & best->flag_within) {
 			struct commit_list *a = *list;
 			while (a) {
 				struct commit *i = a->item;
-				if (!(i->object.flags & best->flag_within))
+				if (!(i->name_flags & best->flag_within))
 					break;
 				a = a->next;
 			}
@@ -119,9 +107,9 @@ static unsigned long finish_depth_computation(
 		while (parents) {
 			struct commit *p = parents->item;
 			parse_commit(p);
-			if (!(p->object.flags & SEEN))
+			if (!(p->name_flags & SEEN))
 				insert_by_date(p, list);
-			p->object.flags |= c->object.flags;
+			p->name_flags |= c->name_flags;
 			parents = parents->next;
 		}
 	}
@@ -133,8 +121,6 @@ static void describe(const char *arg, int last_one)
 	unsigned char sha1[20];
 	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
-	static int initialized = 0;
-	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
@@ -145,14 +131,8 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
-	if (!initialized) {
-		initialized = 1;
-		for_each_ref(get_name, NULL);
-	}
-
-	n = cmit->util;
-	if (n) {
-		printf("%s\n", n->path);
+	if (cmit->name) {
+		printf("%s\n", all ? cmit->name : cmit->name + 5);
 		return;
 	}
 
@@ -160,22 +140,22 @@ static void describe(const char *arg, int last_one)
 		fprintf(stderr, "searching to describe %s\n", arg);
 
 	list = NULL;
-	cmit->object.flags = SEEN;
+	cmit->name_flags = SEEN;
 	commit_list_insert(cmit, &list);
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
 		seen_commits++;
-		n = c->util;
-		if (n) {
+		if (c->name) {
 			if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
-				t->name = n;
+				t->name = all ? c->name : c->name + 5;
+				t->prio = c->name_prio;
 				t->depth = seen_commits - 1;
 				t->flag_within = 1u << match_cnt;
 				t->found_order = match_cnt;
-				c->object.flags |= t->flag_within;
-				if (n->prio == 2)
+				c->name_flags |= t->flag_within;
+				if (c->name_prio == 2)
 					annotated_cnt++;
 			}
 			else {
@@ -185,7 +165,7 @@ static void describe(const char *arg, int last_one)
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			if (!(c->object.flags & t->flag_within))
+			if (!(c->name_flags & t->flag_within))
 				t->depth++;
 		}
 		if (annotated_cnt && !list) {
@@ -197,9 +177,9 @@ static void describe(const char *arg, int last_one)
 		while (parents) {
 			struct commit *p = parents->item;
 			parse_commit(p);
-			if (!(p->object.flags & SEEN))
+			if (!(p->name_flags & SEEN))
 				insert_by_date(p, &list);
-			p->object.flags |= c->object.flags;
+			p->name_flags |= c->name_flags;
 			parents = parents->next;
 		}
 	}
@@ -220,8 +200,7 @@ static void describe(const char *arg, int last_one)
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
 			fprintf(stderr, " %-11s %8d %s\n",
-				prio_names[t->name->prio],
-				t->depth, t->name->path);
+				prio_names[t->prio], t->depth, t->name);
 		}
 		fprintf(stderr, "traversed %lu commits\n", seen_commits);
 		if (gave_up_on) {
@@ -233,14 +212,14 @@ static void describe(const char *arg, int last_one)
 		}
 	}
 	if (abbrev == 0)
-		printf("%s\n", all_matches[0].name->path );
+		printf("%s\n", all_matches[0].name);
 	else
-		printf("%s-%d-g%s\n", all_matches[0].name->path,
+		printf("%s-%d-g%s\n", all_matches[0].name,
 		       all_matches[0].depth,
 		       find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
-		clear_commit_marks(cmit, -1);
+		clear_commit_name_flags(cmit);
 }
 
 int cmd_describe(int argc, const char **argv, const char *prefix)
@@ -275,6 +254,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(3 + argc, args, prefix);
 	}
 
+	/* If --all, then any refs are used.
+	 * If --tags, then any tags are used.
+	 * Otherwise only annotated tags are used.
+	 */
+	load_commit_names(all ? 0 : (tags ? 1 : 2));
+
 	if (argc == 0) {
 		describe("HEAD", 1);
 	} else {
diff --git a/commit.c b/commit.c
index ac24266..24b7268 100644
--- a/commit.c
+++ b/commit.c
@@ -460,6 +460,27 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 	}
 }
 
+void clear_commit_name_flags(struct commit *commit)
+{
+	while (commit) {
+		struct commit_list *parents;
+
+		if (!commit->name_flags)
+			return;
+
+		commit->name_flags = 0;
+
+		parents = commit->parents;
+		if (!parents)
+			return;
+
+		while ((parents = parents->next))
+			clear_commit_name_flags(parents->item);
+
+		commit = commit->parents->item;
+	}
+}
+
 /*
  * Generic support for pretty-printing the header
  */
diff --git a/commit.h b/commit.h
index b661503..80e94b9 100644
--- a/commit.h
+++ b/commit.h
@@ -18,6 +18,9 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
+	char *name;
+	unsigned int name_flags;
+	char name_prio;
 };
 
 extern int save_commit_buffer;
@@ -78,6 +81,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
+void clear_commit_name_flags(struct commit *commit);
 
 /*
  * Performs an in-place topological sort of list supplied.
-- 
1.5.3.5.529.ge3d6d
