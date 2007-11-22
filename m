From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: give rerere a chance
Date: Thu, 22 Nov 2007 11:18:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221117590.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:18:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA4m-0006Yq-G6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbXKVLSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbXKVLSP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:18:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:49025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730AbXKVLSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:18:14 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:18:12 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp024) with SMTP; 22 Nov 2007 12:18:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186C9cS4xI6i24Fo5wB0wgQNgJiqvJFzOhSBgoS+l
	+5Q9lMr/OrCv/r
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65793>


Like non-interactive rebase, interactive mode now calls rerere when
appropriate.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	While I was working with rebase -i yesterday, I realised that it
	did not call rerere at all.  And sure enough, there was a
	NEEDSWORK in rebase -i for that.

	Now, I _hope_ I got all the locations where the rerere should be
	cleared, but this could use a few pairs of eyeballs.

 git-rebase--interactive.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ead7da7..a6dc72a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,6 +81,7 @@ make_patch () {
 
 die_with_patch () {
 	make_patch "$1"
+	git rerere
 	die "$2"
 }
 
@@ -166,13 +167,13 @@ pick_one_preserving_merges () {
 			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
-			# NEEDSWORK: give rerere a chance
 			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
 				output git merge $STRATEGY -m "$msg" \
 					$new_parents
 			then
+				git rerere
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die Error redoing merge $sha1
 			fi
@@ -360,6 +361,7 @@ do
 	--abort)
 		comment_for_reflog abort
 
+		git rerere clear
 		test -d "$DOTEST" || die "No interactive rebase running"
 
 		HEADNAME=$(cat "$DOTEST"/head-name)
@@ -376,6 +378,7 @@ do
 	--skip)
 		comment_for_reflog skip
 
+		git rerere clear
 		test -d "$DOTEST" || die "No interactive rebase running"
 
 		output git reset --hard && do_rest
-- 
1.5.3.6.1977.g54d30
