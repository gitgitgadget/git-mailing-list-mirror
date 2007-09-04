From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive
 files)
Date: Wed, 05 Sep 2007 01:13:55 +0200
Message-ID: <46DDE6B3.8010507@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IShb9-0003LA-0e
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbXIDXOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755036AbXIDXOG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:14:06 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37435
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754336AbXIDXOA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 19:14:00 -0400
Received: from [10.0.1.201] (p508EDAF7.dip.t-dialin.net [80.142.218.247])
	by neapel230.server4you.de (Postfix) with ESMTP id A6DD9873B7;
	Wed,  5 Sep 2007 01:13:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57657>

Junio C Hamano schrieb:
>> Why did it take me that long to come up with such a simple patch?
>> There was a vacation and a feature freeze in between, but above all
>> I was only recently able to convince myself (using ugly code) that
>> format_commit_message() can indeed be made to expand placeholders
>> to git-describe strings..
>=20
> Thanks.  Will take a look.

Here's that ugly code, by the way.  It adds two placeholders, %d for
description and %D for description depth.  Shortcomings of this code:
it adds three members to struct commit, it unconditionally computes
the description when format_commit_message() -- even if the format
string doesn't contain %d and %D, the patch is not nicely split up.
But it convinced me that describe *can* indeed be librarified. :-)

Ren=C3=A9


 Makefile           |    1 +
 builtin-describe.c |  219 +++-----------------------------------------=
-------
 cache.h            |    5 +
 commit.c           |   31 ++++++++
 commit.h           |    5 +
 describe.c         |  170 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 225 insertions(+), 206 deletions(-)

diff --git a/Makefile b/Makefile
index 51af531..7ec95f8 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,7 @@ DIFF_OBJS =3D \
 LIB_OBJS =3D \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o \
+	describe.o \
 	interpolate.o \
 	lockfile.o \
 	patch-ids.o \
