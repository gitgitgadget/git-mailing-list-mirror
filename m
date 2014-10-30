From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Thu, 30 Oct 2014 23:18:05 +0530
Message-ID: <CAEc54XBOvqT234s0UX-osYbOJfyuPquWLtmzDNDhAQoJ8b9eXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Oct 30 18:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjtpj-00034L-AN
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 18:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760701AbaJ3RsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 13:48:08 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34315 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773AbaJ3RsG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 13:48:06 -0400
Received: by mail-ig0-f176.google.com with SMTP id l13so4135814iga.9
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:cc:content-type;
        bh=spK4QTh+5vocB9g33Bcba3JneNrIFo1bkEsf8yIjX38=;
        b=gTDzuW443w9Z92uABmkZwg++fggjqxnmU1dPN+IpMS5jM6bDPxIKQebRynuIIMpbBi
         uTIST62XlaoRcZdUUU3HzCYtFL9M7G/fH+I/5xO5lF+V1Q6RFK+/ZEBE17RwtM5/Z4+p
         saj8pS0rBCKVv2+yQOKMWC0zH0kafnHHcqPBWMgIajzoOWeYYm6Lr96xCMDVRDH+ARHj
         pOCmdCq41SbbvmsvQGMCU0ibpT/NLIjGDuAhZLks1nNfAWdJP1Lxx0/f5tXHlPNB57Pc
         DJwJN4rdttNg0NCgDA1wz2KA2BHWh3qI1NXE2a0NFbdY+mDXWskRPNbXY5b4RmHw8re1
         PywA==
X-Received: by 10.107.29.197 with SMTP id d188mr17210886iod.57.1414691285145;
 Thu, 30 Oct 2014 10:48:05 -0700 (PDT)
Received: by 10.107.28.75 with HTTP; Thu, 30 Oct 2014 10:48:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git_config_parse_key()` is used to sanitize the input key.
Some callers of the function like `git_config_set_multivar_in_file()`
get the pre-sanitized key directly from the user so it becomes
necessary to raise an error specifying what went wrong when the entered
key is defective.

Other callers like `configset_find_element()` get their keys from
the git itself so a return value signifying error would be enough.
The error output shown to the user is useless and confusing in this
case so add a show_err flag to suppress errors in such cases.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---

Hi,

You were right, one of the functions was calling git_config_parse_key()
which was leaking errors to the console. git_config_parse_key() was
meant for sanitizing user provided keys only but it was being used
internally in a place where only a return value would be enough.

Thanks for bringing this to our attention.

Cheers,
Tanay Abhra.

 builtin/config.c |  2 +-
 cache.h          |  2 +-
 config.c         | 19 ++++++++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cc2604..51635dc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -200,7 +200,7 @@ static int get_value(const char *key_, const char *regex_)
             goto free_strings;
         }
     } else {
-        if (git_config_parse_key(key_, &key, NULL)) {
+        if (git_config_parse_key(key_, &key, NULL, 1)) {
             ret = CONFIG_INVALID_KEY;
             goto free_strings;
         }
diff --git a/cache.h b/cache.h
index 99ed096..8129590 100644
--- a/cache.h
+++ b/cache.h
@@ -1362,7 +1362,7 @@ extern int git_config_string(const char **,
const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_parse_key(const char *, char **, int *, int);
 extern int git_config_set_multivar(const char *, const char *, const
char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char
*, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
diff --git a/config.c b/config.c
index 15a2983..eb9058c 100644
--- a/config.c
+++ b/config.c
@@ -1299,7 +1299,7 @@ static struct config_set_element
*configset_find_element(struct config_set *cs,
      * `key` may come from the user, so normalize it before using it
      * for querying entries from the hashmap.
      */
-    ret = git_config_parse_key(key, &normalized_key, NULL);
+    ret = git_config_parse_key(key, &normalized_key, NULL, 0);

     if (ret)
         return NULL;
@@ -1832,8 +1832,9 @@ int git_config_set(const char *key, const char *value)
  *             lowercase section and variable name
  * baselen - pointer to int which will hold the length of the
  *           section + subsection part, can be NULL
+ * show_err - toggle whether the function raises an error on a defective key
  */
-int git_config_parse_key(const char *key, char **store_key, int *baselen_)
+int git_config_parse_key(const char *key, char **store_key, int
*baselen_, int show_err)
 {
     int i, dot, baselen;
     const char *last_dot = strrchr(key, '.');
@@ -1844,12 +1845,14 @@ int git_config_parse_key(const char *key, char
**store_key, int *baselen_)
      */

     if (last_dot == NULL || last_dot == key) {
-        error("key does not contain a section: %s", key);
+        if (show_err)
+            error("key does not contain a section: %s", key);
         return -CONFIG_NO_SECTION_OR_NAME;
     }

     if (!last_dot[1]) {
-        error("key does not contain variable name: %s", key);
+        if (show_err)
+            error("key does not contain variable name: %s", key);
         return -CONFIG_NO_SECTION_OR_NAME;
     }

@@ -1871,12 +1874,14 @@ int git_config_parse_key(const char *key, char
**store_key, int *baselen_)
         if (!dot || i > baselen) {
             if (!iskeychar(c) ||
                 (i == baselen + 1 && !isalpha(c))) {
-                error("invalid key: %s", key);
+                if (show_err)
+                    error("invalid key: %s", key);
                 goto out_free_ret_1;
             }
             c = tolower(c);
         } else if (c == '\n') {
-            error("invalid key (newline): %s", key);
+            if (show_err)
+                error("invalid key (newline): %s", key);
             goto out_free_ret_1;
         }
         (*store_key)[i] = c;
@@ -1926,7 +1931,7 @@ int git_config_set_multivar_in_file(const char
*config_filename,
     char *filename_buf = NULL;

     /* parse-key returns negative; flip the sign to feed exit(3) */
-    ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+    ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 1);
     if (ret)
         goto out_free;

-- 
1.9.0.GIT
