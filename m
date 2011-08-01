From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Mon,  1 Aug 2011 23:36:49 +0530
Message-ID: <1312222025-28453-3-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:11:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwxE-0003Xt-HF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab1HASKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:10:53 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62360 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1HASKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:10:52 -0400
Received: by pzk37 with SMTP id 37so11912645pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xjFWxHUB50Q40Vud5GpGeV/lLmM+loqtiPOT9nPJYcM=;
        b=ilDuy4A1K5F+eNZGDWdC01/+81DK+DjghPNntWqJuGbq5InwjAKiRjgqlKED7Lx/Kh
         siKcujIiG2oZiNBSmMiJfGObut3XnPZYJNjYYZvXY3hbubxnppCxdl1DtmA5JIHG8uV+
         /26jDmBsWNAaM5NZYL7JzKFEUoTPp1hJiZ6Jg=
Received: by 10.68.5.201 with SMTP id u9mr7716808pbu.218.1312222251660;
        Mon, 01 Aug 2011 11:10:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.10.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:10:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178373>

Introduce two new functions corresponding to "git_config_set" and
"git_config_set_multivar" to write a non-standard configuration file.
Expose these new functions in cache.h for other git programs to use.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
index e42c59b..9e8580b 100644
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
+	char *buf = NULL;
+	int ret;
+
+	if (config_exclusive_filename)
+		config_filename = config_exclusive_filename;
+	else
+		config_filename = buf = git_pathdup("config");
+
+	ret = git_config_set_multivar_in_file(config_filename, key, value,
+					value_regex, multi_replace);
+	free(buf);
+	return ret;
+}
+
 static int section_name_match (const char *buf, const char *name)
 {
 	int i = 0, j = 0, dot = 0;
-- 
1.7.4.rc1.7.g2cf08.dirty
