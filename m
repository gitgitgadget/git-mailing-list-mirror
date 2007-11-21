From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 03:40:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 04:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IugSs-0006mv-CG
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 04:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbXKUDlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 22:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbXKUDlH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 22:41:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:43263 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752477AbXKUDlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 22:41:05 -0500
Received: (qmail invoked by alias); 21 Nov 2007 03:41:03 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 21 Nov 2007 04:41:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lmoxFOoblpqayuMTR0qwPuBTSWdOyF/11AfQv51
	tWhLT7CNOR2df1
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65588>


[WIP: this does not handle tags yet, and it lacks a test script
 as well as documentation.]

This program dumps (parts of) a git repository in the format that
fast-import understands.

For clarity's sake, it does not use the 'inline' method of specifying
blobs in the commits, but builds the blobs before building the commits.B

---
	I am way too tired now to continue, but maybe someone else wants
	to pick up the ball.

	Oh, and it relies on "int" being castable to void * and vice 
	versa.  Is anybody aware of a platform where this can lead to
	problems?

	And yes, I will add a copyright when I woke up again.

 .gitignore            |    1 +
 Makefile              |    1 +
 builtin-fast-export.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    1 +
 git.c                 |    1 +
 5 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100755 builtin-fast-export.c

diff --git a/.gitignore b/.gitignore
index 507e351..ef69e2f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,7 @@ git-diff-files
 git-diff-index
 git-diff-tree
 git-describe
+git-fast-export
 git-fast-import
 git-fetch
 git-fetch--tool
