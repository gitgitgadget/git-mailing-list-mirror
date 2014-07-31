From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 6/7] config: add `git_die_config()` to the config-set API
Date: Thu, 31 Jul 2014 02:44:16 -0700
Message-ID: <1406799857-28048-7-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:46:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmw1-0004xN-IO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbaGaJqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:46:00 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:62507 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbaGaJp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:58 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so3158768pdi.34
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kcCGeunSz8oDCrMfEXwVVTkjIQGe/b6vMCqfXp5/l1o=;
        b=loJIw7igtEy99nnpzjuv5Bbpq4l1eYLg3G9Xasi2/1mHA0VaQpZiT+U10QBRdH6F5s
         mPXYdjg7vgIEyly9DypTaZLoix1B2UlFfzyv5Mffg81KvvVeJDezdVec/QvieNKsp5wg
         Fo2dSS7jk9rxdrUm3oWMaJVgH2XO8ZLU+TY/Cu+eJVD3+S6KEHrZW8yDpOB6k1DQkfl4
         /31EfsAZIGuULShbGpIa57i0f+yOFnJOTg2e+yIyr5uEQRvzVyfZ6DECmcwhV6OLebAO
         2OdIod0QrSTS2/xBR2fCJr3CCu1gKAHzJRhp1tKPkPK1RABKyPw8FPdxSzr6W4lW6pkf
         7qxA==
X-Received: by 10.68.133.193 with SMTP id pe1mr2166914pbb.154.1406799955094;
        Thu, 31 Jul 2014 02:45:55 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254548>

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
 config.c                               | 27 +++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

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
index 4d3c6bd..243f618 100644
--- a/cache.h
+++ b/cache.h
@@ -1406,6 +1406,7 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern void git_die_config(const char *key);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index 4937515..03369b8 100644
--- a/config.c
+++ b/config.c
@@ -1515,8 +1515,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
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
@@ -1557,10 +1561,29 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
 int git_config_get_pathname(const char *key, const char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_pathname(&the_config_set, key, dest);
+	ret = git_configset_get_pathname(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key);
+	return ret;
 }
 
+void git_die_config(const char *key)
+{
+	const struct string_list *values;
+	struct key_value_info *kv_info;
+	values = git_config_get_value_multi(key);
+	kv_info = values->items[values->nr - 1].util;
+	if (!kv_info->linenr)
+		die("unable to parse '%s' from command-line config", key);
+	else
+		die("bad config variable '%s' at file line %d in %s",
+			key,
+			kv_info->linenr,
+			kv_info->filename);
+ }
+
 /*
  * Find all the stuff for git_config_set() below.
  */
-- 
1.9.0.GIT
