From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Wed, 29 Oct 2008 02:09:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, schacon@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 29 02:04:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzTd-000626-6C
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 02:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbYJ2BCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 21:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYJ2BCs
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 21:02:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:52380 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752889AbYJ2BCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 21:02:47 -0400
Received: (qmail invoked by alias); 29 Oct 2008 01:02:46 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 29 Oct 2008 02:02:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lOxdZDaSl60fFbxqsCfzXgyTekCr4+bgrZWnHq0
	WDcNFVqpZTK95l
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99344>


Now, git show <tree> shows some more information, and with the -r option,
it recurses into subdirectories.

Requested by Scott Chacon.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The only quirk is the command line parsing for -r: we cannot use 
	DIFF_OPT_TST(&rev.diffopt, RECURSIVE), because that is switched 
	on not only by cmd_log_init(), but implicitly by 
	diff_setup_done(), because FORMAT_PATCH is selected by git-show.

 builtin-log.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3796dda..b00d353 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -297,8 +297,12 @@ static int show_tree_object(const unsigned char *sha1,
 		const char *base, int baselen,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
-	printf("%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
-	return 0;
+	int *recursive = context;
+	printf("%06o %s %.*s%s%s\n", mode,
+			find_unique_abbrev(sha1, DEFAULT_ABBREV),
+			baselen, base,
+			pathname, S_ISDIR(mode) ? "/" : "");
+	return *recursive ? READ_TREE_RECURSIVE : 0;
 }
 
 int cmd_show(int argc, const char **argv, const char *prefix)
@@ -306,6 +310,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct object_array_entry *objects;
 	int i, count, ret = 0;
+	int tree_recursive = 0;
 
 	git_config(git_log_config, NULL);
 
@@ -319,6 +324,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
+	for (i = 1; i < argc && strcmp(argv[i], "--"); i++)
+		if (!strcmp(argv[i], "-r")) {
+			tree_recursive = 1;
+			break;
+		}
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	count = rev.pending.nr;
@@ -348,7 +358,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
-					show_tree_object, NULL);
+					show_tree_object, &tree_recursive);
 			break;
 		case OBJ_COMMIT:
 			rev.pending.nr = rev.pending.alloc = 0;
-- 
1.6.0.2.763.g72663
