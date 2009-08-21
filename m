From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Fri, 21 Aug 2009 10:57:59 +0200
Message-ID: <1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
 <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 21 10:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MePx4-0006sv-Qz
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbZHUI6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 04:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbZHUI6R
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 04:58:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54925 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbZHUI6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 04:58:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7L8tKTJ025932
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 21 Aug 2009 10:55:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MePwp-00022m-Gb; Fri, 21 Aug 2009 10:58:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MePwp-0000sx-ED; Fri, 21 Aug 2009 10:58:11 +0200
X-Mailer: git-send-email 1.6.4.187.gd399.dirty
In-Reply-To: <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 21 Aug 2009 10:55:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7L8tKTJ025932
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251449721.23684@Dgc580LrswBxtvjzqYw3OA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126696>

git reset without argument displays a summary of the remaining
unstaged changes. The problem with these is that they look like an
error message, and the format is inconsistant with the format used in
other places like "git diff --name-status".

This patch mimics the output of "git diff --name-status", and adds a
header to make it clear the output is informative, and not an error.

It also changes the output of "git add --refresh --verbose" in the same
way.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

In previous version, I hadn't noticed that the same message was
displayed for 'git reset' and for 'git add --refresh --verbose'. This
new version takes both cases into account, and avoids saying "after
reset" when the user called "add".

 builtin-add.c    |    2 +-
 builtin-reset.c  |    3 ++-
 cache.h          |    4 ++--
 read-cache.c     |   26 ++++++++++++++++++++------
 t/t7102-reset.sh |    3 ++-
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index a325bc9..006fd08 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -106,7 +106,7 @@ static void refresh(int verbose, const char **pathspec)
 		/* nothing */;
 	seen = xcalloc(specs, 1);
 	refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
-		      pathspec, seen);
+		      pathspec, seen, "Unstaged changes after refreshing the index:");
 	for (i = 0; i < specs; i++) {
 		if (!seen[i])
 			die("pathspec '%s' did not match any files", pathspec[i]);
diff --git a/builtin-reset.c b/builtin-reset.c
index ddf68d5..0fc0b07 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -108,7 +108,8 @@ static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 	if (read_cache() < 0)
 		return error("Could not read index");
 
-	result = refresh_cache(flags) ? 1 : 0;
+	result = refresh_index(&the_index, (flags), NULL, NULL,
+			       "Unstaged changes after reset:") ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
diff --git a/cache.h b/cache.h
index ae0e83e..fda9816 100644
--- a/cache.h
+++ b/cache.h
@@ -330,7 +330,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
-#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL)
+#define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
@@ -477,7 +477,7 @@ extern int check_path(const char *path, int len, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen);
+extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, char *header_msg);
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index f1aff81..1bbaf1c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1065,7 +1065,18 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	return updated;
 }
 
-int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec, char *seen)
+static void show_file(const char * fmt, const char * name, int in_porcelain,
+		      int * first, char *header_msg)
+{
+	if (in_porcelain && *first && header_msg) {
+		printf("%s\n", header_msg);
+		*first=0;
+	}
+	printf(fmt, name);
+}
+
+int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
+		  char *seen, char *header_msg)
 {
 	int i;
 	int has_errors = 0;
@@ -1074,11 +1085,14 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+	int first = 1;
+	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
-	const char *needs_update_message;
+	const char *needs_update_fmt;
+	const char *needs_merge_fmt;
 
-	needs_update_message = ((flags & REFRESH_IN_PORCELAIN)
-				? "locally modified" : "needs update");
+	needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+	needs_merge_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
@@ -1094,7 +1108,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			i--;
 			if (allow_unmerged)
 				continue;
-			printf("%s: needs merge\n", ce->name);
+			show_file(needs_merge_fmt, ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
@@ -1117,7 +1131,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: %s\n", ce->name, needs_update_message);
+			show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_msg);
 			has_errors = 1;
 			continue;
 		}
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e637c7d..e85ff02 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -419,7 +419,8 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 '
 
 cat > expect << EOF
-file2: locally modified
+Unstaged changes after reset:
+M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
-- 
1.6.4.187.gd399.dirty
