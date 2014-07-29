From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 5/6] config: add `git_die_config()` to the config-set API
Date: Tue, 29 Jul 2014 04:28:21 -0700
Message-ID: <1406633302-23144-6-git-send-email-tanayabh@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5by-0003R4-WD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaG2LaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:30:20 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56713 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbaG2LaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:30:17 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so11574603pdb.31
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfT2svD766kN9OPT3YeQUjvoeu9VV0HaH7mhaR6hIII=;
        b=WZea66wJol+DBOsP8nV5nVR81nQwsQy1KKRy2fGWNSp8CfUyqU3NvNDxNzNLAAqrvQ
         ZjeYWL1C6Kc7O7Zc8LgyMO6DobxnM0MA/L39fqxSo14HdNQKMiM5nEOLCvMEZVXdSJFv
         5hkNxQtnkP5mG16NllYzsLVgTe6NXx2nBTcUUx6HL+KTriFMjk0Dlv2Rzmd71GBQ5DzO
         lqGTmKKVVKRMO3BN1wCVENHl2exmjRYX8NHhfhYPbipbfe32mEAjBmZ2QlZN8fuzs1LK
         RNWGERSkqFoMn7oPtX2ElI4fDwoxvX0c8Lib9yWvxNnZPx8rwKDKQ/8V61RLGhlSJ/rY
         Npag==
X-Received: by 10.66.161.169 with SMTP id xt9mr1453221pab.102.1406633416681;
        Tue, 29 Jul 2014 04:30:16 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.30.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:30:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254417>

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
index 1134741..16e99bf 100644
--- a/config.c
+++ b/config.c
@@ -1506,8 +1506,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
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
@@ -1548,10 +1552,29 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
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
