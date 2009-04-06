From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: run post-checkout hook after clone
Date: Mon, 06 Apr 2009 21:05:55 +0200
Message-ID: <49DA5293.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LquAK-0004aE-Vw
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbZDFTGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757044AbZDFTF7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:05:59 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:50240 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbZDFTF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:05:59 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id C3D0FFC90B25;
	Mon,  6 Apr 2009 21:05:56 +0200 (CEST)
Received: from [80.128.95.42] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1Lqu8q-0000XX-00; Mon, 06 Apr 2009 21:05:56 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19S9w8rktAL22HqM1dQos5kVi+h96JCOtRn45A6
	OSTNbVQjB+QcWp8FBkE0fpD1YThshO8LMbNvYXXkXcZ+eY11OD
	cWe62+pNLh2DeI/7jbdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115869>

git-gui is using "git-read-tree -u" when cloning which doesn't
invoke the post-checkout hook as a plain git-clone would.
So git-gui must call the hook itself.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-gui/lib/choose_repository.tcl |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index f9ff62a..00f388f 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -964,7 +964,34 @@ method _readtree_wait {fd} {
 		return
 	}
 
-	set done 1
+	# -- Run the post-checkout hook.
+	#
+	set fd_ph [githook_read post-checkout [string repeat 0 40] \
+		[git rev-parse HEAD] 1]
+	if {$fd_ph ne {}} {
+		global pch_error
+		set pch_error {}
+		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
+		fileevent $fd_ph readable [cb _postcheckout_wait $fd_ph]
+	} else {
+		set done 1
+	}
+}
+
+method _postcheckout_wait {fd_ph} {
+	global pch_error
+
+	append pch_error [read $fd_ph]
+	fconfigure $fd_ph -blocking 1
+	if {[eof $fd_ph]} {
+		if {[catch {close $fd_ph}]} {
+			hook_failed_popup post-checkout $pch_error 0
+		}
+		unset pch_error
+		set done 1
+		return
+	}
+	fconfigure $fd_ph -blocking 0
 }
 
 ######################################################################
-- 
1.6.2.2.405.g4396
