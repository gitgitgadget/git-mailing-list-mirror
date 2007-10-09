From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: use diff plumbing instead of porcelain
Date: Tue, 9 Oct 2007 13:59:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091353140.4174@racer.site>
References: <470B410F.1040506@viscovery.net> <Pine.LNX.4.64.0710091319400.4174@racer.site>
 <470B7581.3030301@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEh4-0005g0-FT
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbXJINAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbXJINAB
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:00:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:44783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752848AbXJINAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:00:00 -0400
Received: (qmail invoked by alias); 09 Oct 2007 12:59:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 09 Oct 2007 14:59:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FaZw8BZ7FhS6YpmXaEQZKD2qCrNNMAumVMH/m8B
	LJIClsCCxOqsbg
X-X-Sender: gene099@racer.site
In-Reply-To: <470B7581.3030301@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60401>


When diff drivers are installed, calling "git diff <tree1>..<tree2>"
calls those drivers.  This borks the patch generation of rebase -i.
So use "git diff-tree -p" instead, which does not call diff drivers.

Noticed by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 9 Oct 2007, Johannes Sixt wrote:

	> Johannes Schindelin schrieb:
	> > On Tue, 9 Oct 2007, Johannes Sixt wrote:
	> > 
	> > > I wonder for what reason rebase--interactive generates a 
	> > > patch using 'git diff' in the make_patch function. Is this 
	> > > an artefact?
	> > 
	> > It was an explicit request by people who use git-rebase 
	> > regularly, and missed being able to see the patch in 
	> > --interactive.
	> 
	> Can we generate the patch with plumbing, 
	> diff-{files,index,tree}? They by-pass any diff drivers.

	Here you are.

 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 050140d..df4cedb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -80,7 +80,7 @@ mark_action_done () {
 make_patch () {
 	parent_sha1=$(git rev-parse --verify "$1"^) ||
 		die "Cannot get patch for $1^"
-	git diff "$parent_sha1".."$1" > "$DOTEST"/patch
+	git diff-tree -p "$parent_sha1".."$1" > "$DOTEST"/patch
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$DOTEST"/author-script ||
@@ -325,7 +325,7 @@ do_next () {
 		;;
 	esac && {
 		test ! -f "$DOTEST"/verbose ||
-			git diff --stat $(cat "$DOTEST"/head)..HEAD
+			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
 	rm -rf "$DOTEST" &&
 	git gc --auto &&
-- 
1.5.3.4.1169.g5fb8d
