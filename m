From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 5/6] pull: allow interactive rebase
Date: Wed,  6 May 2015 01:00:52 +0100
Message-ID: <1430870453-5408-6-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmm4-0004e4-AW
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbbEFABJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:01:09 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33001 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbbEFAAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:55 -0400
Received: by wgin8 with SMTP id n8so199837288wgi.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMIPwyTni6C/i7HkB0mvI214q+M8dldBffrVY7qT+VY=;
        b=YZ5CTWLNvbYK/8cWfbA/yWJFyHVSo/8whdUDctMlWQ1MeZPnvebqINeo1Q6Xcom38b
         AcYvXy88X4EZQ10mfixqWaHaWxiAamgzyEM9TM0fVwjRx+fnbF7+TWIycOAUM7vcMdFg
         I1FJUDKFlGhC5BBuR4PXbxdr5RVTzMzJYITtcU363WK03xmIubU9EKKp0/r7VMzFEK/A
         cc9Ob3JHl2cT2hSYUQGEAURU0W1wIVtYwnV/0YuhJVx6RE1lcb5BJ0IJf+KWFaxb3t9w
         cwGR+Xwh0i3GWbxJ+L6t8MjXJewawLec1suiRH6U7fRkbbBDylvHW14JK0L5FSzZ7Sjd
         G8qA==
X-Received: by 10.180.20.200 with SMTP id p8mr8519661wie.78.1430870453685;
        Tue, 05 May 2015 17:00:53 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id v3sm37712wix.8.2015.05.05.17.00.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:53 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268437>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

Teach 'git pull' the option --rebase=interactive
Teach 'git remote' that the value for config variable branch.<name>.rebase
can be 'interactive'

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---

Notes:
    This feature is already present in msysgit.  This patch can be used
    either to bring the feature into standard git, or to resolve the
    conflict that will occur in the next rebase of msysgit.

 Documentation/config.txt   |  1 +
 Documentation/git-pull.txt |  4 +++-
 builtin/pull.c             | 19 ++++++++++++++++---
 builtin/remote.c           |  8 ++++++--
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..91314ef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -849,6 +849,7 @@ branch.<name>.rebase::
 	instead of merging the default branch from the default remote when
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
+	When the value is `interactive`, the rebase is run in interactive mode.
 +
 	When preserve, also pass `--preserve-merges` along to 'git rebase'
 	so that locally committed merge commits will not be flattened
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 712ab4b..8014908 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -104,7 +104,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve]::
+--rebase[=false|true|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -116,6 +116,8 @@ to `git rebase` so that locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
+When `interactive`, enable the interactive mode of rebase.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/builtin/pull.c b/builtin/pull.c
index f420b4a..76c2f72 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -26,7 +26,8 @@ enum pull_mode {
 	PULL_NOT_SET = -1,
 	PULL_MERGE,
 	PULL_REBASE,
-	PULL_PRESERVE_MERGES_REBASE
+	PULL_PRESERVE_MERGES_REBASE,
+	PULL_INTERACTIVE_REBASE
 };
 
 static const char * const builtin_pull_usage[] = {
@@ -85,12 +86,22 @@ static int parse_pull_mode(const char *name, const char* arg,
 		return 0;
 	}
 
+	if (!strcmp(arg, "interactive")) {
+		*option_rebase = PULL_INTERACTIVE_REBASE;
+		return 0;
+	}
+
+	if (!strcmp(arg, "i")) {
+		*option_rebase = PULL_INTERACTIVE_REBASE;
+		return 0;
+	}
+
 	if (!strcmp(arg, "preserve")) {
 		*option_rebase = PULL_PRESERVE_MERGES_REBASE;
 		return 0;
 	}
 
-	error(_("Invalid value for %s, should be 'true', 'false' or 'preserve'."), name);
+	error(_("Invalid value for %s, should be 'true', 'false', 'interactive' or 'preserve'."), name);
 	return -1;
 }
 
@@ -197,7 +208,7 @@ static int option_parse_x(const struct option *opt,
 }
 
 static struct option builtin_pull_options[] = {
-	{ OPTION_CALLBACK, 0, "rebase", NULL, N_("true|false|preserve"),
+	{ OPTION_CALLBACK, 0, "rebase", NULL, N_("true|false|interactive|preserve"),
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, option_parse_rebase },
 	OPT_BOOL(0, "progress", &progress,
@@ -527,6 +538,8 @@ static int run_rebase(const struct string_list merge_head, const char *fork_poin
 
 	if (pull_mode == PULL_PRESERVE_MERGES_REBASE)
 		argv_array_push(&argv, "--preserve-merges");
+	else if (pull_mode == PULL_INTERACTIVE_REBASE)
+		argv_array_push(&argv, "-i");
 
 	for (v = verbosity; v > 0; v--)
 		argv_array_push(&argv, "-v");
diff --git a/builtin/remote.c b/builtin/remote.c
index 5d3ab90..af6b21d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -245,7 +245,7 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
-	int rebase;
+	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
 };
 
 static struct string_list branch_list;
@@ -306,6 +306,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = 1;
+			else if (!strcmp(value, "interactive"))
+				info->rebase = INTERACTIVE_REBASE;
 		}
 	}
 	return 0;
@@ -1000,7 +1002,9 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf_ln(_("rebases onto remote %s"), merge->items[0].string);
+		printf_ln(_(branch_info->rebase == INTERACTIVE_REBASE ?
+			"rebases interactively onto remote %s" :
+			"rebases onto remote %s"), merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
-- 
2.4.0.7.gf20f26f
