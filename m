From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] clean: add a flag to back up cleaned files
Date: Tue, 27 May 2014 16:17:34 +0200
Message-ID: <1401200254-4592-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 16:17:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpICB-0005Xw-2e
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbaE0ORf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 10:17:35 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:63671 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbaE0ORd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 10:17:33 -0400
Received: by mail-we0-f175.google.com with SMTP id p10so798258wes.20
        for <git@vger.kernel.org>; Tue, 27 May 2014 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=egTx0B247ZuFvYKxvRBG/JpFmrMXtY0i6DNZUwVIyf4=;
        b=PKUxOMkc780RO+yIvh9U+8nOvxoCERo17k4CxZHfiqiUcAwklPS4ThgUePeYEpFxQ/
         B1Qu1JJ/JBoFBkim5kf6Q5ft8ydKM60fWynqYJjuKhxwbr/QMdWJAcgftd6GiVUA8KLS
         wpT9OCl0bUbmoCXb3TBBZHZ2a0mXRgpp/plQa5FpYiDaCLOQ/Obr4LfLz0puPrKdIUYp
         jGrAueYm+H2tH7BRHQDXCFmPox8DRaalhhwb9l9RsdzJcMXFQC9kbaFQ22hTSKrHqn+G
         Nhyvz6/9r2MLdPtRWuLrOvsRRMTJXLd8KJasc2j/nkUZaEZ4zbuhwmi+cUx3Iwz6EeRT
         0FnQ==
X-Received: by 10.180.210.174 with SMTP id mv14mr38725337wic.47.1401200251467;
        Tue, 27 May 2014 07:17:31 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id l4sm35355762wjf.14.2014.05.27.07.17.29
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 07:17:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.msysgit.0.161.g83227c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250169>

The combination of "git clean" and fat fingers can some times cause
data-loss, which can be frustrating.

So let's add a flag that imports the files to be deleted into the
object-database, in a way similar to what git-stash does. Maintain
a reflog of the previously backed up clean-runs.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
I've had a similar patch laying around for quite a while, but since
f538a91 ("git-clean: Display more accurate delete messages"), this
patch is a lot less nasty than before. So here you go, perhaps
someone else has fat fingers and hate to lose work?

 Documentation/config.txt    |   4 ++
 Documentation/git-clean.txt |   4 ++
 builtin/clean.c             | 111 +++++++++++++++++++++++++++++++++++++++++++-
 t/t7300-clean.sh            |  12 +++++
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..d58fe31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -797,6 +797,10 @@ clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
 
+clean.backup::
+	A boolean to make git-clean back up files before they are
+	deleted. Defaults to false.
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 8997922..bc9d703 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -41,6 +41,10 @@ OPTIONS
 --interactive::
 	Show what would be done and clean files interactively. See
 	``Interactive mode'' for details.
+-b::
+--backup::
+	Back up files to a reflog before deleting them. The tree of
+	backed up files are stored in the reflog for refs/clean-backup.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 9a91515..96fb4b2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,9 +16,12 @@
 #include "column.h"
 #include "color.h"
 #include "pathspec.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "cache-tree.h"
 
 static int force = -1; /* unset */
-static int interactive;
+static int interactive, backup;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
@@ -120,6 +123,11 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "clean.backup")) {
+		backup = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
 		return 0;
@@ -148,6 +156,93 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int backed_up_anything;
+
+static void backup_file(const char *path, struct stat *st)
+{
+	if (add_to_cache(path, st, 0))
+		die(_("backing up '%s' failed"), path);
+	backed_up_anything = 1;
+}
+
+static struct commit_list *parents;
+
+static void prepare_backup(void)
+{
+	struct unpack_trees_options opts;
+	unsigned char sha1[20];
+	struct tree *tree;
+	struct commit *parent;
+	struct tree_desc t;
+
+	if (get_sha1("HEAD", sha1))
+		die(_("You do not have the initial commit yet"));
+
+	/* prepare parent-list */
+	parent = lookup_commit_or_die(sha1, "HEAD");
+	commit_list_insert(parent, &parents);
+
+	/* load HEAD into the index */
+
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die(_("Failed to unpack tree object %s"), sha1);
+
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = -1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.index_only = 1;
+
+	if (unpack_trees(1, &t, &opts)) {
+		/* We've already reported the error, finish dying */
+		exit(128);
+	}
+}
+
+static void finish_backup(void)
+{
+	const char *ref = "refs/clean-backup";
+	unsigned char commit_sha1[20];
+	struct strbuf msg = STRBUF_INIT;
+	char logfile[PATH_MAX];
+	struct stat st;
+
+	if (!backed_up_anything)
+		return;
+
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree)) {
+		if (cache_tree_update(active_cache_tree,
+		    (const struct cache_entry * const *)active_cache,
+		    active_nr, 0) < 0)
+			die("failed to update cache");
+	}
+
+	strbuf_addstr(&msg, "Automatically committed by git-clean");
+
+	/* create a reflog, if there isn't one */
+	git_snpath(logfile, sizeof(logfile), "logs/%s", ref);
+	if (stat(logfile, &st)) {
+		FILE *fp = fopen(logfile, "w");
+		if (!fp)
+			warning(_("Can not do reflog for '%s'\n"), ref);
+		else
+			fclose(fp);
+	}
+
+	if (commit_tree(&msg, active_cache_tree->sha1, parents, commit_sha1,
+	    NULL, NULL))
+		die("failed to commit :(");
+
+	update_ref(msg.buf, ref, commit_sha1, NULL, 0, DIE_ON_ERR);
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -207,6 +302,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 				*dir_gone = 0;
 			continue;
 		} else {
+			if (backup && !dry_run)
+				backup_file(path->buf, &st);
 			res = dry_run ? 0 : unlink(path->buf);
 			if (!res) {
 				quote_path_relative(path->buf, prefix, &quoted);
@@ -878,6 +975,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
+		OPT_BOOL('b', "backup", &backup,
+				N_("back up files to a reflog before deleting them")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
 		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
 		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
@@ -922,6 +1021,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
+	if (backup && !dry_run)
+		prepare_backup();
+
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
@@ -985,6 +1087,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		} else {
+			if (backup && !dry_run)
+				backup_file(abs_path.buf, &st);
+
 			res = dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
 				qname = quote_path_relative(item->string, NULL, &buf);
@@ -1002,5 +1107,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	strbuf_release(&buf);
 	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
+
+	if (backup && !dry_run)
+		finish_backup();
+
 	return (errors != 0);
 }
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 74de814..27d1d74 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -527,4 +527,16 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_success 'git clean -b' '
+	git reset --hard HEAD &&
+	git clean -dfx &&
+	mkdir -p foobar &&
+	echo "bar" > bar &&
+	echo "baz" > foobar/baz &&
+	git clean -d -f -b &&
+	git diff --name-only refs/clean-backup@{0}^ refs/clean-backup@{0} >actual &&
+	grep bar actual &&
+	grep foobar/baz actual
+'
+
 test_done
-- 
1.9.2.msysgit.0.161.g83227c1
