From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Wed, 13 May 2015 14:23:53 -0400
Message-ID: <1431541434-21884-3-git-send-email-dturner@twitter.com>
References: <1431541434-21884-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 20:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsbKQ-0001hE-2e
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 20:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbbEMSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 14:24:13 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32847 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbEMSYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 14:24:11 -0400
Received: by pacwv17 with SMTP id wv17so58419995pac.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 11:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYmGuagsj3i+N2iqcsB9Obe9KlNyy+oq91XlifP15Xg=;
        b=XL8PKIRpxbyLj5tVkYkm+VwE27laIshyL7yFI3w0br6BUt3dKy24wzc1XrNFEgQtmR
         P0OsqPNdp3bCC7PtDJCQJMfpTpWmXrXwHA7bvYjQ0jDfap1eJINCsaEyn/ixHiMd5lmv
         Qg8isKKZFLC/pTvBlgMZlgJSPW9AffjEner805HjZe+5tMbB+vAEtd1/6tAt62YLs6ht
         wGoQFyvR4LhSribwyEmrZzXOHWfmsC5edmBEBBQwMnlahiY+buB1whT/mAeJiFd33cbq
         ZbCRBAWjwLt0QYsyy+GuIQlICTRX+H3vsjmIFL3rOKAnSqNaQMobOb0xqGP4WPe6i0nP
         TMhg==
X-Gm-Message-State: ALoCoQkRcAtHCjImpW874QVu7RJnGsw93GPPBsFzoM6TyQTYc1pFX9IXyEkgpQ5mb8pWjywE3G+q
X-Received: by 10.68.135.196 with SMTP id pu4mr454295pbb.64.1431541450640;
        Wed, 13 May 2015 11:24:10 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.26])
        by mx.google.com with ESMTPSA id nt15sm20023104pdb.14.2015.05.13.11.24.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 11:24:09 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431541434-21884-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269001>

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
