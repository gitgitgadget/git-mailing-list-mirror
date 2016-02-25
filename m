From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 01/11] submodule-config: keep update strategy around
Date: Thu, 25 Feb 2016 15:48:29 -0800
Message-ID: <1456444119-6934-2-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5fE-0000Cx-P3
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbcBYXsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:51 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36710 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbcBYXst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:49 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so40216946pab.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gPdSxWW7RJrxhJtKZEEIjlt5U8kkEs7J+bGn3NMcVo=;
        b=bo1iW4KH1Ik1TTci+X1cKc3/u1sZDLJ5gXp+CWq0+Fohm/hMda02uq8kSl7rwmYaBa
         pBSCpaaljgrlUhhdtFzvz8pGjXvZp0rajcD7QEfdO+OHZKKziFDRcVo/G7ZjfwebmdnV
         omwX1BENmYZz+7Rro1RYzfzOIq9VZyqliRIsQNUcVz89bLKlX9pcr7Z6NhgOqTQLeObU
         5SqB6eW6yAB0aZSMXQY7KkWS5lcqhXOMhDIl7XzWwscgRQ4K2SG5/pD/eAEkGyKBhvk4
         6M6Sr6TcUJNU/UkE+pNiQc5eeQEBA4H3LQyntNI7vPhd2C9FVDQh3IBU+KAqsdp4SztM
         hXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gPdSxWW7RJrxhJtKZEEIjlt5U8kkEs7J+bGn3NMcVo=;
        b=QvBnC3PkNSB9FVZjpKC2AUJu1ED2HhYNGp4yKgT3pbiIKli+J42KlOKhfk/d0jma24
         81BIcM2p4dHf/ZsWxDyp2IeVkmQZAEhEOOg4ko0UmCOXfdz3EQhwaq/O0m1IJplTp4nQ
         24uTVuj0sldrESZeIcvODE0R6J0IAbbdgDA0StapabwzgTPygep6hKCR/UaYNulL8Vrt
         GHTya1b32X5zEF+PFVuajZZc+O44G0DYA2uChUFu4zbgoaKgLtRgwJLkuv+0ZGqbU7Bh
         SuVNWU6II3ahvK5APmhVIOfoCl85u64lUtgmZfN5SfXQAHxkskI5MMkxE8vD9ZeDZgWU
         nGjg==
X-Gm-Message-State: AG10YOToHUHWgNgWaZsbm8y9CJEdUL8RIhco8n8IvYKwZbMjQKci8FqQPeTWvnCm4Nwn4JiQ
X-Received: by 10.66.118.7 with SMTP id ki7mr67110507pab.153.1456444128435;
        Thu, 25 Feb 2016 15:48:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id x13sm14587881pfa.72.2016.02.25.15.48.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287508>

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
