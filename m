From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 14/16] refs: rename each_ref_fn_oid to each_ref_fn
Date: Wed, 22 Apr 2015 23:24:19 +0000
Message-ID: <1429745061-295908-15-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl412-000415-0L
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbbDVXYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44809 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758588AbbDVXYh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DF338282A7;
	Wed, 22 Apr 2015 23:24:35 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267667>

each_ref_fn is no longer used, so rename each_ref_fn_oid to each_ref_fn.
Update the documentation to note the change in function signature.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/api-ref-iteration.txt |  2 +-
 refs.c                                        | 48 +++++++++++++--------------
 refs.h                                        | 44 +++++++++++-------------
 revision.c                                    |  6 ++--
 4 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 02adfd4..37379d8 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -6,7 +6,7 @@ Iteration of refs is done by using an iterate function which will call a
 callback function for every ref. The callback function has this
 signature:
 
-	int handle_one_ref(const char *refname, const unsigned char *sha1,
+	int handle_one_ref(const char *refname, const struct object_id *oid,
 			   int flags, void *cb_data);
 
 There are different kinds of iterate functions which all take a
diff --git a/refs.c b/refs.c
index 38ecc2a..9e61b32 100644
--- a/refs.c
+++ b/refs.c
@@ -693,7 +693,7 @@ struct ref_entry_cb {
 	const char *base;
 	int trim;
 	int flags;
-	each_ref_fn_oid *fn;
+	each_ref_fn *fn;
 	void *cb_data;
 };
 
@@ -1669,7 +1669,7 @@ char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, in
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-	each_ref_fn_oid *fn;
+	each_ref_fn *fn;
 	void *cb_data;
 };
 
@@ -1943,7 +1943,7 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * 0.
  */
 static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn_oid fn, int trim, int flags, void *cb_data)
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
@@ -1960,7 +1960,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
@@ -1978,73 +1978,73 @@ static int do_head_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn_oid fn, void *cb_data)
+int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn_oid fn, void *cb_data)
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn_oid fn, void *cb_data)
+		each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
 }
 
-int for_each_branch_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
 
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
-int for_each_remote_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
 
-int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data)
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
@@ -2059,7 +2059,7 @@ int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data)
 	return ret;
 }
 
-int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -2069,7 +2069,7 @@ int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn_oid fn, const char *pattern,
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
@@ -2099,12 +2099,12 @@ int for_each_glob_ref_in(each_ref_fn_oid fn, const char *pattern,
 	return ret;
 }
 
-int for_each_glob_ref(each_ref_fn_oid fn, const char *pattern, void *cb_data)
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 {
 	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
 }
 
-int for_each_rawref(each_ref_fn_oid fn, void *cb_data)
+int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3484,7 +3484,7 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
  * must be empty or end with '/'.  Name will be used as a scratch
  * space, but its contents will be restored before return.
  */
-static int do_for_each_reflog(struct strbuf *name, each_ref_fn_oid fn, void *cb_data)
+static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data)
 {
 	DIR *d = opendir(git_path("logs/%s", name->buf));
 	int retval = 0;
@@ -3524,7 +3524,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn_oid fn, void *cb_
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn_oid fn, void *cb_data)
+int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
diff --git a/refs.h b/refs.h
index abdfb00..0bd2fce 100644
--- a/refs.h
+++ b/refs.h
@@ -69,12 +69,6 @@ struct ref_transaction;
  * single callback invocation.
  */
 typedef int each_ref_fn(const char *refname,
-			const unsigned char *sha1, int flags, void *cb_data);
-
-/*
- * Like each_ref_fn, but passes the object ID using a struct.
- */
-typedef int each_ref_fn_oid(const char *refname,
 			const struct object_id *oid, int flags, void *cb_data);
 
 /*
@@ -86,26 +80,26 @@ typedef int each_ref_fn_oid(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn_oid, void *);
-extern int for_each_ref(each_ref_fn_oid, void *);
-extern int for_each_ref_in(const char *, each_ref_fn_oid, void *);
-extern int for_each_tag_ref(each_ref_fn_oid, void *);
-extern int for_each_branch_ref(each_ref_fn_oid, void *);
-extern int for_each_remote_ref(each_ref_fn_oid, void *);
-extern int for_each_replace_ref(each_ref_fn_oid, void *);
-extern int for_each_glob_ref(each_ref_fn_oid, const char *pattern, void *);
-extern int for_each_glob_ref_in(each_ref_fn_oid, const char *pattern, const char* prefix, void *);
+extern int head_ref(each_ref_fn, void *);
+extern int for_each_ref(each_ref_fn, void *);
+extern int for_each_ref_in(const char *, each_ref_fn, void *);
+extern int for_each_tag_ref(each_ref_fn, void *);
+extern int for_each_branch_ref(each_ref_fn, void *);
+extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
+extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
-extern int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
-extern int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
+extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn_oid fn, void *cb_data);
-extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
-extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
-extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
+		each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 
-extern int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data);
-extern int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data);
+extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
+extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
@@ -113,7 +107,7 @@ static inline const char *has_glob_specials(const char *pattern)
 }
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn_oid, void *);
+extern int for_each_rawref(each_ref_fn, void *);
 
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
@@ -222,7 +216,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
-extern int for_each_reflog(each_ref_fn_oid, void *);
+extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
diff --git a/revision.c b/revision.c
index 94eb94b..6d92c0e 100644
--- a/revision.c
+++ b/revision.c
@@ -1264,7 +1264,7 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 }
 
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
-		int (*for_each)(const char *, each_ref_fn_oid, void *))
+		int (*for_each)(const char *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 	init_all_refs_cb(&cb, revs, flags);
@@ -2079,12 +2079,12 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
 }
 
-static int for_each_good_bisect_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
 }
-- 
2.3.5
