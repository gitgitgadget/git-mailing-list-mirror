From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: improve error message when branch checkout fails
Date: Sat, 4 Apr 2009 22:02:26 +0200
Message-ID: <20090404220226.58a3ac99.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, malc@pulsesoft.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqC72-0005n9-Lt
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 22:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbZDDUDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbZDDUDf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 16:03:35 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:57378 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbZDDUDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 16:03:34 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id B800E940089;
	Sat,  4 Apr 2009 22:03:26 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id A8C5894001B;
	Sat,  4 Apr 2009 22:03:23 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115594>

In "git-bisect.sh" the "git checkout" command is only used to
change the current branch, but it is used like this:

git checkout "$branch"

which will output the following misleading error message when
it fails:

error: pathspec 'foo' did not match any file(s) known to git.

This patch change the way we use "git checkout" like this:

git checkout "$branch" --

so that we will get the following error message:

fatal: invalid reference: foo

which is better.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e313bde..df0ae63 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,7 +77,7 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" || exit
+		git checkout "$start_head" -- || exit
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -370,7 +370,7 @@ bisect_checkout() {
 	_msg="$2"
 	echo "Bisecting: $_msg"
 	mark_expected_rev "$_rev"
-	git checkout -q "$_rev" || exit
+	git checkout -q "$_rev" -- || exit
 	git show-branch "$_rev"
 }
 
@@ -549,7 +549,7 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	git checkout "$branch" && bisect_clean_state
+	git checkout "$branch" -- && bisect_clean_state
 }
 
 bisect_clean_state() {
-- 
1.6.2.2.404.ge96f3.dirty
