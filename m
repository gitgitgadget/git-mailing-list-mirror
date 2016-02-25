From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 01/11] submodule-config: keep update strategy around
Date: Thu, 25 Feb 2016 15:08:18 -0800
Message-ID: <1456441708-13512-2-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ51w-00086r-8a
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbcBYXJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:02 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35380 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbcBYXI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:08:59 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so41929649pfc.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gPdSxWW7RJrxhJtKZEEIjlt5U8kkEs7J+bGn3NMcVo=;
        b=K1TnBC/JpqmqUydwFedKHo6QCRg2Be/GPIgOXQm55BGDjmsBqikBJjurxinpjGlJdF
         o8y2MYqBsTftynjlD+0GGtT4oJFTS9ESnu+j+D+Tf4dhI4+uI/ftIKlp51FqLqNVYiBn
         xPFCxltUSWOMmGXN8MRaUlr7vY/fcG4bWmxU8aXq+qulG2oGbyQcbwacvcS3X4hf5nM7
         k2a9yua11aMZnVQY39qOQG+aUcllUjA1qunA+QJ/Y5fewuQH/vWnYSlXUFVrf6uzkGVM
         J9omsm4hJAjfjHr1xb81wDv/I+D8HA2wqEaQEneOVdAUIWdPfgZeyuDAfJ5axHcLJl15
         pSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gPdSxWW7RJrxhJtKZEEIjlt5U8kkEs7J+bGn3NMcVo=;
        b=KTQprKyG/KcUEJD6WIE/w3N/gZjZeq7BSd8of/m03P1RXqpUGHFNmGcgLBkUpkf3mh
         Su/KZAcyt+lhkcO8YckooX9b8IYFukgWqo2MFRFly0TtWMllYwlJtkY1R8TPG0zQTPW5
         BnSdKy680oHi4MQwHTCP90WRbi89Jxs5XM0vj9riFLBWHZzONSWRZv8eDXWON8LQg/RI
         khLwbgtsToyDr8Wyxe5n0g5hOPOH0R9btRp+frkOOYtESlUYZ2sBuGfm96PC5id8jF3D
         3wPazIiWcwuhgkCsF5VWACbK9By1IxBN5+LAK2u7EjMnzr54EzxXAFjn0OfZcyLTOvdO
         GWRA==
X-Gm-Message-State: AG10YOTWU01s50RSDu5kCADbHBOH6sbwa5tDC/9LuC47mdRsYPzGncNRerROE7XR9xqDRHmy
X-Received: by 10.98.66.157 with SMTP id h29mr66910078pfd.91.1456441738943;
        Thu, 25 Feb 2016 15:08:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id dg12sm14511883pac.47.2016.02.25.15.08.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:08:57 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287473>

Currently submodule.<name>.update is only handled by git-submodule.sh.
C code will start to need to make use of that value as more of the
functionality of git-submodule.sh moves into library code in C.

Add the update field to 'struct submodule' and populate it so it can
be read as sm->update or from sm->update_command.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 13 +++++++++++++
 submodule-config.h |  2 ++
 submodule.c        | 21 +++++++++++++++++++++
 submodule.h        | 16 ++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..a5cd2ee 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -59,6 +59,7 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
 
@@ -194,6 +195,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update_strategy.type = SM_UPDATE_UNSPECIFIED;
+	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +314,16 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite &&
+			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else if (parse_submodule_update_strategy(value,
+			 &submodule->update_strategy) < 0)
+				die(_("invalid value for %s"), var);
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..092ebfc 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -2,6 +2,7 @@
 #define SUBMODULE_CONFIG_CACHE_H
 
 #include "hashmap.h"
+#include "submodule.h"
 #include "strbuf.h"
 
 /*
@@ -14,6 +15,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
diff --git a/submodule.c b/submodule.c
index b83939c..b38dd51 100644
--- a/submodule.c
+++ b/submodule.c
@@ -210,6 +210,27 @@ void gitmodules_config(void)
 	}
 }
 
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
+	free((void*)dst->command);
+	dst->command = NULL;
+	if (!strcmp(value, "none"))
+		dst->type = SM_UPDATE_NONE;
+	else if (!strcmp(value, "checkout"))
+		dst->type = SM_UPDATE_CHECKOUT;
+	else if (!strcmp(value, "rebase"))
+		dst->type = SM_UPDATE_REBASE;
+	else if (!strcmp(value, "merge"))
+		dst->type = SM_UPDATE_MERGE;
+	else if (skip_prefix(value, "!", &value)) {
+		dst->type = SM_UPDATE_COMMAND;
+		dst->command = xstrdup(value);
+	} else
+		return -1;
+	return 0;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index cbc0003..3464500 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,6 +13,20 @@ enum {
 	RECURSE_SUBMODULES_ON = 2
 };
 
+enum submodule_update_type {
+	SM_UPDATE_UNSPECIFIED = 0,
+	SM_UPDATE_CHECKOUT,
+	SM_UPDATE_REBASE,
+	SM_UPDATE_MERGE,
+	SM_UPDATE_NONE,
+	SM_UPDATE_COMMAND
+};
+
+struct submodule_update_strategy {
+	enum submodule_update_type type;
+	const char *command;
+};
+
 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 int remove_path_from_gitmodules(const char *path);
@@ -21,6 +35,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.7.0.rc0.36.g75877e4.dirty
