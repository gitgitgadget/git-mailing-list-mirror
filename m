From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 23/26] initdb: move safe_create_dir into common code
Date: Thu, 15 Oct 2015 15:46:47 -0400
Message-ID: <1444938410-2345-24-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoV8-00074w-3t
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbbJOTrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:37 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36260 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbbJOTrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:33 -0400
Received: by qgx61 with SMTP id 61so80927998qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0TiS843cmGdx9yKLrKOHg+GIj5wt7Snw2epCYnoeqr0=;
        b=JsvBSHESjd/syPtg7JhKeB+hVii8pxVVvMniptXlPpW8TEkRkBqeUQOrcXQFtt20qW
         fhOW9XLbaxemS0K6TEX/0SU/5itWntnchrtyjYANfqKflpiqFE/Qi0WjzQQyxfivj2O4
         tzhEQw3HBoI1/bochTrd6eBxlWvholPuGdySzwS+LW6Fj11PKxyFdDwk29EuhKzKiCR3
         EWvYrkVot37kPptY1sMmqQjJodX73W8glZoZxzhVK0R8tWE2ctyAqi4/HEfIAMibDQES
         eZIT9AguZZ4CsxZ/B6QOLISqW6zbZwzJ8I7yizGtJhvgOiQ8FKDQcilvnFsLw5xVbB/i
         byNw==
X-Gm-Message-State: ALoCoQkSEDrcXbf1iU2kTzAbMZEiC4zs/NllYOBUdBQkMSEeRPfuSPWWCz0/xJGdtmueZgCcpXKd
X-Received: by 10.141.28.6 with SMTP id f6mr15005611qhe.53.1444938452807;
        Thu, 15 Oct 2015 12:47:32 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279692>

In a moment, we'll create initdb functions for ref backends, and code
from initdb that calls this function needs to move into the files
backend.  So this function needs to be public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 12 ------------
 cache.h           |  5 +++++
 path.c            | 12 ++++++++++++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f59f407..07229d6 100644
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
index 9a905a8..1d8a051 100644
--- a/cache.h
+++ b/cache.h
@@ -1737,4 +1737,9 @@ void stat_validity_update(struct stat_validity *sv, int fd);
 int versioncmp(const char *s1, const char *s2);
 void sleep_millisec(int millisec);
 
+/*
+ * Create a directory and (if share is nonzero) adjust its permissions
+ * according to the shared_repository setting.
+ */
+void safe_create_dir(const char *dir, int share);
 #endif /* CACHE_H */
diff --git a/path.c b/path.c
index 212695a..9e0283c 100644
--- a/path.c
+++ b/path.c
@@ -723,6 +723,18 @@ int adjust_shared_perm(const char *path)
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
