From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 2/6] add line number and file name info to `config_set`
Date: Tue, 29 Jul 2014 04:28:18 -0700
Message-ID: <1406633302-23144-3-git-send-email-tanayabh@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5bN-00039p-RV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaG2L3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:29:44 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54707 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbaG2L3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:29:43 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so11533795pdi.34
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Psp7R8t2RiWBzBUxrr3TdenHkBuAeggxaTA8krebttI=;
        b=PsSaXo+RF7u7fBqB9GgJPDM3HV+6F97LJNr0lkexW7GAOnON4OctR0kSBgcyl6uvLD
         4o38JBSTTZFfJBKPpCljEzVhXsZqlm+mIBIOCE8cQYhi8H3AhnUE54l0Un86FK7ONHub
         Aj9hKnRXk3RHKvPycMOLelrCE9eKPWojbfggPmcVXKXC9bVPcmlNHRflqTtkMJyLXLHi
         zrDubZp6lPN8aDzT13Hc2BbZzZi3By8VWlbR4If1XDTw4sJiYU8zbEJBIJ3QNJSwY9UA
         M09UzUNP0O+jqVftas+i4Wv3QnhqUinQwMnQTwzODUkP9e2KQCHNLYEgz4JxEvplKsBY
         tJGg==
X-Received: by 10.66.152.109 with SMTP id ux13mr1465334pab.122.1406633382652;
        Tue, 29 Jul 2014 04:29:42 -0700 (PDT)
Received: from localhost.localdomain ([223.184.138.24])
        by mx.google.com with ESMTPSA id z2sm28554774pdj.16.2014.07.29.04.29.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:29:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254413>

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
