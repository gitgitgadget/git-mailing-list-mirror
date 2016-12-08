Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F051FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbcLHBqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:47 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35356 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLHBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:43 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so79990118pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ng+fNfP/6RiG88cqSVB+Ssmmnl6abWsT9Sq3Zsxew/U=;
        b=NQgVR0tgs4R6T9BnaNEBhZfO6FuNm+1FhPDMd2BiVDZEpDYPR2VqGfz9gMcUz2Pf8S
         Y424QGBiZQRWjdU8A1tks89eThQbTEsHbFcl+lbcHNl4/AViL0/fZ8FMpn1v2V5j27t/
         KOZsI9L4c96tkMxhumYzCMAvern8OTGEhsWL0nH78Y0v4KR0ThwoS76Ani2emtrMoE/l
         tj2+/vH4cJQiNgYiArtyobq0Fwdv33Sh1ITmALCK6BePJINz//4V3IRtvewkHoZXkZdj
         ZXUSt6Blnild2yKWFh+D+qdpTwqwIIhz8fpGx75pg83lYhVVlFVZoPjhcr6Wu6wjQtZF
         FNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ng+fNfP/6RiG88cqSVB+Ssmmnl6abWsT9Sq3Zsxew/U=;
        b=XXET/yLKWt0ZRcvGC8KOidf51HU+f9KHPAGbad1C1kjvId3usJCmfxIH1ifTALsaIB
         Yf5kZxbUdQtiLu1mX7fdO76e1q+TQOD1F6oR9O8XIe3sTgVKh180OS5+diYWEjouOb2H
         5iXSyj6u+GUr7RSV9WWmkS8Gh6wl1M9S71edfw+ST0BtOY4C8WPRIaOhcB9XQckCrOuU
         5n2In7WSSVpc9uXscUj+AD+RUplD5bDqcmtXQTbiwjqpbCgm0koJRoJs01GCrPRZsVOO
         CIiCmPqvzhlvxJvZCtFKmcdtR7QJ1xOFNERc2YkN7UCWcEgZD7b2yQcIefHbZ1+HKs57
         MonA==
X-Gm-Message-State: AKaTC020U86iusv2EWzNpRdRoi8IkG/jN+/c+mZ7UoGq7JNLQTvX/L5SKSaRVpQ76cmrQLpz
X-Received: by 10.99.45.134 with SMTP id t128mr127096254pgt.86.1481161602856;
        Wed, 07 Dec 2016 17:46:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id 13sm45381683pfz.30.2016.12.07.17.46.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 2/7] submodule helper: support super prefix
Date:   Wed,  7 Dec 2016 17:46:18 -0800
Message-Id: <20161208014623.7588-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like main commands in Git, the submodule helper needs
access to the superproject prefix. Enable this in the git.c
but have its own fuse in the helper code by having a flag to
turn on the super prefix.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 31 ++++++++++++++++++++-----------
 git.c                       |  2 +-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5f9f..33676a57cf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,21 +1076,24 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+#define SUPPORT_SUPER_PREFIX (1<<0)
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
+	int option;
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list},
-	{"name", module_name},
-	{"clone", module_clone},
-	{"update-clone", update_clone},
-	{"relative-path", resolve_relative_path},
-	{"resolve-relative-url", resolve_relative_url},
-	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init},
-	{"remote-branch", resolve_remote_submodule_branch}
+	{"list", module_list, 0},
+	{"name", module_name, 0},
+	{"clone", module_clone, 0},
+	{"update-clone", update_clone, 0},
+	{"relative-path", resolve_relative_path, 0},
+	{"resolve-relative-url", resolve_relative_url, 0},
+	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"init", module_init, 0},
+	{"remote-branch", resolve_remote_submodule_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
@@ -1100,9 +1103,15 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
-		if (!strcmp(argv[1], commands[i].cmd))
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (!strcmp(argv[1], commands[i].cmd)) {
+			if (get_super_prefix() &&
+			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
+				die("%s doesn't support --super-prefix",
+				    commands[i].cmd);
 			return commands[i].fn(argc - 1, argv + 1, prefix);
+		}
+	}
 
 	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
diff --git a/git.c b/git.c
index efa1059fe0..98dcf6c518 100644
--- a/git.c
+++ b/git.c
@@ -493,7 +493,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-- 
2.11.0.rc2.30.gc512cbd.dirty

