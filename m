From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH/RFC 1/5] config.c : move configset_iter() to an appropriate position
Date: Thu,  2 Oct 2014 06:24:48 -0700
Message-ID: <1412256292-4286-2-git-send-email-tanayabh@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZgOR-0006Nc-H2
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 15:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbaJBNZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 09:25:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55598 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaJBNZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 09:25:55 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so2379142pad.15
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k7RpN1FPQH7FZ10/7PLEtwrdSpe1gdW5JaszZNyJsyQ=;
        b=mX/nsMuRVjl6hTjPLRU8r/MDX6bODgARE1217p0Xw50YUSiJs5MMmMA72DCDHTCxNv
         fUW1KTtPVoAS74l4dx1wkDxIuWRd5T0jwSJVv60CDxpZcWt734ckx+XH+ZtZs91X42oi
         ybJWjYP2F7ofUh+x0I9q0mUtrpBEqoVIu8rcU/9zmt1kmvoZ3Vcx+/5dAq/kr0f/MiYu
         dl+wt7VHnmauWaIpx6HTyQtcDAxQcGaaD0g4qDqdRY1SjZBsD3JOGHe1EU9DKyhO1PpK
         sqJsqpbi1OnoRdeZG+tkrTJGU7J2NENV9ly5/M0H8rNhmR5OvOf7hiqJx+7ctkFkMYga
         x/0Q==
X-Received: by 10.66.220.230 with SMTP id pz6mr2203205pac.145.1412256355253;
        Thu, 02 Oct 2014 06:25:55 -0700 (PDT)
Received: from localhost.localdomain ([182.67.148.232])
        by mx.google.com with ESMTPSA id qp9sm3612065pbc.31.2014.10.02.06.25.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 06:25:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257802>

Move configset_iter() to an appropriate position where it
can be called by git_config_*() family without putting
a forward declaration for it. 

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 config.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index a677eb6..cb474b2 100644
--- a/config.c
+++ b/config.c
@@ -1150,6 +1150,25 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
+static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+{
+	int i, value_index;
+	struct string_list *values;
+	struct config_set_element *entry;
+	struct configset_list *list = &cs->list;
+	struct key_value_info *kv_info;
+
+	for (i = 0; i < list->nr; i++) {
+		entry = list->items[i].e;
+		value_index = list->items[i].value_index;
+		values = &entry->value_list;
+		if (fn(entry->key, values->items[value_index].string, data) < 0) {
+			kv_info = values->items[value_index].util;
+			git_die_config_linenr(entry->key, kv_info->filename, kv_info->linenr);
+		}
+	}
+}
+
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
 	int ret = 0, found = 0;
@@ -1245,25 +1264,6 @@ static void git_config_raw(config_fn_t fn, void *data)
 		die(_("unknown error occured while reading the configuration files"));
 }
 
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
-{
-	int i, value_index;
-	struct string_list *values;
-	struct config_set_element *entry;
-	struct configset_list *list = &cs->list;
-	struct key_value_info *kv_info;
-
-	for (i = 0; i < list->nr; i++) {
-		entry = list->items[i].e;
-		value_index = list->items[i].value_index;
-		values = &entry->value_list;
-		if (fn(entry->key, values->items[value_index].string, data) < 0) {
-			kv_info = values->items[value_index].util;
-			git_die_config_linenr(entry->key, kv_info->filename, kv_info->linenr);
-		}
-	}
-}
-
 static void git_config_check_init(void);
 
 void git_config(config_fn_t fn, void *data)
-- 
1.9.0.GIT
