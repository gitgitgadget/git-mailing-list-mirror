From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] list-objects: add "void *data" parameter to show functions
Date: Mon, 6 Apr 2009 21:28:36 +0200
Message-ID: <20090407040854.4338.94304.chriscool@tuxfamily.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:12:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr2fm-0002PG-0T
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 06:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757909AbZDGEK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 00:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757453AbZDGEK2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 00:10:28 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:54007 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757808AbZDGEKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 00:10:23 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 88052D48085;
	Tue,  7 Apr 2009 06:10:12 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 6AB64D4802A;
	Tue,  7 Apr 2009 06:10:10 +0200 (CEST)
X-git-sha1: 6592bba95415a74b93f348a7641e92ad0eef69d8 
X-Mailer: git-mail-commits v0.2
In-Reply-To: <20090407040819.4338.4291.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115903>

The goal of this patch is to get rid of the "static struct rev_info
revs" static variable in "builtin-rev-list.c".

To do that, we need to pass the revs to the "show_commit" function
in "builtin-rev-list.c" and this in turn means that the
"traverse_commit_list" function in "list-objects.c" must be passed
functions pointers to functions with 2 parameters instead of one.

So we have to change all the callers and all the functions passed
to "traverse_commit_list".

Anyway this makes the code more clean and more generic, so it
should be a good thing in the long run.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-pack-objects.c |    6 ++--
 builtin-rev-list.c     |   68 ++++++++++++++++++++++++-----------------------
 list-objects.c         |    9 +++---
 list-objects.h         |    6 ++--
 upload-pack.c          |    6 ++--
 5 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 50f8cc1..8c5eaba 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1901,13 +1901,13 @@ static void read_object_list_from_stdin(void)
 
 #define OBJECT_ADDED (1u<<20)
 
