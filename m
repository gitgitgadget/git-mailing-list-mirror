From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 01:27:14 +0100
Message-ID: <87ab9th0rh.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 01:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNG6E-0003Ji-JT
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760548AbZAOA1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759908AbZAOA1S
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:27:18 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:45298 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757160AbZAOA1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:27:17 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1002530B00;
	Thu, 15 Jan 2009 01:26:35 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C45823016A;
	Thu, 15 Jan 2009 01:26:34 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105738>

Previously, the interactive rebase edit mode placed the user after the
commit in question. That was awkward because a commit is supposedly
immutable. Thus, she was forced to use "git commit --amend" for her
changes.

To improve on this UI, we now issue "git reset --soft HEAD^" before
exiting to the user. This puts the changes in the index, editable in
the Git sense. It also makes sure that a pre-filled editor is fired up
when doing "git rebase --continue", in case the user just wanted to
fix the commit message.

The revised UI is close to the situation in a merge/rebase conflict,
and thus familiar to the user.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---


I always have a hard time figuring out what to do during an
interactive rebase. Recently, it dawned on me that the reason is that
I have to do different things: one thing when editing on purpose, and
a different thing when resolving a conflict. So my fingers never learn.

With this change, I propose to make the UI more uniform. I think that
the new way is more intuitive, too, if you will agree that a Git UI
can be intuitive.

As I expect this to not be acceptable due to compatibility concerns, I
have not tested it much. The patch is mostly to catch some attention,
but I will be happy to complete it if there is interest in the change.

It was surprising for me to find the needed code already present. Now
I know that I do not have to do "git commit --amend", it will happen
automatically if I add some files. That trick alone is worth the time
that I have spent on this :-).


Cheers,
Anders.


 Documentation/git-rebase.txt |   10 ++++------
 git-rebase--interactive.sh   |   29 ++++++++---------------------
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 32f0f12..3442a68 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -320,9 +320,8 @@ not look at them but at the commit names ("deadbee" and "fa1afe1" in this
 example), so do not delete or edit the names.
 
 By replacing the command "pick" with the command "edit", you can tell
-'git-rebase' to stop after applying that commit, so that you can edit
-the files and/or the commit message, amend the commit, and continue
-rebasing.
+'git-rebase' to stop after applying that commit. You are free to make
+further modifications before you continue rebasing.
 
 If you want to fold two or more commits into one, replace the command
 "pick" with "squash" for the second and subsequent commit.  If the
@@ -375,9 +374,8 @@ add other commits.  This can be used to split a commit into two:
 
 - Mark the commit you want to split with the action "edit".
 
-- When it comes to editing that commit, execute `git reset HEAD^`.  The
-  effect is that the HEAD is rewound by one, and the index follows suit.
-  However, the working tree stays the same.
+- When it comes to editing that commit, execute `git reset`.  The effect
+  is that the changes in the commit are now only in the working tree.
 
 - Now add the changes to the index that you want to have in the first
   commit.  You can use `git add` (possibly interactively) or
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bdec43c..0fe678f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -274,7 +274,7 @@ peek_next_command () {
 
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
-		"$DOTEST"/amend || exit
+		|| exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|'')
@@ -294,13 +294,13 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		git rev-parse --verify HEAD > "$DOTEST"/amend
+		git reset --soft HEAD^ ||
+			die "Cannot rewind the HEAD"
 		warn "Stopped at $sha1... $rest"
-		warn "You can amend the commit now, with"
 		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
+		warn "You can edit the commit now. When you are satisfied,"
+		warn "mark the corrected paths with 'git add <paths>', and"
+		warn "then run"
 		warn
 		warn "	git rebase --continue"
 		warn
@@ -442,22 +442,9 @@ do
 		else
 			. "$DOTEST"/author-script ||
 				die "Cannot find the author identity"
-			amend=
-			if test -f "$DOTEST"/amend
-			then
-				amend=$(git rev-parse --verify HEAD)
-				test "$amend" = $(cat "$DOTEST"/amend) ||
-				die "\
-You have uncommitted changes in your working tree. Please, commit them
-first and then run 'git rebase --continue' again."
-				git reset --soft HEAD^ ||
-				die "Cannot rewind the HEAD"
-			fi
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e || {
-				test -n "$amend" && git reset --soft $amend
+			git commit --no-verify -F "$DOTEST"/message -e ||
 				die "Could not commit staged changes."
-			}
 		fi
 
 		require_clean_work_tree
@@ -590,7 +577,7 @@ first and then run 'git rebase --continue' again."
 #
 # Commands:
 #  p, pick = use commit
-#  e, edit = use commit, but stop for amending
+#  e, edit = use commit, but stop for editing
 #  s, squash = use commit, but meld into previous commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
-- 
1.6.0.2.514.g23abd3
