From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 8 Feb 2007 09:51:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702080948240.8424@woody.linux-foundation.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
 <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
 <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3p321n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 18:52:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFDRL-0000Lw-Lc
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 18:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXBHRwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbXBHRwF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 12:52:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56932 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbXBHRwC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 12:52:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18HpudD025980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 09:51:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18Hpu5X020758;
	Thu, 8 Feb 2007 09:51:56 -0800
In-Reply-To: <7vmz3p321n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.114__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39067>



On Wed, 7 Feb 2007, Junio C Hamano wrote:
> 
> I think we are in agreement.  I showed an outright hacky one
> because I am not ready to do somewhat involved one at the end of
> the rc period.

How about this?

It makes "git reflog [show]" act as

	git log -g --pretty=oneline --abbrev-cmit

and is fairly straightforward. So you can just write

	git reflog

or 

	git reflog show

and it will show you the reflog in a nice format.

		Linus

---
 Documentation/git-reflog.txt |   17 +++++++++++++----
 builtin-log.c                |   32 ++++++++++++++++++++++++++++++++
 builtin-reflog.c             |   18 ++++++++++++------
 builtin.h                    |    1 +
 4 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 1138865..bc7c987 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -8,13 +8,18 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git-reflog' expire [--dry-run] [--stale-fix]
-	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
-
+'git reflog' <subcommand> <options> 
 
 DESCRIPTION
 -----------
+The command takes various subcommands, and different options
+depending on the subcommand:
+
+[verse]
+git reflog expire [--dry-run] [--stale-fix]
+	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
+
+git reflog [show] [log-options]
 
 Reflog is a mechanism to record when the tip of branches are
 updated.  This command is to manage the information recorded in it.
@@ -25,6 +30,10 @@ Entries older than `expire` time, or entries older than
 tip, are removed from the reflog.  This is typically not used
 directly by the end users -- instead, see gitlink:git-gc[1].
 
+The subcommand "show" (which is also the default, in the absense of any
+subcommands) will take all the normal log options, and show the log of
+the current branch. It is basically an alias for 'git log -g --abbrev-commit
+--pretty=oneline', see gitlink:git-log[1].
 
 
 OPTIONS
diff --git a/builtin-log.c b/builtin-log.c
index 982d871..af2de54 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -11,6 +11,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "tag.h"
+#include "reflog-walk.h"
 
 static int default_show_root = 1;
 
@@ -181,6 +182,37 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+/*
+ * This is equivalent to "git log -g --abbrev-commit --pretty=oneline"
+ */
+int cmd_log_reflog(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info rev;
+
+	git_config(git_log_config);
+	init_revisions(&rev, prefix);
+	init_reflog_walk(&rev.reflog_info);
+	rev.abbrev_commit = 1;
+	rev.verbose_header = 1;
+	cmd_log_init(argc, argv, prefix, &rev);
+
+	/*
+	 * This means that we override whatever commit format the user gave
+	 * on the cmd line.  Sad, but cmd_log_init() currently doesn't
+	 * allow us to set a different default.
+	 */
+	rev.commit_format = CMIT_FMT_ONELINE;
+	rev.always_show_header = 1;
+
+	/*
+	 * We get called through "git reflog", so unlike the other log
+	 * routines, we need to set up our pager manually..
+	 */
+	setup_pager();
+
+	return cmd_log_walk(&rev);
+}
+
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index bfb169a..65b845b 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -13,7 +13,7 @@
  */
 
 static const char reflog_expire_usage[] =
-"git-reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+"git-reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -372,10 +372,16 @@ static const char reflog_usage[] =
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
-	if (argc < 2)
-		usage(reflog_usage);
-	else if (!strcmp(argv[1], "expire"))
+	/* With no command, we default to showing it. */
+	if (argc < 2 || *argv[1] == '-')
+		return cmd_log_reflog(argc, argv, prefix);
+
+	if (!strcmp(argv[1], "show"))
+		return cmd_log_reflog(argc - 1, argv + 1, prefix);
+
+	if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
-	else
-		usage(reflog_usage);
+
+	/* Not a recognized reflog command..*/
+	usage(reflog_usage);
 }
diff --git a/builtin.h b/builtin.h
index dd0e352..5108fd2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -40,6 +40,7 @@ extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
+extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
