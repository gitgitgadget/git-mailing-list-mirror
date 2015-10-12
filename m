From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 32/44] initdb: move safe_create_dir into common code
Date: Mon, 12 Oct 2015 17:51:53 -0400
Message-ID: <1444686725-27660-34-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2M-0005VM-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbbJLVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:37 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33106 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbJLVwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:49 -0400
Received: by qgeb31 with SMTP id b31so28263057qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WFhbLBAtEsiRMbmz4w+LNchx15fgZtNbFTwQKExPGgA=;
        b=Bt2f6frik27MQdojwm+gxrJ+iNoLHgidNr06+2huW3ORIlZFKXUfv73K6kWrHLaR4b
         4H0KB2FxFCkyqiZmwcH1xybEBbY/u4VNgX1CdZJYuPblTwTh2OKzYolXc1iH7u3NT1XD
         Yihr9eNuL8iDrL4Wd+qxjEBRRNVj7X8CZrsY6BZ4Bz+eMuQK6diH/KjepAUNoOEh2yKw
         5N/YQaUmbm2bLAwdrcZWW12vOT15ntCsiXAX28QMP1mKnpg889yTKI88/Bi1p6JQRX4w
         XUxHmUba/wjFBoVx4IZx3nPEWRiEbLZIZROHMtPgKPqmCglIsEPNiqzB5lzdmwNgcOJB
         8Bxg==
X-Gm-Message-State: ALoCoQlhDOvGH7lcYWq7gq/zhDShfhF5uOB572j1x9j3Upn51O6b4sEnHa5gT1KSCi8BxJ/zD+Vj
X-Received: by 10.140.93.195 with SMTP id d61mr14277875qge.89.1444686769009;
        Mon, 12 Oct 2015 14:52:49 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279446>

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
index 313d13f..f6f7259 100644
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
 static void copy_templates_1(struct strbuf *path, struct strbuf *template,
 			     DIR *dir)
 {
diff --git a/cache.h b/cache.h
index 1c45b62..cc817dc 100644
--- a/cache.h
+++ b/cache.h
@@ -1749,4 +1749,9 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting.
+ */
+void safe_create_dir(const char *dir, int share);
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 48bd252..9ab2710 100644
--- a/path.c
+++ b/path.c
@@ -740,6 +740,18 @@ int adjust_shared_perm(const char *path)
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
2.4.2.644.g97b850b-twtrsrc
