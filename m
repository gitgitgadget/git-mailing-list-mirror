From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Reallow git-rebase --interactive --continue if commit is unnecessary
Date: Thu, 20 Dec 2007 02:12:12 -0500
Message-ID: <20071220071212.GA20534@spearce.org>
References: <87r6hias5s.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Dec 20 08:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5FaF-0005lY-Cl
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 08:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXLTHMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 02:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbXLTHMT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 02:12:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33141 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXLTHMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 02:12:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J5FZl-0000oK-AE; Thu, 20 Dec 2007 02:12:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A97C420FBAE; Thu, 20 Dec 2007 02:12:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <87r6hias5s.fsf@gollum.intra.norang.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68977>

During git-rebase --interactive's --continue implementation we used
to silently restart the rebase if the user had made the commit
for us.  This is common if the user stops to edit a commit and
does so by amending it.  My recent change to watch git-commit's
exit status broke this behavior.

Thanks to Bernt Hansen for catching it in 1.5.4-rc1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 47581ce..39f32b1 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -372,8 +372,9 @@ do
 			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
 		} &&
 		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-		git commit --no-verify -F "$DOTEST"/message -e ||
+		if ! git commit --no-verify -F "$DOTEST"/message -e
 			die "Could not commit staged changes."
+		fi
 
 		require_clean_work_tree
 		do_rest
-- 
1.5.4.rc1.1090.gab2276
