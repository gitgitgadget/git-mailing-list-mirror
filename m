From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 4/7] add line number and file name info to `config_set`
Date: Wed, 23 Jul 2014 11:42:55 -0700
Message-ID: <1406140978-9472-5-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WK-0006cP-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254AbaGWSoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:44:03 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:52738 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:44:01 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so2101632pdj.22
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3WOd8E+W5Z4ieEXEmKrFDOqnruXhlnSJ/3xTxTGWRoo=;
        b=uMK19vNsjiZ7/WCfnBSmbxL6uGUErpsDetxbSfoBT5tbinwwnsMbSbQQiRnqOB0Ama
         GhKDeOtdMV1KGH3szgVBAuapsorIo/KJDtsznDD2iD3ZS7DRMGvqq81RCd0AsIaZ9fCl
         I39V7ewTdlbBkvqV2jULuLjGLW+a5P7Yn0BpHAlaHUKOcD3lkh3/p/DzsRffzaVJ2DSX
         vMipA3HW8624XpwnyDZVDHONdAcKOAu+h2AbRN7a7xhecoIZMAF8IaA6WThvFclCFpnB
         nhg7085/EecUnJ6wFUWt7vbwDM7CifqERkYFGJEIV487MKyCL1i8rf2no8+auhmsui+g
         3WKg==
X-Received: by 10.70.125.233 with SMTP id mt9mr4441994pdb.154.1406141041316;
        Wed, 23 Jul 2014 11:44:01 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.43.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:44:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254105>

Store file name and line number for each key-value pair in the cache.
Use the information to print line number and file name in errors raised
by `git_config()` which now uses the configuration files caching layer
internally.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index a7fb9a4..43a951f 100644
--- a/config.c
+++ b/config.c
@@ -1237,9 +1237,15 @@ static int git_config_raw(config_fn_t fn, void *data)
 	return git_config_with_options(fn, data, NULL, 1);
 }
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+};
+
 static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
 	int i;
+	struct key_value_info *kv_info;
 	struct string_list *strptr;
 	struct config_set_element *entry;
 	struct hashmap_iter iter;
@@ -1247,8 +1253,15 @@ static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	while ((entry = hashmap_iter_next(&iter))) {
 		strptr = &entry->value_list;
 		for (i = 0; i < strptr->nr; i++) {
-			if (fn(entry->key, strptr->items[i].string, data) < 0)
-				die("bad config file line in (TODO: file/line info)");
+			if (fn(entry->key, strptr->items[i].string, data) < 0) {
+				kv_info = strptr->items[i].util;
+				if (!kv_info->linenr)
+					die("unable to parse command-line config");
+				else
+					die("bad config file line %d in %s",
+						kv_info->linenr,
+						kv_info->filename);
+			}
 		}
 	}
 	return 0;
@@ -1287,6 +1300,8 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
+	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+	struct string_list_item *si;
 	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
@@ -1299,7 +1314,16 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		string_list_init(&e->value_list, 1);
 		hashmap_add(&cs->config_hash, e);
 	}
-	string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	if (cf) {
+		kv_info->filename = strintern(cf->name);
+		kv_info->linenr = cf->linenr;
+	} else {
+		/* for values read from `git_config_from_parameters()` */
+		kv_info->filename = strintern("parameter");
+		kv_info->linenr = 0;
+	}
+	si->util = kv_info;
 
 	return 0;
 }
@@ -1326,7 +1350,7 @@ void git_configset_clear(struct config_set *cs)
 	hashmap_iter_init(&cs->config_hash, &iter);
 	while ((entry = hashmap_iter_next(&iter))) {
 		free(entry->key);
-		string_list_clear(&entry->value_list, 0);
+		string_list_clear(&entry->value_list, 1);
 	}
 	hashmap_free(&cs->config_hash, 1);
 	cs->hash_initialized = 0;
-- 
1.9.0.GIT
