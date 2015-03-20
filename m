From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 09/16] refs: convert for_each_replace_ref to struct object_id
Date: Fri, 20 Mar 2015 19:28:29 +0000
Message-ID: <1426879716-47835-10-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2br-0001va-FI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbbCTT3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50677 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbbCTT2x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:53 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A6352809A;
	Fri, 20 Mar 2015 19:28:52 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265952>

Update callbacks to take the proper parameters and use struct object_id
elsewhere in the callbacks.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/replace.c | 14 +++++++-------
 refs.c            |  4 ++--
 refs.h            |  2 +-
 replace_object.c  |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 85d39b5..c873180 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -35,7 +35,7 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname, const unsigned char *sha1,
+static int show_reference(const char *refname, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
 	struct show_data *data = cb_data;
@@ -44,19 +44,19 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
-			printf("%s -> %s\n", refname, sha1_to_hex(sha1));
+			printf("%s -> %s\n", refname, oid_to_hex(oid));
 		else { /* data->format == REPLACE_FORMAT_LONG */
-			unsigned char object[20];
+			struct object_id object;
 			enum object_type obj_type, repl_type;
 
-			if (get_sha1(refname, object))
+			if (get_sha1(refname, object.hash))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = sha1_object_info(object, NULL);
-			repl_type = sha1_object_info(sha1, NULL);
+			obj_type = sha1_object_info(object.hash, NULL);
+			repl_type = sha1_object_info(oid->hash, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
-			       sha1_to_hex(sha1), typename(repl_type));
+			       oid_to_hex(oid), typename(repl_type));
 		}
 	}
 
diff --git a/refs.c b/refs.c
index 4d07dec..0d9b340 100644
--- a/refs.c
+++ b/refs.c
@@ -2010,9 +2010,9 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn_oid fn, voi
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref_oid(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 2c78450..951e465 100644
--- a/refs.h
+++ b/refs.h
@@ -101,7 +101,7 @@ extern int for_each_ref_in(const char *, each_ref_fn_oid, void *);
 extern int for_each_tag_ref(each_ref_fn_oid, void *);
 extern int for_each_branch_ref(each_ref_fn_oid, void *);
 extern int for_each_remote_ref(each_ref_fn_oid, void *);
-extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_replace_ref(each_ref_fn_oid, void *);
 extern int for_each_glob_ref(each_ref_fn_oid, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn_oid, const char *pattern, const char* prefix, void *);
 
diff --git a/replace_object.c b/replace_object.c
index 0ab2dc1..f0b39f0 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -53,7 +53,7 @@ static int register_replace_object(struct replace_object *replace,
 }
 
 static int register_replace_ref(const char *refname,
-				const unsigned char *sha1,
+				const struct object_id *oid,
 				int flag, void *cb_data)
 {
 	/* Get sha1 from refname */
@@ -68,7 +68,7 @@ static int register_replace_ref(const char *refname,
 	}
 
 	/* Copy sha1 from the read ref */
-	hashcpy(repl_obj->replacement, sha1);
+	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
 	if (register_replace_object(repl_obj, 1))
-- 
2.2.1.209.g41e5f3a
