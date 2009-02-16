From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Turn the flags in struct dir_struct into a single variable
Date: Mon, 16 Feb 2009 13:20:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161317570.10279@pacific.mpi-cbg.de>
References: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de> <20090215220706.GB4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 13:21:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ2T4-0003KB-IP
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 13:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbZBPMTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 07:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbZBPMTb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 07:19:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:33225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754406AbZBPMTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 07:19:30 -0500
Received: (qmail invoked by alias); 16 Feb 2009 12:19:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 16 Feb 2009 13:19:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193GCtMOqt3qNvsSySMBlvB8nilXB1B6m3QPlA88Q
	/ZVebo3yxa5UQg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090215220706.GB4371@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110175>

By having flags represented as bits in the new member variable 'flags',
it will be easier to use parse_options when dir_struct is involved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 15 Feb 2009, Miklos Vajna wrote:

	> On Sun, Feb 15, 2009 at 09:13:42PM +0100, Johannes Schindelin
	> <Johannes.Schindelin@gmx.de> wrote:
	>
	> > Well, in my juvenile folly I dreamt of turning this into a proper 
	> > bitfield...
	> 
	> Uhm, I think I haven't got what you mean. ;-)

	I meant this...

 builtin-add.c       |    2 +-
 builtin-checkout.c  |    2 +-
 builtin-clean.c     |    4 ++--
 builtin-ls-files.c  |   14 ++++++++------
 builtin-merge.c     |    2 +-
 builtin-read-tree.c |    2 +-
 dir.c               |   17 +++++++++--------
 dir.h               |   12 +++++++-----
 wt-status.c         |    7 +++----
 9 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 7a5a8c7..f2066a1 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -106,7 +106,7 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 	/* Set up the default git porcelain excludes */
 	memset(dir, 0, sizeof(*dir));
 	if (!ignored_too) {
-		dir->collect_ignored = 1;
+		dir->flags |= DIR_COLLECT_IGNORED;
 		setup_standard_excludes(dir);
 	}
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 20b34ce..5b4921d 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -405,7 +405,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.verbose_update = !opts->quiet;
 		topts.fn = twoway_merge;
 		topts.dir = xcalloc(1, sizeof(*topts.dir));
-		topts.dir->show_ignored = 1;
+		topts.dir->flags |= DIR_SHOW_IGNORED;
 		topts.dir->exclude_per_dir = ".gitignore";
 		tree = parse_tree_indirect(old->commit->object.sha1);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
diff --git a/builtin-clean.c b/builtin-clean.c
index f78c2fb..c5ad33d 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -60,7 +60,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
-		dir.show_ignored = 1;
+		dir.flags |= DIR_SHOW_IGNORED;
 
 	if (ignored && ignored_only)
 		die("-x and -X cannot be used together");
@@ -69,7 +69,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		die("clean.requireForce%s set and -n or -f not given; "
 		    "refusing to clean", config_set ? "" : " not");
 
-	dir.show_other_directories = 1;
+	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
 	if (!ignored)
 		setup_standard_excludes(&dir);
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 15f4e97..beb66b7 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -179,7 +179,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			int dtype = ce_to_dtype(ce);
-			if (excluded(dir, ce->name, &dtype) != dir->show_ignored)
+			if (excluded(dir, ce->name, &dtype) !=
+					!!(dir->flags & DIR_SHOW_IGNORED))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -194,7 +195,8 @@ static void show_files(struct dir_struct *dir, const char *prefix)
 			struct stat st;
 			int err;
 			int dtype = ce_to_dtype(ce);
-			if (excluded(dir, ce->name, &dtype) != dir->show_ignored)
+			if (excluded(dir, ce->name, &dtype) !=
+					!!(dir->flags & DIR_SHOW_IGNORED))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
@@ -437,7 +439,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
-			dir.show_ignored = 1;
+			dir.flags |= DIR_SHOW_IGNORED;
 			require_work_tree = 1;
 			continue;
 		}
