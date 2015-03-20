From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 03/16] refs: convert remaining users of for_each_ref_in to object_id
Date: Fri, 20 Mar 2015 19:28:23 +0000
Message-ID: <1426879716-47835-4-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2c1-0002Ex-A3
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbbCTT3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164AbbCTT2r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:47 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 631E028094;
	Fri, 20 Mar 2015 19:28:46 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265947>

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
index ba5f3a0..ec0ca86 100644
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
 
@@ -658,7 +658,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
+				for_each_ref_in("refs/bisect/bad", show_reference_oid, NULL);
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
@@ -669,7 +669,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference, NULL);
+				for_each_branch_ref(show_reference_oid, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
@@ -696,7 +696,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference, NULL);
+				for_each_remote_ref(show_reference_oid, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
diff --git a/refs.c b/refs.c
index 2fe934f..2c7bbd4 100644
--- a/refs.c
+++ b/refs.c
@@ -1969,16 +1969,11 @@ int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
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
@@ -1987,7 +1982,7 @@ int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 
 int for_each_tag_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return for_each_ref_in_oid("refs/tags/", fn, cb_data);
+	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -1995,7 +1990,7 @@ int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_d
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
 }
 
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+int for_each_branch_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
@@ -2005,7 +2000,7 @@ int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
 }
 
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+int for_each_remote_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
diff --git a/refs.h b/refs.h
index 8a5f92f..ff1a41a 100644
--- a/refs.h
+++ b/refs.h
@@ -97,10 +97,10 @@ typedef int each_ref_fn_oid(const char *refname,
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
2.2.1.209.g41e5f3a
