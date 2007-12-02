From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH, next version] Add 'git fast-export', the sister of 'git
 fast-import'
Date: Sun, 2 Dec 2007 14:14:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021410220.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-236771025-1196604853=:27959"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 15:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iypb1-00083V-06
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 15:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbXLBOOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 09:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbXLBOOi
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 09:14:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:44233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750AbXLBOOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 09:14:35 -0500
Received: (qmail invoked by alias); 02 Dec 2007 14:14:33 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp032) with SMTP; 02 Dec 2007 15:14:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Io0ho/PIIA/DzAlZFl5Lc4VZVgMmEfwj9lQTPLb
	j1k264L3JZaud2
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66781>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-236771025-1196604853=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


This program dumps (parts of) a git repository in the format that
fast-import understands.

For clarity's sake, it does not use the 'inline' method of specifying
blobs in the commits, but builds the blobs before building the commits.

Since signed tags' signatures will not necessarily be valid (think
transformations after the export, or excluding revisions, changing
the history), there are 4 modes to handle them: abort (default),
ignore, warn and strip.  The latter just turns the tags into
unsigned ones.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 30 Nov 2007, Junio C Hamano wrote:

	> * js/fast-export (Sun Nov 25 22:37:20 2007 +0100) 1 commit
	>  - Add 'git fast-export', the sister of 'git fast-import'
	> 
	> This needs something like 
	> 9e42d6a1c53dadd409fab11cc76e0eba9ec15365 (sha1_file.c: Fix 
	> size_t related printf format warnings) to compile, I think, but 
	> I haven't tried to fix it (parked in pu)

	How about this instead?

	(It uses ((uint32_t *)NULL) + number, which should be quite 
	portable.)

 .gitignore                        |    1 +
 Documentation/git-fast-export.txt |   83 ++++++++
 Makefile                          |    1 +
 builtin-fast-export.c             |  410 +++++++++++++++++++++++++++++++++++++
 builtin.h                         |    1 +
 t/t9301-fast-export.sh            |  124 +++++++++++
 6 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-fast-export.txt
 create mode 100755 builtin-fast-export.c
 create mode 100755 t/t9301-fast-export.sh

