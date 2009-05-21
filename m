From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] show-branch: migrate to parse-options API
Date: Thu, 21 May 2009 00:33:18 -0700
Message-ID: <fc53e39984e7fabbd53fa23a7d7f24625e685d2c.1242891030.git.bebarino@gmail.com>
References: <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 09:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M72ma-00038L-F0
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 09:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbZEUHd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 03:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZEUHd0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 03:33:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:37060 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZEUHdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 03:33:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so305126rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=l45HXDQZyFwd+k3rZv6wskPqKWpeRyP+syH0C7Eq7GU=;
        b=tE06WdaZtdwi8D21Z+TmVKUulpDZ2de+CMw8mzb3rvWNZuf70jEKeKmlaZpl/UMJ2Z
         zLJovuID7Br+DIvGkPw/dWIx9D4jMRh3VJnga+4aDiIoSn0TT9SVMhsPcLcMi3wVA2+C
         ti12Q2cAAyMkxICzc198qvmBpsSquur8jgkFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g+f4WdFvsv3UubtKgLgLJ1W/Ekv6bRS7TpDPZChtkETpsJt+Z3GEIK5cKsSY9iZh2U
         7suTieBpfCeerfufbttwPTCtgH+Moer0h52IDhP8ai3lWhLSsREP0PEVco667XT5Rchp
         2hMCJYeSVsBXKwkRZ9yaCPwPMcaMc50/HaTm0=
Received: by 10.142.200.3 with SMTP id x3mr887378wff.27.1242891207140;
        Thu, 21 May 2009 00:33:27 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 27sm5344058wfa.2.2009.05.21.00.33.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 00:33:26 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 21 May 2009 00:33:22 -0700
X-Mailer: git-send-email 1.6.3.1.61.g065b0
In-Reply-To: <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
In-Reply-To: <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com> <fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119659>

Note that "-g" no longer uses an equals '=' sign for its optional
arguments, but "--reflog" still does. This is normal behavior for parse
options, as arguments to "-g" are put immediately after the option with
no space.

For example

    git show-branch -g=4

is now

    git show-branch -g4

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-show-branch.c |  125 +++++++++++++++++++++++++------------------------
 1 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c8e9b3c..b1affd2 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -3,11 +3,13 @@
 #include "refs.h"
 #include "builtin.h"
 #include "color.h"
+#include "parse-options.h"
 
-static const char show_branch_usage[] =
-"git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
-static const char show_branch_usage_reflog[] =
-"--reflog is incompatible with --all, --remotes, --independent or --merge-base";
+static const char* show_branch_usage[] = {
+    "git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base] [--topics] [--color] [<refs>...]",
+    "--reflog[=n[,b]] [--list] [--color] <branch>",
+    NULL
+};
 
 static int showbranch_use_color = -1;
 static char column_colors[][COLOR_MAXLEN] = {
@@ -601,18 +603,25 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
 	return 0;
 }
 
-static void parse_reflog_param(const char *arg, int *cnt, const char **base)
+static int reflog = 0;
+
+static int parse_reflog_param(const struct option *opt, const char *arg,
+			      int unset)
 {
 	char *ep;
-	*cnt = strtoul(arg, &ep, 10);
+	const char **base = (const char **)opt->value;
+	if (!arg)
+		arg = "";
+	reflog = strtoul(arg, &ep, 10);
 	if (*ep == ',')
 		*base = ep + 1;
 	else if (*ep)
-		die("unrecognized reflog param '%s'", arg);
+		return error("unrecognized reflog param '%s'", arg);
 	else
 		*base = NULL;
-	if (*cnt <= 0)
-		*cnt = DEFAULT_REFLOG;
+	if (reflog <= 0)
+		reflog = DEFAULT_REFLOG;
+	return 0;
 }
 
 int cmd_show_branch(int ac, const char **av, const char *prefix)
@@ -638,8 +647,44 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int head_at = -1;
 	int topics = 0;
 	int dense = 1;
-	int reflog = 0;
 	const char *reflog_base = NULL;
