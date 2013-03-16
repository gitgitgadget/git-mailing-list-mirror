From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] sha1_name: pass object name length to diagnose_invalid_sha1_path()
Date: Sat, 16 Mar 2013 19:29:31 +0100
Message-ID: <5144BA0B.2040109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 16 19:30:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGvrp-0001bd-1r
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 19:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab3CPS3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 14:29:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:49225 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab3CPS3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 14:29:37 -0400
Received: from [192.168.2.105] (p4FFD98FC.dip.t-dialin.net [79.253.152.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 1C242D5;
	Sat, 16 Mar 2013 19:29:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218311>

The only caller of diagnose_invalid_sha1_path() extracts a substring from
an object name by creating a NUL-terminated copy of the interesting part.
Add a length parameter to the function and thus avoid the need for an
allocation, thereby simplifying the code.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 sha1_name.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 95003c7..4cea6d3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1137,7 +1137,8 @@ int get_sha1_blob(const char *name, unsigned char *sha1)
 static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
 				       const unsigned char *tree_sha1,
-				       const char *object_name)
+				       const char *object_name,
+				       int object_name_len)
 {
 	struct stat st;
 	unsigned char sha1[20];
@@ -1147,8 +1148,8 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 		prefix = "";
 
 	if (!lstat(filename, &st))
-		die("Path '%s' exists on disk, but not in '%s'.",
-		    filename, object_name);
+		die("Path '%s' exists on disk, but not in '%.*s'.",
+		    filename, object_name_len, object_name);
 	if (errno == ENOENT || errno == ENOTDIR) {
 		char *fullname = xmalloc(strlen(filename)
 					     + strlen(prefix) + 1);
@@ -1158,16 +1159,16 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 		if (!get_tree_entry(tree_sha1, fullname,
 				    sha1, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
-			    "Did you mean '%s:%s' aka '%s:./%s'?",
+			    "Did you mean '%.*s:%s' aka '.*%.*s:./%s'?",
 			    fullname,
 			    filename,
-			    object_name,
+			    object_name_len, object_name,
 			    fullname,
-			    object_name,
+			    object_name_len, object_name,
 			    filename);
 		}
-		die("Path '%s' does not exist in '%s'",
-		    filename, object_name);
+		die("Path '%s' does not exist in '%.*s'",
+		    filename, object_name_len, object_name);
 	}
 }
 
@@ -1332,13 +1333,8 @@ static int get_sha1_with_context_1(const char *name,
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		char *object_name = NULL;
-		if (only_to_die) {
-			object_name = xmalloc(cp-name+1);
-			strncpy(object_name, name, cp-name);
-			object_name[cp-name] = '\0';
-		}
-		if (!get_sha1_1(name, cp-name, tree_sha1, GET_SHA1_TREEISH)) {
+		int len = cp - name;
+		if (!get_sha1_1(name, len, tree_sha1, GET_SHA1_TREEISH)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
@@ -1348,8 +1344,8 @@ static int get_sha1_with_context_1(const char *name,
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (ret && only_to_die) {
 				diagnose_invalid_sha1_path(prefix, filename,
-							   tree_sha1, object_name);
-				free(object_name);
+							   tree_sha1,
+							   name, len);
 			}
 			hashcpy(oc->tree, tree_sha1);
 			strncpy(oc->path, filename,
@@ -1360,7 +1356,7 @@ static int get_sha1_with_context_1(const char *name,
 			return ret;
 		} else {
 			if (only_to_die)
-				die("Invalid object name '%s'.", object_name);
+				die("Invalid object name '%.*s'.", len, name);
 		}
 	}
 	return ret;
-- 
1.8.2