-static void show_commit(struct commit *commit)
+static void show_commit(struct commit *commit, void *data)
 {
 	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |= OBJECT_ADDED;
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object_array_entry *p, void *data)
 {
 	add_preferred_base_object(p->name);
 	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
@@ -2071,7 +2071,7 @@ static void get_object_list(int ac, const char **av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object);
+	traverse_commit_list(&revs, show_commit, show_object, NULL);
 
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index eb34147..cd6f6b8 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -42,72 +42,72 @@ static const char rev_list_usage[] =
 "    --bisect-all"
 ;
 
-static struct rev_info revs;
-
 static int show_timestamp;
 static int hdr_termination;
 static const char *header_prefix;
 
-static void finish_commit(struct commit *commit);
-static void show_commit(struct commit *commit)
+static void finish_commit(struct commit *commit, void *data);
+static void show_commit(struct commit *commit, void *data)
 {
-	graph_show_commit(revs.graph);
+	struct rev_info *revs = data;
+
+	graph_show_commit(revs->graph);
 
 	if (show_timestamp)
 		printf("%lu ", commit->date);
 	if (header_prefix)
 		fputs(header_prefix, stdout);
 
-	if (!revs.graph) {
+	if (!revs->graph) {
 		if (commit->object.flags & BOUNDARY)
 			putchar('-');
 		else if (commit->object.flags & UNINTERESTING)
 			putchar('^');
-		else if (revs.left_right) {
+		else if (revs->left_right) {
 			if (commit->object.flags & SYMMETRIC_LEFT)
 				putchar('<');
 			else
 				putchar('>');
 		}
 	}
-	if (revs.abbrev_commit && revs.abbrev)
-		fputs(find_unique_abbrev(commit->object.sha1, revs.abbrev),
+	if (revs->abbrev_commit && revs->abbrev)
+		fputs(find_unique_abbrev(commit->object.sha1, revs->abbrev),
 		      stdout);
 	else
 		fputs(sha1_to_hex(commit->object.sha1), stdout);
-	if (revs.print_parents) {
+	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
 			printf(" %s", sha1_to_hex(parents->item->object.sha1));
 			parents = parents->next;
 		}
 	}
-	if (revs.children.name) {
+	if (revs->children.name) {
 		struct commit_list *children;
 
-		children = lookup_decoration(&revs.children, &commit->object);
+		children = lookup_decoration(&revs->children, &commit->object);
 		while (children) {
 			printf(" %s", sha1_to_hex(children->item->object.sha1));
 			children = children->next;
 		}
 	}
-	show_decorations(&revs, commit);
-	if (revs.commit_format == CMIT_FMT_ONELINE)
+	show_decorations(revs, commit);
+	if (revs->commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else
 		putchar('\n');
 
-	if (revs.verbose_header && commit->buffer) {
+	if (revs->verbose_header && commit->buffer) {
 		struct strbuf buf = STRBUF_INIT;
-		pretty_print_commit(revs.commit_format, commit,
-				    &buf, revs.abbrev, NULL, NULL,
-				    revs.date_mode, 0);
-		if (revs.graph) {
+		pretty_print_commit(revs->commit_format, commit,
+				    &buf, revs->abbrev, NULL, NULL,
+				    revs->date_mode, 0);
+		if (revs->graph) {
 			if (buf.len) {
-				if (revs.commit_format != CMIT_FMT_ONELINE)
-					graph_show_oneline(revs.graph);
+				if (revs->commit_format != CMIT_FMT_ONELINE)
+					graph_show_oneline(revs->graph);
 
-				graph_show_commit_msg(revs.graph, &buf);
+				graph_show_commit_msg(revs->graph, &buf);
 
 				/*
 				 * Add a newline after the commit message.
@@ -125,7 +125,7 @@ static void show_commit(struct commit *commit)
 				 * format doesn't explicitly end in a newline.)
 				 */
 				if (buf.len && buf.buf[buf.len - 1] == '\n')
-					graph_show_padding(revs.graph);
+					graph_show_padding(revs->graph);
 				putchar('\n');
 			} else {
 				/*
@@ -133,7 +133,7 @@ static void show_commit(struct commit *commit)
 				 * the rest of the graph output for this
 				 * commit.
 				 */
-				if (graph_show_remainder(revs.graph))
+				if (graph_show_remainder(revs->graph))
 					putchar('\n');
 			}
 		} else {
@@ -142,14 +142,14 @@ static void show_commit(struct commit *commit)
 		}
 		strbuf_release(&buf);
 	} else {
-		if (graph_show_remainder(revs.graph))
+		if (graph_show_remainder(revs->graph))
 			putchar('\n');
 	}
 	maybe_flush_or_die(stdout, "stdout");
-	finish_commit(commit);
+	finish_commit(commit, data);
 }
 
-static void finish_commit(struct commit *commit)
+static void finish_commit(struct commit *commit, void *data)
 {
 	if (commit->parents) {
 		free_commit_list(commit->parents);
@@ -159,20 +159,20 @@ static void finish_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void finish_object(struct object_array_entry *p)
+static void finish_object(struct object_array_entry *p, void *data)
 {
 	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
 		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object_array_entry *p, void *data)
 {
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream "git pack-objects" very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
 
-	finish_object(p);
+	finish_object(p, data);
 	if (ep) {
 		printf("%s %.*s\n", sha1_to_hex(p->item->sha1),
 		       (int) (ep - p->name),
@@ -264,7 +264,7 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
 
 	if (flags & BISECT_SHOW_ALL) {
-		traverse_commit_list(revs, show_commit, show_object);
+		traverse_commit_list(revs, show_commit, show_object, revs);
 		printf("------\n");
 	}
 
@@ -297,6 +297,7 @@ int show_bisect_vars(struct rev_info *revs, int reaches, int all, int flags)
 
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
+	struct rev_info revs;
 	struct commit_list *list;
 	int i;
 	int read_from_stdin = 0;
@@ -391,8 +392,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	traverse_commit_list(&revs,
-		quiet ? finish_commit : show_commit,
-		quiet ? finish_object : show_object);
+			     quiet ? finish_commit : show_commit,
+			     quiet ? finish_object : show_object,
+			     &revs);
 
 	return 0;
 }
diff --git a/list-objects.c b/list-objects.c
index c8b8375..208a4cb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -137,8 +137,9 @@ void mark_edges_uninteresting(struct commit_list *list,
 }
 
 void traverse_commit_list(struct rev_info *revs,
-			  void (*show_commit)(struct commit *),
-			  void (*show_object)(struct object_array_entry *))
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *data)
 {
 	int i;
 	struct commit *commit;
@@ -146,7 +147,7 @@ void traverse_commit_list(struct rev_info *revs,
 
 	while ((commit = get_revision(revs)) != NULL) {
 		process_tree(revs, commit->tree, &objects, NULL, "");
-		show_commit(commit);
+		show_commit(commit, data);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
@@ -173,7 +174,7 @@ void traverse_commit_list(struct rev_info *revs,
 		    sha1_to_hex(obj->sha1), name);
 	}
 	for (i = 0; i < objects.nr; i++)
-		show_object(&objects.objects[i]);
+		show_object(&objects.objects[i], data);
 	free(objects.objects);
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
diff --git a/list-objects.h b/list-objects.h
index 0f41391..47fae2e 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,11 +1,11 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
 
-typedef void (*show_commit_fn)(struct commit *);
-typedef void (*show_object_fn)(struct object_array_entry *);
+typedef void (*show_commit_fn)(struct commit *, void *);
+typedef void (*show_object_fn)(struct object_array_entry *, void *);
 typedef void (*show_edge_fn)(struct commit *);
 
-void traverse_commit_list(struct rev_info *revs, show_commit_fn, show_object_fn);
+void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 void mark_edges_uninteresting(struct commit_list *, struct rev_info *, show_edge_fn);
 
diff --git a/upload-pack.c b/upload-pack.c
index 4d7357f..a28a0c4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -66,7 +66,7 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 }
 
 static FILE *pack_pipe = NULL;
-static void show_commit(struct commit *commit)
+static void show_commit(struct commit *commit, void *data)
 {
 	if (commit->object.flags & BOUNDARY)
 		fputc('-', pack_pipe);
@@ -78,7 +78,7 @@ static void show_commit(struct commit *commit)
 	commit->buffer = NULL;
 }
 
-static void show_object(struct object_array_entry *p)
+static void show_object(struct object_array_entry *p, void *data)
 {
 	/* An object with name "foo\n0000000..." can be used to
 	 * confuse downstream git-pack-objects very badly.
@@ -134,7 +134,7 @@ static int do_rev_list(int fd, void *create_full_pack)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, show_object);
+	traverse_commit_list(&revs, show_commit, show_object, NULL);
 	fflush(pack_pipe);
 	fclose(pack_pipe);
 	return 0;
-- 
1.6.2.2.537.g3b83b