diff --git a/builtin-describe.c b/builtin-describe.c
index 669110c..50ec08f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -17,124 +17,13 @@ static int tags;	/* But allow any tags if --tags i=
s specified */
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
=20
-struct commit_name {
-	int prio; /* annotated tag =3D 2, tag =3D 1, head =3D 0 */
-	char path[FLEX_ARRAY]; /* more */
-};
-static const char *prio_names[] =3D {
-	"head", "lightweight", "annotated",
-};
-
-static void add_to_known_names(const char *path,
-			       struct commit *commit,
-			       int prio)
-{
-	struct commit_name *e =3D commit->util;
-	if (!e || e->prio < prio) {
-		size_t len =3D strlen(path)+1;
-		free(e);
-		e =3D xmalloc(sizeof(struct commit_name) + len);
-		e->prio =3D prio;
-		memcpy(e->path, path, len);
-		commit->util =3D e;
-	}
-}
-
-static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
-{
-	struct commit *commit =3D lookup_commit_reference_gently(sha1, 1);
-	struct object *object;
-	int prio;
-
-	if (!commit)
-		return 0;
-	object =3D parse_object(sha1);
-	/* If --all, then any refs are used.
-	 * If --tags, then any tags are used.
-	 * Otherwise only annotated tags are used.
-	 */
-	if (!prefixcmp(path, "refs/tags/")) {
-		if (object->type =3D=3D OBJ_TAG)
-			prio =3D 2;
-		else
-			prio =3D 1;
-	}
-	else
-		prio =3D 0;
-
-	if (!all) {
-		if (!prio)
-			return 0;
-		if (!tags && prio < 2)
-			return 0;
-	}
-	add_to_known_names(all ? path + 5 : path + 10, commit, prio);
-	return 0;
-}
-
-struct possible_tag {
-	struct commit_name *name;
-	int depth;
-	int found_order;
-	unsigned flag_within;
-};
-
-static int compare_pt(const void *a_, const void *b_)
-{
-	struct possible_tag *a =3D (struct possible_tag *)a_;
-	struct possible_tag *b =3D (struct possible_tag *)b_;
-	if (a->name->prio !=3D b->name->prio)
-		return b->name->prio - a->name->prio;
-	if (a->depth !=3D b->depth)
-		return a->depth - b->depth;
-	if (a->found_order !=3D b->found_order)
-		return a->found_order - b->found_order;
-	return 0;
-}
-
-static unsigned long finish_depth_computation(
-	struct commit_list **list,
-	struct possible_tag *best)
-{
-	unsigned long seen_commits =3D 0;
-	while (*list) {
-		struct commit *c =3D pop_commit(list);
-		struct commit_list *parents =3D c->parents;
-		seen_commits++;
-		if (c->object.flags & best->flag_within) {
-			struct commit_list *a =3D *list;
-			while (a) {
-				struct commit *i =3D a->item;
-				if (!(i->object.flags & best->flag_within))
-					break;
-				a =3D a->next;
-			}
-			if (!a)
-				break;
-		} else
-			best->depth++;
-		while (parents) {
-			struct commit *p =3D parents->item;
-			parse_commit(p);
-			if (!(p->object.flags & SEEN))
-				insert_by_date(p, list);
-			p->object.flags |=3D c->object.flags;
-			parents =3D parents->next;
-		}
-	}
-	return seen_commits;
-}
-
 static void describe(const char *arg, int last_one)
 {
 	unsigned char sha1[20];
-	struct commit *cmit, *gave_up_on =3D NULL;
-	struct commit_list *list;
+	struct commit *cmit;
 	static int initialized =3D 0;
-	struct commit_name *n;
-	struct possible_tag all_matches[MAX_TAGS];
-	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
-	unsigned long seen_commits =3D 0;
+	char *name;
+	int depth =3D 0;
=20
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -144,100 +33,23 @@ static void describe(const char *arg, int last_on=
e)
=20
 	if (!initialized) {
 		initialized =3D 1;
-		for_each_ref(get_name, NULL);
-	}
-
-	n =3D cmit->util;
-	if (n) {
-		printf("%s\n", n->path);
-		return;
+		load_commit_names(all ? 0 : (tags ? 1 : 2));
 	}
=20
-	if (debug)
-		fprintf(stderr, "searching to describe %s\n", arg);
-
-	list =3D NULL;
-	cmit->object.flags =3D SEEN;
-	commit_list_insert(cmit, &list);
-	while (list) {
-		struct commit *c =3D pop_commit(&list);
-		struct commit_list *parents =3D c->parents;
-		seen_commits++;
-		n =3D c->util;
-		if (n) {
-			if (match_cnt < max_candidates) {
-				struct possible_tag *t =3D &all_matches[match_cnt++];
-				t->name =3D n;
-				t->depth =3D seen_commits - 1;
-				t->flag_within =3D 1u << match_cnt;
-				t->found_order =3D match_cnt;
-				c->object.flags |=3D t->flag_within;
-				if (n->prio =3D=3D 2)
-					annotated_cnt++;
-			}
-			else {
-				gave_up_on =3D c;
-				break;
-			}
-		}
-		for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
-			struct possible_tag *t =3D &all_matches[cur_match];
-			if (!(c->object.flags & t->flag_within))
-				t->depth++;
-		}
-		if (annotated_cnt && !list) {
-			if (debug)
-				fprintf(stderr, "finished search at %s\n",
-					sha1_to_hex(c->object.sha1));
-			break;
-		}
-		while (parents) {
-			struct commit *p =3D parents->item;
-			parse_commit(p);
-			if (!(p->object.flags & SEEN))
-				insert_by_date(p, &list);
-			p->object.flags |=3D c->object.flags;
-			parents =3D parents->next;
-		}
-	}
-
-	if (!match_cnt)
+	name =3D describe_commit(cmit, max_candidates, &depth);
+	if (!name)
 		die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+	if (!all)
+		name +=3D 5;
=20
-	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
-
-	if (gave_up_on) {
-		insert_by_date(gave_up_on, &list);
-		seen_commits--;
-	}
-	seen_commits +=3D finish_depth_computation(&list, &all_matches[0]);
-	free_commit_list(list);
-
-	if (debug) {
-		for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
-			struct possible_tag *t =3D &all_matches[cur_match];
-			fprintf(stderr, " %-11s %8d %s\n",
-				prio_names[t->name->prio],
-				t->depth, t->name->path);
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
-	if (abbrev =3D=3D 0)
-		printf("%s\n", all_matches[0].name->path );
+	if (abbrev =3D=3D 0 || depth =3D=3D 0)
+		printf("%s\n", name);
 	else
-		printf("%s-%d-g%s\n", all_matches[0].name->path,
-		       all_matches[0].depth,
+		printf("%s-%d-g%s\n", name, depth,
 		       find_unique_abbrev(cmit->object.sha1, abbrev));
=20
 	if (!last_one)
-		clear_commit_marks(cmit, -1);
+		clear_commit_name_flags(cmit);
 }
=20
 int cmd_describe(int argc, const char **argv, const char *prefix)
@@ -263,13 +75,8 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 			if (abbrev !=3D 0 && (abbrev < MINIMUM_ABBREV || 40 < abbrev))
 				abbrev =3D DEFAULT_ABBREV;
 		}
