From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 06/11] rerere.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon,  4 Aug 2014 11:33:44 -0700
Message-ID: <1407177229-30081-7-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN62-0007pS-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaHDSez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:55 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48402 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaHDSey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so10441277pab.20
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zS3v4nXMWeVexrgG6wlDFJWVcNooN8zXH/av7qQ7WtM=;
        b=xc4aL11JXlBPC5OO+Cyob4zQ4NMFobOs1qCOun5/bE8GusUMYuEI8AWLVreRt+Qf3u
         3X1W0wP0jwUSJu2TnYTWqnOFWGbEy25ywhB95hNA9HoEPeBWEGxV4SxeeCvkOzjBQg6L
         YkghqoMv1UsyP75vOiREkeO0rRbQnwmPGE87oMraGiKzydXmQvR2IiUyZTb2aD0GxT2O
         UOAgShRoUJsD1oZUcqzl8hRVl9DMYJnlmu2/3jNCgRFi7srpH1mHBvtogtcQN5u3T+Yo
         Z6tvD/8ItpPcQL4fGuZeisQKYZCuFtMnuj9iuqq9iBrCEpbLtZhWu3YfBKELWiTwLDm4
         79lg==
X-Received: by 10.70.64.225 with SMTP id r1mr3633344pds.167.1407177293978;
        Mon, 04 Aug 2014 11:34:53 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254756>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 rerere.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/rerere.c b/rerere.c
index d84b495..20b18ad 100644
--- a/rerere.c
+++ b/rerere.c
@@ -573,15 +573,11 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	return write_rr(rr, fd);
 }
 
-static int git_rerere_config(const char *var, const char *value, void *cb)
+static void git_rerere_config(void)
 {
-	if (!strcmp(var, "rerere.enabled"))
-		rerere_enabled = git_config_bool(var, value);
-	else if (!strcmp(var, "rerere.autoupdate"))
-		rerere_autoupdate = git_config_bool(var, value);
-	else
-		return git_default_config(var, value, cb);
-	return 0;
+	git_config_get_bool("rerere.enabled", &rerere_enabled);
+	git_config_get_bool("rerere.autoupdate", &rerere_autoupdate);
+	git_config(git_default_config, NULL);
 }
 
 static int is_rerere_enabled(void)
@@ -606,7 +602,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 {
 	int fd;
 
-	git_config(git_rerere_config, NULL);
+	git_rerere_config();
 	if (!is_rerere_enabled())
 		return -1;
 
@@ -699,24 +695,6 @@ static void unlink_rr_item(const char *name)
 	rmdir(git_path("rr-cache/%s", name));
 }
 
-struct rerere_gc_config_cb {
-	int cutoff_noresolve;
-	int cutoff_resolve;
-};
-
-static int git_rerere_gc_config(const char *var, const char *value, void *cb)
-{
-	struct rerere_gc_config_cb *cf = cb;
-
-	if (!strcmp(var, "gc.rerereresolved"))
-		cf->cutoff_resolve = git_config_int(var, value);
-	else if (!strcmp(var, "gc.rerereunresolved"))
-		cf->cutoff_noresolve = git_config_int(var, value);
-	else
-		return git_default_config(var, value, cb);
-	return 0;
-}
-
 void rerere_gc(struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
@@ -724,9 +702,12 @@ void rerere_gc(struct string_list *rr)
 	struct dirent *e;
 	int i, cutoff;
 	time_t now = time(NULL), then;
-	struct rerere_gc_config_cb cf = { 15, 60 };
+	int cutoff_noresolve = 15;
+	int cutoff_resolve = 60;
 
-	git_config(git_rerere_gc_config, &cf);
+	git_config_get_int("gc.rerereresolved", &cutoff_resolve);
+	git_config_get_int("gc.rerereunresolved", &cutoff_noresolve);
+	git_config(git_default_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
 		die_errno("unable to open rr-cache directory");
@@ -736,12 +717,12 @@ void rerere_gc(struct string_list *rr)
 
 		then = rerere_last_used_at(e->d_name);
 		if (then) {
-			cutoff = cf.cutoff_resolve;
+			cutoff = cutoff_resolve;
 		} else {
 			then = rerere_created_at(e->d_name);
 			if (!then)
 				continue;
-			cutoff = cf.cutoff_noresolve;
+			cutoff = cutoff_noresolve;
 		}
 		if (then < now - cutoff * 86400)
 			string_list_append(&to_remove, e->d_name);
-- 
1.9.0.GIT
