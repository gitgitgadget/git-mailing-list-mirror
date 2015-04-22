From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 03/16] refs: convert remaining users of for_each_ref_in to object_id
Date: Wed, 22 Apr 2015 23:24:08 +0000
Message-ID: <1429745061-295908-4-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:24:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl40U-0003Ww-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576AbbDVXYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44744 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758565AbbDVXY2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 502DF282AA;
	Wed, 22 Apr 2015 23:24:27 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267653>

Remove the temporary for_each_ref_in_oid function and update the users
of it.  Convert the users of for_each_branch_ref and
for_each_remote_ref (which use for_each_ref_in under the hood) as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c            |  8 ++++----
 builtin/rev-parse.c | 10 +++++-----
 refs.c              | 13 ++++---------
 refs.h              |  6 +++---
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/bisect.c b/bisect.c
index 10f5e57..03d5cd9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -400,16 +400,16 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static int register_ref(const char *refname, const unsigned char *sha1,
+static int register_ref(const char *refname, const struct object_id *oid,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
-		hashcpy(current_bad_oid->hash, sha1);
+		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, "good-")) {
-		sha1_array_append(&good_revs, sha1);
+		sha1_array_append(&good_revs, oid->hash);
 	} else if (starts_with(refname, "skip-")) {
-		sha1_array_append(&skipped_revs, sha1);
+		sha1_array_append(&skipped_revs, oid->hash);
 	}
 
 	return 0;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7b70650..c9f2c93 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -203,9 +203,9 @@ static int show_reference_oid(const char *refname, const struct object_id *oid,
 	return show_reference(refname, oid->hash, flag, cb_data);
 }
 
-static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	show_rev(REVERSED, sha1, refname);
+	show_rev(REVERSED, oid->hash, refname);
 	return 0;
 }
 
@@ -665,7 +665,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
+				for_each_ref_in("refs/bisect/bad", show_reference_oid, NULL);
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
@@ -676,7 +676,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference, NULL);
+				for_each_branch_ref(show_reference_oid, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
@@ -703,7 +703,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference, NULL);
+				for_each_remote_ref(show_reference_oid, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
diff --git a/refs.c b/refs.c
index 95863f2..a81c301 100644
--- a/refs.c
+++ b/refs.c
@@ -2019,16 +2019,11 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-static int for_each_ref_in_oid(const char *prefix, each_ref_fn_oid fn, void *cb_data)
+int for_each_ref_in(const char *prefix, each_ref_fn_oid fn, void *cb_data)
 {
 	return do_for_each_ref_oid(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
-}
-
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
@@ -2037,7 +2032,7 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 
 int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return for_each_ref_in_oid("refs/tags/", fn, cb_data);
+	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -2045,7 +2040,7 @@ int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_d
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
 }
 
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+int for_each_branch_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
@@ -2055,7 +2050,7 @@ int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+int for_each_remote_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
diff --git a/refs.h b/refs.h
index b83529b..d6ef917 100644
--- a/refs.h
+++ b/refs.h
@@ -88,10 +88,10 @@ typedef int each_ref_fn_oid(const char *refname,
  */
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
-extern int for_each_ref_in(const char *, each_ref_fn, void *);
+extern int for_each_ref_in(const char *, each_ref_fn_oid, void *);
 extern int for_each_tag_ref(each_ref_fn_oid, void *);
-extern int for_each_branch_ref(each_ref_fn, void *);
-extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_branch_ref(each_ref_fn_oid, void *);
+extern int for_each_remote_ref(each_ref_fn_oid, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
-- 
2.3.5
