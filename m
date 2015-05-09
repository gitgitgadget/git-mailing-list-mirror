From: dturner@twopensource.com
Subject: [PATCH v3 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Sat,  9 May 2015 16:36:08 -0400
Message-ID: <1431203769-11855-2-git-send-email-dturner@twopensource.com>
References: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 22:36:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrBUN-0000aI-Bf
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbbEIUgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 16:36:44 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34910 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbbEIUgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 16:36:43 -0400
Received: by qgej70 with SMTP id j70so51622602qge.2
        for <git@vger.kernel.org>; Sat, 09 May 2015 13:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=can29zaycVgmV9CWK3dUne+/UWCyk2AoMWQFea08gO8=;
        b=Y3HnPsswvBuG5UF51muIEWFxLj7Zr+jgDuylHUbfmMwSOQvOGwcM+8xoMvsQYouzb6
         NzDiD8JFGRxfYhzQK4hr+Ob12UF6pM4wP9/1PA41kkgOF8V2oO4bGj7X4sswJup8rk1i
         nLENi5+NvjsP5sdXqUaWbLwiEQUhIT17bSba+IORmeE1DJY83zn/83NcjMGLfbKLKdQM
         qyT5hFGtVwm2vb9AZ4pfhEsbhfwenJdICxl4sPoBOqvEb3lclHAaUpUc6e8f5HjpI/e7
         bON61sgCsL+Y5p19AtGm7cdeTvK9/4ioIvBWqtDGV1udfGjCQUoAegIWXXcQNeUm4YR3
         EX0Q==
X-Gm-Message-State: ALoCoQl95wpKbKtGyF80A2XkzVBvTLxpBHkmJZt1iznSrd8w3EUXdDMlXFtQlec5KHKBSOS0RPko
X-Received: by 10.229.16.69 with SMTP id n5mr5233185qca.25.1431203792029;
        Sat, 09 May 2015 13:36:32 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id n83sm6475929qkh.31.2015.05.09.13.36.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 13:36:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431203769-11855-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268713>

From: David Turner <dturner@twitter.com>

Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
is incompatible with G_S_ONLY_TO_DIE because the diagnosis
that ONLY_TO_DIE triggers does not at present consider symlinks, and
it would be a significant amount of additional code to allow it to
do so.

Signed-off-by: David Turner <dturner@twitter.com>
---
 cache.h     | 15 ++++++++-------
 sha1_name.c | 23 ++++++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 679faa9..65505d1 100644
--- a/cache.h
+++ b/cache.h
@@ -929,13 +929,14 @@ struct object_context {
 	struct strbuf symlink_path;
 };
 
-#define GET_SHA1_QUIETLY        01
-#define GET_SHA1_COMMIT         02
-#define GET_SHA1_COMMITTISH     04
-#define GET_SHA1_TREE          010
-#define GET_SHA1_TREEISH       020
-#define GET_SHA1_BLOB	       040
-#define GET_SHA1_ONLY_TO_DIE 04000
+#define GET_SHA1_QUIETLY           01
+#define GET_SHA1_COMMIT            02
+#define GET_SHA1_COMMITTISH        04
+#define GET_SHA1_TREE             010
+#define GET_SHA1_TREEISH          020
+#define GET_SHA1_BLOB             040
+#define GET_SHA1_FOLLOW_SYMLINKS 0100
+#define GET_SHA1_ONLY_TO_DIE    04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_commit(const char *str, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..325f666 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1434,15 +1434,22 @@ static int get_sha1_with_context_1(const char *name,
 			new_filename = resolve_relative_path(filename);
 			if (new_filename)
 				filename = new_filename;
-			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
-			if (ret && only_to_die) {
-				diagnose_invalid_sha1_path(prefix, filename,
-							   tree_sha1,
-							   name, len);
+			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
+				ret = get_tree_entry_follow_symlinks(tree_sha1,
+					filename, sha1, &oc->symlink_path,
+					&oc->mode);
+			} else {
+				ret = get_tree_entry(tree_sha1, filename,
+						     sha1, &oc->mode);
+				if (ret && only_to_die) {
+					diagnose_invalid_sha1_path(prefix,
+								   filename,
+								   tree_sha1,
+								   name, len);
+				}
 			}
-			hashcpy(oc->tree, tree_sha1);
 			strlcpy(oc->path, filename, sizeof(oc->path));
-
+			hashcpy(oc->tree, tree_sha1);
 			free(new_filename);
 			return ret;
 		} else {
@@ -1469,5 +1476,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 
 int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
 {
+	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
+		die("BUG: incompatible flags for get_sha1_with_context");
 	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
 }
-- 
2.0.4.315.gad8727a-twtrsrc
