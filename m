From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] completion: enhance "current branch" display
Date: Sun, 10 May 2009 01:56:21 -0700
Message-ID: <7vvdo91glm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 10 10:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M34pg-0006QI-Pu
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 10:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbZEJI4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 04:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbZEJI4V
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 04:56:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38341 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZEJI4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 04:56:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510085621.ESRH20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 May 2009 04:56:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id pkwM1b0014aMwMQ03kwM83; Sun, 10 May 2009 04:56:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=tUVuHfoxc8kA:10 a=7OjU3gAUHy4A:10
 a=ybZZDoGAAAAA:8 a=uJ7t26oRIgguBJa0pioA:9 a=itJXvwWzldfsXaeeUJ6TO5eaSl0A:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118710>

Introduce GIT_PS1_DESCRIBE option you can set to "contains", "branch", or
"describe" to tweak the way how a detached HEAD is described.

The default behaviour is to describe only exact match with some tag
(otherwise use the first 7 hexdigits) as before.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I do not think the new modes based on name-rev (aka "--contains") are
   much useful if you do your own development while on a detached HEAD,
   but they probably are useful for tourists who sightsee.

 contrib/completion/git-completion.bash |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ccc7e0d..2490d5f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -108,10 +108,21 @@ __git_ps1 ()
 			fi
 
 			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
-				b="$(git describe --exact-match HEAD 2>/dev/null)" ||
+
+				b="$(
+				case "${GIT_PS1_DESCRIBE_STYLE-}" in
+				(contains)
+					git describe --contains HEAD ;;
+				(branch)
+					git describe --contains --all HEAD ;;
+				(describe)
+					git describe HEAD ;;
+				(* | default)
+					git describe --exact-match HEAD ;;
+				esac 2>/dev/null)" ||
+
 				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
 				b="unknown"
-
 				b="($b)"
 			}
 		fi
-- 
1.6.3.9.g6345d