-		else if (!prefixcmp(arg, "--candidates=3D")) {
+		else if (!prefixcmp(arg, "--candidates=3D"))
 			max_candidates =3D strtoul(arg + 13, NULL, 10);
-			if (max_candidates < 1)
-				max_candidates =3D 1;
-			else if (max_candidates > MAX_TAGS)
-				max_candidates =3D MAX_TAGS;
-		}
 		else
 			usage(describe_usage);
 	}
diff --git a/cache.h b/cache.h
index 70abbd5..07ee149 100644
--- a/cache.h
+++ b/cache.h
@@ -600,4 +600,9 @@ extern int diff_auto_refresh_index;
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned=
 char *, int);
=20
+/* describe.c */
+struct commit;
+extern void load_commit_names(int min_prio);
+extern char *describe_commit(struct commit *cmit, int max_candidates, =
int *depthp);
+
 #endif /* CACHE_H */
diff --git a/commit.c b/commit.c
index dc5a064..d2343f2 100644
--- a/commit.c
+++ b/commit.c
@@ -455,6 +455,19 @@ void clear_commit_marks(struct commit *commit, uns=
igned int mark)
 	}
 }
=20
+void clear_commit_name_flags(struct commit *commit)
+{
+	struct commit_list *parents;
+
+	commit->name_flags =3D 0;
+
+	for (parents =3D commit->parents; parents; parents =3D parents->next)=
 {
+		/* Have we already cleared this? */
+		if (parents->item->name_flags)
+			clear_commit_name_flags(parents->item);
+	}
+}
+
 /*
  * Generic support for pretty-printing the header
  */
