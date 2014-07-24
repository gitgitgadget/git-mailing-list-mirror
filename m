From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 24 Jul 2014 20:34:24 +0530
Message-ID: <53D12078.2070004@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com> <xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAKZO-0003yW-WB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 17:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759270AbaGXPEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 11:04:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64504 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759075AbaGXPEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 11:04:30 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so4085642pad.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gq73UmgHLfgNA+iv1PzDgYBKrF8zSMEE62MPRwgCFh8=;
        b=SLXazRpwhuRmueA/3BTW8B9y35bbwTQJBhOzNBA78bdWMe7PqCMNrfig90ld9S8jB6
         sYEZeqrDHS7XwlDdrnE2RyyMkxyIqsYqdPAcVxBrqXFluqtH2322wVBmcL85Ot+hgYOd
         WkXfQYk4KZo3uTjtSOJ/rOqA/RFTPXTbzfSbBGywbfRzRez+kfjpW61O38++/XiLriQ0
         qipbTp3NEDCpJxuT/kzIS6YyaZT1Jnn78FLoUcW4MiIwhvdxWvxl7nBltI9knJ6RwmYo
         WNCU7qE03GXi+F/2ZlFHzI1skahR0NvENhsSJGnkvyoO7NLAKD7MilKSDvDYQJk5+Vah
         N02A==
X-Received: by 10.70.16.68 with SMTP id e4mr2036402pdd.161.1406214269599;
        Thu, 24 Jul 2014 08:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id vu7sm21596879pab.34.2014.07.24.08.04.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 08:04:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254160>

> 
> Are you done with the original series, or do you still want to fix
> the const-ness issue with the string pointer before working on
> follow-up topics like this one?
>

I am attaching the v12 with two new functions git_configset_get_string() &
git_configset_get_string_const().

Diff between v11 and v12 is appended below for easy review.

-- 8< --
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 8a86e45..815c1ee 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -138,13 +138,18 @@ as well as retrieval for the queried variable, including:
 	Similar to `git_config_get_bool`, except that it returns -1 on error
 	rather than dying.

-`int git_config_get_string(const char *key, const char **dest)`::
+`int git_config_get_string_const(const char *key, const char **dest)`::

 	Allocates and copies the retrieved string into the `dest` parameter for
 	the configuration variable `key`; if NULL string is given, prints an
 	error message and returns -1. When the configuration variable `key` is
 	not found, returns 1 without touching `dest`.

+`int git_config_get_string(const char *key, char **dest)`::
+
+	Similar to `git_config_get_string_const`, except that retrieved value
+	copied into the `dest` parameter is a mutable string.
+
 `int git_config_get_pathname(const char *key, const char **dest)`::

 	Similar to `git_config_get_string`, but expands `~` or `~user` into
diff --git a/cache.h b/cache.h
index 2f63fd1..7292aef 100644
--- a/cache.h
+++ b/cache.h
@@ -1361,7 +1361,8 @@ extern int git_configset_add_file(struct config_set *cs, const char *filename);
 extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
 extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
 extern void git_configset_clear(struct config_set *cs);
-extern int git_configset_get_string(struct config_set *cs, const char *key, const char **dest);
+extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
+extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
 extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
 extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
@@ -1373,7 +1374,8 @@ extern int git_config_get_value(const char *key, const char **value);
 extern const struct string_list *git_config_get_value_multi(const char *key);
 extern void git_config_clear(void);
 extern void git_config_iter(config_fn_t fn, void *data);
-extern int git_config_get_string(const char *key, const char **dest);
+extern int git_config_get_string_const(const char *key, const char **dest);
+extern int git_config_get_string(const char *key, char **dest);
 extern int git_config_get_int(const char *key, int *dest);
 extern int git_config_get_ulong(const char *key, unsigned long *dest);
 extern int git_config_get_bool(const char *key, int *dest);
diff --git a/config.c b/config.c
index 22971e9..0d799e0 100644
--- a/config.c
+++ b/config.c
@@ -1332,7 +1332,7 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
 	return e ? &e->value_list : NULL;
 }

-int git_configset_get_string(struct config_set *cs, const char *key, const char **dest)
+int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value))
@@ -1341,6 +1341,19 @@ int git_configset_get_string(struct config_set *cs, const char *key, const char
 		return 1;
 }

+int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
+{
+	const char *value;
+	if (!git_configset_get_value(cs, key, &value)) {
+		if (!value)
+			return config_error_nonbool(key);
+		*dest = xstrdup(value);
+		return 0;
+	}
+	else
+		return 1;
+}
+
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
@@ -1430,7 +1443,13 @@ const struct string_list *git_config_get_value_multi(const char *key)
 	return git_configset_get_value_multi(&the_config_set, key);
 }

-int git_config_get_string(const char *key, const char **dest)
+int git_config_get_string_const(const char *key, const char **dest)
+{
+	git_config_check_init();
+	return git_configset_get_string_const(&the_config_set, key, dest);
+}
+
+int git_config_get_string(const char *key, char **dest)
 {
 	git_config_check_init();
 	return git_configset_get_string(&the_config_set, key, dest);
-- 8< --
