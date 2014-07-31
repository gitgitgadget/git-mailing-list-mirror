From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 2/7] add line number and file name info to `config_set`
Date: Thu, 31 Jul 2014 02:44:12 -0700
Message-ID: <1406799857-28048-3-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:45:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvk-0004kP-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbaGaJpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:41 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56336 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:41 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so3162050pdi.25
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3tLAIMEs4sGyncugBPi1KBRy0gdncQsePfM0SLSyqYE=;
        b=zKxoignaENDnB/Wwq1gZeJjHrhFLZp5dsttxkPPypDH4xvK/35mOOXAos2tMCb45hw
         TeRQ1P5NxofMxqh0ks3UR0GBb8b1fgFKRFoX2G7dpmsYS8EMQGg3Hj4kxW3H/AMap+dQ
         WrslKwgTsr57Rl/Y3M2d3Rbg7fnzE8uaBGUboIE5qtgJkTZ8OB3U+AxEuwiKcwJVx9+G
         WDyd2B0UqGfH+Iuwj/nRNVaeGLH11yQ2S6ZaLO/tadRIn3SRHpoPvMDnI8BBTwatFkkG
         gexMFzXPe3dHWzFxmF3XgQY9T4Hu8k1xD5/jaRsU66LZhYtkNe9BqZcVwqnbOoq0z7jY
         AIjQ==
X-Received: by 10.68.164.100 with SMTP id yp4mr2910994pbb.136.1406799940148;
        Thu, 31 Jul 2014 02:45:40 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254543>

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
