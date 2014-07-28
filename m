From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 2/6] add line number and file name info to `config_set`
Date: Mon, 28 Jul 2014 03:33:51 -0700
Message-ID: <1406543635-19281-3-git-send-email-tanayabh@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGQ-0008H4-1A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbaG1Kej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:39 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50025 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1Kei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:38 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so10240509pac.17
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Psp7R8t2RiWBzBUxrr3TdenHkBuAeggxaTA8krebttI=;
        b=TZJ6T6I4Lh0FX1WGkhMVo9FfEN4VwIQxoKLxwaJZsgKXkMr6BLrbI9ig60czGlnSqR
         HZBUZgxuhKb2O+S1SchYpmc7GbGCnHn+OTn1BDIec7Zzpoqc1cc6/d0VI8RPSGrsx/0B
         ROSn3M2iJ7kfsn0tTg5tNUol79srigCqImEIQxzfZGnD7CUBa46/Zk8v4XiSXPbrDOvj
         pahinm6ff3iLqvI/3tUKrKYfqrBmru283SwUN37eHVgvGmDNODmkXZwkWWn6Gbi9KfKe
         0r2y0pxNOqb84IJljfdkKfKn8hKSZqwAL5FNwHou2I+E5eOf3C1XrSD+YvFdDd5ibOeY
         m2SA==
X-Received: by 10.68.253.73 with SMTP id zy9mr9195826pbc.114.1406543678390;
        Mon, 28 Jul 2014 03:34:38 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254292>

Store file name and line number for each key-value pair in the cache
during parsing of the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index e5b7f10..5499108 100644
--- a/config.c
+++ b/config.c
@@ -1232,6 +1232,11 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+};
+
 int git_config(config_fn_t fn, void *data)
 {
 	return git_config_with_options(fn, data, NULL, 1);
@@ -1262,6 +1267,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
+	struct string_list_item *si;
+	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+
 	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
@@ -1274,7 +1282,16 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -1301,7 +1318,7 @@ void git_configset_clear(struct config_set *cs)
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
