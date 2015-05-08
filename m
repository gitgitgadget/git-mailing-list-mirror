From: dturner@twopensource.com
Subject: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri,  8 May 2015 14:13:38 -0400
Message-ID: <1431108819-6831-2-git-send-email-dturner@twopensource.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 20:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqmmf-0001gA-29
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbEHSN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 14:13:57 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35285 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbEHSNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:13:55 -0400
Received: by qkhg7 with SMTP id g7so53415816qkh.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S0UX3aujTPVyKdHqPNCt5jPVpnw3rnKOFNVhUigkyR4=;
        b=HuuMtlvrZYriDARjv+YKIICWPOaOUx4FtrlDwKlg9SldlRjIAU4JIEKVj0YblsJa6s
         xerpWPg8NG1f2+jW5+pbSfPlQcQI9p9AafipdwyG6GZAg+3k9OdcQyJrzoGMB4dfzp3y
         wcOBtj50JAPnMY30Y19p194dg+NKkUeWa2ZTal/894MBGnPQj7w7vae8axH7EFpLDmJw
         +6AB+UBlfVkzmYg/LfYAPeG3/VrRMiEW2h2c26f2pKqjy4IqgsGcLgi2VAvMcF0zrI66
         k1mjTdaZ5SxFrjyo2Aps9SvJaMjmxxwrqejNAhL/uXch3j3TxUlXN5wq0s2r1ALVr9pK
         EQxg==
X-Gm-Message-State: ALoCoQnWJUWy1DhVIqrJylepfwsKyOVxXmNp549R7vIR6BSBMhuoPPFpdAMRkDAUGnucbLq0nXUd
X-Received: by 10.140.195.14 with SMTP id q14mr6937714qha.78.1431108834499;
        Fri, 08 May 2015 11:13:54 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 69sm4099966qhv.17.2015.05.08.11.13.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 11:13:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268637>

From: David Turner <dturner@twitter.com>

Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
ONLY_TO_DIE triggers does not consider symlinks.

Signed-off-by: David Turner <dturner@twitter.com>
---
 cache.h     | 15 ++++++++-------
 sha1_name.c |  8 ++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

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
index 6d10f05..23863f7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1434,6 +1434,12 @@ static int get_sha1_with_context_1(const char *name,
 			new_filename = resolve_relative_path(filename);
 			if (new_filename)
 				filename = new_filename;
+			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
+				ret = get_tree_enty_follow_symlinks(tree_sha1,
+					filename, sha1, oc->path, &oc->mode);
+				free(new_filename);
+				return ret;
+			}
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (ret && only_to_die) {
 				diagnose_invalid_sha1_path(prefix, filename,
@@ -1469,5 +1475,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 
 int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
 {
+	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
+		die(_("internal error: bad flags for get_sha1_with_context"));
 	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
 }
-- 
2.0.4.315.gad8727a-twtrsrc
