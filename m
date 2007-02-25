From: Roland Dreier <roland@digitalvampire.org>
Subject: [PATCH] Allow arbitrary number of arguments to git-pack-objects
Date: Sun, 25 Feb 2007 09:34:27 -0800
Message-ID: <871wkep2e4.fsf@digitalvampire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNGb-0005Rw-2Z
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbXBYRea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbXBYRea
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:34:30 -0500
Received: from sccrmhc11.comcast.net ([204.127.200.81]:35159 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965028AbXBYRe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:34:29 -0500
Received: from hellmouth.digitalvampire.org ([67.169.18.80])
          by comcast.net (sccrmhc11) with ESMTP
          id <2007022517342801100ilpfie>; Sun, 25 Feb 2007 17:34:28 +0000
Received: from localhost.localdomain (shaolin.home.digitalvampire.org [10.1.0.2])
	by hellmouth.digitalvampire.org (Postfix) with ESMTP id C81C982D4D;
	Sun, 25 Feb 2007 09:34:27 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 803CE1DF73; Sun, 25 Feb 2007 09:34:27 -0800 (PST)
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40559>

If a repository ever gets in a situation where there are too many
packs (more than 60 or so), perhaps because of frequent use of
git-fetch -k or incremental git-repack, then it becomes impossible to
fully repack the repository with git-repack -a.  That command just
dies with the cryptic message

    fatal: too many internal rev-list options

This message comes from git-pack-objects, which is passed one command
line option like --unpacked=pack-<SHA1>.pack for each pack file to be
repacked.  However, the current code has a static limit of 64 command
line arguments and just aborts if more arguments are passed to it.

Fix this by dynamically allocating the array of command line
arguments, and doubling the size each time it overflows.

Signed-off-by: Roland Dreier <roland@digitalvampire.org>
---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5ed9ce..c4bbe43 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1551,9 +1551,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	int i;
-	const char *rp_av[64];
+	const char **rp_av;
+	int rp_ac_max = 64;
 	int rp_ac;
 
+	rp_av = xcalloc(rp_ac_max, sizeof *rp_av);
+
 	rp_av[0] = "pack-objects";
 	rp_av[1] = "--objects"; /* --thin will make it --objects-edge */
 	rp_ac = 2;
@@ -1626,8 +1629,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
-			if (ARRAY_SIZE(rp_av) - 1 <= rp_ac)
-				die("too many internal rev-list options");
+			if (rp_ac_max - 1 <= rp_ac) {
+				rp_ac_max *= 2;
+				rp_av = xrealloc(rp_av, rp_ac_max * sizeof *rp_av);
+			}
 			rp_av[rp_ac++] = arg;
 			continue;
 		}