+	struct option builtin_show_branch_options[] = {
+		OPT_BOOLEAN('a', "all", &all_heads,
+			    "show remote-tracking and local branches"),
+		OPT_BOOLEAN('r', "remotes", &all_remotes,
+			    "show remote-tracking branches"),
+		OPT_BOOLEAN(0, "color", &showbranch_use_color,
+			    "color '*!+-' corresponding to the branch"),
+		{ OPTION_INTEGER, 0, "more", &extra, "n",
+			    "show <n> more commits after the common ancestor",
+			    PARSE_OPT_OPTARG | PARSE_OPT_LASTARG_DEFAULT,
+			    NULL, (intptr_t)1 },
+		OPT_SET_INT(0, "list", &extra, "synonym to more=-1", -1),
+		OPT_BOOLEAN(0, "no-name", &no_name, "suppress naming strings"),
+		OPT_BOOLEAN(0, "current", &with_current_branch,
+			    "include the current branch"),
+		OPT_BOOLEAN(0, "sha1-name", &sha1_name,
+			    "name commits with their object names"),
+		OPT_BOOLEAN(0, "merge-base", &merge_base,
+			    "act like git merge-base -a"),
+		OPT_BOOLEAN(0, "independent", &independent,
+			    "show refs unreachable from any other ref"),
+		OPT_BOOLEAN(0, "topo-order", &lifo,
+			    "show commits in topological order"),
+		OPT_BOOLEAN(0, "topics", &topics,
+			    "show only commits not on the first branch"),
+		OPT_SET_INT(0, "sparse", &dense,
+			    "show merges reachable from only one tip", 0),
+		OPT_SET_INT(0, "date-order", &lifo,
+			    "show commits where no parent comes before its "
+			    "children", 0),
+		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, "<n>[,<base>]",
+			    "show <n> most recent ref-log entries starting at "
+			    "base",
+			    PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			    parse_reflog_param },
+		OPT_END()
+	};
 
 	git_config(git_show_branch_config, NULL);
 
@@ -652,63 +697,18 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		av = default_arg - 1; /* ick; we would not address av[0] */
 	}
 
-	while (1 < ac && av[1][0] == '-') {
-		const char *arg = av[1];
-		if (!strcmp(arg, "--")) {
-			ac--; av++;
-			break;
-		}
-		else if (!strcmp(arg, "--all") || !strcmp(arg, "-a"))
-			all_heads = all_remotes = 1;
-		else if (!strcmp(arg, "--remotes") || !strcmp(arg, "-r"))
-			all_remotes = 1;
-		else if (!strcmp(arg, "--more"))
-			extra = 1;
-		else if (!strcmp(arg, "--list"))
-			extra = -1;
-		else if (!strcmp(arg, "--no-name"))
-			no_name = 1;
-		else if (!strcmp(arg, "--current"))
-			with_current_branch = 1;
-		else if (!strcmp(arg, "--sha1-name"))
-			sha1_name = 1;
-		else if (!prefixcmp(arg, "--more="))
-			extra = atoi(arg + 7);
-		else if (!strcmp(arg, "--merge-base"))
-			merge_base = 1;
-		else if (!strcmp(arg, "--independent"))
-			independent = 1;
-		else if (!strcmp(arg, "--topo-order"))
-			lifo = 1;
-		else if (!strcmp(arg, "--topics"))
-			topics = 1;
-		else if (!strcmp(arg, "--sparse"))
-			dense = 0;
-		else if (!strcmp(arg, "--date-order"))
-			lifo = 0;
-		else if (!strcmp(arg, "--reflog") || !strcmp(arg, "-g")) {
-			reflog = DEFAULT_REFLOG;
-		}
-		else if (!prefixcmp(arg, "--reflog="))
-			parse_reflog_param(arg + 9, &reflog, &reflog_base);
-		else if (!prefixcmp(arg, "-g="))
-			parse_reflog_param(arg + 3, &reflog, &reflog_base);
-		else if (!strcmp(arg, "--color"))
-			showbranch_use_color = 1;
-		else if (!strcmp(arg, "--no-color"))
-			showbranch_use_color = 0;
-		else
-			usage(show_branch_usage);
-		ac--; av++;
-	}
-	ac--; av++;
+	ac = parse_options(ac, av, builtin_show_branch_options,
+			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (all_heads)
+		all_remotes = 1;
 
 	if (extra || reflog) {
 		/* "listing" mode is incompatible with
 		 * independent nor merge-base modes.
 		 */
 		if (independent || merge_base)
-			usage(show_branch_usage);
+			usage_with_options(show_branch_usage,
+					   builtin_show_branch_options);
 		if (reflog && ((0 < extra) || all_heads || all_remotes))
 			/*
 			 * Asking for --more in reflog mode does not
@@ -716,7 +716,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 *
 			 * Also --all and --remotes do not make sense either.
 			 */
-			usage(show_branch_usage_reflog);
+			die("--reflog is incompatible with --all, --remotes, "
+			    "--independent or --merge-base");
 	}
 
 	/* If nothing is specified, show all branches by default */
-- 
1.6.3.1.61.g065b0
