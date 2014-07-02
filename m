From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 03/19] rebase -i: reword executes pre-commit hook on interim commit
Date: Wed,  2 Jul 2014 19:47:55 +0200
Message-ID: <12171cf0323b3d10b12b02e3b7d42ff4b7964724.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:49:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfE-0006WL-QT
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbaGBRtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:39 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:62912 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbaGBRti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:38 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so11547269wes.36
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+DbhgW214p+BMNr6cee3iDUBJ7hqd+gDYk0d8SidIMY=;
        b=uI5Pibo2umAKRgXLHQf0Fg5tivsgcbB+rh4zvYw9ngscUzszc288+cbOQpipPLJ05h
         GVczCpdre83J1yrgVgLMTI+4fM9o7QQpJNvrBcDQNU/kLJBTcZ6b2jAvlnK/f2Nb/J/f
         /TVKHWibk/NsV7df8gNROVtMdn/TH+8Kf6zsbP8AsgEIMxjY8YDZ8sc07U32vkvZiYtH
         4wFjjbUiftzncC5/Pv1D8EpI/5ESFAD0yFpQJb/m27/611LbNMAb3weAEQqCS18bbZBd
         ZOiJ1DZQqF539nMtaq0qqcVJZARYwvthZ9s0uo/1pHsiH7NzuXudazUfeDioKIBY1x6Y
         8vqQ==
X-Received: by 10.194.24.2 with SMTP id q2mr19854369wjf.91.1404323377282;
        Wed, 02 Jul 2014 10:49:37 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252807>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. This happens in two
steps. Firstly, the named commit is cherry-picked. Secondly, the
commit created in the first step is amended using an unchanged index
to edit the log message. The pre-commit hook is meant to verify the
changes introduced by a commit (for instance, catching inserted
trailing white space). Since the committed tree is not changed
between the two steps, do not execute the pre-commit hook in the
second step.

Specify the git-commit option `--no-verify` to disable the pre-commit
hook when editing the log message. Because `--no-verify` also skips
the commit-msg hook, execute the hook from within
git-rebase--interactive after the commit is created. Fortunately, the
commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
git-commit terminates. Caveat: In case the commit-msg hook finds the
new log message ill-formatted, the user is only notified of the
failed commit-msg hook but the log message is used for the commit
anyway. git-commit ought to offer more fine-grained control over
which hooks are executed.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 689400e..b50770d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -504,10 +504,19 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $sha1... $rest"
-			exit_with_patch $sha1 1
-		}
+		# TODO: Work around the fact that git-commit lets us
+		# disable either both the pre-commit and the commit-msg
+		# hook or none. Disable the pre-commit hook because the
+		# tree is left unchanged but run the commit-msg hook
+		# from here because the log message is altered.
+		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
+			if test -x "$GIT_DIR"/hooks/commit-msg
+			then
+				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
+			fi || {
+				warn "Could not amend commit after successfully picking $sha1... $rest"
+				exit_with_patch $sha1 1
+			}
 		record_in_rewritten $sha1
 		;;
 	edit|e)
-- 
2.0.0
