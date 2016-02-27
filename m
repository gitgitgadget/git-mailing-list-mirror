From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] environment.c: introduce SETUP_GIT_ENV helper macro
Date: Sat, 27 Feb 2016 23:13:35 +0600
Message-ID: <1456593215-16302-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:18:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZiVL-0003B5-IF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638AbcB0RSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:18:01 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35108 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbcB0RSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:18:00 -0500
Received: by mail-lf0-f51.google.com with SMTP id l143so69912520lfe.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LsM/fmunjOTZknDVsgtlMcsEnmXgGz70sXNLvPGe+kk=;
        b=Lnx/zoei6wW29fFN+PZN3Ttqtl5QTiNKymxTo1ffaPuQm+lKZERgW9k08BSBFw0P+n
         X3khR1uQxLlf6SYVcWtNQbfWYB9TdOz+etwNJkFndDnybVJxriFDLXN57tNcA+vdSxE2
         TaCRd2Tef74IH/pUyeGRedRIf4lD2rOk7qXOfJHqCgTdCFBrj/L1x/8PIToMSzjzY5vi
         9HyX3gZpdzbRnTYkUQBA4ZtUI2wIOY2FwrXcfU7qQl30pYefMzjM9UwKdikJUjD5gY/x
         a1PwMyy1jZMQi8HpajQQSdwm2KtFyIdlR6jwl6KXMV/iMKomP2V+TX3GeR2yGVRroRoE
         VIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LsM/fmunjOTZknDVsgtlMcsEnmXgGz70sXNLvPGe+kk=;
        b=X1P9X9x2ksCtVJ2xpoZhX+qGAwK9j09+BMKyGIz9hATswMzCQzbtmWmOZ1a7PH6C9u
         4mvZK9tPgSLd00pt0Cw/ZntWQJEdBaLhxoH5OBEHO1Fc92HYo1to98jBlaFSpvmKWnqi
         soEoxAQnwsf3H5ne+ikKL+qPh4n9EaNejL2psH8RVb3EBKiaZUfs1jsT4xdouGl3i8Ye
         5sO86tOjDC8CLrzlJZ/tnEd+IhAu0IUS1Vk40ESX73Yy/O1wScgxx4ylz1Zk6WGR5bVU
         gGyXVozfV0dd2PHzQdUee4KxLa7VCdbXOe7AN4IE0M3kwND2cP3x26uDyNnxNHikg5Y5
         xG1A==
X-Gm-Message-State: AD7BkJI5sZndcAVrMijvIHiCam423icfUa1cgk5HAbuOKwYCfIxZoV9h0XMUGJtyhecIqA==
X-Received: by 10.25.42.13 with SMTP id q13mr2634023lfq.96.1456593478499;
        Sat, 27 Feb 2016 09:17:58 -0800 (PST)
Received: from localhost.localhost ([2.134.234.130])
        by smtp.gmail.com with ESMTPSA id s75sm2563396lfs.21.2016.02.27.09.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Feb 2016 09:17:57 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.142.g64f2103.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287704>

The environment.c contans a couple of functions which are
consist from the following pattern:

        if (!env)
                setup_git_env();
        return env;

Let's move this to the SETUP_GIT_ENV helper macro to prevent
code duplication in these functions.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 environment.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/environment.c b/environment.c
index 6dec9d0..04cb6cd 100644
--- a/environment.c
+++ b/environment.c
@@ -126,6 +126,11 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
+#define SETUP_GIT_ENV(env)              \
+	if (!env)                       \
+		setup_git_env();        \
+	return env;
+
 static char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -199,9 +204,7 @@ int is_bare_repository(void)
 
 const char *get_git_dir(void)
 {
-	if (!git_dir)
-		setup_git_env();
-	return git_dir;
+	SETUP_GIT_ENV(git_dir);
 }
 
 const char *get_git_common_dir(void)
@@ -211,9 +214,7 @@ const char *get_git_common_dir(void)
 
 const char *get_git_namespace(void)
 {
-	if (!namespace)
-		setup_git_env();
-	return namespace;
+	SETUP_GIT_ENV(namespace);
 }
 
 const char *strip_namespace(const char *namespaced_ref)
@@ -251,9 +252,7 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!git_object_dir)
-		setup_git_env();
-	return git_object_dir;
+	SETUP_GIT_ENV(git_object_dir);
 }
 
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
@@ -295,16 +294,12 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
 
 char *get_index_file(void)
 {
-	if (!git_index_file)
-		setup_git_env();
-	return git_index_file;
+	SETUP_GIT_ENV(git_index_file);
 }
 
 char *get_graft_file(void)
 {
-	if (!git_graft_file)
-		setup_git_env();
-	return git_graft_file;
+	SETUP_GIT_ENV(git_graft_file);
 }
 
 int set_git_dir(const char *path)
-- 
2.5.0
