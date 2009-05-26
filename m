From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: fix PS1 display during an AM on detached HEAD
Date: Mon, 25 May 2009 22:56:03 -0700
Message-ID: <7vy6skqufg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 07:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8pe9-0005vH-LV
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 07:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbZEZF4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 01:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbZEZF4E
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 01:56:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50386 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZEZF4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 01:56:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090526055603.LBSW20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 May 2009 01:56:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id w5w31b0034aMwMQ035w3dk; Tue, 26 May 2009 01:56:04 -0400
X-Authority-Analysis: v=1.0 c=1 a=XyVkfOVLXpcA:10 a=sgsF-1rxaPEA:10
 a=ybZZDoGAAAAA:8 a=7collTRRkirXcnq1TnwA:9 a=nNFxXnqUdj84qf0KNP3Qk5lVkNUA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119995>

This is a companion patch to previous 8763dbb (completion: fix PS1 display
during a merge on detached HEAD, 2009-05-16).  While rebasing or running am
on a detached HEAD, the code failed to set $b (branch description) that
enables the whole status display business.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 The original incorrectly indents the "rebase-apply" case, which gives
 the patch some "Huh?" effect, which this patch also fixes.

 contrib/completion/git-completion.bash |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0c8bb53..c84d765 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -84,26 +84,24 @@ __git_ps1 ()
 	if [ -n "$g" ]; then
 		local r
 		local b
-		if [ -d "$g/rebase-apply" ]; then
-			if [ -f "$g/rebase-apply/rebasing" ]; then
-				r="|REBASE"
-		elif [ -f "$g/rebase-apply/applying" ]; then
-				r="|AM"
-			else
-				r="|AM/REBASE"
-			fi
-			b="$(git symbolic-ref HEAD 2>/dev/null)"
-		elif [ -f "$g/rebase-merge/interactive" ]; then
+		if [ -f "$g/rebase-merge/interactive" ]; then
 			r="|REBASE-i"
 			b="$(cat "$g/rebase-merge/head-name")"
 		elif [ -d "$g/rebase-merge" ]; then
 			r="|REBASE-m"
 			b="$(cat "$g/rebase-merge/head-name")"
 		else
-			if [ -f "$g/MERGE_HEAD" ]; then
+			if [ -d "$g/rebase-apply" ]; then
+				if [ -f "$g/rebase-apply/rebasing" ]; then
+					r="|REBASE"
+				elif [ -f "$g/rebase-apply/applying" ]; then
+					r="|AM"
+				else
+					r="|AM/REBASE"
+				fi
+			elif [ -f "$g/MERGE_HEAD" ]; then
 				r="|MERGING"
-			fi
-			if [ -f "$g/BISECT_LOG" ]; then
+			elif [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
 
-- 
1.6.3.1.169.g33fd7
