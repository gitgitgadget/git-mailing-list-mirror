From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-gui/gitk: Do not depend on Cygwin's "kill" command on
 Windows
Date: Thu, 23 Oct 2014 21:30:54 +0200
Message-ID: <5449576E.8040808__34825.0704505064$1414092921$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 21:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhOAE-0008Cw-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 21:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbaJWTfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 15:35:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:40030 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaJWTfF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 15:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XhOA3-0008AF-LH
	for git@vger.kernel.org; Thu, 23 Oct 2014 21:35:03 +0200
Received: from p4ff44ffd.dip0.t-ipconnect.de ([79.244.79.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 21:35:03 +0200
Received: from sschuberth by p4ff44ffd.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 21:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff44ffd.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Windows does not necessarily mean Cygwin, it could also be MSYS. The
latter ships with a version of "kill" that does not understand "-f". In
msysgit this was addressed shipping Cygwin's version of kill.

Properly fix this by using the stock Windows "taskkill" command instead,
which is available since Windows XP Professional.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-gui/git-gui.sh | 4 +---
 gitk-git/gitk      | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b186329..a1c823e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -666,9 +666,7 @@ proc kill_file_process {fd} {
 
 	catch {
 		if {[is_Windows]} {
-			# Use a Cygwin-specific flag to allow killing
-			# native Windows processes
-			exec kill -f $process
+			exec taskkill /pid $process
 		} else {
 			exec kill $process
 		}
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3520bda..bfc5cfa 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -445,7 +445,7 @@ proc stop_instance {inst} {
 	set pid [pid $fd]
 
 	if {$::tcl_platform(platform) eq {windows}} {
-	    exec kill -f $pid
+	    exec taskkill /pid $pid
 	} else {
 	    exec kill $pid
 	}
-- 
1.8.4-mingw-3
