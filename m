From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: [PATCH] Work around a bad interaction between Tcl and cmd.exe with "^{tree}"
Date: Tue, 10 Jul 2007 15:09:29 +0200
Message-ID: <11840729692004-git-send-email-j.sixt@eudaptics.com>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jul 10 16:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GXf-0001XJ-2i
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbXGJOSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXGJOSI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:18:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47038 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbXGJOSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:18:07 -0400
X-Greylist: delayed 4107 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2007 10:18:07 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@telecom.at>)
	id 1I8FTE-0003JT-1N; Tue, 10 Jul 2007 15:09:36 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 19A226EF; Tue, 10 Jul 2007 15:09:30 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id D1F0C102; Tue, 10 Jul 2007 15:09:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.32.g2968f
X-Spam-Score: 2.1 (++)
X-Spam-Report: AWL=-1.574, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52076>

From: Johannes Sixt <johannes.sixt@telecom.at>

It seems that MSYS's wish does some quoting for Bourne shells, in
particular, escape the first '{' of the "^{tree}" suffix, but then it uses
cmd.exe to run the "git rev-parse" command. However, cmd.exe does not remove
the backslash, so that the resulting ref expression ends up in git's guts
as unrecognizable garbage.

Fortunately, recent versions of git can refer to the root tree object using
the notation "$commit:", which avoids the problematic case.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/commit.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index dc7c88c..43a5aca 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -258,7 +258,7 @@ proc commit_committree {fd_wt curHEAD msg} {
 	# -- Verify this wasn't an empty change.
 	#
 	if {$commit_type eq {normal}} {
-		set old_tree [git rev-parse "$PARENT^{tree}"]
+		set old_tree [git rev-parse "$PARENT:"]
 		if {$tree_id eq $old_tree} {
 			info_popup {No changes to commit.
 
-- 
1.5.3.rc0.32.g2968f
