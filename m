From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] show-branch: migrate to parse-options API
Date: Sun, 17 May 2009 03:47:04 -0700
Message-ID: <1242557224-8411-3-git-send-email-bebarino@gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com>
 <1242557224-8411-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 12:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5dtq-0005YO-Du
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 12:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbZEQKrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 06:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbZEQKrQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 06:47:16 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:48411 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbZEQKrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 06:47:13 -0400
Received: by pzk13 with SMTP id 13so1640221pzk.33
        for <git@vger.kernel.org>; Sun, 17 May 2009 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=SS3kiJrnGmuG1XabyiQ8sLj1Moh2nw60Apat42ZK5Ck=;
        b=NUWKE5qw6osLoKe4THYhaOi1tx4wM9XOv6hbRNg4GwuzCI742iyETdQuHVziLNJE7V
         0KidnzKsA24XJ1FNvBiFfnfVyusepYXh/aKwskrAqRX7OxnMXj67PNzsY1aNSvi0xaxN
         qZkWva5BtaG5dGTVbcchsuK6751r55aVulcqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rZTBs4Hx0yqskBkZDk7nX68iAh//EhBK2nXT9POlc4Sfl/wKj8fBpZ3uztec52C4v6
         F5klPTh7jFVylUJaQAuBwbv8vPTSd/Mg/yuZyHWaLce+GWL3fR5Ob6L++zRx57jD5OAk
         GTr7UTowkZej0qQ56BJGMTwVkOviWv3YT9E0c=
Received: by 10.114.192.3 with SMTP id p3mr8708970waf.166.1242557234121;
        Sun, 17 May 2009 03:47:14 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id m28sm3580727waf.2.2009.05.17.03.47.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 03:47:13 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 17 May 2009 03:47:10 -0700
X-Mailer: git-send-email 1.6.3.1.30.g55524
In-Reply-To: <1242557224-8411-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119391>

Also die instead of calling usage with an error string.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-show-branch.c |  117 +++++++++++++++++++++++++------------------------
 1 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index c3afabb..e9acd4c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -2,11 +2,13 @@
 #include "commit.h"
 #include "refs.h"
 #include "builtin.h"
+#include "parse-options.h"
 
-static const char show_branch_usage[] =
-"git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
-static const char show_branch_usage_reflog[] =
-"--reflog is incompatible with --all, --remotes, --independent or --merge-base";
+static const char* show_branch_usage[] = {
+    "git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base] [--topics] [<refs>...]",
+    "--reflog[=n[,b]] [--list] <branch>",
+    NULL
+};
 
 static int default_num;
 static int default_alloc;
@@ -569,18 +571,25 @@ static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
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
 		die("unrecognized reflog param '%s'", arg);
 	else
 		*base = NULL;
-	if (*cnt <= 0)
-		*cnt = DEFAULT_REFLOG;
+	if (reflog <= 0)
+		reflog = DEFAULT_REFLOG;
+	return 0;
 }
 
 int cmd_show_branch(int ac, const char **av, const char *prefix)
@@ -606,8 +615,42 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
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
+			    PARSE_OPT_OPTARG | PARSE_OPT_CUSTOM_ARGH,
+			    parse_reflog_param },
+		OPT_END()
+	};
 
 	git_config(git_show_branch_config, NULL);
 
@@ -617,59 +660,18 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
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
@@ -677,7 +679,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 *
 			 * Also --all and --remotes do not make sense either.
 			 */
-			usage(show_branch_usage_reflog);
+			die("--reflog is incompatible with --all, --remotes, "
+			    "--independent or --merge-base");
 	}
 
 	/* If nothing is specified, show all branches by default */
-- 
1.6.3.1.30.g55524
