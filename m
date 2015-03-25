From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH RFC] init-db: introduce new -c/--config option
Date: Thu, 26 Mar 2015 00:22:39 +0600
Message-ID: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:23:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YapxQ-0007eI-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 19:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbCYSXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 14:23:08 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35395 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbbCYSXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 14:23:06 -0400
Received: by lbcgn8 with SMTP id gn8so23981320lbc.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z5dTEpBje0ERiySPRPLi3N6+arGatUlSptmLzgLfRfg=;
        b=JW2nvOxZUocUrJX9Ul3xui+/lcW6MpQLNzx6cY4vGYhb2zec+7MTyZF3d3fxQytMVk
         Ki4sIfb1Yjd4GyrMx0b9w5FwHYtuWvYnyvTA+15siWwgd8mRhQ02z6gXUW+yzHZRGlR+
         HDD4nWCThaQ6mi4//7D+lbzH3DdPe5hFx+LEgOMJombP2PM+5H9F+JrxPQxPfWBTAryt
         CGBfr4JuQJgEgQ0h1xxYgUCzmvBeaWs+0NIRUQG0AbSjNstCS1eejeUkefzNzAa/2VbW
         8ooFD6DvP2Pe/cU48rFaZTDghQ/dqtuzHh0+yzNqpWduMTlF81eqmveNzcX8oVJBd3A3
         RTSA==
X-Received: by 10.152.26.169 with SMTP id m9mr9716533lag.45.1427307784158;
        Wed, 25 Mar 2015 11:23:04 -0700 (PDT)
Received: from localhost.localdomain ([37.151.35.144])
        by mx.google.com with ESMTPSA id a4sm739949lbm.32.2015.03.25.11.23.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 11:23:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.611.g09038fc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266289>

For now we can clone repository with the `git clone` command and pass
-c/--config with configuration option to it and these configuration
options will be set in the clonned repository config.

This patch provides the same functional, but for the `git init` command.
It allows to pass -c/--config option to the `git init` command and
given configuration option will be added to the newly created repository,
after it will be created.

This option can be used multiply times. If given configuration option
is the same that in the default config, given option will overwrite.

Main purpose of this option is to get rid of the manual editing of
the config.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-init.txt | 11 ++++++++++-
 builtin/init-db.c          | 33 +++++++++++++++++++++++++++++++--
 t/t0001-init.sh            | 16 ++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..3ecbf2a 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>]
+	  [--separate-git-dir <git dir>] [--config <key>=<value>]
 	  [--shared[=<permissions>]] [directory]
 
 
@@ -111,6 +111,15 @@ into it.
 If you provide a 'directory', the command is run inside it. If this directory
 does not exist, it will be created.
 
+--config <key>=<value>::
+-c <key>=<value>::
+Set a new configuration option in the new repository. The <key> expected in
+the same format as linkgit:git-config[1] (e.g., `core.eol=true`). If
+This option can be used multiply times. If multiply options are given with
+the same keys, each value will be written to the config. If given key is
+the same that used in the default configuration file, previous value
+will be overwritten.
+
 --
 
 TEMPLATE DIRECTORY
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 280454a..184de40 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -471,6 +471,26 @@ static const char *const init_db_usage[] = {
 	NULL
 };
 
+static int write_one_config(const char *key, const char *value, void *data) {
+	char *v = NULL;
+	git_config_get_string(key, &v);
+	if (v) {
+		git_config_set(key, value);
+		return 1
+	} else
+		return git_config_set_multivar(key, value ? value : "true", "^$", 0);
+}
+
+static void write_config(struct string_list *config){
+	int i;
+
+	for (i = 0; i < config->nr; i++) {
+		if (git_config_parse_parameter(config->items[i].string,
+					       write_one_config, NULL) < 0)
+			die("unable to write parameters to config file");
+	}
+}
+
 /*
  * If you want to, you can share the DB area with any number of branches.
  * That has advantages: you can save space by sharing all the SHA1 objects.
@@ -479,11 +499,13 @@ static const char *const init_db_usage[] = {
  */
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
+	int ret;
 	const char *git_dir;
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
+	static struct string_list option_config;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -496,6 +518,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
+			   N_("set config inside the new repository")),
 		OPT_END()
 	};
 
@@ -592,6 +616,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	set_git_dir_init(git_dir, real_git_dir, 1);
-
-	return init_db(template_dir, flags);
+	ret = init_db(template_dir, flags);
+	/*
+	 * new repository already created, so we can update .git/config if
+	 * -c/--config passed
+	 */
+	write_config(&option_config);
+	return ret;
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7de8d85..8ce3537 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -339,4 +339,20 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
+test_expect_success 'git init -c key=value' '
+	rm -rf newdir realgitdir &&
+	git init -c core.foo=bar newdir &&
+	echo bar >expect &&
+	git --git-dir=newdir/.git config core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git init -c key=value override default value' '
+	rm -rf newdir &&
+	git init -c core.filemode=false newdir &&
+	echo false >expect &&
+	git --git-dir=newdir/.git config core.filemode >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.3.3.611.g09038fc.dirty
