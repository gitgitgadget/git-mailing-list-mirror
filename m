From: dturner@twopensource.com
Subject: [PATCH v4 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Mon, 11 May 2015 13:56:28 -0400
Message-ID: <1431366989-7405-3-git-send-email-dturner@twopensource.com>
References: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:57:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrrwr-0004Sx-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbbEKR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:56:54 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35247 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbEKR4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:56:52 -0400
Received: by qgej70 with SMTP id j70so71913469qge.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOdGL/mv44Ri3cWmO4lbpkeYCcOaMVVZ47SDGWm8/Qo=;
        b=ZJnsx++5bNyS/RXIvGBSzyJafjRkk4oh57IIAdhQkqghKoy7SOjdHXMijkJq3xFPKJ
         biAM6cvKP3co/8g6cf5vQ5/ZPuwfRPrPsmV6aJELW/Qz4kvS9W0xP4VN0IZOAbRBi7U7
         U2/eAJRkiaK/sGIXbqtnzaFvDPcG7Gb3Pu42eU92SNdV1+uX2uiW3kl3B55T62WJcjRt
         gWqP2Yb92hpRc97z1JkFq/nXAIruo6Kj9Ei6n5dBVIGwIYgaEnr3ItXFTE10HfoeJVHu
         6ytO7GoUVE4aeqV2PAWLBPqk4ReC05vKKFS2+N6STrrCMlvzVS0+w4lYggAZm228F2jI
         eGyQ==
X-Gm-Message-State: ALoCoQm8aAql1hG67qogAmVxDHqLep3F6bHzA3TtNnbmzVdJuIa0WTldvNhBbzXP/veqAXfao6QI
X-Received: by 10.140.151.15 with SMTP id 15mr15099402qhx.104.1431367011444;
        Mon, 11 May 2015 10:56:51 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 20sm11093161qhf.14.2015.05.11.10.56.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 May 2015 10:56:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268806>

From: David Turner <dturner@twitter.com>

Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
is incompatible with G_S_ONLY_TO_DIE because the diagnosis
that ONLY_TO_DIE triggers does not at present consider symlinks, and
it would be a significant amount of additional code to allow it to
do so.

Signed-off-by: David Turner <dturner@twitter.com>
---
 cache.h     | 20 +++++++++++++-------
 sha1_name.c | 20 +++++++++++++++-----
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..65505d1 100644
--- a/cache.h
+++ b/cache.h
@@ -922,15 +922,21 @@ struct object_context {
 	unsigned char tree[20];
 	char path[PATH_MAX];
 	unsigned mode;
+	/*
+	 * symlink_path is only used by get_tree_entry_follow_symlinks,
+	 * and only for symlinks that point outside the repository.
+	 */
+	struct strbuf symlink_path;
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
index 6d10f05..0c26515 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1434,11 +1434,19 @@ static int get_sha1_with_context_1(const char *name,
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
 			hashcpy(oc->tree, tree_sha1);
 			strlcpy(oc->path, filename, sizeof(oc->path));
@@ -1469,5 +1477,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 
 int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
 {
+	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
+		die("BUG: incompatible flags for get_sha1_with_context");
 	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
 }
-- 
2.0.4.315.gad8727a-twtrsrc
