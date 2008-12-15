From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gc: make --prune useful again by accepting an optional
 parameter
Date: Mon, 15 Dec 2008 21:22:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812152121260.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 15 21:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCJqN-00021y-NN
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 21:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYLOUNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYLOUNt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 15:13:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:32932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753178AbYLOUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 15:13:49 -0500
Received: (qmail invoked by alias); 15 Dec 2008 20:13:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 15 Dec 2008 21:13:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QY31vAmIQ8391IzyWfiK3uaiMObMS5B9Agpdj2k
	eDR4PGv64Nzsnp
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103204>


With this patch, "git gc --no-prune" will not prune any loose (and
dangling) object, and "git gc --prune=5.minutes.ago" will prune
all loose objects older than 5 minutes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Not meant for 1.6.1, obviously.

 Documentation/git-gc.txt |    9 ++++++++-
 builtin-gc.c             |   13 ++++++++-----
 t/t5304-prune.sh         |   20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

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
index bbc41ac..078c5b3 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -199,14 +199,15 @@ static int need_to_gc(void)
 
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
@@ -255,9 +256,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
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
1.6.0.4.1189.g8876f
