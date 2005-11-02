From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: fix for empty line after Comments
Date: Wed, 02 Nov 2005 15:42:48 -0500
Message-ID: <1130964168.23026.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 21:42:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPRf-0001Cs-9w
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVKBUmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbVKBUmw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:42:52 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:52889 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965232AbVKBUmw
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 15:42:52 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EXPRb-0006cT-31
	for git@vger.kernel.org; Wed, 02 Nov 2005 15:42:51 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EXPRZ-000604-AQ
	for git@vger.kernel.org; Wed, 02 Nov 2005 15:42:49 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11038>

git-diff-tree called with one tree-ish shows the commit ID, which should
be ignored by gitk.  getblobdiffs() and gettreediffline() recognize and
ignore commit ID now.

Also, the p variable that was used as the other argument git-diff-tree
is no longer used, so it's dropped in both places.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
index a9d37d9..e935484 100755
--- a/gitk
+++ b/gitk
@@ -2805,7 +2805,6 @@ proc gettreediffs {ids} {
     set treepending $ids
     set treediff {}
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
     if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
@@ -2830,6 +2829,8 @@ proc gettreediffline {gdtf ids} {
 	    }
 	}
 	return
+    } elseif {$n == 40} {
+	return
     }
     set file [lindex $line 5]
     lappend treediff $file
@@ -2840,7 +2841,6 @@ proc getblobdiffs {ids} {
     global difffilestart nextupdate diffinhdr treediffs
 
     set id [lindex $ids 0]
-    set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
     set cmd [list | git-diff-tree -r -p -C $id]
     if {[catch {set bdf [open $cmd r]} err]} {
@@ -2934,7 +2934,7 @@ proc getblobdiffline {bdf ids} {
 	} elseif {$diffinhdr || $x == "\\"} {
 	    # e.g. "\ No newline at end of file"
 	    $ctext insert end "$line\n" filesep
-	} else {
+	} elseif {![regexp {^[0-9a-f]{40}$} $line]} {
 	    # Something else we don't recognize
 	    if {$curdifftag != "Comments"} {
 		$ctext insert end "\n"


-- 
Regards,
Pavel Roskin
