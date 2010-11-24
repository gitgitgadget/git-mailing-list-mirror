From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to be more useful
Date: Wed, 24 Nov 2010 12:19:20 -0800
Message-ID: <1290629960-60917-1-git-send-email-kevin@sb.org>
References: <20101110015327.GB1503@burratino>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Raible <raible@nextest.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 21:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLoa-0005Tz-U8
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab0KXUTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 15:19:36 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49582 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab0KXUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 15:19:35 -0500
Received: by pzk6 with SMTP id 6so49471pzk.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:19:34 -0800 (PST)
Received: by 10.142.147.21 with SMTP id u21mr9037643wfd.257.1290629974738;
        Wed, 24 Nov 2010 12:19:34 -0800 (PST)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm9861769wfg.8.2010.11.24.12.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 12:19:33 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.488.gc5e8
In-Reply-To: <20101110015327.GB1503@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162079>

Extend the "edit" command to simply stop for editing if no sha1 is
given or if the sha1 is equal to "-". This behaves the same as "x false"
but is a bit friendlier for the user.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---

Two changes since the last patch:
* Picked up the extended explanation suggested by Jonathan Nieder.
  I left off the last line about "noop" as that doesn't seem related.
* If the line given is "edit - some comments", emit "some comments" when
  stopped. This is undocumented, so if anyone has any suggestions for how
  it should be documented I'm all ears. I'm also not sure if it should use
  the output format I selected now, or if it should just emit the comment
  in place of the commit summary (e.g. Stopped at $sha1... $comment).

 git-rebase--interactive.sh |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5934b97..176f735 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -469,12 +469,29 @@ do_next () {
 		comment_for_reflog edit
 
 		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$DOTEST"/stopped-sha
-		make_patch $sha1
+		comment=''
+		if test -n "$sha1" -a "$sha1" != "-"; then
+			pick_one $sha1 ||
+				die_with_patch $sha1 "Could not apply $sha1... $rest"
+			echo "$sha1" > "$DOTEST"/stopped-sha
+			make_patch $sha1
+		else
+			# we just want to exit to the shell
+			# we don't have a valid $sha1 or $rest, so recreate that
+			# save the original $rest to a comment for later
+			comment="$rest"
+			line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)
+			sha1="${line%% *}"
+			rest="${line#* }"
+			echo "$sha1" > "$DOTEST"/stopped-sha
+		fi
 		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
+		if test -n "$comment"; then
+			warn
+			warn "	$comment"
+			warn
+		fi
 		warn "You can amend the commit now, with"
 		warn
 		warn "	git commit --amend"
@@ -1016,11 +1033,14 @@ first and then run 'git rebase --continue' again."
 # Commands:
 #  p, pick = use commit
 #  r, reword = use commit, but edit the commit message
-#  e, edit = use commit, but stop for amending
+#  e, edit = use commit (if specified), but stop to amend/examine/test
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
 #
+# The argument to edit is optional; if left out or equal to "-",
+# it means to stop to examine or amend the previous commit.
+#
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
-- 
1.7.3.2.488.gc5e8
