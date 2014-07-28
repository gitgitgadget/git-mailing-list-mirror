From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 5/6] config: add `git_die_config()` to the config-set API
Date: Mon, 28 Jul 2014 03:33:54 -0700
Message-ID: <1406543635-19281-6-git-send-email-tanayabh@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGi-0008Ow-FM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaG1Kew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35902 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbaG1Ket (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so10269354pab.33
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUUN5dKurllagrlML3M9dII42uXxF4WZX0Dg4SkmKEQ=;
        b=zbMwyZikzhBB+Ey0XFRzIt/drbzSYBqAz5UwkLBetuLkL++0woYVz4DZ+yS0RMUyCW
         QbYKr5i6gYc1jU9K2rRUA8HCQHM7Oz7nuBPuwxPFotXDiHG//QoGBjP1+IY3DbB99knQ
         72vX8nbxE4P9AZ++oPVWzKE6gbv9TOW1O1EA9++kKby0BTiOX5KJc4C3xt+LJ67ooDO+
         Qf4CWXNRXsK56b5dHRIkrHjxMZqRydBOnSAm06KK9qHCWLeAJLaETPkWQazUtoFnw34c
         /CTbmLxAcUfl8jKrWRh+bhGBif18fRsgS41NzwaPm3W97uPWOb7Rrt3IcTave+Mt8Vm8
         8fCg==
X-Received: by 10.69.10.164 with SMTP id eb4mr37774219pbd.35.1406543688924;
        Mon, 28 Jul 2014 03:34:48 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254295>

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
Note: git_config_get_string() calls git_config_get_string_const(),
so no need to check for whether to die or not, as it is done by
git_config_get_string_const().

 Documentation/technical/api-config.txt |  5 +++++
 cache.h                                |  1 +
 config.c                               | 24 ++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

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
index 93bdbab..8512225 100644
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
index 2ce3318..136ee9c 100644
--- a/config.c
+++ b/config.c
@@ -1505,8 +1505,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
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
@@ -1547,10 +1551,26 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
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
+		die("unable to parse command-line config");
+	else
+		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);
+ }
+
 /*
  * Find all the stuff for git_config_set() below.
  */
-- 
1.9.0.GIT
