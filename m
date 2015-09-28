From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 32/43] initdb: move safe_create_dir into common code
Date: Mon, 28 Sep 2015 18:02:07 -0400
Message-ID: <1443477738-32023-33-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWH-00017W-7x
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbbI1WDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:32 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35072 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbbI1WD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:29 -0400
Received: by qgt47 with SMTP id 47so133561099qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9y50FoLTbilPRrNBZ5cHgE13ZZPVo3tJc3BQeVuxqnI=;
        b=VOcTwSuilzNwuYFqxYUjodZcS6TAn3CeDfbqm5TDPPeFRIkTKRkoHU036Uvn4eQKM+
         UXS1CvF4xouepZrZKtOQCVaGapjC1r6lksH4mYFchEzLR2XZk8vEb4dhx8OYMkzHVdjI
         a0pbDuo10y1A8JFjjLpPKv6aFdKKUj8shHyH24ZmOkWaEVljk0vBj8ePejlBOdz4cF7B
         MD50L83T6sXUvXHAT8yviUItedv2LcoEenpAp0Di9DmbNkFo7d6nhnEB+n3tMHOQ2irB
         MrGZaalY20GQwdH73jNnjZ41DYOFJhpIPeHoyT+PJI+TlGtN83FR4b8Sh5Lj52o0dAof
         wVPw==
X-Gm-Message-State: ALoCoQmTnIh0ufwOruoyySZkQE7BCQDGSYatLc/uwQL+5q2KM3+ECzL8rCDMJfrn67sjrO+nC/pP
X-Received: by 10.141.28.6 with SMTP id f6mr26769588qhe.53.1443477808601;
        Mon, 28 Sep 2015 15:03:28 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278765>

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
index cf6a3c8..f0b095c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -24,18 +24,6 @@ static int init_shared_repository = -1;
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
