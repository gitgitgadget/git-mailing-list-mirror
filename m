From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 1/7] submodule-config: keep update strategy around
Date: Fri, 12 Feb 2016 15:34:34 -0800
Message-ID: <1455320080-14648-2-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:34:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEg-0005Qz-Rv
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcBLXer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:47 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35043 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbcBLXep (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:45 -0500
Received: by mail-pa0-f50.google.com with SMTP id ho8so54086453pac.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F3Xsw5kvw92xAkTPp2OqeHGGvhYjK7SN6Li+bRwrvss=;
        b=e4nIIuHtJp3vK+NFu4q/rgrtYxqQ3r3ixXiu+F1gZ5vEXzZL5syHMSkGASL9mJSEdp
         Ghrp744N0CatkC9wBnE54jx6ktwmhMznKJxA4GnesveBx9Gq+PDhftfHQ5Uc7Fl2R9gu
         Oud8br97ZoB4/frXuA89UM7do8L55iDMx0gXUIzr/UgBTGoXwGkC5JOIzvrlsy31HF0N
         mxzqazcTvnVIPiaaTjWhy9jWUCffW+VjwRmzUg+gHxK56TvtRdqyatTpezAZx5OZIpMH
         3tS/kk98htC0N9bEu2smR0iMq5d0hCo0yQDuNRv3Gfze5TAqAmNh0zsp5QTstFXeETER
         4SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F3Xsw5kvw92xAkTPp2OqeHGGvhYjK7SN6Li+bRwrvss=;
        b=YyrgvwAJiexe6IbViduXJX+qXiEoVHBV9C/7p59ZrH8xcwfstQ7gwq+8FkXDxs0ymm
         weBEMXpkangJgToi6QHq3ya8pMhLgKVdHbmll5xmvM7F7dLzR1m1HVNJkJcotlVf43ec
         GYFinWse42/v2hBRe78dgrogVf3qAacaMVTrcBnhwKnqDgrNuHSzW5dnHFkdhZMHWSi9
         2GG7JF2cUcZ5u+DwrBQZRQnyr1x3Amg10xtwn2hklNWrTrs34a4uMwfZjpQDOkRKP5KC
         JIv+NY3Nu5mmrbLSO+pkrAtcII/yRTGhknWmwhWNgxDdW0O9aayob/I4Lfu2iSqp7bHd
         JN2Q==
X-Gm-Message-State: AG10YOREvQsbQx0ShAkDzGiE18CIF8YrlzFPeKGrQOjxydUnit/3Qj0MDjTYIv4UpkJkaCMf
X-Received: by 10.66.159.161 with SMTP id xd1mr5924540pab.104.1455320085434;
        Fri, 12 Feb 2016 15:34:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id dz8sm21879399pab.19.2016.02.12.15.34.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:44 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286083>

Currently submodule.<name>.update is only handled by git-submodule.sh.
C code will start to need to make use of that value as more of the
functionality of git-submodule.sh moves into library code in C.

Add the update field to 'struct submodule' and populate it so it can
be read as sm->update or from sm->update_command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 12 ++++++++++++
 submodule-config.h |  2 ++
 submodule.c        | 19 +++++++++++++++++++
 submodule.h        | 16 ++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index fe8ceab..254067b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update_strategy.type = SM_UPDATE_UNSPECIFIED;
+	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -340,6 +342,16 @@ static int parse_config(const char *var, const char *value, void *data)
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
index 9bfa65a..e4857f5 100644
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
index b83939c..8fd4512 100644
--- a/submodule.c
+++ b/submodule.c
@@ -210,6 +210,25 @@ void gitmodules_config(void)
 	}
 }
 
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
+	dst->command = NULL;
+	if (!strcmp(value, "none"))
+		dst->type = SM_UPDATE_NONE;
+	else if (!strcmp(value, "checkout"))
+		dst->type = SM_UPDATE_CHECKOUT;
+	else if (!strcmp(value, "rebase"))
+		dst->type = SM_UPDATE_REBASE;
+	else if (!strcmp(value, "merge"))
+		dst->type = SM_UPDATE_MERGE;
+	else if (skip_prefix(value, "!", &dst->command))
+		dst->type = SM_UPDATE_COMMAND;
+	else
+		return -1;
+	return 0;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index e06eaa5..9a86124 100644
--- a/submodule.h
+++ b/submodule.h
@@ -14,6 +14,20 @@ enum {
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
@@ -22,6 +36,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.7.1.292.g18a4ced.dirty
