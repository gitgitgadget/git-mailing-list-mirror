From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] revision: simplify argument parsing.
Date: Sat, 01 Apr 2006 19:17:20 -0800
Message-ID: <7vmzf4mzsv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
	<7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604011628500.3684@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 05:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPt5i-0007pm-Tw
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 05:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWDBDRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 22:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWDBDRW
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 22:17:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63462 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751659AbWDBDRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Apr 2006 22:17:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402031721.WYFQ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Apr 2006 22:17:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18256>

This just moves code around to consolidate the part that sets
revs->limited to one place based on various flags.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Just the preparation for the next step...

 revision.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

53069686601d156dea3787a100ffc4e35c78040f
diff --git a/revision.c b/revision.c
index 07cc86f..cdd29c5 100644
--- a/revision.c
+++ b/revision.c
@@ -552,32 +552,26 @@ int setup_revisions(int argc, const char
 			}
 			if (!strncmp(arg, "--max-age=", 10)) {
 				revs->max_age = atoi(arg + 10);
-				revs->limited = 1;
 				continue;
 			}
-			if (!strncmp(arg, "--min-age=", 10)) {
-				revs->min_age = atoi(arg + 10);
-				revs->limited = 1;
-				continue;
-			}
 			if (!strncmp(arg, "--since=", 8)) {
 				revs->max_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--after=", 8)) {
 				revs->max_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--min-age=", 10)) {
+				revs->min_age = atoi(arg + 10);
+				continue;
+			}
 			if (!strncmp(arg, "--before=", 9)) {
 				revs->min_age = approxidate(arg + 9);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strncmp(arg, "--until=", 8)) {
 				revs->min_age = approxidate(arg + 8);
-				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
@@ -596,13 +590,11 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--topo-order")) {
 				revs->topo_order = 1;
-				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--date-order")) {
 				revs->lifo = 0;
 				revs->topo_order = 1;
-				revs->limited = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--parents")) {
@@ -644,7 +636,6 @@ int setup_revisions(int argc, const char
 			}
 			if (!strcmp(arg, "--unpacked")) {
 				revs->unpacked = 1;
-				revs->limited = 1;
 				continue;
 			}
 			*unrecognized++ = arg;
@@ -707,6 +698,9 @@ int setup_revisions(int argc, const char
 		commit = get_commit_reference(revs, def, sha1, 0);
 		add_one_commit(commit, revs);
 	}
+
+	if ((revs->max_age != -1) || revs->topo_order || revs->unpacked)
+		revs->limited = 1;
 
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data);
-- 
1.3.0.rc1.gf385