diff --git a/.gitignore b/.gitignore
index 6564618..8694d02 100644
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
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
new file mode 100644
index 0000000..073ff7f
--- /dev/null
+++ b/Documentation/git-fast-export.txt
@@ -0,0 +1,83 @@
+git-fast-export(1)
+==================
+
+NAME
+----
+git-fast-export - Git data exporter
+
+
+SYNOPSIS
+--------
+'git-fast-export [options]' | 'git-fast-import'
+
+DESCRIPTION
+-----------
+This program dumps the given revisions in a form suitable to be piped
+into gitlink:git-fast-import[1].
+
+You can use it as a human readable bundle replacement (see
+gitlink:git-bundle[1]), or as a kind of an interactive
+gitlink:git-filter-branch[1].
+
+
+OPTIONS
+-------
+--progress=<n>::
+	Insert 'progress' statements every <n> objects, to be shown by
+	gitlink:git-fast-import[1] during import.
+
+--signed-tags=(ignore|warn|strip|abort)::
+	Specify how to handle signed tags.  Since any transformation
+	after the export can change the tag names (which can also happen
+	when excluding revisions) the signatures will not match.
++
+When asking to 'abort' (which is the default), this program will die
+when encountering a signed tag.  With 'strip', the tags will be made
+unsigned, with 'ignore', they will be silently ignored (i.e. not exported)
+and with 'warn', they will be exported, but you will see a warning.
+
+
+EXAMPLES
+--------
+
+-------------------------------------------------------------------
+$ git fast-export --all | (cd /empty/repository && git fast-import)
+-------------------------------------------------------------------
+
+This will export the whole repository and import it into the existing
+empty repository.  Except for reencoding commits that are not in
+UTF-8, it would be a one-to-one mirror.
+
+-----------------------------------------------------
+$ git fast-export master~5..master |
+	sed "s|refs/heads/master|refs/heads/other|" |
+	git fast-import
+-----------------------------------------------------
+
+This makes a new branch called 'other' from 'master~5..master'
+(i.e. if 'master' has linear history, it will take the last 5 commits).
+
+Note that this assumes that none of the blobs and commit messages
+referenced by that revision range contains the string
+'refs/heads/master'.
+
+
+Limitations
+-----------
+
+Since gitlink:git-fast-import[1] cannot tag trees, you will not be
+able to export the linux-2.6.git repository completely, as it contains
+a tag referencing a tree instead of a commit.
+
+
+Author
+------
+Written by Johannes E. Schindelin <johannes.schindelin@gmx.de>.
+
+Documentation
+--------------
+Documentation by Johannes E. Schindelin <johannes.schindelin@gmx.de>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 6b9131b..f9a62eb 100644
--- a/Makefile
+++ b/Makefile
@@ -338,6 +338,7 @@ BUILTIN_OBJS = \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
+	builtin-fast-export.o \
 	builtin-fetch.o \
 	builtin-fetch-pack.o \
 	builtin-fetch--tool.o \
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
new file mode 100755
index 0000000..570bce6
--- /dev/null
+++ b/builtin-fast-export.c
@@ -0,0 +1,410 @@
+/*
+ * "git fast-export" builtin command
+ *
+ * Copyright (C) 2007 Johannes E. Schindelin
+ */
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
+#include "utf8.h"
+#include "parse-options.h"
+
+/*
+ * TODO:
+ * - tags (--signed-tags=(ignore|warn|strip|abort)
+ */
+
+static const char *fast_export_usage[] = {
+	"git-fast-export [rev-list-opts]",
+	NULL
+};
+
+static int progress;
+static enum { IGNORE, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
+
+static int parse_opt_signed_tag_mode(const struct option *opt,
+		 const char *arg, int unset)
+{
+	if (unset || !strcmp(arg, "abort"))
+		signed_tag_mode = ABORT;
+	else if (!strcmp(arg, "ignore"))
+		signed_tag_mode = IGNORE;
+	else if (!strcmp(arg, "warn"))
+		signed_tag_mode = WARN;
+	else if (!strcmp(arg, "strip"))
+		signed_tag_mode = STRIP;
+	else
+		return error("Unknown signed-tag mode: %s", arg);
+	return 0;
+}
+
+static struct decoration idnums;
+static uint32_t last_idnum;
+
+static int has_unshown_parent(struct commit *commit)
+{
+	struct commit_list *parent;
+
+	for (parent = commit->parents; parent; parent = parent->next)
+		if (!(parent->item->object.flags & SHOWN) &&
+				!(parent->item->object.flags & UNINTERESTING))
+			return 1;
+	return 0;
+}
+
+/* Since intptr_t is C99, we do not use it here */
+static void mark_object(struct object *object)
+{
+	last_idnum++;
+	add_decoration(&idnums, object, ((uint32_t *)NULL) + last_idnum);
+}
+
+static int get_object_mark(struct object *object)
+{
+	void *decoration = lookup_decoration(&idnums, object);
+	if (!decoration)
+		return 0;
+	return (uint32_t *)decoration - (uint32_t *)NULL;
+}
+
+static void show_progress(void)
+{
+	static int counter = 0;
+	if (!progress)
+		return;
+	if ((++counter % progress) == 0)
+		printf("progress %d objects\n", counter);
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
+	mark_object(object);
+
+	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
+	if (fwrite(buf, size, 1, stdout) != 1)
+		die ("Could not write blob %s", sha1_to_hex(sha1));
+	printf("\n");
+
+	show_progress();
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
+					get_object_mark(object), spec->path);
+		}
+	}
+}
+
+static const char *find_encoding(const char *begin, const char *end)
+{
+	const char *needle = "\nencoding ";
+	char *bol, *eol;
+
+	bol = memmem(begin, end ? end - begin : strlen(begin),
+		needle, strlen(needle));
+	if (!bol)
+		return git_commit_encoding;
+	bol += strlen(needle);
+	eol = strchrnul(bol, '\n');
+	*eol = '\0';
+	return bol;
+}
+
+static void handle_commit(struct commit *commit, struct rev_info *rev)
+{
+	int saved_output_format = rev->diffopt.output_format;
+	const char *author, *author_end, *committer, *committer_end;
+	const char *encoding, *message;
+	char *reencoded = NULL;
+	struct commit_list *p;
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
+	encoding = find_encoding(committer_end, message);
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
+	mark_object(&commit->object);
+	if (!is_encoding_utf8(encoding))
+		reencoded = reencode_string(message, "UTF-8", encoding);
+	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
+		(const char *)commit->util, last_idnum,
+		(int)(author_end - author), author,
+		(int)(committer_end - committer), committer,
+		reencoded ? strlen(reencoded) : message ? strlen(message) : 0,
+		reencoded ? reencoded : message ? message : "");
+	if (reencoded)
+		free(reencoded);
+
+	for (i = 0, p = commit->parents; p; p = p->next) {
+		int mark = get_object_mark(&p->item->object);
+		if (!mark)
+			continue;
+		if (i == 0)
+			printf("from :%d\n", mark);
+		else if (i == 1)
+			printf("merge :%d", mark);
+		else
+			printf(" :%d", mark);
+		i++;
+	}
+	if (i > 1)
+		printf("\n");
+
+	log_tree_diff_flush(rev);
+	rev->diffopt.output_format = saved_output_format;
+
+	printf("\n");
+
+	show_progress();
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
+static void handle_tag(const char *name, struct tag *tag)
+{
+        unsigned long size;
+        enum object_type type;
+	char *buf;
+	const char *tagger, *tagger_end, *message;
+	size_t message_size = 0;
+
+	buf = read_sha1_file(tag->object.sha1, &type, &size);
+	if (!buf)
+		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+	message = memmem(buf, size, "\n\n", 2);
+	if (message) {
+		message += 2;
+		message_size = strlen(message);
+	}
+	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
+	if (!tagger)
+		die ("No tagger for tag %s", sha1_to_hex(tag->object.sha1));
+	tagger++;
+	tagger_end = strchrnul(tagger, '\n');
+
+	/* handle signed tags */
+	if (message) {
+		const char *signature = strstr(message,
+			"\n-----BEGIN PGP SIGNATURE-----\n");
+		if (signature)
+			switch(signed_tag_mode) {
+			case ABORT:
+				die ("Encountered signed tag %s; use "
+					"--signed-tag=<mode> to handle it.",
+					sha1_to_hex(tag->object.sha1));
+			case WARN:
+				warning ("Exporting signed tag %s",
+					sha1_to_hex(tag->object.sha1));
+				/* fallthru */
+			case IGNORE:
+				break;
+			case STRIP:
+				message_size = signature + 1 - message;
+				break;
+			}
+	}
+
+	if (!prefixcmp(name, "refs/tags/"))
+		name += 10;
+	printf("tag %s\nfrom :%d\n%.*s\ndata %d\n%.*s\n",
+		name, get_object_mark(tag->tagged),
+		(int)(tagger_end - tagger), tagger,
+		(int)message_size, message_size, message ? message : "");
+}
+
+static void get_tags_and_duplicates(struct object_array *pending,
+		struct path_list *extra_refs)
+{
+	struct commit *commit;
+	struct tag *tag;
+	int i;
+
+	for (i = 0; i < pending->nr; i++) {
+		struct object_array_entry *e = pending->objects + i;
+		unsigned char sha1[20];
+		char *full_name;
+
+		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
+			continue;
+
+		switch (e->item->type) {
+		case OBJ_COMMIT:
+			commit = (struct commit *)e->item;
+			break;
+		case OBJ_TAG:
+			tag = (struct tag *)e->item;
+			while (tag && tag->object.type == OBJ_TAG) {
+				path_list_insert(full_name, extra_refs)->util
+					= tag;
+				tag = (struct tag *)tag->tagged;
+			}
+			if (!tag)
+				die ("Tag %s points nowhere?", e->name);
+			switch(tag->object.type) {
+			case OBJ_COMMIT:
+				commit = (struct commit *)tag;
+				break;
+			case OBJ_BLOB:
+				handle_object(tag->object.sha1);
+				continue;
+			}
+			break;
+		default:
+			die ("Unexpected object of type %s",
+					typename(e->item->type));
+		}
+		if (commit->util)
+			/* more than one name for the same object */
+			path_list_insert(full_name, extra_refs)->util = commit;
+		else
+			commit->util = full_name;
+	}
+}
+
+static void handle_tags_and_duplicates(struct path_list *extra_refs)
+{
+	struct commit *commit;
+	int i;
+
+	for (i = extra_refs->nr - 1; i >= 0; i--) {
+		const char *name = extra_refs->items[i].path;
+		struct object *object = extra_refs->items[i].util;
+		switch (object->type) {
+		case OBJ_TAG:
+			handle_tag(name, (struct tag *)object);
+			break;
+		case OBJ_COMMIT:
+			/* create refs pointing to already seen commits */
+			commit = (struct commit *)object;
+			printf("reset %s\nfrom :%d\n\n", name,
+					get_object_mark(&commit->object));
+			show_progress();
+			break;
+		}
+	}
+}
+
+int cmd_fast_export(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	struct object_array commits = { 0, 0, NULL };
+	struct path_list extra_refs = { NULL, 0, 0, 0 };
+	struct commit *commit;
+	struct option options[] = {
+		OPT_INTEGER(0, "progress", &progress,
+				"show progress after <n> objects"),
+		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
+				"select handling of signed tags",
+				parse_opt_signed_tag_mode),
+		OPT_END()
+	};
+
+	/* we handle encodings */
+	git_config(git_default_config);
+
+	init_revisions(&revs, prefix);
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = parse_options(argc, argv, options, fast_export_usage, 0);
+	if (argc > 1)
+		usage_with_options (fast_export_usage, options);
+
+	get_tags_and_duplicates(&revs.pending, &extra_refs);
+
+	prepare_revision_walk(&revs);
+	revs.diffopt.format_callback = show_filemodify;
+	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
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
+	handle_tags_and_duplicates(&extra_refs);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 3055bcc..142ab63 100644
--- a/builtin.h
+++ b/builtin.h
@@ -33,6 +33,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
new file mode 100755
index 0000000..59f6996
--- /dev/null
+++ b/t/t9301-fast-export.sh
@@ -0,0 +1,124 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='git-fast-export'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	echo Wohlauf > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo die Luft > file &&
+	echo geht frisch > file2 &&
+	git add file file2 &&
+	test_tick &&
+	git commit -m second &&
+	echo und > file2 &&
+	test_tick &&
+	git commit -m third file2 &&
+	test_tick &&
+	git tag rein &&
+	git checkout -b wer HEAD^ &&
+	echo lange > file2
+	test_tick &&
+	git commit -m sitzt file2 &&
+	test_tick &&
+	git tag -a -m valentin muss &&
+	git merge -s ours master
+
+'
+
+test_expect_success 'fast-export | fast-import' '
+
+	MASTER=$(git rev-parse --verify master) &&
+	REIN=$(git rev-parse --verify rein) &&
+	WER=$(git rev-parse --verify wer) &&
+	MUSS=$(git rev-parse --verify muss) &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	git fast-export --all |
+	(cd new &&
+	 git fast-import &&
+	 test $MASTER = $(git rev-parse --verify refs/heads/master) &&
+	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
+	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
+	 test $MUSS = $(git rev-parse --verify refs/tags/muss))
+
+'
+
+test_expect_success 'fast-export master~2..master' '
+
+	git fast-export master~2..master |
+		sed "s/master/partial/" |
+		(cd new &&
+		 git fast-import &&
+		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
+		 git diff master..partial &&
+		 git diff master^..partial^ &&
+		 ! git rev-parse partial~2)
+
+'
+
+test_expect_success 'iso-8859-1' '
+
+        git config i18n.commitencoding ISO-8859-1 &&
+        # use author and committer name in ISO-8859-1 to match it.
+        . ../t3901-8859-1.txt &&
+        test_tick &&
+        echo rosten >file &&
+        git commit -s -m den file &&
+	git fast-export wer^..wer |
+		sed "s/wer/i18n/" |
+		(cd new &&
+		 git fast-import &&
+		 git cat-file commit i18n | grep "Áéí óú")
+
+'
+
+cat > signed-tag-import << EOF
+tag sign-your-name
+from $(git rev-parse HEAD)
+tagger C O Mitter <committer@example.com> 1112911993 -0700
+data 210
+A message for a sign
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1.4.5 (GNU/Linux)
+
+fakedsignaturefakedsignaturefakedsignaturefakedsignaturfakedsign
+aturefakedsignaturefake=
+=/59v
+-----END PGP SIGNATURE-----
+EOF
+
+test_expect_success 'set up faked signed tag' '
+
+	cat signed-tag-import | git fast-import
+
+'
+
+test_expect_success 'signed-tags=abort' '
+
+	! git fast-export --signed-tags=abort sign-your-name
+
+'
+
+test_expect_success 'signed-tags=ignore' '
+
+	git fast-export --signed-tags=ignore sign-your-name > output &&
+	grep PGP output
+
+'
+
+test_expect_success 'signed-tags=strip' '
+
+	git fast-export --signed-tags=strip sign-your-name > output &&
+	! grep PGP output
+
+'
+
+test_done
+
-- 
1.5.3.6.2112.ge2263

---1463811741-236771025-1196604853=:27959--
