From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] gitk: Add workaround to handle corrupted author date
Date: Sun,  2 Dec 2007 17:36:23 +0100
Message-ID: <1196613383337-git-send-email-prohaska@zib.de>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 17:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyroE-000732-4v
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXLBQg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbXLBQg0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:36:26 -0500
Received: from mailer.zib.de ([130.73.108.11]:59630 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbXLBQgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:36:25 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lB2GaO1n019448
	for <git@vger.kernel.org>; Sun, 2 Dec 2007 17:36:24 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lB2GaNRX002788;
	Sun, 2 Dec 2007 17:36:23 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66790>

6e6db85ea9423eea755cf5acf7a563c0d9559063 contains a corrupted
author line, which is lacking the time and timezone information.

This commit adds a workaround to handle this situation.  If the
time cannot be parsed, it is assumed to be 0 and the full line
is assumed to be the author's name.
---
 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

This works around the issue for me.  However, I don't think
this patch should be applied.

The best was if such a corrupted commit wouldn't enter the
repository in the first place.  But once it is there, I think git
should verify the format of a commit and report an approriate
error.  gitk could continue to assume well formed commits.

    Steffen

diff --git a/gitk b/gitk
index 1da0b0a..873766c 100755
--- a/gitk
+++ b/gitk
@@ -439,7 +439,12 @@ proc parsecommit {id contents listed} {
 	set tag [lindex $line 0]
 	if {$tag == "author"} {
 	    set audate [lindex $line end-1]
-	    set auname [lrange $line 1 end-2]
+	    if {[catch {formatdate $audate}]} {
+		set audate 0
+		set auname [lrange $line 1 end]
+	    } else {
+		set auname [lrange $line 1 end-2]
+	    }
 	} elseif {$tag == "committer"} {
 	    set comdate [lindex $line end-1]
 	    set comname [lrange $line 1 end-2]
-- 
1.5.3.7.949.g2221a6
