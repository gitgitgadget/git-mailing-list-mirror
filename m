From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rebase --interactive: Compute upstream SHA1 before switching
 branches
Date: Mon, 02 Jun 2008 16:01:40 +0200
Message-ID: <4843FD44.90905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 16:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3AcX-0001qE-J5
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 16:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408AbYFBOBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbYFBOBs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 10:01:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5386 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbYFBOBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 10:01:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K3AbV-0006m4-8c; Mon, 02 Jun 2008 16:01:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F0233546; Mon,  2 Jun 2008 16:01:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83523>

From: Johannes Sixt <johannes.sixt@telecom.at>

If the upstream argument to rebase (the first argument) was relative to
HEAD and the name of the branch to rebase (the second argument) was given,
the upstream would have been interpreted relative to the second argument.
In particular, this command

    git rebase -i HEAD topic

would always finish with "Nothing to do". (a1bf91e fixed the same issue
for non-interactive rebase.)

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

I made this with -U5 so that you can see the checkout in the context.

BTW, methinks, this checkout is unnecessary, since before the rebase
begins, there is a 'git checkout $ONTO', and the branch switching is
certainly not needed to compute the todo list...

-- Hannes

 git-rebase--interactive.sh |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8ee08ff..0ca986f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -473,25 +473,24 @@ do
 			;;
 		esac

 		require_clean_work_tree

+		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+		test -z "$ONTO" && ONTO=$UPSTREAM
+
 		if test ! -z "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
 			output git checkout "$2" ||
 				die "Could not checkout $2"
 		fi

 		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
-		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-
 		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"

-		test -z "$ONTO" && ONTO=$UPSTREAM
-
 		: > "$DOTEST"/interactive || die "Could not mark as interactive"
 		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
 			echo "detached HEAD" > "$DOTEST"/head-name

 		echo $HEAD > "$DOTEST"/head
-- 
1.5.6.rc0.885.gdf17.dirty
