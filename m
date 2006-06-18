From: Linus Torvalds <torvalds@osdl.org>
Subject: Move "void *util" from "struct object" into "struct commit"
Date: Sat, 17 Jun 2006 18:26:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606171815220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 18 03:26:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frm3u-00021c-AN
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 03:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFRB01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 21:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFRB01
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 21:26:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751084AbWFRB00 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 21:26:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5I1QJgt001681
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Jun 2006 18:26:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5I1QIo7005444;
	Sat, 17 Jun 2006 18:26:19 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22045>


Every single user actually wanted this only for commit objects, and we 
have no reason to waste space on it for other object types. So just move 
the structure member from the low-level "struct object" into the "struct 
commit". 

This leaves the commit object the same size, and removes one unnecessary 
pointer from all other object allocations.

This shrinks memory usage (still at a fairly hefty half-gig, admittedly) 
of "git-rev-list --all --objects" on the mozilla repo by another 5% in my 
tests.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is on top of the previous memory usage shrinking patch, and won't 
actually work without it (although if wanted, you can start off with this 
one with some trivial modifications - they are _barely_ interdependent, 
with very little overlap) 

 blame.c               |   48 ++++++++++++++++++++++++------------------------
 builtin-show-branch.c |   24 ++++++++++++------------
 commit.c              |    4 ++--
 commit.h              |    1 +
 name-rev.c            |   12 +++++++++---
 object.h              |    1 -
 6 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/blame.c b/blame.c
