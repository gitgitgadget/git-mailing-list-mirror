From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: exchange all "if [ .. ]" by "if test .."
Date: Tue, 24 Jul 2007 03:18:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240318010.14781@racer.site>
References: <200707232236.21389.johannes.sixt@telecom.at>
 <7vvecak1aw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 04:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID9z6-0001i0-PV
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 04:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761548AbXGXCSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 22:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760930AbXGXCSo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 22:18:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761357AbXGXCSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 22:18:43 -0400
Received: (qmail invoked by alias); 24 Jul 2007 02:18:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 24 Jul 2007 04:18:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HdspKyZAHqtrX73iULR+Ov5g+E/UX1CUWkpbwmG
	yOEXWviMdrcVt0
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvecak1aw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53521>


This patch is literally

:%s/if \[ *\(.*[^ ]\) *\]/if test \1/

in vi, after making sure that the other instances of "[..]" are not
actually invocations of "test".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 23 Jul 2007, Junio C Hamano wrote:

	> Johannes Sixt <johannes.sixt@telecom.at> writes:
	> 
	> > Not all shells grok a closing ']' of the shell '[' command without
	> > surrounding space.
	> >
	> > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
	> > ---
	> >
	> > I didn't go the long way to change all `[ ... ]` into `test ...`
	> 
	> Maybe that would have been a better idea.

	Voila.

	(Obviously, this is on top of my last patch to rebase -i, to bug 
	you into applying it ;-)

	Seriously again, if I should rather redo it relative to "master", 
	please say so.  Or apply the regsub and get all the karma for 
	free...

 git-rebase--interactive.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ac1f5a2..93289c0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -102,7 +102,7 @@ pick_one () {
 		pick_one_preserving_merges "$@" && return
 	parent_sha1=$(git rev-parse --verify $sha1^ 2>/dev/null)
 	current_sha1=$(git rev-parse --verify HEAD)
-	if [ $current_sha1 = $parent_sha1 ]; then
+	if test $current_sha1 = $parent_sha1; then
 		output git reset --hard $sha1
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
@@ -116,7 +116,7 @@ pick_one_preserving_merges () {
 	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
 	sha1=$(git rev-parse $sha1)
 
-	if [ -f "$DOTEST"/current-commit ]
+	if test -f "$DOTEST"/current-commit
 	then
 		current_commit=$(cat "$DOTEST"/current-commit) &&
 		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
@@ -130,7 +130,7 @@ pick_one_preserving_merges () {
 	new_parents=
 	for p in $(git rev-list --parents -1 $sha1 | cut -d\  -f2-)
 	do
-		if [ -f "$REWRITTEN"/$p ]
+		if test -f "$REWRITTEN"/$p
 		then
 			preserve=f
 			new_p=$(cat "$REWRITTEN"/$p)
@@ -188,7 +188,7 @@ nth_string () {
 }
 
 make_squash_message () {
-	if [ -f "$SQUASH_MSG" ]; then
+	if test -f "$SQUASH_MSG"; then
 		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([0-9]\+\).*/\1/p" \
 			< "$SQUASH_MSG" | tail -n 1)+1))
 		echo "# This is a combination of $COUNT commits."
@@ -286,7 +286,7 @@ do_next () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
 	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if [ -d "$REWRITTEN" ]
+	if test -d "$REWRITTEN"
 	then
 		test -f "$DOTEST"/current-commit &&
 			current_commit=$(cat "$DOTEST"/current-commit) &&
@@ -403,7 +403,7 @@ do
 
 		require_clean_work_tree
 
-		if [ ! -z "$2"]
+		if test ! -z "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
@@ -426,7 +426,7 @@ do
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
-		if [ t = "$PRESERVE_MERGES" ]
+		if test t = "$PRESERVE_MERGES"
 		then
 			# $REWRITTEN contains files for each commit that is
 			# reachable by at least one merge base of $HEAD and
-- 
1.5.3.rc2.32.g35c5b-dirty
