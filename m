From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 2/7] add line number and file name info to `config_set`
Date: Thu, 31 Jul 2014 08:47:37 -0700
Message-ID: <1406821662-1570-3-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsbB-0008KP-7e
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbaGaPsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:43 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56525 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbaGaPsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so3697536pde.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3tLAIMEs4sGyncugBPi1KBRy0gdncQsePfM0SLSyqYE=;
        b=Ry2W0PzBiCev7o2IGbha0NzvyVkP23W32dzUuTKt8FfaqvxUXP+rxrZtgcUo0TYCEo
         j7O5j7ADRdLpCx/hAXlnVYZ4hXqhPmV7+SOxYprtPwsMCAM+osDjHuuWQPpLXJX6y1iB
         lZOclynKeChWGUAxYhHOjPo2c27wNWIGy2XZT2TmUllbVHcFw2hf7zqSwsug7ac4VV3L
         py4NByTbhUjK6eYEhHzwRU/pj52x0Ap44RoniirZWFlV0LMoo/6qsb0xUj2E+hztanAb
         CxsW5J6O8B9zBywxn7qK7UKMaj71PiRf/dX+9njEjijMPIiDgg5ZjgSw7bUeTZSv29Nm
         TcjA==
X-Received: by 10.70.87.225 with SMTP id bb1mr13279641pdb.67.1406821720062;
        Thu, 31 Jul 2014 08:48:40 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254583>

Store file name and line number for each key-value pair in the cache
during parsing of the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index ed5fc8e..4a15383 100644
--- a/config.c
+++ b/config.c
@@ -1230,6 +1230,11 @@ int git_config_with_options(config_fn_t fn, void *data,
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
@@ -1260,6 +1265,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
 {
 	struct config_set_element *e;
+	struct string_list_item *si;
+	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+
 	e = configset_find_element(cs, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
@@ -1272,7 +1280,16 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -1299,7 +1316,7 @@ void git_configset_clear(struct config_set *cs)
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
