From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH 1/2] git-gc: allow --prune to be specified with --auto
Date: Thu, 4 Oct 2007 17:12:49 -0700
Message-ID: <20071005001249.GA12896@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 02:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idaos-0003od-My
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 02:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762824AbXJEAMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 20:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762817AbXJEAMv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 20:12:51 -0400
Received: from tater.midwinter.com ([216.32.86.90]:38693 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762808AbXJEAMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 20:12:50 -0400
Received: (qmail 13027 invoked by uid 1001); 5 Oct 2007 00:12:49 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60021>

This will run git-prune only if there are still lots of loose objects
after the repack finishes. Obviously the caveats about pruning not being
a safe operation to run concurrently with other git commands still apply.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-gc.txt |    4 +++-
 builtin-gc.c             |   18 +++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b9d5660..60731e9 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -33,7 +33,9 @@ OPTIONS
 	done by default.  Pass this option if you want it, and only
 	when you know nobody else is creating new objects in the
 	repository at the same time (e.g. never use this option
-	in a cron script).
+	in a cron script). If used with the `--auto` option,
+	pruning will only be done if there are many loose objects
+	in the repository after gitlink:git-repack[1] is finished.
 
 --aggressive::
 	Usually 'git-gc' runs very quickly while providing good disk
diff --git a/builtin-gc.c b/builtin-gc.c
index 23ad2b6..b65cacc 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -208,7 +208,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		prune = 0;
 		if (!need_to_gc())
 			return 0;
 	}
@@ -222,15 +221,24 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_repack[0]);
 
+	if (auto_gc) {
+		if (too_many_loose_objects()) {
+			if (! prune) {
+				warning("There are too many unreachable loose "
+					"objects; run 'git gc --prune' to "
+					"remove them.");
+			}
+			// else we will run the prune next
+		} else {
+			prune = 0;
+		}
+	}
+
 	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_prune[0]);
 
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_rerere[0]);
 
-	if (auto_gc && too_many_loose_objects())
-		warning("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them.");
-
 	return 0;
 }
-- 
1.5.3.4.203.gcc61a
