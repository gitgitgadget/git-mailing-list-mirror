From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-add: Add a --refresh option.
Date: Sat, 11 Aug 2007 12:32:15 +0200
Message-ID: <87bqdeweds.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 12:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJoGr-0004hG-Bn
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbXHKKcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbXHKKcV
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:32:21 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:41869 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbXHKKcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:32:20 -0400
Received: from adsl-89-217-132-200.adslplus.ch ([89.217.132.200] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IJoGY-0000Vc-1I
	for git@vger.kernel.org; Sat, 11 Aug 2007 05:32:18 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7315F1E7174; Sat, 11 Aug 2007 12:32:15 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55604>

This allows to refresh only a subset of the project files, based on
the specified pathspecs.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-add.c |   28 +++++++++++++++++++++++++++-
 cache.h       |    4 ++--
 read-cache.c  |    6 +++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

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
-- 
1.5.3.rc4.70.gf909

-- 
Alexandre Julliard
julliard@winehq.org
