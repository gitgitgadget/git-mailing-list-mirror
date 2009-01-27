From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix submodule squashing into unrelated commit
Date: Tue, 27 Jan 2009 12:42:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271241010.14855@racer>
References: <7vljsxyv58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 12:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRmLr-0004uV-Ah
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 12:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZA0LmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752914AbZA0LmF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 06:42:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:45700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbZA0LmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 06:42:04 -0500
Received: (qmail invoked by alias); 27 Jan 2009 11:42:00 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp017) with SMTP; 27 Jan 2009 12:42:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nw6gUh9wng2q1wUyBFCRawp5VLcP2dzzreB0ULi
	5jjUzt42/sDO+a
X-X-Sender: gene099@racer
In-Reply-To: <7vljsxyv58.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107334>


Actually, I think the issue is pretty independent of submodules; when
"git commit" gets an empty parameter, it misinterprets it as a file.

So avoid passing an empty parameter to "git commit".

Actually, this is a nice cleanup, as MSG_FILE and EDIT_COMMIT were mutually
exclusive; use one variable instead

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	We might want to safeguard "git commit", too.

 git-rebase--interactive.sh    |    9 ++++-----
 t/t3404-rebase-interactive.sh |    2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 002929e..3ac7162 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -373,17 +373,15 @@ do_next () {
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
 		squash|s)
-			EDIT_COMMIT=
 			USE_OUTPUT=output
 			MSG_OPT=-F
-			MSG_FILE="$MSG"
+			EDIT_OR_FILE="$MSG"
 			cp "$MSG" "$SQUASH_MSG"
 			;;
 		*)
-			EDIT_COMMIT=-e
 			USE_OUTPUT=
 			MSG_OPT=
-			MSG_FILE=
+			EDIT_OR_FILE=-e
 			rm -f "$SQUASH_MSG" || exit
 			cp "$MSG" "$GIT_DIR"/SQUASH_MSG
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
@@ -397,7 +395,8 @@ do_next () {
 			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify $MSG_OPT "$MSG_FILE" $EDIT_COMMIT || failed=t
+			$USE_OUTPUT git commit --no-verify \
+				$MSG_OPT "$EDIT_OR_FILE" || failed=t
 		fi
 		if test $failed = t
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6ffb9ad..4becc55 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -484,7 +484,7 @@ test_expect_success 'submodule rebase setup' '
 	git commit -a -m "Three changes submodule"
 '
 
-test_expect_failure 'submodule rebase -i' '
+test_expect_success 'submodule rebase -i' '
 	FAKE_LINES="1 squash 2 3" git rebase -i A
 '
 
-- 
1.6.1.482.g7d54be
