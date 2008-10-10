From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: do not fail when there is no commit to
 cherry-pick
Date: Fri, 10 Oct 2008 13:42:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810101341120.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <6beb92080810091204n6df4338fs3b182194a8d6454e@mail.gmail.com> <alpine.DEB.1.00.0810101319150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Leonardo Sobral Cunha <sobral@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 10 13:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoGIk-0006dY-Sj
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbYJJLfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753783AbYJJLfm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:35:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753097AbYJJLfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:35:40 -0400
Received: (qmail invoked by alias); 10 Oct 2008 11:35:37 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 10 Oct 2008 13:35:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e/KNrPKAetACzrjhlTybioUu8wO0gacdmh4T3LN
	TaEiRkAzI9OOxE
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0810101319150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97928>


In case there is no commit to apply (for example because you rebase to
upstream and all your local patches have been applied there), do not
fail.  The non-interactive rebase already behaves that way.

Do this by introducing a new command, "noop", which is substituted for
an empty commit list, so that deleting the commit list can still abort
as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 10 Oct 2008, Johannes Schindelin wrote:

	> Maybe we should add a new command "noop" which is automatically 
	> inserted when there is no other command?

	And this implements that.

 git-rebase--interactive.sh    |    3 ++-
 t/t3404-rebase-interactive.sh |   11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 076414a..49a6b5c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -271,7 +271,7 @@ do_next () {
 		"$DOTEST"/amend || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
-	'#'*|'')
+	'#'*|''|noop)
 		mark_action_done
 		;;
 	pick|p)
@@ -583,6 +583,7 @@ first and then run 'git rebase --continue' again."
 			--abbrev=7 --reverse --left-right --cherry-pick \
 			$UPSTREAM...$HEAD | \
 			sed -n "s/^>/pick /p" > "$TODO"
+		test -s "$TODO" || echo noop >> "$TODO"
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e0ded19..7d10a27 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -419,4 +419,15 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
 
 '
 
+test_expect_success 'do "noop" when there is nothing to cherry-pick' '
+
+	git checkout -b branch4 HEAD &&
+	GIT_EDITOR=: git commit --amend \
+		--author="Somebody else <somebody@else.com>" 
+	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
+	git rebase -i branch3 &&
+	test $(git rev-parse branch3) = $(git rev-parse branch4)
+
+'
+
 test_done
-- 
1.6.0.2.713.g3dcb0
