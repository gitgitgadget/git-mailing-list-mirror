From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Thu, 14 May 2015 16:38:07 -0400
Message-ID: <1431635888-11538-3-git-send-email-dturner@twitter.com>
References: <1431635888-11538-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 22:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yszti-0007sY-NI
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934016AbbENUiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:38:18 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36507 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934004AbbENUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:38:16 -0400
Received: by qgg76 with SMTP id 76so17506280qgg.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYmGuagsj3i+N2iqcsB9Obe9KlNyy+oq91XlifP15Xg=;
        b=FJPyj3r7ET1FG1K6Y5YvnVWe0e3uxnQvRC+cDcY4Bn3QoyJwZC9W3u0WBwlNjJHfVi
         WPuo3hvoXH2xRTmKOMX4QCmTAMqs+tRNzrLenoZD8MHGIuXceZ6PWPeAOqQTcOsoggDy
         E+VsXHl4cAeivoHJr60BkYio41annLLL4ZIy8Sjy3oLMjmIP4mC+HoVfHJgJcwirJJ+O
         ELB8XK/jdlmF68XS88axknbOR9Xrw+v6fk8sMVbFgDlzZ44ejUw+phLS0w/0pKBDCAM2
         4eMj0pqFzFLAVZ1BdnLgOuUdEf30Ax2bPjiOfxXuP40up0UXos8upc20nA8c5hHTGOji
         K7Sw==
X-Gm-Message-State: ALoCoQnwKCZIStdasbnkD92rJb1Y8xsBlZApeul11r7yyHK33+g6VX2nArWSJrXqbpe2iYMauZvo
X-Received: by 10.55.42.219 with SMTP id q88mr13418001qkq.20.1431635895828;
        Thu, 14 May 2015 13:38:15 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id r33sm107494qkh.12.2015.05.14.13.38.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 13:38:14 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431635888-11538-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269086>

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
