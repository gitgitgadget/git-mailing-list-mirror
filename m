From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gc: make --prune useful again by accepting an optional
 parameter
Date: Sat, 14 Feb 2009 20:02:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214025115.615119bf@perceptron> <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de> <20090214074954.7e423dd2@perceptron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPn2-0003t6-TJ
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZBNTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZBNTBa
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:01:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:49239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751572AbZBNTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:01:30 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:01:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 14 Feb 2009 20:01:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ynmcC0imyZs++4EjS65jsQHmiLT8hEOjAB2OXIl
	RJT6n7qV3m9q1D
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090214074954.7e423dd2@perceptron>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109892>

With this patch, "git gc --no-prune" will not prune any loose (and
dangling) object, and "git gc --prune=5.minutes.ago" will prune
all loose objects older than 5 minutes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Actually, when trying to add tests to Jan's patch, I realized that 
	I already have a patch in my personal tree, which makes --prune 
	accept an optional parameter...

	Jan, what do you think?  If you prefer --prune-expire, can you 
	please adapt my test?

 Documentation/git-gc.txt |    9 ++++++++-
 builtin-gc.c             |   19 ++++++++++++-------
 t/t5304-prune.sh         |   20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 7086eea..fcef5fb 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git gc' [--aggressive] [--auto] [--quiet]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date>]
 
 DESCRIPTION
 -----------
@@ -59,6 +59,13 @@ are consolidated into a single pack by using the `-A` option of
 'git-repack'. Setting `gc.autopacklimit` to 0 disables
 automatic consolidation of packs.
 
+--prune=<date>::
+	Prune loose objects older than date (default is 2 weeks ago).
+	This option is on by default.
+
+--no-prune::
+	Do not prune any loose objects.
+
 --quiet::
 	Suppress all progress reports.
 
diff --git a/builtin-gc.c b/builtin-gc.c
index a201438..a962f38 100644
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
+			"prune unreferenced objects (deprecated)",
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
index 771c0a0..2e9c4a9 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -112,4 +112,24 @@ test_expect_success 'prune: do not prune heads listed as an argument' '
 
 '
 
+test_expect_success 'gc --no-prune && gc --prune=<date>' '
+
+	before=$(git count-objects | sed "s/ .*//") &&
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	git gc --no-prune &&
+	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git gc --prune=5002.days.ago &&
+	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE &&
+	git gc --prune=5000.days.ago &&
+	test 0 = $(git count-objects | sed "s/ .*//") &&
+	test ! -f $BLOB_FILE
+
+'
+
 test_done
-- 
1.6.2.rc0.367.g7f9a5
