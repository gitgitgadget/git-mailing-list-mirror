X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] support fetching into a shallow repository
Date: Mon, 30 Oct 2006 20:09:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302008520.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:19:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30510>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecWh-0006Cp-Cs for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161462AbWJ3TJV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWJ3TJV
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:09:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:21893 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161433AbWJ3TJU (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:09:20 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:09:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp033) with SMTP; 30 Oct 2006 20:09:13 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


A shallow commit is a commit which has parents, which in turn are
"grafted away", i.e. the commit appears as if it were a root.

Since these shallow commits should not be edited by the user, but
only by core git, they are recorded in the file $GIT_DIR/shallow.

A repository containing shallow commits is called shallow.

The advantage of a shallow repository is that even if the upstream
contains lots of history, your local (shallow) repository needs not
occupy much disk space.

The disadvantage is that you might miss a merge base when pulling
some remote branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile      |    2 +-
 commit.c      |   21 ++++++++++++
 commit.h      |    8 ++++-
 fetch-pack.c  |    4 ++
 shallow.c     |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c |   22 ++++++++++++-
 6 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 28a5d91..5f57aad 100644
--- a/Makefile
+++ b/Makefile
@@ -263,7 +263,7 @@ LIB_OBJS = \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
 	write_or_die.o trace.o list-objects.o grep.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o
+	color.o wt-status.o archive-zip.o archive-tar.o shallow.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/commit.c b/commit.c
index a6d543e..bffa278 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "tag.h"
 #include "commit.h"
+#include "pkt-line.h"
 
 int save_commit_buffer = 1;
 
@@ -221,6 +222,8 @@ static void prepare_commit_graft(void)
 		return;
 	graft_file = get_graft_file();
 	read_graft_file(graft_file);
+	/* make sure shallows are read */
+	is_repository_shallow();
 	commit_graft_prepared = 1;
 }
 
@@ -234,6 +237,24 @@ static struct commit_graft *lookup_commi
 	return commit_graft[pos];
 }
 
