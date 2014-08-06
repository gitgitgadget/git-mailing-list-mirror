From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 5/8] config: add `git_die_config()` to the config-set API
Date: Wed,  6 Aug 2014 07:53:09 -0700
Message-ID: <1407336792-16962-6-git-send-email-tanayabh@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2iC-0000E1-Md
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbaHFPBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:01:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59530 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbaHFPBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:01:01 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so3611505pac.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Ec6rwgHLyHfBNP6VfYfjJ+m/5teR8ky+rmodnOy0js=;
        b=AMYh4KEV234MCp4yr0sfPVrA8hdQ9Y4PBps2fpOYIzjDUPxBhTHpiCY28viuWeO/gd
         BQFWrCEnjmBXHEkQplrhG46/busgVWduFbJdqFmGqP7D6us18BTbAZVFXzwOi7/F6eQZ
         xg9BIA9XeEz8R7wvaSyKvB6qeMqguUNDfZfRjea58Wgp71WgqTjxXZEG6AMX0D1INuix
         C/4uUv/nrSuKrf2eCO+7MDBkY2rvVNaNr0P+RA68Zt5gIU8WUuaboGkIi7Fb8JcJOE64
         1D994p8mdmp71cHBGXcPqMFygWQkgNzDpVIJBEra0roVr+rg+wShpPiA/D9T2kcdrGQp
         Ge4w==
X-Received: by 10.70.89.161 with SMTP id bp1mr11950102pdb.62.1407337261051;
        Wed, 06 Aug 2014 08:01:01 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.00.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:01:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254861>

Add `git_die_config` that dies printing the line number and the file name
of the highest priority value for the configuration variable `key`. A custom
error message is also printed before dying, specified by the caller, which can
be skipped if `err` argument is set to NULL.

It has usage in non-callback based config value retrieval where we can
raise an error and die if there is a semantic error.
For example,

	if (!git_config_get_value(key, &value)){
		if (!strcmp(value, "foo"))
			git_config_die(key, "value: `%s` is illegal", value);
		else
			/* do work */
	}

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 13 ++++++++++++
 cache.h                                |  3 +++
 config.c                               | 39 ++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 21f280c..0d8b99b 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -155,6 +155,19 @@ as well as retrieval for the queried variable, including:
 	Similar to `git_config_get_string`, but expands `~` or `~user` into
 	the user's home directory when found at the beginning of the path.
 
+`git_die_config(const char *key, const char *err, ...)`::
+
+	First prints the error message specified by the caller in `err` and then
+	dies printing the line number and the file name of the highest priority
+	value for the configuration variable `key`.
+
+`void git_die_config_linenr(const char *key, const char *filename, int linenr)`::
+
+	Helper function which formats the die error message according to the
+	parameters entered. Used by `git_die_config()`. It can be used by callers
+	handling `git_config_get_value_multi()` to print the correct error message
+	for the desired value.
+
 See test-config.c for usage examples.
 
 Value Parsing Helpers
diff --git a/cache.h b/cache.h
index f11ce41..89a0d51 100644
--- a/cache.h
+++ b/cache.h
@@ -1388,6 +1388,9 @@ struct key_value_info {
 	int linenr;
 };
 
+extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.c b/config.c
index 4cefa25..5ae9ab0 100644
--- a/config.c
+++ b/config.c
@@ -1469,8 +1469,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
 int git_config_get_string_const(const char *key, const char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_string_const(&the_config_set, key, dest);
+	ret = git_configset_get_string_const(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key, NULL);
+	return ret;
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -1511,8 +1515,39 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
 int git_config_get_pathname(const char *key, const char **dest)
 {
+	int ret;
 	git_config_check_init();
-	return git_configset_get_pathname(&the_config_set, key, dest);
+	ret = git_configset_get_pathname(&the_config_set, key, dest);
+	if (ret < 0)
+		git_die_config(key, NULL);
+	return ret;
+}
+
+NORETURN
+void git_die_config_linenr(const char *key, const char *filename, int linenr)
+{
+	if (!filename)
+		die(_("unable to parse '%s' from command-line config"), key);
+	else
+		die(_("bad config variable '%s' in file '%s' at line %d"),
+		    key, filename, linenr);
+}
+
+NORETURN __attribute__((format(printf, 2, 3)))
+void git_die_config(const char *key, const char *err, ...)
+{
+	const struct string_list *values;
+	struct key_value_info *kv_info;
+
+	if (err) {
+		va_list params;
+		va_start(params, err);
+		vreportf("error: ", err, params);
+		va_end(params);
+	}
+	values = git_config_get_value_multi(key);
+	kv_info = values->items[values->nr - 1].util;
+	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
 }
 
 /*
-- 
1.9.0.GIT
