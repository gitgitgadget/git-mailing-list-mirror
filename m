From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 6/7] config: add `git_die_config()` to the config-set API
Date: Wed, 23 Jul 2014 11:42:57 -0700
Message-ID: <1406140978-9472-7-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WT-0006n7-4G
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbaGWSoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:44:11 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43183 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867AbaGWSoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:44:08 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so2124479pdj.29
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiuEE9ygyzAL2enRgtjVtWemSklLvqSsDqG9vFqPzw4=;
        b=ueLauSza/fFLTg2a14YumCsIE2YS2KOGlKpqtBWnGuKHm3nOM1QVN5XMsERPY9dQyN
         5u5Ls3ezSK/jgvwLSyAqMcmOZbNjWxGqwYTRTQCvX8dH+0wkW5svuWklEqiTiDwhhOwm
         N5sB7IKFNnVJncXoiwlBgaoOsZ9Nob4Qa0FqEM4Lh/03YzHaxTVNBnNpqQrwTsrzhonn
         lOBarxHkPyBaVJcXpYS3SLrThW4aeKzkc7yMMBUvnw/qkYixTzYK77gdpeZHV+vomtih
         kOGrmQpUtuYyuFe4P1LqNbbGF/T89ZKjZfOAA0C9yxLoCDH9I4sASNfKK1PlZ8uxsnrQ
         CNSg==
X-Received: by 10.66.230.163 with SMTP id sz3mr4454600pac.136.1406141048004;
        Wed, 23 Jul 2014 11:44:08 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.44.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:44:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254107>

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
 Documentation/technical/api-config.txt |  5 +++++
 cache.h                                |  1 +
 config.c                               | 24 ++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 8a86e45..14571e7 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -150,6 +150,11 @@ as well as retrieval for the queried variable, including:
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
index 2f63fd1..fc886c3 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,6 +1380,7 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern void git_die_config(const char *key);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index 43a951f..f0c9805 100644
--- a/config.c
+++ b/config.c
@@ -1491,8 +1491,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
 int git_config_get_string(const char *key, const char **dest)
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
@@ -1527,8 +1531,24 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
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
+	const struct string_list *strptr;
+	struct key_value_info *kv_info;
+	strptr = git_config_get_value_multi(key);
+	kv_info = strptr->items[strptr->nr - 1].util;
+	if (!kv_info->linenr)
+		die("unable to parse command-line config");
+	else
+		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);
 }
 
 /*
-- 
1.9.0.GIT
