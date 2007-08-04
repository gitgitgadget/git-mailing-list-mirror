From: Alexandre Julliard <julliard@winehq.org>
Subject: [RFC/PATCH] update-index: Add a --refresh-only option to refresh specified files.
Date: Sat, 04 Aug 2007 11:59:32 +0200
Message-ID: <87odhnk4cb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 11:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHGQK-0006Hl-1k
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 11:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXHDJ7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 05:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbXHDJ7h
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 05:59:37 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:59533 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbXHDJ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 05:59:36 -0400
Received: from adsl-84-226-58-170.adslplus.ch ([84.226.58.170] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IHGQ3-0006Sy-C3
	for git@vger.kernel.org; Sat, 04 Aug 2007 04:59:35 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id EF604429EA1; Sat,  4 Aug 2007 11:59:32 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54817>

This allows to quickly refresh a file that has been touched without
having to stat all the files of the project.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---

Does this look reasonable?  The refresh_index_path() function is a
copy/paste of refresh_index(), I'm not sure all of it is really
needed, but I don't claim to understand all the subtleties of the
index management...


 builtin-update-index.c |   17 +++++++++++++--
 cache.h                |    1 +
 read-cache.c           |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 509369e..ac24ef3 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -22,6 +22,7 @@ static int allow_add;
 static int allow_remove;
 static int allow_replace;
 static int info_only;
+static int refresh_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
@@ -266,8 +267,9 @@ static void chmod_path(int flip, const char *path)
 	die("git-update-index: cannot chmod %cx '%s'", flip, path);
 }
 
-static void update_one(const char *path, const char *prefix, int prefix_length)
+static int update_one(const char *path, const char *prefix, int prefix_length)
 {
+	int has_errors = 0;
 	const char *p = prefix_path(prefix, prefix_length, path);
 	if (!verify_path(p)) {
 		fprintf(stderr, "Ignoring path %s\n", path);
@@ -278,6 +280,10 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
+	if (refresh_only) {
+		has_errors |= refresh_index_path(&the_index, 0, path);
+		goto free_return;
+	}
 	cache_tree_invalidate_path(active_cache_tree, path);
 
 	if (force_remove) {
@@ -292,6 +298,7 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
  free_return:
 	if (p < path || p > path + strlen(path))
 		free((char*)p);
+	return has_errors;
 }
 
 static void read_index_info(int line_termination)
@@ -620,6 +627,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				has_errors |= refresh_cache(REFRESH_REALLY | refresh_flags);
 				continue;
 			}
+			if (!strcmp(path, "--refresh-only")) {
+				refresh_only = 1;
+				continue;
+			}
 			if (!strcmp(path, "--cacheinfo")) {
 				unsigned char sha1[20];
 				unsigned int mode;
@@ -702,7 +713,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			die("unknown option %s", path);
 		}
 		p = prefix_path(prefix, prefix_length, path);
-		update_one(p, NULL, 0);
+		has_errors |= update_one(p, NULL, 0);
 		if (set_executable_bit)
 			chmod_path(set_executable_bit, p);
 		if (p < path || p > path + strlen(path))
@@ -722,7 +733,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			else
 				path_name = buf.buf;
 			p = prefix_path(prefix, prefix_length, path_name);
-			update_one(p, NULL, 0);
+			has_errors |= update_one(p, NULL, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
 			if (p < path_name || p > path_name + strlen(path_name))
diff --git a/cache.h b/cache.h
index e97af18..6982ab4 100644
--- a/cache.h
+++ b/cache.h
@@ -278,6 +278,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 extern int refresh_index(struct index_state *, unsigned int flags);
+extern int refresh_index_path(struct index_state *istate, unsigned int flags, const char *path);
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index e060392..1c0bfe8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -836,6 +836,55 @@ int refresh_index(struct index_state *istate, unsigned int flags)
 	return has_errors;
 }
 
+int refresh_index_path(struct index_state *istate, unsigned int flags, const char *path)
+{
+	int really = (flags & REFRESH_REALLY) != 0;
+	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
+	int quiet = (flags & REFRESH_QUIET) != 0;
+	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
+	struct cache_entry *ce, *new;
+	int cache_errno = 0;
+	int i = index_name_pos(istate, path, strlen(path));
+
+	if (i < 0) {
+		printf("%s: not in index\n", path);
+		return 1;
+	}
+
+	ce = istate->cache[i];
+	if (ce_stage(ce)) {
+		if (allow_unmerged)
+			return 0;
+		printf("%s: needs merge\n", ce->name);
+		return 1;
+	}
+
+	new = refresh_cache_ent(istate, ce, really, &cache_errno);
+	if (new == ce)
+		return 0;
+	if (!new) {
+		if (not_new && cache_errno == ENOENT)
+			return 0;
+		if (really && cache_errno == EINVAL) {
+			/* If we are doing --really-refresh that
+			 * means the index is not valid anymore.
+			 */
+			ce->ce_flags &= ~htons(CE_VALID);
+			istate->cache_changed = 1;
+		}
+		if (quiet)
+			return 0;
+		printf("%s: needs update\n", ce->name);
+		return 1;
+	}
+	istate->cache_changed = 1;
+	/* You can NOT just free istate->cache[i] here, since it
+	 * might not be necessarily malloc()ed but can also come
+	 * from mmap(). */
+	istate->cache[i] = new;
+	return 0;
+}
+
 struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 {
 	return refresh_cache_ent(&the_index, ce, really, NULL);
-- 
1.5.3.rc4

-- 
Alexandre Julliard
julliard@winehq.org
