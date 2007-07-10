From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH] Work around a bad interaction between Tcl and cmd.exe with 
 "^{tree}"
Date: Tue, 10 Jul 2007 18:10:20 +0200
Organization: eudaptics software gmbh
Message-ID: <4693AF6C.99DB933@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 18:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8IHT-0004q6-P1
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 18:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbXGJQJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 12:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbXGJQJg
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 12:09:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52372 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbXGJQJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 12:09:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I8IHM-0007ru-Sq; Tue, 10 Jul 2007 18:09:33 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E9A526EF; Tue, 10 Jul 2007 18:09:32 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.0 (++)
X-Spam-Report: AWL=-1.651, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52089>

It seems that MSYS's wish does some quoting for Bourne shells, in
particular, escape the first '{' of the "^{tree}" suffix, but then it uses
cmd.exe to run "git rev-parse". However, cmd.exe does not remove the
backslash, so that the resulting rev expression ends up in git's guts
as unrecognizable garbage: rev-parse fails, and git-gui hickups in a way
that it must be restarted.

Fortunately, recent versions of git can refer to the root tree object using
the notation "$commit:", which avoids the problematic case.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
This is a resend with a slightly improved commit message.
The first version didn't get through for some reason anyway, it seems.

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
