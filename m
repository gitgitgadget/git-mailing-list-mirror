From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] completion: simplify "current branch" in __git_ps1()
Date: Sun, 10 May 2009 01:53:19 -0700
Message-ID: <7v1vqx2vb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 10 10:53:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M34nE-0005mA-TA
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 10:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbZEJIxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 04:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZEJIxV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 04:53:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49011 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbZEJIxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 04:53:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510085320.FABB18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 May 2009 04:53:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pktK1b0074aMwMQ04ktKJU; Sun, 10 May 2009 04:53:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=arbvoYmnwuUA:10 a=GPxRuyC2TyIA:10
 a=ybZZDoGAAAAA:8 a=h7nqLX7HVKD1OcaJrawA:9 a=NyzLtIzIA9AnG0DwFgjXLqxFLKQA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118709>

As I very often work on a detached HEAD, I found it pretty confusing
when __git_ps1() said 'some-name'.  Did I create a branch with that name
by mistake, or do I happen to be on a commit with that exact tag?

This patch fixes the issue by enclosing non branch names in a pair of
parentheses when used to substitute %s token in __git_ps1() argument.

It also fixes a small bug where the branch part is left empty when
.git/HEAD is unreadable for whatever reason.  The output now says
"(unknown)".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..ccc7e0d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -106,13 +106,14 @@ __git_ps1 ()
 			if [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
-			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"; then
-				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"; then
-					if [ -r "$g/HEAD" ]; then
-						b="$(cut -c1-7 "$g/HEAD")..."
-					fi
-				fi
-			fi
+
+			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
+				b="$(git describe --exact-match HEAD 2>/dev/null)" ||
+				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
+				b="unknown"
+
+				b="($b)"
+			}
 		fi
 
 		local w
-- 
1.6.3.9.g6345d
