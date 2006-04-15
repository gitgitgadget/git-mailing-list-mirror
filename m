From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --stat: do not do its own three-dashes.
Date: Sat, 15 Apr 2006 14:10:39 -0700
Message-ID: <7virpaee9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 23:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUs2a-0000V9-KH
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 23:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWDOVKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWDOVKl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 17:10:41 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18853 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751560AbWDOVKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 17:10:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415211040.CSLL815.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 17:10:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18766>

I missed that "git-diff-* --stat" spits out three-dash separator
on its own without being asked.  Remove it.

When we output commit log followed by diff, perhaps --patch-with-stat,
for downstream consumer, we _would_ want the three-dash between
the message and the diff material, but that logic belongs to the
caller, not diff generator.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Now the next task is to make "git log" not to do its own
   commit formatting, but let the log_tree_commit() do it, just
   like we do in diff-tree --pretty.  This would open the door
   for us to (optionally) omit log message when there is no
   diff, and honor the --max-count by counting what we actually
   output.

   When that happens, the printf() I moved tentatively to
   cmd_log() should become part of the commit formatting
   log_tree_commit() does, perhaps with --pretty=format-patch.

 diff.c |    2 --
 git.c  |    4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

6f4780f9dfd3bc6b23f9ea66b3d49577e0a0c2f9
diff --git a/diff.c b/diff.c
index f1b672d..cda8d20 100644
--- a/diff.c
+++ b/diff.c
@@ -245,8 +245,6 @@ static void show_stats(struct diffstat_t
 	if (data->nr == 0)
 		return;
 
-	printf("---\n");
-
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 
diff --git a/git.c b/git.c
index 78ed403..61265a8 100644
--- a/git.c
+++ b/git.c
@@ -388,8 +388,10 @@ static int cmd_log(int argc, const char 
 		pretty_print_commit(commit_format, commit, ~0, buf,
 				    LOGSIZE, abbrev);
 		printf("%s\n", buf);
-		if (do_diff)
+		if (do_diff) {
+			printf("---\n");
 			log_tree_commit(&opt, commit);
+		}
 		shown = 1;
 		free(commit->buffer);
 		commit->buffer = NULL;
-- 
1.3.0.rc4.g5a48-dirty
