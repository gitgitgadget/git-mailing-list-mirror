From: Brad King <brad.king@kitware.com>
Subject: [PATCH v3 2/4] read-cache.c: Refactor --ignore-missing implementation
Date: Mon, 27 Jan 2014 09:45:07 -0500
Message-ID: <e8a33f2e20e9f2041bf5f0fa952536755dbdf34c.1390833624.git.brad.king@kitware.com>
References: <cover.1390592626.git.brad.king@kitware.com> <cover.1390833624.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 15:45:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7nRE-0008Je-HK
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 15:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbaA0OpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 09:45:09 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:35751 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753628AbaA0Ook (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 09:44:40 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 44BC79FBA6; Mon, 27 Jan 2014 09:45:09 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390833624.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241141>

Move lstat ENOENT handling from refresh_index to refresh_cache_ent and
activate it with a new CE_MATCH_IGNORE_MISSING option.  This will allow
other call paths into refresh_cache_ent to use the feature.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 cache.h      | 2 ++
 read-cache.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index c9efe88..c96ada7 100644
--- a/cache.h
+++ b/cache.h
@@ -498,6 +498,8 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
 #define CE_MATCH_RACY_IS_DIRTY		02
 /* do stat comparison even if CE_SKIP_WORKTREE is true */
 #define CE_MATCH_IGNORE_SKIP_WORKTREE	04
+/* ignore non-existent files during stat update  */
+#define CE_MATCH_IGNORE_MISSING		0x08
 extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
diff --git a/read-cache.c b/read-cache.c
index 33dd676..d61846c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1031,6 +1031,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int changed, size;
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
+	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
 
 	if (ce_uptodate(ce))
 		return ce;
@@ -1050,6 +1051,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	}
 
 	if (lstat(ce->name, &st) < 0) {
+		if (ignore_missing && errno == ENOENT)
+			return ce;
 		if (err)
 			*err = errno;
 		return NULL;
@@ -1127,7 +1130,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
-	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
+	unsigned int options = ((really ? CE_MATCH_IGNORE_VALID : 0) |
+				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
 	const char *modified_fmt;
 	const char *deleted_fmt;
 	const char *typechange_fmt;
@@ -1176,8 +1180,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (!new) {
 			const char *fmt;
 
-			if (not_new && cache_errno == ENOENT)
-				continue;
 			if (really && cache_errno == EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
-- 
1.8.5.2
