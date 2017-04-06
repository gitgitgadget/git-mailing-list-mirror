Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44BD20966
	for <e@80x24.org>; Thu,  6 Apr 2017 06:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755415AbdDFGDC (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 02:03:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35849 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbdDFGDA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 02:03:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so6067678pgh.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWZvS5PZzAfR19XYR0qfs4s16ZW3i021h1JkqYIin+8=;
        b=cMqTAMcfzPkSJQL6dGJdBVd1IF0rknBqeKQV8oreadGQTVBfL1e2pp9PgU8wYv3afT
         3Mxsfr0Cj5HtIjeAJJkYDW9MpikJw3FMVobHnN16eP7HkY4MRcvTr5oa4SvOZYzjcdc5
         3m6h/tEabY+/+82pxB2xT3uyzvAzlsXjGA78kCY1DzN2wZ2iBAoiXCO9dwcXA4AeRt+S
         BgxTcGqrqfWcWY8+HiXlG+zWKIXLxLwhZh7Q0g6uMsgFKiWHb37lezB8CRBl0xOcDsux
         o3kP9w5rltAh7OtKQHg9b7Fg4fZjiRdNmmBIK8W55d6jjikyci5MojGvery7KYJJL1zN
         B7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWZvS5PZzAfR19XYR0qfs4s16ZW3i021h1JkqYIin+8=;
        b=rIFrtie+m+uQD7Mcx8FuQea+82kwaxfhwLHQ0dYrnaGRpqncv11rL173NdKdJyA7Za
         don6gUTWtWaDe0PfBROWcoowZz4QPAE1kz4i1DiRgZrgD3w9OzCd2DC6ViePF2gYiINK
         XC2V1jc9lz1sckvEo5B4vA7ipvgMLjop7C3gq5AGPGXLirYBzow/V2MNQ46eE24MT8bk
         YL67LQJ7GSRqsiSgBsvTxS24nC8Zf4vND0YrwWdsCauccuzMuofs3kkXLiWBKmDz65Wa
         QV5a/GSfI/BP0W1nEEc7L7vK40Y29DEB1vXXkQMICZl2d+knAmVB17I58jy7K0BpCCe8
         fyqg==
X-Gm-Message-State: AFeK/H0OwCKOQnqHgx6kOUirYesy83XRW8VmbafGUMMRmyzi4MaOdrFl49tBr9FgZehEew==
X-Received: by 10.99.177.4 with SMTP id r4mr34039511pgf.16.1491458579875;
        Wed, 05 Apr 2017 23:02:59 -0700 (PDT)
Received: from localhost.localdomain ([47.11.8.91])
        by smtp.gmail.com with ESMTPSA id e89sm1167946pfd.122.2017.04.05.23.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 23:02:59 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     =sbeller@google.com, peff@peff.net,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v1] Disallow git commands from within unpopulated submodules
Date:   Thu,  6 Apr 2017 11:30:53 +0530
Message-Id: <20170406060053.4453-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main motivations for disallowing git commands within an
unpopulated submodule are:

Whenever we run "git -C status" within an unpopulated submodule, it
falls back to the superproject. This occurs since there is no .git
file in the submodule directory. So superproject's status gets displayed.
Also, the user's intention is not clear behind running the command
in an unpopulated submodule. Hence we prefer to error out.

When we run the command "git -C sub add ." within a submodule, the
results observed are:

In the case of the populated submodule, it acts like running “git add .“
inside the submodule. This is uncontroversial and runs as expected.

In the case of the unpopulated submodule, the user's intention behind
entering the above command is unclear. He may have intended to add
the submodule to the superproject or to add all files inside the
sub/ directory to the submodule or superproject. Hence we’ll prefer
to error out in these case.

Eventually, we use a check_prefix_inside_submodule to see check if the
path is inside an unpopulated submodule. If it is, then we report the
user about the unpopulated submodule.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

Since this patch effectively uses RUN_SETUP, builtin commands like
'diff' and other non-builtin commands are not filtered.
For such cases, I think, we need to handle them separately.

Also since currently, git-submodule is not a builtin command, the
command for initializing and updating the submodule doesn't return an
error message, but once it is converted to builtin, we need to handle
its case explicitly.

The build report of this patch is available on:
https://travis-ci.org/pratham-pc/git/builds/219030999

Also, the above patch was initially my GSoC project topic, but I changed
it later on and added these bug fixes to my wishlist of the proposal.

 builtin/submodule--helper.c      |  4 ----
 git.c                            |  3 +++
 submodule.c                      | 45 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                      |  6 ++++++
 t/t6134-pathspec-in-submodule.sh |  2 +-
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 15a5430c0..4f7c7d7b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -219,10 +219,6 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-struct module_list {
-	const struct cache_entry **entries;
-	int alloc, nr;
-};
 #define MODULE_LIST_INIT { NULL, 0, 0 }
 
 static int module_list_compute(int argc, const char **argv,
diff --git a/git.c b/git.c
index 33f52acbc..eefe3fb01 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "submodule.h"
 
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
@@ -364,6 +365,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		if (prefix)
 			die("can't use --super-prefix from a subdirectory");
 	}
+	if (prefix)
+		check_prefix_inside_submodule(prefix);
 
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
diff --git a/submodule.c b/submodule.c
index 0a2831d84..d2c3023bf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -545,6 +545,51 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+#define MODULE_LIST_INIT { NULL, 0, 0 }
+
+void check_prefix_inside_submodule(const char *prefix)
+{
+	struct module_list list = MODULE_LIST_INIT;
+	int i;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
+		list.entries[list.nr++] = ce;
+		while (i + 1 < active_nr &&
+			!strcmp(ce->name, active_cache[i + 1]->name))
+			 /*
+			  * Skip entries with the same name in different stages
+			  * to make sure an entry is returned only once.
+			  */
+			i++;
+	}
+
+	for(i = 0; i < list.nr; i++) {
+		if(strlen((*list.entries[i]).name) ==  strlen(prefix)) {
+			if (!strcmp((*list.entries[i]).name, prefix)) {
+				/* This case cannot happen because */
+				die("BUG: prefixes end with '/', but we do not record ending slashes in the index");
+			}
+		}
+		else if(strlen((*list.entries[i]).name) ==  strlen(prefix)-1) {
+			const char *out = NULL;
+			if(skip_prefix(prefix, (*list.entries[i]).name, &out)) {
+				if(strlen(out) == 1 && out[0] == '/')
+					die(_("command from inside unpopulated submodule '%s' not supported."), (*list.entries[i]).name);
+			}
+		}
+	}
+
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index 05ab674f0..5e41e5afc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,6 +31,12 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
+struct module_list {
+	const struct cache_entry **entries;
+	int alloc, nr;
+};
+
+extern void check_prefix_inside_submodule(const char *prefix);
 extern int is_staging_gitmodules_ok(void);
 extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 extern int remove_path_from_gitmodules(const char *path);
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index fd401ca60..086cc4c47 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -25,7 +25,7 @@ test_expect_success 'error message for path inside submodule' '
 '
 
 cat <<EOF >expect
-fatal: Pathspec '.' is in submodule 'sub'
+fatal: command from inside unpopulated submodule 'sub' not supported.
 EOF
 
 test_expect_success 'error message for path inside submodule from within submodule' '
-- 
2.11.0

