From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: fix the display of files when filtered by path
Date: Tue, 13 Dec 2011 16:50:50 +0000
Message-ID: <87hb14wg4l.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 13 18:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaVtg-0003Gi-1v
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 18:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1LMRMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 12:12:01 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:62960 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682Ab1LMRMA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 12:12:00 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111213171155.MIN27013.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 13 Dec 2011 17:11:55 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RaVtT-00067m-O7; Tue, 13 Dec 2011 17:11:55 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1BC06204C8; Tue, 13 Dec 2011 17:11:55 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=9XFZt7WcSwMA:10 a=kj9zAlcOel0A:10 a=FP58Ms26AAAA:8 a=1vSshlC292vCDhhB4mUA:9 a=MS6zm6YF7NNKexw5M5kA:7 a=CjuIK1q_8ugA:10 a=er7-qRgh4PtJugEs:21 a=WWKIV6sD9VLXeSyK:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187032>

Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to files
under the given directory but the file list is left empty. This is because
the path_filter function fails to match the filenames which are relative
to the working tree to the filter which is filessytem relative.
This solves the problem by making both names fully qualified filesystem
paths before performing the comparison.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk-git/gitk |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2a92e20..b728345 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -18,6 +18,26 @@ proc gitdir {} {
     }
 }
 
+proc gitworktree {} {
+    variable _gitworktree
+    if {[info exists _gitworktree]} {
+	return $_gitworktree
+    }
+    # v1.7.0 introduced --show-toplevel to return the canonical work-tree
+    if {[catch {set _gitworktree [exec git rev-parse --show-toplevel]}]} {
+        # try to set work tree from environment, core.worktree or use
+        # cdup to obtain a relative path to the top of the worktree. If
+        # run from the top, the ./ prefix ensures normalize expands pwd.
+        if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
+	    catch {set _gitworktree [exec git config --get core.worktree]}
+	    if {$_gitworktree eq ""} {
+		set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
+	    }
+        }
+    }
+    return $_gitworktree
+}
+
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -7376,19 +7396,15 @@ proc startdiff {ids} {
     }
 }
 
+# If the filename (name) is under any of the passed filter paths
+# then return true to include the file in the listing.
 proc path_filter {filter name} {
+    set worktree [gitworktree]
     foreach p $filter {
-	set l [string length $p]
-	if {[string index $p end] eq "/"} {
-	    if {[string compare -length $l $p $name] == 0} {
-		return 1
-	    }
-	} else {
-	    if {[string compare -length $l $p $name] == 0 &&
-		([string length $name] == $l ||
-		 [string index $name $l] eq "/")} {
-		return 1
-	    }
+	set fq_p [file normalize $p]
+	set fq_n [file normalize [file join $worktree $name]]
+	if {[string match [file normalize $fq_p]* $fq_n]} {
+	    return 1
 	}
     }
     return 0
-- 
1.7.8.msysgit.0
