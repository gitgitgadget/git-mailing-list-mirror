From: David Turner <dturner@twopensource.com>
Subject: [PATCH v13 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Wed, 20 May 2015 13:03:39 -0400
Message-ID: <1432141420-1027-3-git-send-email-dturner@twopensource.com>
References: <1432141420-1027-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 19:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7Pk-0000b3-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbbETREN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:04:13 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35339 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbETREK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:04:10 -0400
Received: by igbyr2 with SMTP id yr2so107926919igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OIb5hPMr4lu9ORuTV2xw/tDsq8O5ITUAcRFlcbZXWjE=;
        b=ThhZp7ZZvpIUVSfNiqQ26N1YfKHVuw6+TvV6X4oHkyy5ugE9NyG7c2MV5A5cid4vXF
         8+RoVhfXG8B24y9lccRAKzmae0sokaHftxHwvgSbSFfpYWi5mTAzZrzEfcfS5Ay8uYiq
         YL+Bb1h1+0heOhlVyw+ZdNxflviGqNLfrEJso2SoaNpjEGrPdCHnhvTTzTo3AUkczeLc
         dJ1NWw7PYV9iguDxmatwO4PFTnhUh/KAKUPDXocRaiYJBnh/0UDOXtxl4H0poUbQz+OI
         ThPr8xljWUWrTlMdwit1CHejP/EgrkpDc3gduLhAT82zlfNgljbITdmfzUSRdLxJD/kI
         cA2w==
X-Gm-Message-State: ALoCoQnc/j9VQ8GM6/q7JdPSyP2hiIWhaWHZ7f6GPndzl2PTisFuN4CXPdEBcYq8VvMu0sP3EGlc
X-Received: by 10.107.3.166 with SMTP id e38mr17647656ioi.50.1432141449607;
        Wed, 20 May 2015 10:04:09 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id r4sm1993464igh.9.2015.05.20.10.04.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 10:04:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1432141420-1027-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269475>

Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
is incompatible with G_S_ONLY_TO_DIE because the diagnosis
that ONLY_TO_DIE triggers does not at present consider symlinks, and
it would be a significant amount of additional code to allow it to
do so.

Signed-off-by: David Turner <dturner@twopensource.com>
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
