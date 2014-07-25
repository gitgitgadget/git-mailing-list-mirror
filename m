From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 2/6] add line number and file name info to `config_set`
Date: Fri, 25 Jul 2014 05:58:11 -0700
Message-ID: <1406293095-15920-3-git-send-email-tanayabh@gmail.com>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 14:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAf5l-00036y-WB
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760331AbaGYM7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:59:16 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36111 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760410AbaGYM7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:59:14 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so6006861pad.22
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wPLSERtQME88Yd/SmrD70PlhkPTw5xDEDm+kmXla/y4=;
        b=vredAyVKfojGsc+K0kV8LnLqa9GPRoAlWiyCG3JobFozHbNclivu3DtQzODV7LxbK+
         9G01Pcl7WNg6GzCcxKUupQEhZTW8d7rTmCCwEBUrHgn6+Y8dBI+vSdfv8aTIEP9BvAb9
         9j079RI7iRnXluNxn6iE98qS2cvDqiy630OsSbXHUP7zySNEZMyvzSZ7sGkfI2Y14QFd
         Y42CVMXrfsKaxUlb1I1/7iYz0F/f648JamMw26mmMoZadFWHToKrc/V48bQODCCjcs9+
         Z1qH+O032+mgJtGyOfSX8nFPWW2I6KxpjY0dwQAUWM/zegjXB4MilUN97cINBRNfqasW
         iItw==
X-Received: by 10.66.122.36 with SMTP id lp4mr18702208pab.82.1406293154426;
        Fri, 25 Jul 2014 05:59:14 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.45])
        by mx.google.com with ESMTPSA id tg9sm8798900pbc.29.2014.07.25.05.59.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 05:59:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254213>

Store file name and line number for each key-value pair in the cache
during parsing of the configuration files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 06257d9..110f9a5 100644
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
-- 
1.9.0.GIT
