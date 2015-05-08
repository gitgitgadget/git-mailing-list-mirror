From: dturner@twopensource.com
Subject: [PATCH v2 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri,  8 May 2015 18:38:45 -0400
Message-ID: <1431124726-22562-2-git-send-email-dturner@twopensource.com>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 00:39:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqqvk-0003Bu-7x
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbbEHWji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 18:39:38 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36169 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbbEHWjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 18:39:35 -0400
Received: by qcbgy10 with SMTP id gy10so44229123qcb.3
        for <git@vger.kernel.org>; Fri, 08 May 2015 15:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s1Ll4ME0sPJq8dAjM1MaFRNedO9TG8gfSoXERJEBOt8=;
        b=PNfrcNZJHivs1NGAkvOJhvf9EGhWrxgY2p8viQ22Rk7St+smgjxrAraIXFP5VbMZzs
         HMdTpAijxebwq7ilMbNu+qjFZQFMSVMfOQ+UBUoqglswKEe2GYP+0onlYSRP6NW8JEAk
         NmkvFu8PSVFDcu/fmGJQcyoE35So2MYEVABlqs7xQGQhzsSie3p/PA2SRVIaWBgcuIDY
         LScyFJWnptAD/qagqVNrRdwbRhu8wgu44aXZHS+MObJeWK8D/IWUaTDyWx8TzLC71BOf
         mrqEmglkaRzst69IPCwTlRWsUMUFzTx8g2WBkZoNyHK34KJA4bJDbU+0Zd7RMpjzZDJy
         O8wA==
X-Gm-Message-State: ALoCoQnmFCRlo6qIKM6ytToqjofkFDlPLnmxNVvYJRPhtaDV5mJcLPrWovOxTG2KDO66pm+a7qux
X-Received: by 10.55.20.89 with SMTP id e86mr585741qkh.74.1431124774401;
        Fri, 08 May 2015 15:39:34 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 104sm4599100qgj.43.2015.05.08.15.39.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 15:39:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268681>

From: David Turner <dturner@twitter.com>

Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
ONLY_TO_DIE triggers does not consider symlinks.

Signed-off-by: David Turner <dturner@twitter.com>
---
 cache.h     | 15 ++++++++-------
 sha1_name.c | 24 ++++++++++++++++--------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 3d3244b..16743de 100644
--- a/cache.h
+++ b/cache.h
@@ -924,13 +924,14 @@ struct object_context {
 	unsigned mode;
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
index 6d10f05..cbe679e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1434,15 +1434,21 @@ static int get_sha1_with_context_1(const char *name,
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
+					filename, sha1, oc->path, &oc->mode);
+			} else {
+				ret = get_tree_entry(tree_sha1, filename,
+						     sha1, &oc->mode);
+				if (ret && only_to_die) {
+					diagnose_invalid_sha1_path(prefix,
+								   filename,
+								   tree_sha1,
+								   name, len);
+				}
+				hashcpy(oc->tree, tree_sha1);
+				strlcpy(oc->path, filename, sizeof(oc->path));
 			}
-			hashcpy(oc->tree, tree_sha1);
-			strlcpy(oc->path, filename, sizeof(oc->path));
-
 			free(new_filename);
 			return ret;
 		} else {
@@ -1469,5 +1475,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 
 int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
 {
+	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
+		die("BUG: incompatible flags for get_sha1_with_context");
 	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
 }
-- 
2.0.4.315.gad8727a-twtrsrc
