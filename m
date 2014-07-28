From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v13 0/2] git config cache & special querying api utilizing the cache
Date: Mon, 28 Jul 2014 03:10:37 -0700
Message-ID: <1406542239-17024-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBhu8-0007Yd-P1
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbaG1KLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:11:36 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63032 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaG1KLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:11:36 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so9709850pdj.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9ol8nbPjpqouTBgKBgcUWg8vVZZKsZsCRz0MSfxE268=;
        b=fFmv6KWHAcOkkuXBdykZt+MctuI1XjYIH4I+2TbH5scLwhckzo+vv4Igzq+CuJhilO
         S1n6LYlteazuHQV8vykd3RZr40W7n4ToUlirebkw6uxALEIJfK5FhGocDPTEg+adW5Gc
         CC2PTGuDpo4cuyo5Bvt1aHvo4+qVhAtoKr4DLbxFSOSw7nvs4qEgoyn35RVDypN9n8WX
         v1yKQ3QxQW6WzokJIaRTTBmjiX6vGrax70S3q/z7bsWbbQrnLPaGMN3jZcAeWkoBShVB
         nlqwUphr9/jla5HQgiV02PU7udFfym9M2TSUbig1+JtC1a8BC9iNkiX5MzFdNFaYKqZb
         OCcQ==
X-Received: by 10.66.174.17 with SMTP id bo17mr37061842pac.98.1406542294765;
        Mon, 28 Jul 2014 03:11:34 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id rz4sm65251240pab.13.2014.07.28.03.11.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:11:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254286>

[v13]: v12 was rejected because of redundant implementation of the new functions,
	hope this one is okay.

I am attaching the v13 with two new functions git_configset_get_string() &
git_configset_get_string_const().

Diff between v11 and v13 is appended below for easy review.
v11 can be seen at [1].

[1]:: http://thread.gmane.org/gmane.comp.version-control.git/253862/

Tanay Abhra (2):
  add `config_set` API for caching config-like files
  test-config: add tests for the config_set API

 .gitignore                             |   1 +
 Documentation/technical/api-config.txt | 142 +++++++++++++++++
 Makefile                               |   1 +
 cache.h                                |  32 ++++
 config.c                               | 274 +++++++++++++++++++++++++++++++++
 setup.c                                |   9 ++
 t/t1308-config-set.sh                  | 200 ++++++++++++++++++++++++
 test-config.c                          | 142 +++++++++++++++++
 8 files changed, 801 insertions(+)
 create mode 100755 t/t1308-config-set.sh
 create mode 100644 test-config.c

-- 
1.9.0.GIT

-- 8< --
t_config_get_string(const char *key, const char **dest)`::
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
index 22971e9..d3ad661 100644
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
@@ -1341,6 +1341,11 @@ int git_configset_get_string(struct config_set *cs, const char *key, const char
 		return 1;
 }
 
+int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
+{
+	return git_configset_get_string_const(cs, key, (const char **)dest);
+}
+
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
 {
 	const char *value;
@@ -1430,10 +1435,16 @@ const struct string_list *git_config_get_value_multi(const char *key)
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
-	return git_configset_get_string(&the_config_set, key, dest);
+	return git_config_get_string_const(key, (const char **)dest);
 }
 
 int git_config_get_int(const char *key, int *dest)
-- 8< --