@@ -455,11 +457,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--directory")) {
-			dir.show_other_directories = 1;
+			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 			continue;
 		}
 		if (!strcmp(arg, "--no-empty-directory")) {
-			dir.hide_empty_directories = 1;
+			dir.flags |= DIR_HIDE_EMPTY_DIRECTORIES;
 			continue;
 		}
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
@@ -551,7 +553,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		ps_matched = xcalloc(1, num);
 	}
 
-	if (dir.show_ignored && !exc_given) {
+	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
 			argv[0]);
 		exit(1);
diff --git a/builtin-merge.c b/builtin-merge.c
index 6d2160d..4c11935 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -636,7 +636,7 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
 	memset(&dir, 0, sizeof(dir));
-	dir.show_ignored = 1;
+	dir.flags |= DIR_SHOW_IGNORED;
 	dir.exclude_per_dir = ".gitignore";
 	opts.dir = &dir;
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 38fef34..8e02738 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -170,7 +170,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 				die("more than one --exclude-per-directory are given.");
 
 			dir = xcalloc(1, sizeof(*opts.dir));
-			dir->show_ignored = 1;
+			dir->flags |= DIR_SHOW_IGNORED;
 			dir->exclude_per_dir = arg + 24;
 			opts.dir = dir;
 			/* We do not need to nor want to do read-directory
diff --git a/dir.c b/dir.c
index b9230c4..56e386b 100644
--- a/dir.c
+++ b/dir.c
@@ -487,14 +487,14 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 		return recurse_into_directory;
 
 	case index_gitdir:
-		if (dir->show_other_directories)
+		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			return ignore_directory;
 		return show_directory;
 
 	case index_nonexistent:
-		if (dir->show_other_directories)
+		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
-		if (!dir->no_gitlinks) {
+		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
 				return show_directory;
@@ -503,7 +503,7 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	}
 
 	/* This is the "show_other_directories" case */
-	if (!dir->hide_empty_directories)
+	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
 	if (!read_directory_recursive(dir, dirname, dirname, len, 1, simplify))
 		return ignore_directory;
@@ -601,7 +601,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 
 			dtype = DTYPE(de);
 			exclude = excluded(dir, fullname, &dtype);
-			if (exclude && dir->collect_ignored
+			if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
 
@@ -609,7 +609,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			 * Excluded? If we don't explicitly want to show
 			 * ignored files, ignore it
 			 */
-			if (exclude && !dir->show_ignored)
+			if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 				continue;
 
 			if (dtype == DT_UNKNOWN)
@@ -621,7 +621,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			 * even if we don't ignore them, since the
 			 * directory may contain files that we do..
 			 */
-			if (!exclude && dir->show_ignored) {
+			if (!exclude && (dir->flags & DIR_SHOW_IGNORED)) {
 				if (dtype != DT_DIR)
 					continue;
 			}
@@ -634,7 +634,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 				len++;
 				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
 				case show_directory:
-					if (exclude != dir->show_ignored)
+					if (exclude != !!(dir->flags
+							& DIR_SHOW_IGNORED))
 						continue;
 					break;
 				case recurse_into_directory:
diff --git a/dir.h b/dir.h
index 8009877..811e865 100644
--- a/dir.h
+++ b/dir.h
@@ -34,11 +34,13 @@ struct exclude_stack {
 struct dir_struct {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
-	unsigned int show_ignored:1,
-		     show_other_directories:1,
-		     hide_empty_directories:1,
-		     no_gitlinks:1,
-		     collect_ignored:1;
+	enum {
+		DIR_SHOW_IGNORED = 1<<0,
+		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
+		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
+		DIR_NO_GITLINKS = 1<<3,
+		DIR_COLLECT_IGNORED = 1<<4
+	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
 
diff --git a/wt-status.c b/wt-status.c
index 96ff2f8..f2eae20 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -250,10 +250,9 @@ static void wt_status_print_untracked(struct wt_status *s)
 
 	memset(&dir, 0, sizeof(dir));
 
-	if (!s->untracked) {
-		dir.show_other_directories = 1;
-		dir.hide_empty_directories = 1;
-	}
+	if (!s->untracked)
+		dir.flags |=
+			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
 
 	read_directory(&dir, ".", "", 0, NULL);
-- 
1.6.2.rc0.392.g7c2ec
