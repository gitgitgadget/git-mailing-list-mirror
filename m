From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 04/16] refs: convert for_each_ref_in_submodule to object_id
Date: Wed, 22 Apr 2015 23:24:09 +0000
Message-ID: <1429745061-295908-5-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl40T-0003Ww-Ol
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbbDVXYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44745 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757319AbbDVXYa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D5BCA282AC;
	Wed, 22 Apr 2015 23:24:27 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267654>

Convert for_each_ref_in_submodule and all of its caller.  Introduce two
temporary wrappers in revision.c to handle the incompatibilities between
each_ref_fn and each_ref_fn_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c      | 10 +++++-----
 refs.h      |  8 ++++----
 revision.c  | 28 +++++++++++++++++++++-------
 submodule.c |  2 +-
 4 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index a81c301..aa13cc2 100644
--- a/refs.c
+++ b/refs.c
@@ -2025,9 +2025,9 @@ int for_each_ref_in(const char *prefix, each_ref_fn_oid fn, void *cb_data)
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data)
+		each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref_oid(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
@@ -2035,7 +2035,7 @@ int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
 }
@@ -2045,7 +2045,7 @@ int for_each_branch_ref(each_ref_fn_oid fn, void *cb_data)
 	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
 
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int for_each_branch_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
@@ -2055,7 +2055,7 @@ int for_each_remote_ref(each_ref_fn_oid fn, void *cb_data)
 	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
 
-int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
diff --git a/refs.h b/refs.h
index d6ef917..62eb553 100644
--- a/refs.h
+++ b/refs.h
@@ -99,10 +99,10 @@ extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* pr
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data);
-extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+		each_ref_fn_oid fn, void *cb_data);
+extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
+extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
+extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 
 extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
 extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
diff --git a/revision.c b/revision.c
index 7ddbaa0..93d9311 100644
--- a/revision.c
+++ b/revision.c
@@ -1232,6 +1232,12 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	return 0;
 }
 
+static int handle_one_ref_oid(const char *path, const struct object_id *oid,
+	int flag, void *cb_data)
+{
+	return handle_one_ref(path, oid->hash, flag, cb_data);
+}
+
 static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	unsigned flags)
 {
@@ -1265,6 +1271,14 @@ static void handle_refs(const char *submodule, struct rev_info *revs, unsigned f
 	for_each(submodule, handle_one_ref, &cb);
 }
 
+static void handle_refs_oid(const char *submodule, struct rev_info *revs, unsigned flags,
+		int (*for_each)(const char *, each_ref_fn_oid, void *))
+{
+	struct all_refs_cb cb;
+	init_all_refs_cb(&cb, revs, flags);
+	for_each(submodule, handle_one_ref_oid, &cb);
+}
+
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
@@ -2073,12 +2087,12 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
 }
 
-static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
 }
@@ -2106,17 +2120,17 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
-		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, for_each_branch_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
-		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
-		handle_refs(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
+		handle_refs_oid(submodule, revs, *flags, for_each_bad_bisect_ref);
+		handle_refs_oid(submodule, revs, *flags ^ (UNINTERESTING | BOTTOM), for_each_good_bisect_ref);
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
-		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, for_each_tag_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--remotes")) {
-		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, for_each_remote_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
diff --git a/submodule.c b/submodule.c
index d491e6a..97e74c5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -422,7 +422,7 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
-static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int has_remote(const char *refname, const struct object_id *oid, int flags, void *cb_data)
 {
 	return 1;
 }
-- 
2.3.5
