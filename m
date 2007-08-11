From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-add: Add support for --refresh option.
Date: Sat, 11 Aug 2007 23:59:01 +0200
Message-ID: <874pj5wx5m.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 23:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJyzI-0003Uh-Pb
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 23:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760377AbXHKV7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760587AbXHKV7H
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 17:59:07 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:42797 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861AbXHKV7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 17:59:06 -0400
Received: from adsl-89-217-132-200.adslplus.ch ([89.217.132.200] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IJyz9-0005Y0-KI
	for git@vger.kernel.org; Sat, 11 Aug 2007 16:59:04 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 614A1429EA1; Sat, 11 Aug 2007 23:59:01 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55637>

This allows to refresh only a subset of the project files, based on
the specified pathspecs.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---

This time with test and docs...

 Documentation/git-add.txt |    6 +++++-
 builtin-add.c             |   28 +++++++++++++++++++++++++++-
 cache.h                   |    4 ++--
 read-cache.c              |    6 +++++-
 t/t3700-add.sh            |   12 ++++++++++++
 5 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 4af3a9b..dee38f8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,7 @@ git-add - Add file contents to the index
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--refresh] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -66,6 +66,10 @@ OPTIONS
 	command line. If no paths are specified, all tracked files are
 	updated.
 
+\--refresh::
+	Don't add the file(s), but only refresh their stat()
+	information in the index.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
diff --git a/builtin-add.c b/builtin-add.c
index de5c108..82c806a 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -123,6 +123,23 @@ static void update(int verbose, const char **files)
 	run_diff_files(&rev, 0);
 }
 
+static void refresh(int verbose, const char **pathspec)
+{
+	char *seen;
+	int i, specs;
+
+	for (specs = 0; pathspec[specs];  specs++)
+		/* nothing */;
+	seen = xcalloc(specs, 1);
+	if (read_cache() < 0)
+		die("index file corrupt");
+	refresh_index(&the_index, verbose ? 0 : REFRESH_QUIET, pathspec, seen);
+	for (i = 0; i < specs; i++) {
+		if (!seen[i])
+			die("pathspec '%s' did not match any files", pathspec[i]);
+	}
+}
+
 static int git_add_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.excludesfile")) {
@@ -143,7 +160,7 @@ static const char ignore_warning[] =
 int cmd_add(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose = 0, show_only = 0, ignored_too = 0;
+	int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 	const char **pathspec;
 	struct dir_struct dir;
 	int add_interactive = 0;
@@ -191,6 +208,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			take_worktree_changes = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--refresh")) {
+			refresh_only = 1;
+			continue;
+		}
 		usage(builtin_add_usage);
 	}
 
@@ -206,6 +227,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	pathspec = get_pathspec(prefix, argv + i);
 
+	if (refresh_only) {
+		refresh(verbose, pathspec);
+		goto finish;
+	}
+
 	fill_directory(&dir, pathspec, ignored_too);
 
 	if (show_only) {
diff --git a/cache.h b/cache.h
index 4507404..c7e00e7 100644
--- a/cache.h
+++ b/cache.h
@@ -173,7 +173,7 @@ extern struct index_state the_index;
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_file_to_cache(path, verbose) add_file_to_index(&the_index, (path), (verbose))
-#define refresh_cache(flags) refresh_index(&the_index, flags)
+#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
 #define ce_match_stat(ce, st, really) ie_match_stat(&the_index, (ce), (st), (really))
 #define ce_modified(ce, st, really) ie_modified(&the_index, (ce), (st), (really))
 #endif
@@ -278,7 +278,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
-extern int refresh_index(struct index_state *, unsigned int flags);
+extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index 865369d..8b1c94e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "cache-tree.h"
 #include "refs.h"
+#include "dir.h"
 
 /* Index extensions.
  *
@@ -798,7 +799,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	return updated;
 }
 
-int refresh_index(struct index_state *istate, unsigned int flags)
+int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec, char *seen)
 {
 	int i;
 	int has_errors = 0;
@@ -824,6 +825,9 @@ int refresh_index(struct index_state *istate, unsigned int flags)
 			continue;
 		}
 
+		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+			continue;
+
 		new = refresh_cache_ent(istate, ce, really, &cache_errno);
 		if (new == ce)
 			continue;
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 213e924..a328bf5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -143,4 +143,16 @@ test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over st
 	git ls-files --stage | grep "^120000 .* 0	symlink$"
 '
 
+test_expect_success 'git add --refresh' '
+	>foo && git add foo && git commit -a -m "commit all" &&
+	test -z "`git diff-index HEAD -- foo`" &&
+	git read-tree HEAD &&
+	case "`git diff-index HEAD -- foo`" in
+	:100644" "*"M	foo") echo ok;;
+	*) echo fail; (exit 1);;
+	esac &&
+	git add --refresh -- foo &&
+	test -z "`git diff-index HEAD -- foo`"
+'
+
 test_done
-- 
1.5.3.rc4.70.gf909

-- 
Alexandre Julliard
julliard@winehq.org
