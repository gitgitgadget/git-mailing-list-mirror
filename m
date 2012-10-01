From: Olaf Klischat <olaf.klischat@gmail.com>
Subject: [PATCH 1/2] git-add: -s flag added (silently ignore files)
Date: Mon,  1 Oct 2012 09:14:59 +0200
Message-ID: <1349075700-26334-2-git-send-email-olaf.klischat@gmail.com>
References: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org, olaf@sofd.de
X-From: git-owner@vger.kernel.org Mon Oct 01 09:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIaE9-0002ed-OK
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 09:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab2JAHPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 03:15:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50138 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab2JAHPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 03:15:14 -0400
Received: by bkcjk13 with SMTP id jk13so4702538bkc.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GlIwP212nOhxpNQRX9mer1ziDC3GWyE4A8G1+NjS2hc=;
        b=b5XEdxwUOQpZ0GhVc7YezHDgQVMDOVw7/+B2wzcf1pthbys2YZBcxCiNl++O5pEOPe
         0g83cwzmDWcJX1iZdCpry9B0O/BTkSRT/jF5oR9sMzTYJ2blmFR2V7l97DLYI8LwPkJK
         vL4qseKwCF4oPsDmVV3StfH5XxWATjWmhp4Uub8ydn+8KXMYNKPxE+1ty8Y5W1kxvBUR
         2jwgKH9xH3+QQO47dxYm8OOmMk/6kyED3ecJHjcVEnz9T6xsLJQkzcJsWcRizo93uDbq
         jzatGjK65Q0ZH9kzQ6jZcndYzMPl+q9iQZg9E+Ocml7bQuNDJOLJbBNsdJa7nB+GSEpW
         mXmw==
Received: by 10.204.150.209 with SMTP id z17mr5652887bkv.8.1349075713501;
        Mon, 01 Oct 2012 00:15:13 -0700 (PDT)
Received: from tack.home.local. (e178068083.adsl.alicedsl.de. [85.178.68.83])
        by mx.google.com with ESMTPS id e13sm5851880bkw.12.2012.10.01.00.15.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 00:15:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206722>

Signed-off-by: Olaf Klischat <olaf.klischat@gmail.com>
---
 builtin/add.c  |   14 +++++++++++---
 t/t3700-add.sh |   17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e664100..61bb9ce 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -313,7 +313,7 @@ static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int ignore_add_errors, addremove, intent_to_add, ignore_missing, silent_ignores = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -329,6 +329,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	OPT_BOOLEAN('s', "silent-ignores", &silent_ignores, N_("don't fail when ignored files are specified on the command line (ignore them silently)")),
 	OPT_END(),
 };
 
@@ -339,6 +340,11 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "add.silentignores") ||
+	    !strcmp(var, "add.silent-ignores")) {
+		silent_ignores = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -346,11 +352,11 @@ static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
 
-	if (dir->ignored_nr) {
+	if (dir->ignored_nr && !silent_ignores) {
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		fprintf(stderr, _("Use -f if you really want to add them, or -s to ignore them silently.\n"));
 		die(_("no files added"));
 	}
 
@@ -390,6 +396,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
+	if (ignored_too && silent_ignores)
+		die(_("-f and -s are mutually incompatible"));
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if ((addremove || take_worktree_changes) && !argc) {
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..1e17ae2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -294,7 +294,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
 cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
-Use -f if you really want to add them.
+Use -f if you really want to add them, or -s to ignore them silently.
 fatal: no files added
 EOF
 cat >expect.out <<\EOF
@@ -310,4 +310,19 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+cat >expect.err <<\EOF
+EOF
+cat >expect.out <<\EOF
+add 'track-this'
+EOF
+
+test_expect_success 'git add --dry-run --silent-ignore --ignore-missing of non-existing file' '
+	git add --dry-run --silent-ignore --ignore-missing track-this ignored-file >actual.out 2>actual.err
+'
+
+test_expect_success 'git add --dry-run --silent-ignore --ignore-missing of non-existing file output' '
+	test_i18ncmp expect.out actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_done
-- 
1.7.10.4
