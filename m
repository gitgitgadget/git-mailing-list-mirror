From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: only automatically amend commit if HEAD did not
 change
Date: Tue, 22 Jul 2008 22:36:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222235520.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 23:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPXm-0007uL-VS
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbYGVVgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbYGVVgP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:36:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:35855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbYGVVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:36:14 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:36:13 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp035) with SMTP; 22 Jul 2008 23:36:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/k9JFf0D7kgIcEOWXAFIgQzJnOH4ju9L1aivLPR1
	za+0Fs/qx6ecNw
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89544>


If the user called "rebase -i", marked a commit as "edit", "rebase
--continue" would automatically amend the commit when there were
staged changes.

However, this is actively wrong when the current commit is not the
one marked with "edit".  So guard against this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e63a864..444f393 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -276,7 +276,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		: > "$DOTEST"/amend
+		git rev-parse HEAD > "$DOTEST"/amend
 		warn
 		warn "You can amend the commit now, with"
 		warn
@@ -419,7 +419,9 @@ do
 		else
 			. "$DOTEST"/author-script ||
 				die "Cannot find the author identity"
-			if test -f "$DOTEST"/amend
+			if test -f "$DOTEST"/amend &&
+				test $(git rev-parse HEAD) = \
+					$(cat "$DOTEST"/amend)
 			then
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
-- 
1.6.0.rc0.22.gf2096d.dirty
