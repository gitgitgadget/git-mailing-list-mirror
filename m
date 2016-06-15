From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 11/16] refs: convert for_each_rawref to struct object_id.
Date: Wed, 22 Apr 2015 23:24:16 +0000
Message-ID: <1429745061-295908-12-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl411-000415-DV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585AbbDVXYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44788 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758581AbbDVXYe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:34 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 46434282A6;
	Wed, 22 Apr 2015 23:24:33 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267663>

Convert callbacks to use struct object_id internally as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/branch.c       |  4 ++--
 builtin/describe.c     | 12 ++++++------
 builtin/for-each-ref.c |  4 ++--
 builtin/fsck.c         | 16 ++++++++--------
 refs.c                 | 10 +++++-----
 refs.h                 |  2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 258fe2f..ee3e909 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -328,7 +328,7 @@ static int match_patterns(const char **pattern, const char *refname)
 	return 0;
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int append_ref(const char *refname, const struct object_id *oid, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
 	struct ref_list *ref_list = cb->ref_list;
@@ -365,7 +365,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
-		commit = lookup_commit_reference_gently(sha1, 1);
+		commit = lookup_commit_reference_gently(oid->hash, 1);
 		if (!commit) {
 			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
 			return 0;
diff --git a/builtin/describe.c b/builtin/describe.c
index e00a75b..a36c829 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -119,10 +119,10 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	int is_tag = starts_with(path, "refs/tags/");
-	unsigned char peeled[20];
+	struct object_id peeled;
 	int is_annotated, prio;
 
 	/* Reject anything outside refs/tags/ unless --all */
@@ -134,10 +134,10 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 		return 0;
 
 	/* Is it annotated? */
-	if (!peel_ref(path, peeled)) {
-		is_annotated = !!hashcmp(sha1, peeled);
+	if (!peel_ref(path, peeled.hash)) {
+		is_annotated = !!oidcmp(oid, &peeled);
 	} else {
-		hashcpy(peeled, sha1);
+		oidcpy(&peeled, oid);
 		is_annotated = 0;
 	}
 
@@ -154,7 +154,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	else
 		prio = 0;
 
-	add_to_known_names(all ? path + 5 : path + 10, peeled, prio, sha1);
+	add_to_known_names(all ? path + 5 : path + 10, peeled.hash, prio, oid->hash);
 	return 0;
 }
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..50c3fbe 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -840,7 +840,7 @@ struct grab_ref_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int grab_single_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
@@ -878,7 +878,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, sha1);
+	hashcpy(ref->objectname, oid->hash);
 	ref->flag = flag;
 
 	cnt = cb->grab_cnt;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4783896..85238a7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -25,7 +25,7 @@ static int include_reflogs = 1;
 static int check_full = 1;
 static int check_strict;
 static int keep_cache_objects;
-static unsigned char head_sha1[20];
+static struct object_id head_oid;
 static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
@@ -482,13 +482,13 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 	return 0;
 }
 
-static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct object *obj;
 
-	obj = parse_object(sha1);
+	obj = parse_object(oid->hash);
 	if (!obj) {
-		error("%s: invalid sha1 pointer %s", refname, sha1_to_hex(sha1));
+		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
 		return 0;
@@ -504,8 +504,8 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 
 static void get_default_heads(void)
 {
-	if (head_points_at && !is_null_sha1(head_sha1))
-		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
+	if (head_points_at && !is_null_oid(&head_oid))
+		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
@@ -556,7 +556,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, head_sha1, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
@@ -565,7 +565,7 @@ static int fsck_head_link(void)
 	else if (!starts_with(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
-	if (is_null_sha1(head_sha1)) {
+	if (is_null_oid(&head_oid)) {
 		if (null_is_error)
 			return error("HEAD: detached HEAD points at nothing");
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
diff --git a/refs.c b/refs.c
index 19ce65a..185b40f 100644
--- a/refs.c
+++ b/refs.c
@@ -1838,17 +1838,17 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to;
-	unsigned char junk[20];
+	struct object_id junk;
 
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, 0, junk, NULL);
+	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -2125,9 +2125,9 @@ int for_each_glob_ref(each_ref_fn_oid fn, const char *pattern, void *cb_data)
 	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+int for_each_rawref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref(&ref_cache, "", fn, 0,
+	return do_for_each_ref_oid(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
diff --git a/refs.h b/refs.h
index 2b2a688..6df7d8a 100644
--- a/refs.h
+++ b/refs.h
@@ -113,7 +113,7 @@ static inline const char *has_glob_specials(const char *pattern)
 }
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn, void *);
+extern int for_each_rawref(each_ref_fn_oid, void *);
 
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
-- 
2.3.5
