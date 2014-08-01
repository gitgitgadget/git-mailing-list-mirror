From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Fri,  1 Aug 2014 10:05:53 -0700
Message-ID: <1406912756-15517-6-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:07:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGIM-0001vS-HC
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbaHARHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:07:00 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:42533 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbaHARG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so5891755pdj.29
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8p+4XpNkdXhMYmZtSmTEEkPhWusecXEWVU7b0JaHdzs=;
        b=cpej8NPCchRAK8RgMH4RbDjZGSAnAf2X80Y+ztCDV3MecyrderOhrsg88/t9ojNUdc
         ueUQFrXYIeWSs4JM04Vr9Cw2Il1PmH8QMPLrSihRNE2+cuEm7NMIJrBbo69yxmNi4fnW
         wcASBVqaC3yPXR0AD4jaxDS4ESRxQxtpo7Ipi3G/JiaFjVHyjkk9EnY1IfTeFIKvealI
         smKkRRpP/vllVve27SdK99vZdHlP03Ns/bXaAJ5WBdz9g8WzuLJpAPO0IEjIVHIE1Wyn
         Nu15n0edaLph4YwPfaBD2m/C09cxB6OAQr0eyBUZ41sYE/KDFNOdTcOXL8JaR5KA2COw
         Vk6g==
X-Received: by 10.68.94.34 with SMTP id cz2mr7707351pbb.7.1406912818891;
        Fri, 01 Aug 2014 10:06:58 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254638>

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
 Documentation/technical/api-config.txt | 12 ++++++++++++
 cache.h                                |  2 ++
 config.c                               | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 815c1ee..d6a2c39 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -155,6 +155,18 @@ as well as retrieval for the queried variable, including:
 	Similar to `git_config_get_string`, but expands `~` or `~user` into
 	the user's home directory when found at the beginning of the path.
 
+`void git_die_config(const char *key)`::
+
+	Dies printing the line number and the file name of the highest
+	priority value for the configuration variable `key`.
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
index c61919d..9ec2f4e 100644
--- a/cache.h
+++ b/cache.h
@@ -1382,6 +1382,8 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern void git_die_config(const char *key);
+extern void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index f923b1c..ddbfe4d 100644
--- a/config.c
+++ b/config.c
@@ -1474,8 +1474,12 @@ const struct string_list *git_config_get_value_multi(const char *key)
 
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
@@ -1516,8 +1520,34 @@ int git_config_get_maybe_bool(const char *key, int *dest)
 
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
+NORETURN
+void git_die_config_linenr(const char *key, const char *filename, int linenr)
+{
+	if (!linenr)
+		die(_("unable to parse '%s' from command-line config"), key);
+	else
+		die(_("bad config variable '%s' at file line %d in %s"),
+			key,
+			linenr,
+			filename);
+}
+
+NORETURN
+void git_die_config(const char *key)
+{
+	const struct string_list *values;
+	struct key_value_info *kv_info;
+	values = git_config_get_value_multi(key);
+	kv_info = values->items[values->nr - 1].util;
+	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
 }
 
 /*
-- 
1.9.0.GIT
