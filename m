From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Export three helper functions from ls-files
Date: Sun, 18 Nov 2007 02:21:25 -0800
Message-ID: <1195381287-26823-2-git-send-email-gitster@pobox.com>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthHr-0007vO-Lu
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbXKRKVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXKRKVg
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:21:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44237 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbXKRKVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:21:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9C1562EF
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BB4CB96153
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 05:21:53 -0500 (EST)
X-Mailer: git-send-email 1.5.3.5.1815.g9445b
In-Reply-To: <1195381287-26823-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65360>

This exports three helper functions from ls-files.

 * pathspec_match() checks if a given path matches a set of pathspecs
   and optionally records which pathspec was used.  This function used
   to be called "match()" but renamed to be a bit less vague.

 * report_path_error() takes a set of pathspecs and the record
   pathspec_match() above leaves, and gives error message.  This
   was split out of the main function of ls-files.

 * overlay_tree_on_cache() takes a tree-ish (typically "HEAD")
   and overlays it on the current in-core index.  By iterating
   over the resulting index, the caller can find out the paths
   in either the index or the HEAD.  This function used to be
   called "overlay_tree()" but renamed to be a bit more
   descriptive.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-ls-files.c |   98 +++++++++++++++++++++++++++------------------------
 cache.h            |    6 +++
 2 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e0b856f..be485bb 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -38,28 +38,28 @@ static const char *tag_modified = "";
 
 
 /*
- * Match a pathspec against a filename. The first "len" characters
+ * Match a pathspec against a filename. The first "skiplen" characters
  * are the common prefix
  */
-static int match(const char **spec, char *ps_matched,
-		 const char *filename, int len)
+int pathspec_match(const char **spec, char *ps_matched,
+		   const char *filename, int skiplen)
 {
 	const char *m;
 
 	while ((m = *spec++) != NULL) {
-		int matchlen = strlen(m + len);
+		int matchlen = strlen(m + skiplen);
 
 		if (!matchlen)
 			goto matched;
-		if (!strncmp(m + len, filename + len, matchlen)) {
-			if (m[len + matchlen - 1] == '/')
+		if (!strncmp(m + skiplen, filename + skiplen, matchlen)) {
+			if (m[skiplen + matchlen - 1] == '/')
 				goto matched;
-			switch (filename[len + matchlen]) {
+			switch (filename[skiplen + matchlen]) {
 			case '/': case '\0':
 				goto matched;
 			}
 		}
-		if (!fnmatch(m + len, filename + len, 0))
+		if (!fnmatch(m + skiplen, filename + skiplen, 0))
 			goto matched;
 		if (ps_matched)
 			ps_matched++;
@@ -80,7 +80,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	if (len >= ent->len)
 		die("git-ls-files: internal error - directory entry not superset of prefix");
 
-	if (pathspec && !match(pathspec, ps_matched, ent->name, len))
+	if (pathspec && !pathspec_match(pathspec, ps_matched, ent->name, len))
 		return;
 
 	fputs(tag, stdout);
@@ -185,7 +185,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	if (len >= ce_namelen(ce))
 		die("git-ls-files: internal error - cache entry not superset of prefix");
 
-	if (pathspec && !match(pathspec, ps_matched, ce->name, len))
+	if (pathspec && !pathspec_match(pathspec, ps_matched, ce->name, len))
 		return;
 
 	if (tag && *tag && show_valid_bit &&
@@ -331,7 +331,7 @@ static const char *verify_pathspec(const char *prefix)
  * that were given from the command line.  We are not
  * going to write this index out.
  */
-static void overlay_tree(const char *tree_name, const char *prefix)
+void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 {
 	struct tree *tree;
 	unsigned char sha1[20];
@@ -384,6 +384,42 @@ static void overlay_tree(const char *tree_name, const char *prefix)
 	}
 }
 
+int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset)
+{
+	/*
+	 * Make sure all pathspec matched; otherwise it is an error.
+	 */
+	int num, errors = 0;
+	for (num = 0; pathspec[num]; num++) {
+		int other, found_dup;
+
+		if (ps_matched[num])
+			continue;
+		/*
+		 * The caller might have fed identical pathspec
+		 * twice.  Do not barf on such a mistake.
+		 */
+		for (found_dup = other = 0;
+		     !found_dup && pathspec[other];
+		     other++) {
+			if (other == num || !ps_matched[other])
+				continue;
+			if (!strcmp(pathspec[other], pathspec[num]))
+				/*
+				 * Ok, we have a match already.
+				 */
+				found_dup = 1;
+		}
+		if (found_dup)
+			continue;
+
+		error("pathspec '%s' did not match any file(s) known to git.",
+		      pathspec[num] + prefix_offset);
+		errors++;
+	}
+	return errors;
+}
+
 static const char ls_files_usage[] =
 	"git-ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
@@ -563,47 +599,17 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		 */
 		if (show_stage || show_unmerged)
 			die("ls-files --with-tree is incompatible with -s or -u");
-		overlay_tree(with_tree, prefix);
+		overlay_tree_on_cache(with_tree, prefix);
 	}
 	show_files(&dir, prefix);
 
 	if (ps_matched) {
-		/* We need to make sure all pathspec matched otherwise
-		 * it is an error.
-		 */
-		int num, errors = 0;
-		for (num = 0; pathspec[num]; num++) {
-			int other, found_dup;
-
-			if (ps_matched[num])
-				continue;
-			/*
-			 * The caller might have fed identical pathspec
-			 * twice.  Do not barf on such a mistake.
-			 */
-			for (found_dup = other = 0;
-			     !found_dup && pathspec[other];
-			     other++) {
-				if (other == num || !ps_matched[other])
-					continue;
-				if (!strcmp(pathspec[other], pathspec[num]))
-					/*
-					 * Ok, we have a match already.
-					 */
-					found_dup = 1;
-			}
-			if (found_dup)
-				continue;
-
-			error("pathspec '%s' did not match any file(s) known to git.",
-			      pathspec[num] + prefix_offset);
-			errors++;
-		}
-
-		if (errors)
+		int bad;
+		bad = report_path_error(ps_matched, pathspec, prefix_offset);
+		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
 
-		return errors ? 1 : 0;
+		return bad ? 1 : 0;
 	}
 
 	return 0;
diff --git a/cache.h b/cache.h
index f0a25c7..a84f343 100644
--- a/cache.h
+++ b/cache.h
@@ -603,4 +603,10 @@ extern int diff_auto_refresh_index;
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
+
+/* ls-files */
+int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
+int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
+void overlay_tree_on_cache(const char *tree_name, const char *prefix);
+
 #endif /* CACHE_H */
-- 
1.5.3.5.1815.g9445b
