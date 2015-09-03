From: David Turner <dturner@twopensource.com>
Subject: [PATCH 31/43] initdb: move safe_create_dir into common code
Date: Wed,  2 Sep 2015 21:55:01 -0400
Message-ID: <1441245313-11907-32-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlF-0006Td-EM
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbbICB4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:17 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33830 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbICB4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:15 -0400
Received: by qkfq186 with SMTP id q186so15075858qkf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUyy//7Aue0EJS65XsAaWwh47gB2Jz3TyAuAfwGCoJ8=;
        b=GMF+cxIb46cn17N9VTh4/BWWNbMRdQbX6+iXcWP35YK5NSM0qkVC4xkaLy+dF0VIsW
         mrEbTijmZ5z2gPpJPMJCOk/0JLMnAhvoxtLWUvQ0RyxUh6MVo7lzqZDvalN2NuqI6oiz
         7votG/JiY06ggRsYN3oCWYAlNzlg/geYjzEplfXbElqwWX1NQNdWzJDQp+UN05sbrYUl
         +8IjQdGkuxPXZg8wEqzzdPRfk+fDYoz4HkKQLt1m8bNEl1UnvmkAPwyduFUxlCOeUN8u
         nCjqcREG06jE/sh/FFVc3EaT+YiOQyaGLYd6Kwl9UdguIPJLIaPGlsESVvDaO8FYR4mQ
         XzRQ==
X-Gm-Message-State: ALoCoQl9ol+GH8z0h0c1vT5iGbXZN4R7H3dtbyCXvmUPsuaZMTwrqw1a+vqMenFMpEwvMwir5yTK
X-Received: by 10.55.24.8 with SMTP id j8mr34025818qkh.93.1441245374283;
        Wed, 02 Sep 2015 18:56:14 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277152>

In a moment, we'll create initdb functions for ref backends, and code
from initdb that calls this function needs to move into the files
backend.  So this function needs to be public.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c | 12 ------------
 cache.h           |  5 +++++
 path.c            | 12 ++++++++++++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 04caee1..06f8cca 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -25,18 +25,6 @@ static int init_shared_repository = -1;
 static const char *init_db_template_dir;
 static const char *git_link;
 
-static void safe_create_dir(const char *dir, int share)
-{
-	if (mkdir(dir, 0777) < 0) {
-		if (errno != EEXIST) {
-			perror(dir);
-			exit(1);
-		}
-	}
-	else if (share && adjust_shared_perm(dir))
-		die(_("Could not make %s writable by group"), dir);
-}
-
 static void copy_templates_1(char *path, int baselen,
 			     char *template, int template_baselen,
 			     DIR *dir)
diff --git a/cache.h b/cache.h
index 98b13a8..a9669de 100644
--- a/cache.h
+++ b/cache.h
@@ -1717,4 +1717,9 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting.
+ */
+void safe_create_dir(const char *dir, int share);
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 82d9097..25d3941 100644
--- a/path.c
+++ b/path.c
@@ -726,6 +726,18 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+void safe_create_dir(const char *dir, int share)
+{
+	if (mkdir(dir, 0777) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+	else if (share && adjust_shared_perm(dir))
+		die(_("Could not make %s writable by group"), dir);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
-- 
2.0.4.315.gad8727a-twtrsrc
