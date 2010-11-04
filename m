From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2] git-rebase--interactive.sh: extend "edit" command to be more useful
Date: Thu,  4 Nov 2010 15:01:26 -0700
Message-ID: <1288908086-91520-1-git-send-email-kevin@sb.org>
References: <4CD32034.4030104@nextest.com>
Cc: Yann Dirson <ydirson@free.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 23:01:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7sJ-0007XV-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0KDWBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:01:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51620 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab0KDWBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:01:34 -0400
Received: by pvb32 with SMTP id 32so735420pvb.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:01:34 -0700 (PDT)
Received: by 10.142.234.2 with SMTP id g2mr1165083wfh.112.1288908094200;
        Thu, 04 Nov 2010 15:01:34 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w23sm555377wfd.9.2010.11.04.15.01.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:01:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.203.gd142e
In-Reply-To: <4CD32034.4030104@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160782>

Extend the "edit" command to simply stop for editing if no sha1 is
given. This behaves the same as "x false" but is a bit friendlier
for the user.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 git-rebase--interactive.sh |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9121bb6..a8e00a2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -477,10 +477,19 @@ do_next () {
 		comment_for_reflog edit
 
 		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$DOTEST"/stopped-sha
-		make_patch $sha1
+		if test -n "$sha1"; then
+			pick_one $sha1 ||
+				die_with_patch $sha1 "Could not apply $sha1... $rest"
+			echo "$sha1" > "$DOTEST"/stopped-sha
+			make_patch $sha1
+		else
+			# we just want to exit to the shell
+			# we don't have a $sha1 or $rest, so recreate that
+			line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)
+			sha1="${line%% *}"
+			rest="${line#* }"
+			echo "$sha1" > "$DOTEST"/stopped-sha
+		fi
 		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
@@ -1003,7 +1012,7 @@ first and then run 'git rebase --continue' again."
 # Commands:
 #  p, pick = use commit
 #  r, reword = use commit, but edit the commit message
-#  e, edit = use commit, but stop for amending
+#  e, edit = use commit (if specified), but pause to amend/examine/test
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
-- 
1.7.3.2.203.gd142e