@@ -819,6 +832,8 @@ static long format_commit_message(const struct comm=
it *commit,
 		{ "%Cblue" },	/* blue */
 		{ "%Creset" },	/* reset color */
 		{ "%n" },	/* newline */
+		{ "%d" },	/* description */
+		{ "%D" },	/* description depth */
 		{ "%m" },	/* left/right/bottom */
 	};
 	enum interp_index {
@@ -837,6 +852,7 @@ static long format_commit_message(const struct comm=
it *commit,
 		IBODY,
 		IRED, IGREEN, IBLUE, IRESET_COLOR,
 		INEWLINE,
+		IDESC, IDESC_DEPTH,
 		ILEFT_RIGHT,
 	};
 	struct commit_list *p;
@@ -920,6 +936,21 @@ static long format_commit_message(const struct com=
mit *commit,
 		if (!table[i].value)
 			interp_set_entry(table, i, "<unknown>");
=20
+	{
+	struct commit *cmit =3D (struct commit *)commit;
+	char *name;
+	char tmp[20];
+	int depth;
+	load_commit_names(2);
+	name =3D describe_commit(cmit, 10, &depth);
+	if (!name)
+		name =3D "";
+	sprintf(tmp, "%d", depth);
+	interp_set_entry(table, IDESC, name);
+	interp_set_entry(table, IDESC_DEPTH, tmp);
+	clear_commit_name_flags(cmit);
+	}
+
 	do {
 		char *buf =3D *buf_p;
 		unsigned long space =3D *space_p;
diff --git a/commit.h b/commit.h
index 467872e..69b6d67 100644
--- a/commit.h
+++ b/commit.h
@@ -17,6 +17,9 @@ struct commit {
 	struct commit_list *parents;
 	struct tree *tree;
 	char *buffer;
+	char *name;
+	unsigned int name_flags;
+	char name_prio;
 };
=20
 extern int save_commit_buffer;
@@ -72,6 +75,8 @@ struct commit *pop_most_recent_commit(struct commit_l=
ist **list,
 struct commit *pop_commit(struct commit_list **stack);
=20
 void clear_commit_marks(struct commit *commit, unsigned int mark);
+void clear_commit_name_flags(struct commit *commit);
+
=20
 /*
  * Performs an in-place topological sort of list supplied.
diff --git a/describe.c b/describe.c
new file mode 100644
index 0000000..acd4517
--- /dev/null
+++ b/describe.c
@@ -0,0 +1,170 @@
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "refs.h"
+
+#define SEEN		(1u<<0)
+#define MAX_TAGS	(FLAG_BITS - 1)
+
+struct possible_tag {
+	char *name;
+	int name_prio;
+	int depth;
+	int found_order;
+	unsigned flag_within;
+};
+
+static int get_name(const char *path, const unsigned char *sha1, int f=
lag,
+                    void *cb_data)
+{
+	struct commit *commit =3D lookup_commit_reference_gently(sha1, 1);
+	if (commit) {
+		struct object *object =3D parse_object(sha1);
+		int min_prio =3D *((int *)cb_data);
+		int prio =3D 0;
+
+		if (!prefixcmp(path, "refs/tags/")) {
+			if (object->type =3D=3D OBJ_TAG)
+				prio =3D 2;
+			else
+				prio =3D 1;
+		}
+
+		if (prio >=3D min_prio &&
+		    (!commit->name || commit->name_prio < prio)) {
+			free(commit->name);
+			commit->name =3D xstrdup(path + 5);
+			commit->name_prio =3D prio;
+		}
+	}
+	return 0;
+}
+
+void load_commit_names(int min_prio)
+{
+	for_each_ref(get_name, &min_prio);
+}
+
+static int compare_pt(const void *a_, const void *b_)
+{
+	struct possible_tag *a =3D (struct possible_tag *)a_;
+	struct possible_tag *b =3D (struct possible_tag *)b_;
+	if (a->name_prio !=3D b->name_prio)
+		return b->name_prio - a->name_prio;
+	if (a->depth !=3D b->depth)
+		return a->depth - b->depth;
+	if (a->found_order !=3D b->found_order)
+		return a->found_order - b->found_order;
+	return 0;
+}
+
+static unsigned long finish_depth_computation(
+	struct commit_list **list,
+	struct possible_tag *best)
+{
+	unsigned long seen_commits =3D 0;
+	while (*list) {
+		struct commit *c =3D pop_commit(list);
+		struct commit_list *parents =3D c->parents;
+		seen_commits++;
+		if (c->name_flags & best->flag_within) {
+			struct commit_list *a =3D *list;
+			while (a) {
+				struct commit *i =3D a->item;
+				if (!(i->name_flags & best->flag_within))
+					break;
+				a =3D a->next;
+			}
+			if (!a)
+				break;
+		} else
+			best->depth++;
+		while (parents) {
+			struct commit *p =3D parents->item;
+			parse_commit(p);
+			if (!(p->name_flags & SEEN))
+				insert_by_date(p, list);
+			p->name_flags |=3D c->name_flags;
+			parents =3D parents->next;
+		}
+	}
+	return seen_commits;
+}
+
+char *describe_commit(struct commit *cmit, int max_candidates, int *de=
pthp)
+{
+	struct commit *gave_up_on =3D NULL;
+	struct commit_list *list;
+	struct possible_tag all_matches[MAX_TAGS];
+	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
+	unsigned long seen_commits =3D 0;
+
+	if (cmit->name) {
+		*depthp =3D 0;
+		return cmit->name;
+	}
+
+	if (max_candidates < 1)
+		max_candidates =3D 1;
+	else if (max_candidates > MAX_TAGS)
+		max_candidates =3D MAX_TAGS;
+
+	list =3D NULL;
+	cmit->name_flags =3D SEEN;
+	commit_list_insert(cmit, &list);
+	while (list) {
+		struct commit *c =3D pop_commit(&list);
+		struct commit_list *parents =3D c->parents;
+		seen_commits++;
+		if (c->name) {
+			if (match_cnt < max_candidates) {
+				struct possible_tag *t =3D &all_matches[match_cnt++];
+				t->name =3D c->name;
+				t->name_prio =3D c->name_prio;
+				t->depth =3D seen_commits - 1;
+				t->flag_within =3D 1u << match_cnt;
+				t->found_order =3D match_cnt;
+				c->name_flags |=3D t->flag_within;
+				if (c->name_prio =3D=3D 2)
+					annotated_cnt++;
+			}
+			else {
+				gave_up_on =3D c;
+				break;
+			}
+		}
+		for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
+			struct possible_tag *t =3D &all_matches[cur_match];
+			if (!(c->name_flags & t->flag_within))
+				t->depth++;
+		}
+		if (annotated_cnt && !list)
+			break;
+		while (parents) {
+			struct commit *p =3D parents->item;
+			parse_commit(p);
+			if (!(p->name_flags & SEEN))
+				insert_by_date(p, &list);
+			p->name_flags |=3D c->name_flags;
+			parents =3D parents->next;
+		}
+	}
+
+	if (!match_cnt) {
+		free_commit_list(list);
+		*depthp =3D -1;
+		return NULL;
+	}
+
+	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
+
+	if (gave_up_on) {
+		insert_by_date(gave_up_on, &list);
+		seen_commits--;
+	}
+	seen_commits +=3D finish_depth_computation(&list, &all_matches[0]);
+	free_commit_list(list);
+
+	*depthp =3D all_matches[0].depth;
+	return all_matches[0].name;
+}
