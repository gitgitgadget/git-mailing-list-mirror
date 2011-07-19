From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Tue, 19 Jul 2011 22:47:40 +0530
Message-ID: <1311095876-3098-3-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDwa-0002rX-9e
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab1GSRSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:18:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1GSRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:18:47 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hloFMV4nWW1Af4wlJ07fYco/ryTI6MkIGxVJ4PouZ3k=;
        b=MJruz0HC0S4kVFplH0AEUkwPIFVxICD2HZ50TOfQWDWubPLup4gGhPpNdSDgPi5BWe
         Pc27a1jGJrdQZ+ZFT6IbEsJsCrVgQb+iuYuwSrCvyUGS4JVPEgTSsA81TT26D6oDq3E9
         LOl467AuK5ldxDOTOqMaRCz4kVPQrMY/Z3Dyg=
Received: by 10.143.26.34 with SMTP id d34mr3546562wfj.165.1311095927367;
        Tue, 19 Jul 2011 10:18:47 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.18.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:18:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177467>

Introduce two new functions corresponding to "git_config_set" and
"git_config_set_multivar" to write a non-standard configuration file.
Expose thse new functions in cache.h for other git programs to use.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h  |    2 ++
 config.c |   25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index bc9e5eb..833ee75 100644
--- a/cache.h
+++ b/cache.h
@@ -1056,9 +1056,11 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file(const char *, const char *, const char *, int, const char *);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
diff --git a/config.c b/config.c
index 1fc063b..443324e 100644
--- a/config.c
+++ b/config.c
@@ -1092,9 +1092,15 @@ contline:
 	return offset;
 }
 
+int git_config_set_in_file(const char *key, const char *value,
+			const char *filename)
+{
+	return git_config_set_multivar_in_file(key, value, NULL, 0, filename);
+}
+
 int git_config_set(const char *key, const char *value)
 {
-	return git_config_set_multivar(key, value, NULL, 0);
+	return git_config_set_in_file(key, value, config_exclusive_filename);
 }
 
 /*
@@ -1189,14 +1195,19 @@ out_free_ret_1:
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char *key, const char *value,
-	const char *value_regex, int multi_replace)
+int git_config_set_multivar_in_file(const char *key, const char *value,
+				const char *value_regex, int multi_replace,
+				const char *filename)
 {
 	int fd = -1, in_fd;
 	int ret;
 	char *config_filename;
+	const char *saved_config_filename;
 	struct lock_file *lock = NULL;
 
+	saved_config_filename = config_exclusive_filename;
+	config_exclusive_filename = filename;
+
 	if (config_exclusive_filename)
 		config_filename = xstrdup(config_exclusive_filename);
 	else
@@ -1379,6 +1390,7 @@ out_free:
 	if (lock)
 		rollback_lock_file(lock);
 	free(config_filename);
+	config_exclusive_filename = saved_config_filename;
 	return ret;
 
 write_err_out:
@@ -1387,6 +1399,13 @@ write_err_out:
 
 }
 
+int git_config_set_multivar(const char *key, const char *value,
+			const char *value_regex, int multi_replace)
+{
+	return git_config_set_multivar_in_file(key, value, value_regex,
+					multi_replace, config_exclusive_filename);
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-- 
1.7.4.rc1.7.g2cf08.dirty
