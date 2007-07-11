From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] Move the --decorate option from builtin-log.c to
 revision.c.
Date: Wed, 11 Jul 2007 02:29:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110229120.4047@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 11 03:37:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8R8c-0002GO-Ph
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbXGKBhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbXGKBhE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:37:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754696AbXGKBhC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:37:02 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:37:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 11 Jul 2007 03:37:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191JcB2SyZ15dtqMPfedaGCkO+uqy8mWJDoeTw6bH
	MkztTxsNdgNB0I
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707110220340.4047@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52125>


It is more logical to have the --decorate option in revision, like
many others affecting the way how commits are shown.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-log.txt        |    3 ---
 Documentation/pretty-options.txt |    4 ++++
 builtin-log.c                    |   14 ++------------
 revision.c                       |    4 ++++
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 7adcdef..b55a87e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -51,9 +51,6 @@ include::pretty-options.txt[]
 	a record about how the tip of a reference was changed.
 	See also gitlink:git-reflog[1].
 
---decorate::
-	Print out the ref names of any commits that are shown.
-
 --full-diff::
 	Without this flag, "git log -p <paths>..." shows commits that
 	touch the specified paths, and diffs about the same specified
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 746bc5b..3b21e0d 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -20,3 +20,7 @@ people using 80-column terminals.
 	command to re-code the commit log message in the encoding
 	preferred by the user.  For non plumbing commands this
 	defaults to UTF-8.
+
+--decorate::
+	When a commit is shown, and it matches a ref, print that ref name
+	in brackets after the commit name.
diff --git a/builtin-log.c b/builtin-log.c
index c14eea5..59372bb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,9 +24,6 @@ void add_head(struct rev_info *revs);
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
-	int i;
-	int decorate = 0;
-
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
@@ -40,15 +37,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		if (rev->diffopt.nr_paths != 1)
 			usage("git logs can only follow renames on one pathname at a time");
 	}
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--decorate")) {
-			if (!decorate)
-				for_each_ref(add_ref_decoration, NULL);
-			decorate = 1;
-		} else
-			die("unrecognized argument: %s", arg);
-	}
+	if (argc > 1)
+		die("unrecognized argument: %s", argv[1]);
 }
 
 static int cmd_log_walk(struct rev_info *rev)
diff --git a/revision.c b/revision.c
index 33ee9ee..7683d0a 100644
--- a/revision.c
+++ b/revision.c
@@ -1176,6 +1176,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->reverse ^= 1;
 				continue;
 			}
+			if (!strcmp(arg, "--decorate")) {
+				for_each_ref(add_ref_decoration, NULL);
+				continue;
+			}
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-- 
1.5.3.rc0.2783.gf3f7
