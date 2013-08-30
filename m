From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: fix race error at click while reading commits
Date: Sat, 31 Aug 2013 02:39:38 +0300
Message-ID: <20130830233938.GA10148@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Aug 31 01:45:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFYO6-0002Tc-D5
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 01:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891Ab3H3Xpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 19:45:54 -0400
Received: from p3plsmtpa09-03.prod.phx3.secureserver.net ([173.201.193.232]:35081
	"EHLO p3plsmtpa09-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752523Ab3H3Xpy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 19:45:54 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2013 19:45:54 EDT
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa09-03.prod.phx3.secureserver.net with 
	id KBfb1m00G4CavkR01BfmzH; Fri, 30 Aug 2013 16:39:48 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233483>

If I click the commit list while reading (or rereading, by Shift-F5)
commits, sometimes an error message appears:
`can't read "pending_select": no such variable',
because pending_select is reset during update.

Just removing update or saving value in local variable would result in
occasional scrolling to some random commit in history, often very far
from the beginning. So nicer choice is skip the selection if change is
detected

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk-git/gitk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b3706fc..5a8a57c 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -5038,8 +5038,11 @@ proc layoutmore {} {
     }
     if {[info exists pending_select] &&
 	[commitinview $pending_select $curview]} {
+	set save_pending_select $pending_select
 	update
-	selectline [rowofcommit $pending_select] 1
+	if {[info exists pending_select] && $pending_select == $save_pending_select} {
+	    selectline [rowofcommit $save_pending_select] 1
+	}
     }
     drawvisible
 }
-- 
1.8.4.rc3.902.g80a4b9e
