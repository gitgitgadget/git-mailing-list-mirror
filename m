From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: use single blamestuff for all show_line_source{} calls
Date: Mon, 3 Feb 2014 22:53:52 +0200
Message-ID: <20140203205352.GA5136@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQX1-0005v4-WA
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaBCUyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:54:12 -0500
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:33821
	"EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784AbaBCUyL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 15:54:11 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-04.prod.phx3.secureserver.net with 
	id Mwu31n00K4CavkR01wu9me; Mon, 03 Feb 2014 13:54:11 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241477>

There seems to be no point to search for several origins at once.
I doubt it is even fully working (because there is one blameinst),
but blamestuff for some reason is an array. Also, it is not cleaned
after blame is completed

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 90764e8..dfac4fd 100755
--- a/gitk
+++ b/gitk
@@ -3815,17 +3815,18 @@ proc show_line_source {} {
     nowbusy blaming [mc "Searching"]
     fconfigure $f -blocking 0
     set i [reg_instance $f]
-    set blamestuff($i) {}
+    set blamestuff {}
     set blameinst $i
     filerun $f [list read_line_source $f $i]
 }
 
 proc stopblaming {} {
-    global blameinst
+    global blameinst blamestuff
 
     if {[info exists blameinst]} {
 	stop_instance $blameinst
 	unset blameinst
+	unset blamestuff
 	notbusy blaming
     }
 }
@@ -3834,7 +3835,7 @@ proc read_line_source {fd inst} {
     global blamestuff curview commfd blameinst nullid nullid2
 
     while {[gets $fd line] >= 0} {
-	lappend blamestuff($inst) $line
+	lappend blamestuff $line
     }
     if {![eof $fd]} {
 	return 1
@@ -3845,17 +3846,18 @@ proc read_line_source {fd inst} {
     fconfigure $fd -blocking 1
     if {[catch {close $fd} err]} {
 	error_popup [mc "Error running git blame: %s" $err]
+	unset blamestuff
 	return 0
     }
 
     set fname {}
-    set line [split [lindex $blamestuff($inst) 0] " "]
+    set line [split [lindex $blamestuff 0] " "]
     set id [lindex $line 0]
     set lnum [lindex $line 1]
     if {[string length $id] == 40 && [string is xdigit $id] &&
 	[string is digit -strict $lnum]} {
 	# look for "filename" line
-	foreach l $blamestuff($inst) {
+	foreach l $blamestuff {
 	    if {[string match "filename *" $l]} {
 		set fname [string range $l 9 end]
 		break
@@ -3878,6 +3880,7 @@ proc read_line_source {fd inst} {
     } else {
 	puts "oops couldn't parse git blame output"
     }
+    unset blamestuff
     return 0
 }
 
-- 
1.8.5.2.421.g4cdf8d0
