From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] gc: make --prune useful again by accepting an optional
 parameter
Date: Sat, 14 Feb 2009 23:10:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142306400.10279@pacific.mpi-cbg.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214074954.7e423dd2@perceptron> <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de> <200902142233.07190.trast@student.ethz.ch> <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
 <1234545279-23153-1-git-send-email-trast@student.ethz.ch>    <20090214025115.615119bf@perceptron>    <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>    <20090214074954.7e423dd2@perceptron>    <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
 <3651.78.34.159.109.1234647192.squirrel@heapsort.de> <alpine.DEB.1.00.0902142301030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-538790407-1234649411=:10279"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSim-00027p-TY
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZBNWJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbZBNWJV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:09:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:55420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752138AbZBNWJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:09:20 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:09:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 14 Feb 2009 23:09:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VeQZoW/WVhbyyajXmHgAHjY5OP8Y8mYfhkEhGSN
	pBdHlqDQ3aI6Ox
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902142301030.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109939>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-538790407-1234649411=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

With this patch, "git gc --no-prune" will not prune any loose (and
dangling) object, and "git gc --prune=5.minutes.ago" will prune
all loose objects older than 5 minutes.

This patch benefitted from suggestions by Thomas Rast and Jan Krüger.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-gc.txt |   10 +++++++++-
 builtin-gc.c             |   19 ++++++++++++-------
 t/t5304-prune.sh         |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 7086eea..b292e98 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git gc' [--aggressive] [--auto] [--quiet]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune]
 
 DESCRIPTION
 -----------
@@ -59,6 +59,14 @@ are consolidated into a single pack by using the `-A` option of
 'git-repack'. Setting `gc.autopacklimit` to 0 disables
 automatic consolidation of packs.
 
+--prune=<date>::
+	Prune loose objects older than date (default is 2 weeks ago,
+	overrideable by the config variable `gc.pruneExpire`).  This
+	option is on by default.
+
+--no-prune::
+	Do not prune any loose objects.
+
 --quiet::
 	Suppress all progress reports.
 
diff --git a/builtin-gc.c b/builtin-gc.c
index a201438..8d990ed 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -161,7 +161,8 @@ static int need_to_gc(void)
 	 */
 	if (too_many_packs())
 		append_option(argv_repack,
-			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      prune_expire && !strcmp(prune_expire, "now") ?
+			      "-a" : "-A",
 			      MAX_ADD);
 	else if (!too_many_loose_objects())
 		return 0;
@@ -173,14 +174,15 @@ static int need_to_gc(void)
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
-	int prune = 0;
 	int aggressive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
 	char buf[80];
 
 	struct option builtin_gc_options[] = {
-		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects (deprecated)"),
+		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
+			"prune unreferenced objects",
+			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
 		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
@@ -218,7 +220,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			"\"git help gc\" for more information.\n");
 	} else
 		append_option(argv_repack,
-			      !strcmp(prune_expire, "now") ? "-a" : "-A",
+			      prune_expire && !strcmp(prune_expire, "now")
+			      ? "-a" : "-A",
 			      MAX_ADD);
 
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
@@ -230,9 +233,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
-	argv_prune[2] = prune_expire;
-	if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
-		return error(FAILED_RUN, argv_prune[0]);
+	if (prune_expire) {
+		argv_prune[2] = prune_expire;
+		if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
+			return error(FAILED_RUN, argv_prune[0]);
+	}
 
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_rerere[0]);
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 771c0a0..55ed7c7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -112,4 +112,42 @@ test_expect_success 'prune: do not prune heads listed as an argument' '
 
 '
 
+test_expect_success 'gc --no-prune' '
+
+	before=$(git count-objects | sed "s/ .*//") &&
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	git config gc.pruneExpire 2.days.ago &&
+	git gc --no-prune &&
+	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE
+
+'
+
+test_expect_success 'gc respects gc.pruneExpire' '
+
+	git config gc.pruneExpire 5002.days.ago &&
+	git gc &&
+	test -f $BLOB_FILE &&
+	git config gc.pruneExpire 5000.days.ago &&
+	git gc &&
+	test ! -f $BLOB_FILE
+
+'
+
+test_expect_success 'gc --prune=<date>' '
+
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	git gc --prune=5002.days.ago &&
+	test -f $BLOB_FILE &&
+	git gc --prune=5000.days.ago &&
+	test ! -f $BLOB_FILE
+
+'
+
 test_done
-- 
1.6.2.rc0.367.g7f9a5


--8323328-538790407-1234649411=:10279--
