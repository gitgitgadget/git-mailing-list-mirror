From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] stash: implement "stash create"
Date: Mon, 09 Jul 2007 00:57:53 -0700
Message-ID: <7v3azyvwji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 09:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7o86-0003vS-6l
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXGIH5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 03:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbXGIH5z
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:57:55 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33352 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXGIH5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 03:57:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709075754.KUVV3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 03:57:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MKxt1X0091kojtg0000000; Mon, 09 Jul 2007 03:57:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51969>

This subcommand creates a stash from the current state and writes out the
resulting commit object ID to the standard output, without updating the
stash ref nor resetting the tree.  It is intended to be used by scripts
to temporarily rewind the working tree to a clean state.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is currently only needed for the next one, which I do
   not think is ready for 1.5.3, so both will stay in either
   'pu' or perhaps in 'next'.

 git-stash.sh |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index de13dd1..8c22cd4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -23,7 +23,7 @@ clear_stash () {
 	: >"$logfile"
 }
 
-save_stash () {
+create_stash () {
 	stash_msg="$1"
 
 	if no_changes
@@ -31,9 +31,6 @@ save_stash () {
 		echo >&2 'No local changes to save'
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
-		clear_stash || die "Cannot initialize stash"
-
 	# state of the base commit
 	if b_commit=$(git rev-parse --verify HEAD)
 	then
@@ -79,7 +76,20 @@ save_stash () {
 	w_commit=$(printf '%s\n' "$stash_msg" |
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
 		die "Cannot record working tree state"
+}
+
+save_stash () {
+	stash_msg="$1"
+
+	if no_changes
+	then
+		echo >&2 'No local changes to save'
+		exit 0
+	fi
+	test -f "$GIT_DIR/logs/$ref_stash" ||
+		clear_stash || die "Cannot initialize stash"
 
+	create_stash "$stash_msg"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
 	printf >&2 'Saved "%s"\n' "$stash_msg"
@@ -185,6 +195,13 @@ apply)
 clear)
 	clear_stash
 	;;
+create)
+	if test $# -gt 0 && test "$1" = create
+	then
+		shift
+	fi
+	create_stash "$*" && echo "$w_commit"
+	;;
 help | usage)
 	usage
 	;;
-- 
1.5.3.rc0.81.g1ed84