+int write_shallow_commits(int fd, int use_pack_protocol)
+{
+	int i, count = 0;
+	for (i = 0; i < commit_graft_nr; i++)
+		if (commit_graft[i]->nr_parent < 0) {
+			const char *hex =
+				sha1_to_hex(commit_graft[i]->sha1);
+			count++;
+			if (use_pack_protocol)
+				packet_write(fd, "shallow %s", hex);
+			else {
+				write(fd, hex,  40);
+				write(fd, "\n", 1);
+			}
+		}
+	return count;
+}
+
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 {
 	char *tail = buffer;
diff --git a/commit.h b/commit.h
index fc13de9..c559510 100644
--- a/commit.h
+++ b/commit.h
@@ -97,7 +97,7 @@ void sort_in_topological_order_fn(struct
 
 struct commit_graft {
 	unsigned char sha1[20];
-	int nr_parent;
+	int nr_parent; /* < 0 if shallow commit */
 	unsigned char parent[FLEX_ARRAY][20]; /* more */
 };
 
@@ -107,4 +107,10 @@ int read_graft_file(const char *graft_fi
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
 
+extern int register_shallow(const unsigned char *sha1);
+extern int write_shallow_commits(int fd, int use_pack_protocol);
+extern int is_repository_shallow();
+extern struct commit_list *get_shallow_commits(struct object_array *heads,
+		int depth);
+
 #endif /* COMMIT_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index 36ea092..488adc9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -177,6 +177,8 @@ static int find_common(int fd[2], unsign
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
+	if (is_repository_shallow())
+		write_shallow_commits(fd[1], 1);
 	packet_flush(fd[1]);
 	if (!fetching)
 		return 1;
@@ -423,6 +425,8 @@ static int fetch_pack(int fd[2], int nr_
 	int status;
 
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
+	if (is_repository_shallow() && !server_supports("shallow"))
+		die("Server does not support shallow clients");
 	if (server_supports("multi_ack")) {
 		if (verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
diff --git a/shallow.c b/shallow.c
new file mode 100644
index 0000000..3cf2127
--- /dev/null
+++ b/shallow.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "commit.h"
+
+static int is_shallow = -1;
+
+int register_shallow(const unsigned char *sha1)
+{
+	struct commit_graft *graft =
+		xmalloc(sizeof(struct commit_graft));
+	struct commit *commit = lookup_commit(sha1);
+
+	hashcpy(graft->sha1, sha1);
+	graft->nr_parent = -1;
+	if (commit && commit->object.parsed)
+		commit->parents = NULL;
+	return register_commit_graft(graft, 0);
+}
+
+int is_repository_shallow()
+{
+	FILE *fp;
+	char buf[1024];
+
+	if (is_shallow >= 0)
+		return is_shallow;
+
+	fp = fopen(git_path("shallow"), "r");
+	if (!fp) {
+		is_shallow = 0;
+		return is_shallow;
+	}
+	is_shallow = 1;
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		unsigned char sha1[20];
+		if (get_sha1_hex(buf, sha1))
+			die("bad shallow line: %s", buf);
+		register_shallow(sha1);
+	}
+	fclose(fp);
+	return is_shallow;
+}
+
+struct commit_list *get_shallow_commits(struct object_array *heads, int depth)
+{
+	int i = 0, cur_depth = 0;
+	struct commit_list *result = NULL;
+	struct object_array stack = {0, 0, NULL};
+	struct commit *commit = NULL;
+
+	while (commit || i < heads->nr || stack.nr) {
+		struct commit_list *p;
+		if (!commit) {
+			if (i < heads->nr) {
+				commit = (struct commit *)
+					heads->objects[i++].item;
+				if (commit->object.type != OBJ_COMMIT) {
+					commit = NULL;
+					continue;
+				}
+				commit->util = xcalloc(1, sizeof(int));
+				cur_depth = 0;
+			} else {
+				commit = (struct commit *)
+					stack.objects[--stack.nr].item;
+				cur_depth = *(int *)commit->util;
+			}
+		}
+		parse_commit(commit);
+		cur_depth++;
+		for (p = commit->parents, commit = NULL; p; p = p->next) {
+			if (!p->item->util) {
+				int *pointer = xmalloc(sizeof(int));
+				p->item->util = pointer;
+				*pointer =  cur_depth;
+			} else {
+				int *pointer = p->item->util;
+				if (cur_depth >= *pointer)
+					continue;
+				*pointer = cur_depth;
+			}
+			if (cur_depth < depth) {
+				if (p->next)
+					add_object_array(&p->item->object,
+							NULL, &stack);
+				else {
+					commit = p->item;
+					cur_depth = *(int *)commit->util;
+				}
+			} else
+				commit_list_insert(p->item, &result);
+		}
+	}
+
+	return result;
+}
+
diff --git a/upload-pack.c b/upload-pack.c
index 7f7df2a..8dd6121 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -486,6 +486,7 @@ static int get_common_commits(void)
 
 static void receive_needs(void)
 {
+	struct object_array shallows = {0, 0, NULL};
 	static char line[1000];
 	int len;
 
@@ -495,8 +496,19 @@ static void receive_needs(void)
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
 		if (!len)
-			return;
+			break;
 
+		if (!strncmp("shallow ", line, 8)) {
+			unsigned char sha1[20];
+			struct object *object;
+			if (get_sha1(line + 8, sha1))
+				die("invalid shallow line: %s", line);
+			object = parse_object(sha1);
+			if (!object)
+				die("did not find object for %s", line);
+			add_object_array(object, NULL, &shallows);
+			continue;
+		}
 		if (strncmp("want ", line, 5) ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
@@ -528,11 +540,17 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (shallows.nr > 0) {
+		int i;
+		for (i = 0; i < shallows.nr; i++)
+			register_shallow(shallows.objects[i].item->sha1);
+	}
 }
 
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band side-band-64k ofs-delta";
+	static const char *capabilities = "multi_ack thin-pack side-band"
+		" side-band-64k ofs-delta shallow";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.4.3.3.gca42
