From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 2/7] rewrite git_config() to use the config-set API
Date: Wed, 23 Jul 2014 11:42:53 -0700
Message-ID: <1406140978-9472-3-git-send-email-tanayabh@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 20:44:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA1WC-0006U1-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbaGWSn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:43:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56633 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbaGWSnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:43:55 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so2236161pad.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMDFNpbJ7V5CEcjpQZROV1j6EOjXvZouAdf/IWwcQIU=;
        b=wPqRU0f3a9nzz8l4EuTNU7y12Z4BGu0Z2BNe+XzH/YRPQ2jMT2HiBovO3eMTdn6jA/
         6DYX1vHcly2z72g6+i/6NU75McCWzIlwDUMz+rni62E416FoPD+9EIF7QbPleEUkgjyY
         ct9rMYoyrvc4gqb8JO5NhDWPaAEGfLqLGbBNXjF6cIukgSbp7ka8eZIZyAUXZyZo2FmA
         6wgX+pHj+ON0f8Kpns5IDnKGe6l4Z8UHfHR8m5Alqqmjpm+y8lIqNg8FQaZlmfnFVJeR
         QlRUGJfUsc5B6nyJ4ppMKfNtEDoztw2lx6/Q5nyuTz05t/GJwZR5WNk3cjTAN0jf9OSa
         heBw==
X-Received: by 10.70.92.81 with SMTP id ck17mr4506500pdb.2.1406141034738;
        Wed, 23 Jul 2014 11:43:54 -0700 (PDT)
Received: from localhost.localdomain ([27.56.89.40])
        by mx.google.com with ESMTPSA id z10sm1067820pdo.14.2014.07.23.11.43.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 11:43:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254103>

Of all the functions in `git_config*()` family, `git_config()` has the
most invocations in the whole code base. Each `git_config()` invocation
causes config file rereads which can be avoided using the config-set API.

Use the config-set API to rewrite `git_config()` to use the config caching
layer to avoid config file rereads on each invocation during a git process
lifetime. First invocation constructs the cache, and after that for each
successive invocation, `git_config()` feeds values from the config cache
instead of rereading the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 6db8f97..a7fb9a4 100644
--- a/config.c
+++ b/config.c
@@ -1232,11 +1232,36 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-int git_config(config_fn_t fn, void *data)
+static int git_config_raw(config_fn_t fn, void *data)
 {
 	return git_config_with_options(fn, data, NULL, 1);
 }
 
+static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i;
+	struct string_list *strptr;
+	struct config_set_element *entry;
+	struct hashmap_iter iter;
+	hashmap_iter_init(&cs->config_hash, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		strptr = &entry->value_list;
+		for (i = 0; i < strptr->nr; i++) {
+			if (fn(entry->key, strptr->items[i].string, data) < 0)
+				die("bad config file line in (TODO: file/line info)");
+		}
+	}
+	return 0;
+}
+
+static void git_config_check_init(void);
+
+int git_config(config_fn_t fn, void *data)
+{
+	git_config_check_init();
+	return configset_iter(&the_config_set, fn, data);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
@@ -1418,7 +1443,7 @@ static void git_config_check_init(void)
 	if (the_config_set.hash_initialized)
 		return;
 	git_configset_init(&the_config_set);
-	git_config(config_set_callback, &the_config_set);
+	git_config_raw(config_set_callback, &the_config_set);
 }
 
 void git_config_clear(void)
-- 
1.9.0.GIT
