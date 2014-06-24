From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 1/4] gitk: use single blamestuff for all
 show_line_source{} calls
Date: Tue, 24 Jun 2014 21:18:04 +0300
Message-ID: <20140624181738.GA23114@wheezy.local>
References: <20140624181514.GA23051@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:18:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVIW-0000qV-PL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbaFXSSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:18:21 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:40478
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378AbaFXSSU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:18:20 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-06.prod.phx3.secureserver.net with 
	id JJJD1o0043gsSd601JJJwJ; Tue, 24 Jun 2014 11:18:20 -0700
Content-Disposition: inline
In-Reply-To: <20140624181514.GA23051@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252413>

There seems to be no point to search for several origins at once.
Probably is is not even fully working (because there is one blameinst),
but blamestuff for some reason is an array. Also, it is not cleaned
after blame is completed.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 41e5071..8ef6aa8 100755
--- a/gitk
+++ b/gitk
@@ -3824,17 +3824,18 @@ proc show_line_source {} {
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
@@ -3843,7 +3844,7 @@ proc read_line_source {fd inst} {
     global blamestuff curview commfd blameinst nullid nullid2
 
     while {[gets $fd line] >= 0} {
-	lappend blamestuff($inst) $line
+	lappend blamestuff $line
     }
     if {![eof $fd]} {
 	return 1
@@ -3854,17 +3855,18 @@ proc read_line_source {fd inst} {
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
@@ -3887,6 +3889,7 @@ proc read_line_source {fd inst} {
     } else {
 	puts "oops couldn't parse git blame output"
     }
+    unset blamestuff
     return 0
 }
 
-- 
2.0.0.526.g5318336
