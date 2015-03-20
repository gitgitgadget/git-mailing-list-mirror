From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 14/16] refs: rename each_ref_fn_oid to each_ref_fn
Date: Fri, 20 Mar 2015 19:28:34 +0000
Message-ID: <1426879716-47835-15-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bS-0001gd-Br
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbbCTT3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:04 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50698 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbbCTT26 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:58 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F0F112808F;
	Fri, 20 Mar 2015 19:28:56 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265945>

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
index bbcb044..941e466 100644
--- a/refs.c
+++ b/refs.c
@@ -668,7 +668,7 @@ struct ref_entry_cb {
 	const char *base;
 	int trim;
 	int flags;
-	each_ref_fn_oid *fn;
+	each_ref_fn *fn;
 	void *cb_data;
 };
 
@@ -1624,7 +1624,7 @@ char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, in
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-	each_ref_fn_oid *fn;
+	each_ref_fn *fn;
 	void *cb_data;
 };
 
@@ -1898,7 +1898,7 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * 0.
  */
 static int do_for_each_ref(struct ref_cache *refs, const char *base,
-			   each_ref_fn_oid fn, int trim, int flags, void *cb_data)
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
@@ -1910,7 +1910,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
+static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
@@ -1928,73 +1928,73 @@ static int do_head_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
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
@@ -2009,7 +2009,7 @@ int head_ref_namespaced(each_ref_fn_oid fn, void *cb_data)
 	return ret;
 }
 
-int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -2019,7 +2019,7 @@ int for_each_namespaced_ref(each_ref_fn_oid fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn_oid fn, const char *pattern,
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
@@ -2049,12 +2049,12 @@ int for_each_glob_ref_in(each_ref_fn_oid fn, const char *pattern,
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
@@ -3491,7 +3491,7 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
  * must be empty or end with '/'.  Name will be used as a scratch
  * space, but its contents will be restored before return.
  */
-static int do_for_each_reflog(struct strbuf *name, each_ref_fn_oid fn, void *cb_data)
+static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data)
 {
 	DIR *d = opendir(git_path("logs/%s", name->buf));
 	int retval = 0;
@@ -3531,7 +3531,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn_oid fn, void *cb_
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn_oid fn, void *cb_data)
+int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
diff --git a/refs.h b/refs.h
index c491c44..b893f4a 100644
--- a/refs.h
+++ b/refs.h
@@ -78,12 +78,6 @@ struct ref_transaction;
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
@@ -95,26 +89,26 @@ typedef int each_ref_fn_oid(const char *refname,
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
@@ -122,7 +116,7 @@ static inline const char *has_glob_specials(const char *pattern)
 }
 
 /* can be used to learn about broken ref and symref */
-extern int for_each_rawref(each_ref_fn_oid, void *);
+extern int for_each_rawref(each_ref_fn, void *);
 
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
@@ -249,7 +243,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
-extern int for_each_reflog(each_ref_fn_oid, void *);
+extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
diff --git a/revision.c b/revision.c
index b491d22..3d64644 100644
--- a/revision.c
+++ b/revision.c
@@ -1249,7 +1249,7 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 }
 
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
-		int (*for_each)(const char *, each_ref_fn_oid, void *))
+		int (*for_each)(const char *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 	init_all_refs_cb(&cb, revs, flags);
@@ -2062,12 +2062,12 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
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
2.2.1.209.g41e5f3a
