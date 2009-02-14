From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc: make --prune useful again by accepting an optional
 parameter
Date: Sat, 14 Feb 2009 23:05:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142301030.10279@pacific.mpi-cbg.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214074954.7e423dd2@perceptron> <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de> <200902142233.07190.trast@student.ethz.ch> <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
 <1234545279-23153-1-git-send-email-trast@student.ethz.ch>    <20090214025115.615119bf@perceptron>    <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>    <20090214074954.7e423dd2@perceptron>    <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
 <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSdo-0000eP-2T
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZBNWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbZBNWEL
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:04:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752001AbZBNWEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:04:10 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:04:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 14 Feb 2009 23:04:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T4dIFLXJT7QW4DqcOZHbOsGNqf05yWZsQmOn+UO
	QJeUOryc2DLhTT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200902142233.07190.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109938>


Thanks for both of your sets of comments.

This is the interdiff.

---
 Documentation/git-gc.txt |    7 ++++---
 builtin-gc.c             |    2 +-
 t/t5304-prune.sh         |   24 +++++++++++++++++++++---
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index fcef5fb..b292e98 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date>]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune]
 
 DESCRIPTION
 -----------
@@ -60,8 +60,9 @@ are consolidated into a single pack by using the `-A` option of
 automatic consolidation of packs.
 
 --prune=<date>::
-	Prune loose objects older than date (default is 2 weeks ago).
-	This option is on by default.
+	Prune loose objects older than date (default is 2 weeks ago,
+	overrideable by the config variable `gc.pruneExpire`).  This
+	option is on by default.
 
 --no-prune::
 	Do not prune any loose objects.
diff --git a/builtin-gc.c b/builtin-gc.c
index 06bc83c..fc556ed 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -181,7 +181,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	struct option builtin_gc_options[] = {
 		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
-			"prune unreferenced objects (deprecated)",
+			"prune unreferenced objects",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2e9c4a9..55ed7c7 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -112,7 +112,7 @@ test_expect_success 'prune: do not prune heads listed as an argument' '
 
 '
 
-test_expect_success 'gc --no-prune && gc --prune=<date>' '
+test_expect_success 'gc --no-prune' '
 
 	before=$(git count-objects | sed "s/ .*//") &&
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
@@ -120,14 +120,32 @@ test_expect_success 'gc --no-prune && gc --prune=<date>' '
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
 	test-chmtime =-$((86400*5001)) $BLOB_FILE &&
+	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune &&
 	test 1 = $(git count-objects | sed "s/ .*//") &&
+	test -f $BLOB_FILE
+
+'
+
+test_expect_success 'gc respects gc.pruneExpire' '
+
+	git config gc.pruneExpire 5002.days.ago &&
+	git gc &&
 	test -f $BLOB_FILE &&
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
 	git gc --prune=5002.days.ago &&
-	test 1 = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
 	git gc --prune=5000.days.ago &&
-	test 0 = $(git count-objects | sed "s/ .*//") &&
 	test ! -f $BLOB_FILE
 
 '
-- 
1.6.2.rc0.367.g7f9a5
