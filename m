From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/2] rebase -i: remove get_author_ident_from_commit() from
	"git-sh-setup.sh"
Date: Sun, 21 Jun 2009 07:08:44 +0200
Message-ID: <20090621050846.3554.57922.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 07:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIFLw-0003gD-C5
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 07:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZFUFMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 01:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZFUFMO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 01:12:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45477 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbZFUFMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 01:12:12 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3D92781805A;
	Sun, 21 Jun 2009 07:12:04 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CA61C81805F;
	Sun, 21 Jun 2009 07:12:01 +0200 (CEST)
X-git-sha1: 5cbae7b5c3f2c40fd7f24d6fba335094d03cba5f 
X-Mailer: git-mail-commits v0.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121963>

The "get_author_ident_from_commit" function is only used in
"git-rebase--interactive.sh" so there is no need for this function
to be in "git-sh-setup.sh" anymore.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   27 +++++++++++++++++++++++++++
 git-sh-setup.sh            |   27 ---------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f96d887..92e2523 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -116,6 +116,33 @@ mark_action_done () {
 	fi
 }
 
+get_author_ident_from_commit () {
+	pick_author_script='
+	/^author /{
+		s/'\''/'\''\\'\'\''/g
+		h
+		s/^author \([^<]*\) <[^>]*> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+		g
+		s/^author [^<]* <\([^>]*\)> .*$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+		g
+		s/^author [^<]* <[^>]*> \(.*\)$/\1/
+		s/'\''/'\''\'\'\''/g
+		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+		q
+	}
+	'
+	encoding=$(git config i18n.commitencoding || echo UTF-8)
+	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
+	LANG=C LC_ALL=C sed -ne "$pick_author_script"
+}
+
 make_patch () {
 	sha1_and_parents="$(git rev-list --parents -1 "$1")"
 	case "$sha1_and_parents" in
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 80acb7d..b4624c5 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -131,33 +131,6 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
-get_author_ident_from_commit () {
-	pick_author_script='
-	/^author /{
-		s/'\''/'\''\\'\'\''/g
-		h
-		s/^author \([^<]*\) <[^>]*> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_NAME='\''&'\''/p
-
-		g
-		s/^author [^<]* <\([^>]*\)> .*$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
-
-		g
-		s/^author [^<]* <[^>]*> \(.*\)$/\1/
-		s/'\''/'\''\'\'\''/g
-		s/.*/GIT_AUTHOR_DATE='\''&'\''/p
-
-		q
-	}
-	'
-	encoding=$(git config i18n.commitencoding || echo UTF-8)
-	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
-	LANG=C LC_ALL=C sed -ne "$pick_author_script"
-}
-
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
-- 
1.6.3.GIT
