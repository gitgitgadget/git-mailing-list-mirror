From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 5/6] config: add `git_die_config()` to the config-set API
Date: Fri, 25 Jul 2014 05:58:14 -0700
Message-ID: <1406293095-15920-6-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf67-0003OZ-JD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760427AbaGYM7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:39 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38754 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760424AbaGYM7i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:38 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so6018783pab.6
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89YSHkLmClXkKdCu+n3E+z9IbPfQjOSB0JgdrrSoYZs=;
        b=ASt2vL8G7aFI+8zqhbx2UkpE/4a9TajTfmSfarNzZUU37/SjZdTQBYw5RztfCnTOeW
         j4anrahWD2TvGa7TpgDS8u/yISpHHCRZ4MW1GxlOvBewgEBUkC38Z1Gvuta5kmHwcbIj
         8DcJlsnDD7XRW4qiJs/wMc/gGAsx7n0ccatG0xcYAulLXKiZaX99tpVKhti0e+EXiUeG
         4qMTi8neOdDJwrmHq2m+LHHTH5Hx9A0G74c5f8NJk3HPsaQRZOs2QI71a7HftBI71Vmn
         KeczoT52k7WsBCPp4MMyLnVJ8RrNVnyA8dxU/SQu5L6zoR4UKu0Kf/Swwg+9OqYJfp9B
         tZfQ==
X-Received: by 10.68.125.226 with SMTP id mt2mr18827707pbb.6.1406293177814;
        Fri, 25 Jul 2014 05:59:37 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.59.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:59:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254216>

Add `git_die_config` that dies printing the line number and the file name
of the highest priority value for the configuration variable `key`.

It has usage in non-callback based config value retrieval where we can
raise an error and die if there is a semantic error.
For example,

	if (!git_config_get_value(key, &value)) {
		/* NULL values not allowed */
		if (!value)
			git_config_die(key);
		else
			/* do work */
	}

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt |  5 ++++
 cache.h                                |  1 +
 config.c                               | 44 ++++++++++++++++++++++++++--------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 815c1ee..e7ec7cc 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -155,6 +155,11 @@ as well as retrieval for the queried variable, including:
 	Similar to `git_config_get_string`, but expands `~` or `~user` into
 	the user's home directory when found at the beginning of the path.
 
+`void git_die_config(const char *key)`::
+
+	Dies printing the line number and the file name of the highest
+	priority value for the configuration variable `key`.
+
 See test-config.c for usage examples.
 
 Value Parsing Helpers
diff --git a/cache.h b/cache.h
index 11ded5a..5c3dd88 100644
--- a/cache.h
+++ b/cache.h
@@ -1407,6 +1407,7 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern void git_die_config(const char *key);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index aa5c0ad..1e49ae7 100644
--- a/config.c
+++ b/config.c
@@ -1403,11 +1403,12 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
 
 int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
 {
-	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
-		return git_config_string(dest, key, value);
-	else
-		return 1;
+	int ret;
+	char *value;
+	ret = git_configset_get_string(cs, key, &value);
+	if (ret <= 0)
+		*dest = (const char*)value;
+	return ret;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -1418,8 +1419,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
 			return config_error_nonbool(key);
 		*dest = xstrdup(value);
 		return 0;
-	}
-	else
+	} else
 		return 1;
 }
 
@@ -1514,14 +1514,22 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
 int git_config_get_string_const(const char *key, const char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_string_const(&the_config_set, key, dest);
+	ret = git_configset_get_string_const(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key);
+	return ret;
 }
 
 int git_config_get_string(const char *key, char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_string(&the_config_set, key, dest);
+	ret = git_configset_get_string(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key);
+	return ret;
 }
 
 int git_config_get_int(const char *key, int *dest)
@@ -1556,8 +1564,24 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
 int git_config_get_pathname(const char *key, const char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_pathname(&the_config_set, key, dest);
+	ret = git_configset_get_pathname(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key);
+	return ret;
+}
+
+void git_die_config(const char *key)
+{
+	const struct string_list *values;
+	struct key_value_info *kv_info;
+	values = git_config_get_value_multi(key);
+	kv_info = values->items[values->nr - 1].util;
+	if (!kv_info->linenr)
+		die("unable to parse command-line config");
+	else
+		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);
 }
 
 /*
-- 
1.9.0.GIT
