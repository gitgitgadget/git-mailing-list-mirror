From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Replace misleading message during interactive rebasing
Date: Mon, 26 Nov 2007 22:18:11 +0100
Message-ID: <1196111891-18518-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, tsuna@lrde.epita.fr, j.sixt@viscovery.net,
	Johannes.Schindelin@gmx.de, mcostalba@gmail.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 22:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlRc-0004hn-I5
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbXKZVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbXKZVY0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:24:26 -0500
Received: from wincent.com ([72.3.236.74]:39718 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbXKZVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:24:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQLIC4Q018261;
	Mon, 26 Nov 2007 15:18:13 -0600
X-Mailer: git-send-email 1.5.3.6.953.gdffc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66126>

git-rebase--interactive uses git-cherry-pick under the covers to reorder
commits, which in turn means that in the event of a conflict a message
will be shown advising the user to commit the results and use the -c
switch to retain authorship after fixing the conflict.

The message is misleading because what the user really needs to do is
run "git rebase --continue"; the committing is handled by git-rebase
and the authorship of the commit message is retained automatically.

We solve this problem by using an environment variable to communicate
to git-cherry-pick that rebasing is underway and replace the misleading
error message with a more helpful one.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

This applies on top of "master".

The question of whether the environment variable should have a leading
underscore came up on the mailing list. I don't really care at all either
way, I'd just like to see the misleading message go away. I'll leave it
up to others to decide.

Another thing to decide is whether the help text should be more than
just "run 'git rebase --continue'", but should mention
"git rebase --abort" as well. Junio, please feel free to modify the
patch if you think it would be appropriate.

 builtin-revert.c           |    8 +++++---
 git-rebase--interactive.sh |    2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index a0586f9..5a57574 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -229,7 +229,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	int i;
-	char *oneline, *reencoded_message = NULL;
+	char *oneline, *reencoded_message = NULL, *help_message;
 	const char *message, *encoding;
 	const char *defmsg = xstrdup(git_path("MERGE_MSG"));
 
@@ -352,11 +352,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
 			die ("Error wrapping up %s", defmsg);
+		help_message = getenv("_GIT_CHERRY_PICK_HELP");
 		fprintf(stderr, "Automatic %s failed.  "
 			"After resolving the conflicts,\n"
 			"mark the corrected paths with 'git add <paths>' "
-			"and commit the result.\n", me);
-		if (action == CHERRY_PICK) {
+			"and %s.\n", me,
+			help_message ? help_message : "commit the result");
+		if (action == CHERRY_PICK && !help_message) {
 			fprintf(stderr, "When commiting, use the option "
 				"'-c %s' to retain authorship and message.\n",
 				find_unique_abbrev(commit->object.sha1,
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf44b6a..e5f9810 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -117,6 +117,7 @@ pick_one () {
 		sha1=$(git rev-parse --short $sha1)
 		output warn Fast forward to $sha1
 	else
+		export _GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
 		output git cherry-pick "$@"
 	fi
 }
@@ -187,6 +188,7 @@ pick_one_preserving_merges () {
 			fi
 			;;
 		*)
+			export _GIT_CHERRY_PICK_HELP="run 'git rebase --continue'"
 			output git cherry-pick "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
-- 
1.5.3.6.952.g84ef