diff --git a/Makefile b/Makefile
index dd3ba6f..8784eff 100644
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,7 @@ BUILTIN_OBJS = \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
+	builtin-fast-export.o \
 	builtin-fetch.o \
 	builtin-fetch-pack.o \
 	builtin-fetch--tool.o \
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
new file mode 100755
index 0000000..2e8e3dd
--- /dev/null
+++ b/builtin-fast-export.c
@@ -0,0 +1,202 @@
+#include "builtin.h"
+#include "cache.h"
+#include "commit.h"
+#include "object.h"
+#include "tag.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "log-tree.h"
+#include "revision.h"
+#include "decorate.h"
+#include "path-list.h"
+
+static struct decoration idnums;
+static uint32_t last_idnum;
+
+static const char *fast_export_usage = "git-fast-export [rev-list-opts]";
+
+static int has_unshown_parent(struct commit *commit)
+{
+	struct commit_list *parent;
+
+	for (parent = commit->parents; parent; parent = parent->next)
+		if (!(parent->item->object.flags & SHOWN))
+			return 1;
+	return 0;
+}
+
+static void handle_object(const unsigned char *sha1)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buf;
+	struct object *object;
+
+	if (is_null_sha1(sha1))
+		return;
+
+	object = parse_object(sha1);
+	if (!object)
+		die ("Could not read blob %s", sha1_to_hex(sha1));
+
+	if (object->flags & SHOWN)
+		return;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		die ("Could not read blob %s", sha1_to_hex(sha1));
+
+	last_idnum++;
+	add_decoration(&idnums, object, (void *)last_idnum);
+
+	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
+	if (fwrite(buf, size, 1, stdout) != 1)
+		die ("Could not write blob %s", sha1_to_hex(sha1));
+	printf("\n");
+
+	object->flags |= SHOWN;
+	free(buf);
+}
+
+static void show_filemodify(struct diff_queue_struct *q,
+		struct diff_options *options, void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *spec = q->queue[i]->two;
+		if (is_null_sha1(spec->sha1))
+			printf("D %s\n", spec->path);
+		else {
+			struct object *object = lookup_object(spec->sha1);
+			printf("M 0%06o :%d %s\n", spec->mode,
+					(int)lookup_decoration(&idnums, object),
+					spec->path);
+		}
+	}
+}
+
+static void handle_commit(struct commit *commit, struct rev_info *rev)
+{
+	const char *author, *author_end, *committer, *committer_end, *message;
+	int saved_output_format = rev->diffopt.output_format;
+	int i;
+
+	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
+
+	parse_commit(commit);
+	author = strstr(commit->buffer, "\nauthor ");
+	if (!author)
+		die ("Could not find author in commit %s",
+				sha1_to_hex(commit->object.sha1));
+	author++;
+	author_end = strchrnul(author, '\n');
+	committer = strstr(author_end, "\ncommitter ");
+	if (!committer)
+		die ("Could not find committer in commit %s",
+				sha1_to_hex(commit->object.sha1));
+	committer++;
+	committer_end = strchrnul(committer, '\n');
+	message = strstr(committer_end, "\n\n");
+	if (message)
+		message += 2;
+
+	if (commit->parents) {
+		parse_commit(commit->parents->item);
+		diff_tree_sha1(commit->parents->item->tree->object.sha1,
+				commit->tree->object.sha1, "", &rev->diffopt);
+	}
+	else
+		diff_root_tree_sha1(commit->tree->object.sha1,
+				"", &rev->diffopt);
+
+	for (i = 0; i < diff_queued_diff.nr; i++)
+		handle_object(diff_queued_diff.queue[i]->two->sha1);
+
+	last_idnum++;
+	add_decoration(&idnums, &commit->object, (void *)last_idnum);
+	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
+		(const char *)commit->util, last_idnum,
+		author_end - author, author,
+		committer_end - committer, committer,
+		message ? strlen(message) : 0, message ? message : "");
+
+	log_tree_diff_flush(rev);
+	rev->diffopt.output_format = saved_output_format;
+
+	printf("\n");
+}
+
+static void handle_tail(struct object_array *commits, struct rev_info *revs)
+{
+	struct commit *commit;
+	while (commits->nr) {
+		commit = (struct commit *)commits->objects[commits->nr - 1].item;
+		if (has_unshown_parent(commit))
+			return;
+		handle_commit(commit, revs);
+		commits->nr--;
+	}
+}
+
+int cmd_fast_export(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	struct object_array commits = { 0, 0, NULL };
+	struct path_list extra_refs = { NULL, 0, 0, 0 };
+	struct commit *commit;
+	int i;
+
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1)
+		usage (fast_export_usage);
+
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		unsigned char sha1[20];
+		char *full_name;
+
+		/* TODO: handle tags */
+		commit = (struct commit *)e->item;
+		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
+			die ("Could not get a unique ref name for '%s'",
+				e->name);
+		if (commit->util)
+			/* more than one name for the same object */
+			path_list_insert(full_name, &extra_refs)->util = commit;
+		else
+			commit->util = full_name;
+	}
+
+	prepare_revision_walk(&revs);
+	revs.diffopt.format_callback = show_filemodify;
+	revs.diffopt.recursive = 1;
+	while ((commit = get_revision(&revs))) {
+		if (has_unshown_parent(commit)) {
+			struct commit_list *parent = commit->parents;
+			add_object_array(&commit->object, NULL, &commits);
+			for (; parent; parent = parent->next)
+				if (!parent->item->util)
+					parent->item->util = commit->util;
+		}
+		else {
+			handle_commit(commit, &revs);
+			handle_tail(&commits, &revs);
+		}
+	}
+
+	if (commits.nr)
+		die ("This should not happen: there were %d commits left!",
+			commits.nr);
+
+	for (i = 0; i < extra_refs.nr; i++) {
+		/* create refs pointing to already seen commits */
+		commit = extra_refs.items[i].util;
+		printf("reset %s\nfrom :%d\n\n",
+				extra_refs.items[i].path,
+				(int)lookup_decoration(&idnums,
+					&commit->object));
+	}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index e76f5da..5723f9e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -31,6 +31,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 0b6825e..deda6dd 100644
--- a/git.c
+++ b/git.c
@@ -301,6 +301,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
-- 
1.5.3.5.1751.gf6fb4
