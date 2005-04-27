From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make -s flag to show-diff a no-op.
Date: Wed, 27 Apr 2005 15:06:58 -0700
Message-ID: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQuc5-0002Zg-Np
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVD0WH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVD0WH2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:07:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51956 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262048AbVD0WHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 18:07:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427220658.JHZG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 18:06:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With the recent "no-patch-by-default" change, the -s flag to
the show-diff command (and silent variable in the show-diff.c)
became meaningless.  This patch deprecates it.

Cogito uses "show-diff -s" for the purpose of "I do not want the
patch text.  I just want to know if something has potentially
changed, in which case I know you will have some output.  I'll
run update-cache --refresh if you say something", so we cannot
barf on seeing -s on our command line yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

show-diff.c |   18 +++++++++---------
1 files changed, 9 insertions(+), 9 deletions(-)

--- k/show-diff.c
+++ l/show-diff.c
@@ -6,12 +6,12 @@
 #include "cache.h"
 #include "diff.h"
 
-static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [-p] [paths...]";
+static const char *show_diff_usage =
+"show-diff [-p] [-q] [-r] [-z] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
 static int silent = 0;
-static int silent_on_nonexisting_files = 0;
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
 {
@@ -69,16 +69,16 @@ int main(int argc, char **argv)
 	int i;
 
 	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "-s"))
-			silent_on_nonexisting_files = silent = 1;
-		else if (!strcmp(argv[1], "-p"))
+		if (!strcmp(argv[1], "-p"))
 			generate_patch = 1;
 		else if (!strcmp(argv[1], "-q"))
-			silent_on_nonexisting_files = 1;
-		else if (!strcmp(argv[1], "-z"))
-			line_termination = 0;
+			silent = 1;
 		else if (!strcmp(argv[1], "-r"))
 			; /* no-op */
+		else if (!strcmp(argv[1], "-s"))
+			; /* no-op */
+		else if (!strcmp(argv[1], "-z"))
+			line_termination = 0;
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -116,7 +116,7 @@ int main(int argc, char **argv)
 				perror(ce->name);
 				continue;
 			}	
-			if (silent_on_nonexisting_files)
+			if (silent)
 				continue;
 			show_file('-', ce);
 			continue;

