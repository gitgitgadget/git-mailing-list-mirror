From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-reset: add -q option to operate quietly
Date: Sun, 4 Nov 2007 09:37:20 +0000
Message-ID: <20071104093720.6950.qmail@e7d9732ff18748.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iobuu-000774-9e
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbXKDJhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbXKDJhB
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:37:01 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53720 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753088AbXKDJhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:37:00 -0500
Received: (qmail 6951 invoked by uid 1000); 4 Nov 2007 09:37:20 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63370>

Many git commands have a -q option to suppress output to stdout, let's
have it for git-reset too.

This was asked for by Joey Hess through
 http://bugs.debian.org/444933

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-reset.txt |    7 +++++--
 builtin-reset.c             |   14 ++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 87afa6f..050e4ea 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,8 +8,8 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git-reset' [--mixed | --soft | --hard] [<commit>]
-'git-reset' [--mixed] <commit> [--] <paths>...
+'git-reset' [--mixed | --soft | --hard] [-q] [<commit>]
+'git-reset' [--mixed] [-q] <commit> [--] <paths>...
 
 DESCRIPTION
 -----------
@@ -45,6 +45,9 @@ OPTIONS
 	switched to. Any changes to tracked files in the working tree
 	since <commit> are lost.
 
+-q::
+	Be quiet, only report errors.
+
 <commit>::
 	Commit to make the current HEAD.
 
diff --git a/builtin-reset.c b/builtin-reset.c
index e1dc31e..dd301df 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,7 +18,7 @@
 #include "tree.h"
 
 static const char builtin_reset_usage[] =
-"git-reset [--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]";
+"git-reset [--mixed | --soft | --hard] [-q] [<commit-ish>] [ [--] <paths>...]";
 
 static char *args_to_str(const char **argv)
 {
@@ -173,7 +173,7 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, reset_type = NONE, update_ref_status = 0;
+	int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -185,7 +185,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
-	if (i < argc) {
+	while (i < argc) {
 		if (!strcmp(argv[i], "--mixed")) {
 			reset_type = MIXED;
 			i++;
@@ -198,6 +198,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			reset_type = HARD;
 			i++;
 		}
+		else if (!strcmp(argv[i], "-q")) {
+			quiet = 1;
+			i++;
+		}
+		else
+			break;
 	}
 
 	if (i < argc && argv[i][0] != '-')
@@ -258,7 +264,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	switch (reset_type) {
 	case HARD:
-		if (!update_ref_status)
+		if (!update_ref_status && !quiet)
 			print_new_head_line(commit);
 		break;
 	case SOFT: /* Nothing else to do. */
-- 
1.5.3.5
