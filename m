From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 2/3] read-cache.c: Thread lstat error through make_cache_entry signature
Date: Fri, 24 Jan 2014 10:01:02 -0500
Message-ID: <6694dc55c558c4705c6b37d4dd7703aa04788fd7.1390574981.git.brad.king@kitware.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com> <cover.1390574980.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 16:00:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6iFX-0005OZ-Da
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 16:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbaAXPAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 10:00:44 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59097 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752541AbaAXPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 10:00:35 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 9616B9FBA6; Fri, 24 Jan 2014 10:01:03 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390574980.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241012>

Add an 'int *err' argument to make_cache_entry to receive any error
that occurred when matching stat information for a file on disk.
Thread it through to the same argument of refresh_cache_ent.
This will allow callers of make_cache_entry to determine whether
failure was due to a missing file on disk.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 builtin/apply.c    |  2 +-
 builtin/checkout.c |  2 +-
 builtin/reset.c    |  2 +-
 cache.h            |  2 +-
 merge-recursive.c  |  3 ++-
 read-cache.c       | 12 +++++++-----
 resolve-undo.c     |  2 +-
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..15e14ce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3675,7 +3675,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			die("sha1 information is lacking or useless "
 			    "(%s).", name);
 
-		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
+		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0, NULL);
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"), name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..c7338bb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -208,7 +208,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, sha1))
 		die(_("Unable to add merge result for '%s'"), path);
-	ce = make_cache_entry(mode, sha1, path, 2, 0);
+	ce = make_cache_entry(mode, sha1, path, 2, 0, NULL);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..8e0375d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -122,7 +122,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		if (one->mode && !is_null_sha1(one->sha1)) {
 			struct cache_entry *ce;
 			ce = make_cache_entry(one->mode, one->sha1, one->path,
-				0, 0);
+					      0, 0, NULL);
 			if (!ce)
 				die(_("make_cache_entry failed for path '%s'"),
 				    one->path);
diff --git a/cache.h b/cache.h
index c9efe88..8e4f17d 100644
--- a/cache.h
+++ b/cache.h
@@ -487,7 +487,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IMPLICIT_DOT 32	/* internal to "git add -u/-A" */
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
-extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
+extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh, int *err);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
 extern void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
diff --git a/merge-recursive.c b/merge-recursive.c
index a18bd15..4394c44 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -201,7 +201,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, refresh);
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path,
+			      stage, refresh, NULL);
 	if (!ce)
 		return error(_("addinfo_cache failed for path '%s'"), path);
 	return add_cache_entry(ce, options);
diff --git a/read-cache.c b/read-cache.c
index 33dd676..8f16cee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,7 +15,8 @@
 #include "strbuf.h"
 #include "varint.h"
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+					       int really, int* err);
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -696,7 +697,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 
 struct cache_entry *make_cache_entry(unsigned int mode,
 		const unsigned char *sha1, const char *path, int stage,
-		int refresh)
+		int refresh, int* err)
 {
 	int size, len;
 	struct cache_entry *ce;
@@ -717,7 +718,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	ce->ce_mode = create_ce_mode(mode);
 
 	if (refresh)
-		return refresh_cache_entry(ce, 0);
+		return refresh_cache_entry(ce, 0, err);
 
 	return ce;
 }
@@ -1207,9 +1208,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+					       int really, int* err)
 {
-	return refresh_cache_ent(&the_index, ce, really, NULL, NULL);
+	return refresh_cache_ent(&the_index, ce, really, err, NULL);
 }
 
 
diff --git a/resolve-undo.c b/resolve-undo.c
index c09b006..2b7a937 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -144,7 +144,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 		if (!ru->mode[i])
 			continue;
 		nce = make_cache_entry(ru->mode[i], ru->sha1[i],
-				       ce->name, i + 1, 0);
+				       ce->name, i + 1, 0, NULL);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
 		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
-- 
1.8.5.2
