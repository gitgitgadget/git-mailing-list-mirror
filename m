From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 01/11] submodule-config: keep update strategy around
Date: Wed, 24 Feb 2016 19:06:48 -0800
Message-ID: <1456369618-18127-2-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:08:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmHZ-0001Fe-0S
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbcBYDHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:09 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35810 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759881AbcBYDHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:06 -0500
Received: by mail-pf0-f169.google.com with SMTP id c10so25159002pfc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/BzZrOTjeBswJAnINL0aZ95SrigLPIt4fiZMjs614w=;
        b=jUDh6F/ubrGUL1l1TGyhQPkoAKetOjsO/iVXC1YBBaYURhIj5Q7RlDQtsHst8zUNDa
         zbo91wo4WziDSftkbjSb5naLcr8LAqpb3ePFEFC3WHtxK7cqT72fefzImxMVfavD8IXL
         fAVZrjYtpEgKnpJmsvtWCZYORtZ2DG9HPWKY/O+dlQ6j4/yrPaqXt99JWm44vx704SVW
         C/SPJftsU67YoECcRulwRU7+8ztqK0SQ10IN6TMcHYvQtHluogMeXaAEck3Rwu9ArpSl
         01/EImwAlb+VM9RGUgPbnd2BbVVljKtjdYEggRE4uFaM6UFUF1kMNMiKv+dPN6ZvgA/3
         oWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/BzZrOTjeBswJAnINL0aZ95SrigLPIt4fiZMjs614w=;
        b=PT2u0uVDPfvNhgg67zaTu+3sVMZZbQGZmES90HhKOQ/zp6s8thKTeB6PMYz0iazKlx
         T+ls54ZedQEBMRmhmVa4Nt95VQeUh25Pyj5co8bNLG93ItbOLTqPdi5A6dTAMcLztAOJ
         LSwG+YZT7ptDAYdbBCgg8Z40tDr1y8oae8XZ5EZOT8K5OM3H0b1KMNLPn5UL8XN+iZOm
         UiRv5Mbp7nuUTANWOYku/4GqDSNd0L1A/j4dMebb690jToYjEyywrZ9yLErNtKT+VoIj
         6c5U3hUq/VwnJSBiJOeLMhUgqO3UUOhBHOaIKh7v+8u1qJ8kpawH9fBmtqMuOdy7azds
         +tLw==
X-Gm-Message-State: AG10YOTyOt/nQXaGrAcEKNMoTC/JhIod39ib3TF5yilbJKHcT1t1KzZW+f47xFBho5SmZghN
X-Received: by 10.98.79.9 with SMTP id d9mr59203267pfb.46.1456369625132;
        Wed, 24 Feb 2016 19:07:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id h66sm7941427pfd.91.2016.02.24.19.07.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:04 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287327>

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
2.7.2.373.g1655498.dirty
