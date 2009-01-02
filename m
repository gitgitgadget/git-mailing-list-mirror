From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 1/4] rebase -i: execute hook only after argument checking
Date: Fri,  2 Jan 2009 23:28:26 +0100
Message-ID: <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
References: <200901022320.14055.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, bss@iguanasuicide.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsWX-0008ET-45
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbZABW21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757698AbZABW20
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:28:26 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:2229 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756919AbZABW2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:28:25 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:22 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:22 +0100
X-Mailer: git-send-email 1.6.1.71.gaaa47.dirty
In-Reply-To: <200901022320.14055.trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jan 2009 22:28:22.0564 (UTC) FILETIME=[6BC09640:01C96D29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104430>

Previously, the pre-rebase-hook would be launched before we knew if
the <upstream> [<branch>] arguments were supplied.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is a quick fix and not really part of the series.  2/4 textually
depends on it, however, so I'm sending it along.

 git-rebase--interactive.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c8b0861..2c668cd 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -554,7 +554,6 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
-		run_pre_rebase_hook ${1+"$@"}
 		test $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
@@ -562,11 +561,13 @@ first and then run 'git rebase --continue' again."
 		git var GIT_COMMITTER_IDENT >/dev/null ||
 			die "You need to set your committer info first"
 
+		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+		run_pre_rebase_hook ${1+"$@"}
+
 		comment_for_reflog start
 
 		require_clean_work_tree
 
-		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
 		if test ! -z "$2"
-- 
1.6.1.71.gaaa47.dirty
