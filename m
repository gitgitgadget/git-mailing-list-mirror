From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] --prune is now default for 'pack-refs'
Date: Mon, 08 Jan 2007 16:44:04 -0800
Message-ID: <7vodp9t4ff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 01:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4562-00063e-EC
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 01:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbXAIAoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAIAoH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 19:44:07 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32796 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXAIAoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 19:44:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109004405.ZAQJ7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 19:44:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8ojE1W00n1kojtg0000000; Mon, 08 Jan 2007 19:43:15 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36289>

There is no reason not to, really.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 5da5105..464269f 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -7,7 +7,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 
 SYNOPSIS
 --------
-'git-pack-refs' [--all] [--prune]
+'git-pack-refs' [--all] [--no-prune]
 
 DESCRIPTION
 -----------
@@ -40,10 +40,11 @@ developed and packing their tips does not help performance.
 This option causes branch tips to be packed as well.  Useful for
 a repository with many branches of historical interests.
 
-\--prune::
+\--no-prune::
+
+The command usually removes loose refs under `$GIT_DIR/refs`
+hierarchy after packing them.  This option tells it not to.
 
-After packing the refs, remove loose refs under `$GIT_DIR/refs`
-hierarchy.  This should probably become default.
 
 Author
 ------
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 8dc5b9e..6de7128 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -4,7 +4,7 @@
 #include "tag.h"
 
 static const char builtin_pack_refs_usage[] =
-"git-pack-refs [--all] [--prune]";
+"git-pack-refs [--all] [--prune | --no-prune]";
 
 struct ref_to_prune {
 	struct ref_to_prune *next;
@@ -90,10 +90,15 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 
 	memset(&cbdata, 0, sizeof(cbdata));
 
+	cbdata.prune = 1;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--prune")) {
-			cbdata.prune = 1;
+			cbdata.prune = 1; /* now the default */
+			continue;
+		}
+		if (!strcmp(arg, "--no-prune")) {
+			cbdata.prune = 0;
 			continue;
 		}
 		if (!strcmp(arg, "--all")) {
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index b1e9f2e..16bdae4 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -34,7 +34,7 @@ test_expect_success \
     'see if a branch still exists when packed' \
     'git-branch b &&
      git-pack-refs --all &&
-     rm .git/refs/heads/b &&
+     rm -f .git/refs/heads/b &&
      echo "$SHA1 refs/heads/b" >expect &&
      git-show-ref b >result &&
      diff expect result'
