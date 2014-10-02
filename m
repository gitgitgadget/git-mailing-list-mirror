From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 3/5] add "unset.variable" for unsetting previously set variables
Date: Thu,  2 Oct 2014 06:24:50 -0700
Message-ID: <1412256292-4286-4-git-send-email-tanayabh@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:26:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOY-0006Ru-0o
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbaJBN0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:26:03 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37654 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaJBN0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:26:02 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so2367673pab.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jw/7wM6LutAFhDrELYM7njT/H6rR6m8Ie/iZxymkOCw=;
        b=cGBHcLyZTegwcrH9sZhZjl4nxYCBj+kpHiJ0BiUGuwEhOlq9z5qgG9Lpf1ZJLozJPb
         igHPY0xXU5oUF0UD50WStTsqikqs9y6IxY8AD8UKkyKF2kh3u+UOnSz/ZfCI4cO3bOR6
         WVxV5YpDkKdPfgpe6D5UswJdT+UafyxCbOpkbGH0MQdO8Q8HO9GKeZnGaQo5pI+Hlgmu
         hgqyoCxD+Gwxx2BSurqF/qnEZ4+ADzDXpwaYZaPa8QW915zqR/e51Xyit2JLjZAZKTLg
         XVvaeWocD18noKohtZoCPa7Dy7Jb2JdseGXZYtPQDEJVpz+pcKh76UxAOwK9MpzOXaaN
         6tKg==
X-Received: by 10.68.179.228 with SMTP id dj4mr88238910pbc.130.1412256361283;
        Thu, 02 Oct 2014 06:26:01 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.25.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:26:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257803>

Add a new config variable "unset.variable" which unsets previously set
variables. It affects `git_config()` and `git_config_get_*()` family
of functions. It removes the matching variables from the `configset`
which were added previously. Those matching variables which come after
the "unset.variable" in parsing order will not be deleted and will
be left untouched.

It affects the result of "git config -l" and similar calls.
It may be used in cases where the user can not access the config files,
for example, the system wide config files may be only accessible to
the system administrator. We can unset an unwanted variable declared in
the system config file by using "unset.variable" in a local config file.

for example, /etc/gitconfig may look like this,
	[foo]
		bar = baz

in the repo config file, we will write,
	[unset]
		variable  = foo.bar
to unset foo.bar previously declared in system wide config file.

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/config.c b/config.c
index 09cf009..a80832d 100644
--- a/config.c
+++ b/config.c
@@ -1311,6 +1311,38 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	return found_entry;
 }
 
+static void delete_config_variable(struct config_set *cs, const char *key, const char *value)
+{
+	char *normalized_value;
+	struct config_set_element *e = NULL;
+	int ret, current = 0, updated = 0;
+	struct configset_list *list = &cs->list;
+	/*
+	 * if we find a key value pair with key as "unset.variable", unset all variables
+	 * in the configset with keys equivalent to the value in "unset.variable".
+	 * unsetting a variable means that the variable is permanently deleted from the
+	 * configset.
+	 */
+	ret = git_config_parse_key(value, &normalized_value, NULL);
+	if (!ret) {
+		/* first remove matching variables from the configset_list */
+		while (current < list->nr) {
+			if (!strcmp(list->items[current].e->key, normalized_value))
+				current++;
+			else
+				list->items[updated++] = list->items[current++];
+		}
+		list->nr = updated;
+		/* then delete the matching entry from the configset hashmap */
+		e = configset_find_element(cs, normalized_value);
+		if (e) {
+			free(e->key);
+			string_list_clear(&e->value_list, 1);
+			hashmap_remove(&cs->config_hash, e, NULL);
+		}
+	}
+}
+
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
@@ -1331,6 +1363,8 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		hashmap_add(&cs->config_hash, e);
 	}
 	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	if (!strcmp(key, "unset.variable"))
+		delete_config_variable(cs, key, value);
 
 	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
 	l_item = &cs->list.items[cs->list.nr++];
-- 
1.9.0.GIT