index 88bfec2..2dd70ee 100644
--- a/blame.c
+++ b/blame.c
@@ -108,8 +108,8 @@ static struct patch *get_patch(struct co
 	xdemitconf_t xecfg;
 	mmfile_t file_c, file_o;
 	xdemitcb_t ecb;
-	struct util_info *info_c = (struct util_info *)commit->object.util;
-	struct util_info *info_o = (struct util_info *)other->object.util;
+	struct util_info *info_c = (struct util_info *)commit->util;
+	struct util_info *info_o = (struct util_info *)other->util;
 	struct timeval tv_start, tv_end;
 
 	get_blob(commit);
@@ -195,7 +195,7 @@ static int get_blob_sha1_internal(const 
 
 static void get_blob(struct commit *commit)
 {
-	struct util_info *info = commit->object.util;
+	struct util_info *info = commit->util;
 	char type[20];
 
 	if (info->buf)
@@ -221,8 +221,8 @@ #if DEBUG
 /* For debugging only */
 static void print_map(struct commit *cmit, struct commit *other)
 {
-	struct util_info *util = cmit->object.util;
-	struct util_info *util2 = other->object.util;
+	struct util_info *util = cmit->util;
+	struct util_info *util2 = other->util;
 
 	int i;
 	int max =
@@ -257,8 +257,8 @@ #endif
 static void fill_line_map(struct commit *commit, struct commit *other,
 			  struct patch *p)
 {
-	struct util_info *util = commit->object.util;
-	struct util_info *util2 = other->object.util;
+	struct util_info *util = commit->util;
+	struct util_info *util2 = other->util;
 	int *map = util->line_map;
 	int *map2 = util2->line_map;
 	int cur_chunk = 0;
@@ -320,14 +320,14 @@ static void fill_line_map(struct commit 
 
 static int map_line(struct commit *commit, int line)
 {
-	struct util_info *info = commit->object.util;
+	struct util_info *info = commit->util;
 	assert(line >= 0 && line < info->num_lines);
 	return info->line_map[line];
 }
 
 static struct util_info* get_util(struct commit *commit)
 {
-	struct util_info *util = commit->object.util;
+	struct util_info *util = commit->util;
 
 	if (util)
 		return util;
@@ -338,13 +338,13 @@ static struct util_info* get_util(struct
 	util->line_map = NULL;
 	util->num_lines = -1;
 	util->pathname = NULL;
-	commit->object.util = util;
+	commit->util = util;
 	return util;
 }
 
 static int fill_util_info(struct commit *commit)
 {
-	struct util_info *util = commit->object.util;
+	struct util_info *util = commit->util;
 
 	assert(util);
 	assert(util->pathname);
@@ -357,7 +357,7 @@ static int fill_util_info(struct commit 
 
 static void alloc_line_map(struct commit *commit)
 {
-	struct util_info *util = commit->object.util;
+	struct util_info *util = commit->util;
 	int i;
 
 	if (util->line_map)
@@ -381,7 +381,7 @@ static void alloc_line_map(struct commit
 
 static void init_first_commit(struct commit* commit, const char* filename)
 {
-	struct util_info* util = commit->object.util;
+	struct util_info* util = commit->util;
 	int i;
 
 	util->pathname = filename;
@@ -390,7 +390,7 @@ static void init_first_commit(struct com
 
 	alloc_line_map(commit);
 
-	util = commit->object.util;
+	util = commit->util;
 
 	for (i = 0; i < util->num_lines; i++)
 		util->line_map[i] = i;
@@ -411,7 +411,7 @@ static void process_commits(struct rev_i
 	assert(commit);
 	init_first_commit(commit, path);
 
-	util = commit->object.util;
+	util = commit->util;
 	num_blame_lines = util->num_lines;
 	blame_lines = xmalloc(sizeof(struct commit *) * num_blame_lines);
 	blame_contents = util->buf;
@@ -450,7 +450,7 @@ static void process_commits(struct rev_i
 			continue;
 
 		alloc_line_map(commit);
-		util = commit->object.util;
+		util = commit->util;
 
 		for (parents = commit->parents;
 		     parents != NULL; parents = parents->next) {
@@ -510,7 +510,7 @@ static int compare_tree_path(struct rev_
 {
 	int ret;
 	const char* paths[2];
-	struct util_info* util = c2->object.util;
+	struct util_info* util = c2->util;
 	paths[0] = util->pathname;
 	paths[1] = NULL;
 
@@ -539,7 +539,7 @@ static int same_tree_as_empty_path(struc
 
 static const char* find_rename(struct commit* commit, struct commit* parent)
 {
-	struct util_info* cutil = commit->object.util;
+	struct util_info* cutil = commit->util;
 	struct diff_options diff_opts;
 	const char *paths[1];
 	int i;
@@ -583,7 +583,7 @@ static void simplify_commit(struct rev_i
 		return;
 
 	if (!commit->parents) {
-		struct util_info* util = commit->object.util;
+		struct util_info* util = commit->util;
 		if (!same_tree_as_empty_path(revs, commit->tree,
 					     util->pathname))
 			commit->object.flags |= TREECHANGE;
@@ -610,7 +610,7 @@ static void simplify_commit(struct rev_i
 		case REV_TREE_NEW:
 		{
 
-			struct util_info* util = commit->object.util;
+			struct util_info* util = commit->util;
 			if (revs->remove_empty_trees &&
 			    same_tree_as_empty_path(revs, p->tree,
 						    util->pathname)) {
@@ -701,13 +701,13 @@ static const char* format_time(unsigned 
 
 static void topo_setter(struct commit* c, void* data)
 {
-	struct util_info* util = c->object.util;
+	struct util_info* util = c->util;
 	util->topo_data = data;
 }
 
 static void* topo_getter(struct commit* c)
 {
-	struct util_info* util = c->object.util;
+	struct util_info* util = c->util;
 	return util->topo_data;
 }
 
@@ -850,7 +850,7 @@ int main(int argc, const char **argv)
 		struct util_info* u;
 		if (!c)
 			c = initial;
-		u = c->object.util;
+		u = c->util;
 
 		if (!found_rename && strcmp(filename, u->pathname))
 			found_rename = 1;
@@ -868,7 +868,7 @@ int main(int argc, const char **argv)
 		if (!c)
 			c = initial;
 
-		u = c->object.util;
+		u = c->util;
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
 		if(compability) {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index cf9c071..09d8227 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -51,9 +51,9 @@ struct commit_name {
 static void name_commit(struct commit *commit, const char *head_name, int nth)
 {
 	struct commit_name *name;
-	if (!commit->object.util)
-		commit->object.util = xmalloc(sizeof(struct commit_name));
-	name = commit->object.util;
+	if (!commit->util)
+		commit->util = xmalloc(sizeof(struct commit_name));
+	name = commit->util;
 	name->head_name = head_name;
 	name->generation = nth;
 }
@@ -65,8 +65,8 @@ static void name_commit(struct commit *c
  */
 static void name_parent(struct commit *commit, struct commit *parent)
 {
-	struct commit_name *commit_name = commit->object.util;
-	struct commit_name *parent_name = parent->object.util;
+	struct commit_name *commit_name = commit->util;
+	struct commit_name *parent_name = parent->util;
 	if (!commit_name)
 		return;
 	if (!parent_name ||
@@ -80,12 +80,12 @@ static int name_first_parent_chain(struc
 	int i = 0;
 	while (c) {
 		struct commit *p;
-		if (!c->object.util)
+		if (!c->util)
 			break;
 		if (!c->parents)
 			break;
 		p = c->parents->item;
-		if (!p->object.util) {
+		if (!p->util) {
 			name_parent(c, p);
 			i++;
 		}
@@ -106,7 +106,7 @@ static void name_commits(struct commit_l
 	/* First give names to the given heads */
 	for (cl = list; cl; cl = cl->next) {
 		c = cl->item;
-		if (c->object.util)
+		if (c->util)
 			continue;
 		for (i = 0; i < num_rev; i++) {
 			if (rev[i] == c) {
@@ -132,9 +132,9 @@ static void name_commits(struct commit_l
 			struct commit_name *n;
 			int nth;
 			c = cl->item;
-			if (!c->object.util)
+			if (!c->util)
 				continue;
-			n = c->object.util;
+			n = c->util;
 			parents = c->parents;
 			nth = 0;
 			while (parents) {
@@ -142,7 +142,7 @@ static void name_commits(struct commit_l
 				char newname[1000], *en;
 				parents = parents->next;
 				nth++;
-				if (p->object.util)
+				if (p->util)
 					continue;
 				en = newname;
 				switch (n->generation) {
@@ -257,7 +257,7 @@ static void join_revs(struct commit_list
 static void show_one_commit(struct commit *commit, int no_name)
 {
 	char pretty[256], *cp;
-	struct commit_name *name = commit->object.util;
+	struct commit_name *name = commit->util;
 	if (commit->object.parsed)
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
 				    pretty, sizeof(pretty), 0, NULL, NULL);
diff --git a/commit.c b/commit.c
index 11fca55..5914200 100644
--- a/commit.c
+++ b/commit.c
@@ -711,12 +711,12 @@ int count_parents(struct commit * commit
 
 void topo_sort_default_setter(struct commit *c, void *data)
 {
-	c->object.util = data;
+	c->util = data;
 }
 
 void *topo_sort_default_getter(struct commit *c)
 {
-	return c->object.util;
+	return c->util;
 }
 
 /*
diff --git a/commit.h b/commit.h
index c9de167..7c9ca3f 100644
--- a/commit.h
+++ b/commit.h
@@ -11,6 +11,7 @@ struct commit_list {
 
 struct commit {
 	struct object object;
+	void *util;
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
diff --git a/name-rev.c b/name-rev.c
index 1f0135f..c29b93e 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -19,7 +19,7 @@ static void name_rev(struct commit *comm
 		const char *tip_name, int merge_traversals, int generation,
 		int deref)
 {
-	struct rev_name *name = (struct rev_name *)commit->object.util;
+	struct rev_name *name = (struct rev_name *)commit->util;
 	struct commit_list *parents;
 	int parent_number = 1;
 
@@ -41,7 +41,7 @@ static void name_rev(struct commit *comm
 
 	if (name == NULL) {
 		name = xmalloc(sizeof(rev_name));
-		commit->object.util = name;
+		commit->util = name;
 		goto copy_data;
 	} else if (name->merge_traversals > merge_traversals ||
 			(name->merge_traversals == merge_traversals &&
@@ -108,7 +108,13 @@ static int name_ref(const char *path, co
 static const char* get_rev_name(struct object *o)
 {
 	static char buffer[1024];
-	struct rev_name *n = (struct rev_name *)o->util;
+	struct rev_name *n;
+	struct commit *c;
+
+	if (o->type != TYPE_COMMIT)
+		return "undefined";
+	c = (struct commit *) o;
+	n = c->util;
 	if (!n)
 		return "undefined";
 
diff --git a/object.h b/object.h
index a0762b6..f4ee2e5 100644
--- a/object.h
+++ b/object.h
@@ -29,7 +29,6 @@ struct object {
 	unsigned flags : FLAG_BITS;
 	unsigned char sha1[20];
 	struct object_refs *refs;
-	void *util;
 };
 
 extern int track_object_refs;
