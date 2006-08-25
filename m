From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-commit: fix signed off handling
Date: Fri, 25 Aug 2006 02:27:40 +0200
Message-ID: <20060825002740.GH2817@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 25 02:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGPYF-0003eh-Dy
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbWHYA1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbWHYA1z
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:27:55 -0400
Received: from [130.225.96.91] ([130.225.96.91]:25254 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422789AbWHYA1y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:27:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 643C5770079
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:27:42 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25290-15 for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:27:41 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3EC07770076
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:27:41 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 1218F6DF88D
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:26:23 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1125F629FB; Fri, 25 Aug 2006 02:27:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25982>

Handle the sign off insertion before starting the CG: comment lines. Also,
fix typo in grepping for existing sign off lines.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

The late calling of the add_signoff function has multiple problems,
since at that point comment lines has already been added and the sign
off line will end up in only one of the log message files.

 cg-commit |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/cg-commit b/cg-commit
index 5cebd81..b0b5c34 100755
--- a/cg-commit
+++ b/cg-commit
@@ -406,12 +406,10 @@ # Always have at least one blank line, t
 # the poor people whose text editor has no 'O' command.
 [ "$written" ] || { tty -s && echo >>"$LOGMSG"; }
 
-add_signoff() {
-	if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
-		grep -q -i sign-off-by $LOGMSG || echo
-		echo "Signed-off-by: $signoff"
-	fi >> $LOGMSG
-}
+if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
+	grep -q -i signed-off-by $LOGMSG || echo
+	echo "Signed-off-by: $signoff"
+fi >> $LOGMSG
 
 # CG: -----------------------------------------------------------------------
 editor_comment_start commit
@@ -472,7 +470,6 @@ editor_msg_end
 
 cp "$LOGMSG" "$LOGMSG2"
 if tty -s; then
-	add_signoff
 	if [ "$editor" ] && ! editor $commitalways commit c; then
 		rm "$LOGMSG" "$LOGMSG2"
 		[ "$review" ] && rm "$PATCH"
@@ -503,7 +500,6 @@ __END__
 	editor_parse_setif GIT_AUTHOR_DATE Date
 else
 	cat >>"$LOGMSG2"
-	add_signoff
 fi
 
 if [ ! "$review" ]; then
-- 
Jonas Fonseca
