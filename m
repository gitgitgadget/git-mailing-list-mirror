From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Wed, 27 Jul 2011 08:48:59 +0530
Message-ID: <1311736755-24205-3-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qluhx-0005xW-LP
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab1G0DWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:22:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33787 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab1G0DW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:22:28 -0400
Received: by gyh3 with SMTP id 3so764601gyh.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+pR1n6xbO+TtPem/6bKGvz4pSKRMAbAt20MXp2V25rM=;
        b=ieO86no/aLWx0wLWfkuzeD0ohj7bpe7KNwZqmhPHu1eZon0HdWFhzQlKGplxr96vul
         P6ei6Wz/kJGr9vYiAKLzzgxmYq1tMTbatGs3tChOtE2LyCe8kEIUKjg5j1ssrZgV9LvC
         HZP6E6KzOy3jEfS8wF9TOqOc2gKFd8rvPEBd4=
Received: by 10.142.56.6 with SMTP id e6mr4414039wfa.86.1311736946988;
        Tue, 26 Jul 2011 20:22:26 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.22.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:22:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177906>

Introduce two new functions corresponding to "git_config_set" and
"git_config_set_multivar" to write a non-standard configuration file.
Expose thse new functions in cache.h for other git programs to use.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h  |    2 ++
 config.c |   36 +++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 9e12d55..33d3428 100644
--- a/cache.h
+++ b/cache.h
@@ -1069,9 +1069,11 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
diff --git a/config.c b/config.c
index 6b61a84..a0578b2 100644
--- a/config.c
+++ b/config.c
@@ -1092,6 +1092,12 @@ contline:
 	return offset;
 }
 
+int git_config_set_in_file(const char *config_filename,
+			const char *key, const char *value)
+{
+	return git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
+}
+
 int git_config_set(const char *key, const char *value)
 {
 	return git_config_set_multivar(key, value, NULL, 0);
@@ -1189,19 +1195,14 @@ out_free_ret_1:
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char *key, const char *value,
-	const char *value_regex, int multi_replace)
+int git_config_set_multivar_in_file(const char *config_filename,
+				const char *key, const char *value,
+				const char *value_regex, int multi_replace)
 {
 	int fd = -1, in_fd;
 	int ret;
-	char *config_filename;
 	struct lock_file *lock = NULL;
 
-	if (config_exclusive_filename)
-		config_filename = xstrdup(config_exclusive_filename);
-	else
-		config_filename = git_pathdup("config");
-
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
@@ -1378,7 +1379,6 @@ int git_config_set_multivar(const char *key, const char *value,
 out_free:
 	if (lock)
 		rollback_lock_file(lock);
-	free(config_filename);
 	return ret;
 
 write_err_out:
@@ -1387,6 +1387,24 @@ write_err_out:
 
 }
 
+int git_config_set_multivar(const char *key, const char *value,
+			const char *value_regex, int multi_replace)
+{
+	const char *config_filename;
+	char *filename_buf = NULL;
+	int ret;
+
+	if (config_exclusive_filename)
+		config_filename = config_exclusive_filename;
+	else
+		config_filename = filename_buf = git_pathdup("config");
+
+	ret = git_config_set_multivar_in_file(config_filename, key, value,
+					value_regex, multi_replace);
+	free(filename_buf);
+	return ret;
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-- 
1.7.4.rc1.7.g2cf08.dirty
