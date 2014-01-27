From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 3/4] read-cache.c: Extend make_cache_entry refresh flag with options
Date: Mon, 27 Jan 2014 09:45:08 -0500
Message-ID: <75285192b54cc1fab5daeef39d399d164efbca40.1390833624.git.brad.king@kitware.com>
References: <cover.1390592626.git.brad.king@kitware.com> <cover.1390833624.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 15:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7nRD-0008Je-FU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 15:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbaA0OpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 09:45:11 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:35755 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539AbaA0Ook (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 09:44:40 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 47BA99FBA7; Mon, 27 Jan 2014 09:45:09 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390833624.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241140>

Convert the make_cache_entry boolean 'refresh' argument to a more
general 'refresh_options' argument.  Pass the value through to the
underlying refresh_cache_ent call.  Add option CE_MATCH_REFRESH to
enable stat refresh.  Update call sites to use the new signature.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 cache.h           |  4 +++-
 merge-recursive.c |  3 ++-
 read-cache.c      | 21 +++++++++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index c96ada7..e8820e1 100644
--- a/cache.h
+++ b/cache.h
@@ -487,7 +487,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IMPLICIT_DOT 32	/* internal to "git add -u/-A" */
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
-extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
+extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
 extern void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
@@ -500,6 +500,8 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
 #define CE_MATCH_IGNORE_SKIP_WORKTREE	04
 /* ignore non-existent files during stat update  */
 #define CE_MATCH_IGNORE_MISSING		0x08
+/* enable stat refresh */
+#define CE_MATCH_REFRESH		0x10
 extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index a18bd15..c3753c8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -201,7 +201,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
+			      (refresh ? CE_MATCH_REFRESH : 0 ));
 	if (!ce)
 		return error(_("addinfo_cache failed for path '%s'"), path);
 	return add_cache_entry(ce, options);
diff --git a/read-cache.c b/read-cache.c
index d61846c..db3902e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,7 +15,8 @@
 #include "strbuf.h"
 #include "varint.h"
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+					       unsigned int options);
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -696,7 +697,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 
 struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage,
-		int refresh)
+		unsigned int refresh_options)
 {
 	int size, len;
 	struct cache_entry *ce;
@@ -716,10 +717,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	if (refresh)
-		return refresh_cache_entry(ce, 0);
-
-	return ce;
+	return refresh_cache_entry(ce, refresh_options);
 }
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
@@ -1029,11 +1027,12 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	struct stat st;
 	struct cache_entry *updated;
 	int changed, size;
+	int refresh = options & CE_MATCH_REFRESH;
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
 
-	if (ce_uptodate(ce))
+	if (!refresh || ce_uptodate(ce))
 		return ce;
 
 	/*
@@ -1130,7 +1129,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
-	unsigned int options = ((really ? CE_MATCH_IGNORE_VALID : 0) |
+	unsigned int options = (CE_MATCH_REFRESH |
+				(really ? CE_MATCH_IGNORE_VALID : 0) |
 				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
 	const char *modified_fmt;
 	const char *deleted_fmt;
@@ -1209,9 +1209,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+					       unsigned int options)
 {
-	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
+	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
 }
 
 
-- 
1.8.5.2
