From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: fix PS1 display during a merge on detached HEAD
Date: Sat, 16 May 2009 11:46:22 -0700
Message-ID: <7vzldcnawx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 16 20:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5OuO-0000OA-6C
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 20:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbZEPSqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZEPSqW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 14:46:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41894 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZEPSqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 14:46:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516184623.SYRC17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 May 2009 14:46:23 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id sJmN1b0094aMwMQ04JmNZl; Sat, 16 May 2009 14:46:22 -0400
X-Authority-Analysis: v=1.0 c=1 a=yLX1NePeSeQA:10 a=sgsF-1rxaPEA:10
 a=ybZZDoGAAAAA:8 a=FWoY3YqTcDU6H9TBt1AA:9 a=rEGL-6bn52nh7D6spFZnQJ9goEAA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119373>

If your merge stops in a conflict while on a detached HEAD, recent
completion code fails to show anything.  This was because various cases
added to support the operation-in-progress markers (e.g. REBASE, MERGING)
forgot that they need to set the variable "b" to something for the result
they computed to be displayed at all.

Probably not many people make trial merges on a detached HEAD (which is
tremendously useful feature of git, by the way), and that may be why this
was not noticed for a long time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad26b7c..4462ef0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -99,10 +99,10 @@ __git_ps1 ()
 		elif [ -d "$g/rebase-merge" ]; then
 			r="|REBASE-m"
 			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -f "$g/MERGE_HEAD" ]; then
-			r="|MERGING"
-			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
+			if [ -f "$g/MERGE_HEAD" ]; then
+				r="|MERGING"
+			fi
 			if [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
