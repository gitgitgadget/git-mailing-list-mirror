From: Max Kirillov <max@max630.net>
Subject: [PATCH 2/3] gitk: refactor: separate io from logic in the searching
 origin of line
Date: Tue, 4 Feb 2014 00:42:12 +0200
Message-ID: <20140203224212.GB5136@wheezy.local>
References: <20140203205352.GA5136@wheezy.local>
 <20140203223346.GA14202@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASDo-0007WL-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbaBCWm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:42:28 -0500
Received: from m1plsmtpa01-08.prod.mesa1.secureserver.net ([64.202.165.187]:43023
	"EHLO m1plsmtpa01-08.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbaBCWm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 17:42:28 -0500
Received: from wheezy.local ([89.27.29.195])
	by m1plsmtpa01-08.prod.mesa1.secureserver.net with 
	id MyiP1n0074CavkR01yiS8o; Mon, 03 Feb 2014 15:42:28 -0700
Content-Disposition: inline
In-Reply-To: <20140203223346.GA14202@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241485>

The pattern of maintaining blame command and collecting output
can be reused for searching of latest change to region.
It still can use the blame's global variables, because the two
search commands should not run concurrently as well as two instances
of blame.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 7699a66..eef88a1 100755
--- a/gitk
+++ b/gitk
@@ -3771,7 +3771,7 @@ proc external_blame {parent_idx {line {}}} {
 }
 
 proc show_line_source {} {
-    global cmitmode currentid parents curview blamestuff blameinst
+    global cmitmode currentid parents curview
     global diff_menu_line diff_menu_filebase flist_menu_file
     global nullid nullid2 gitdir cdup
 
@@ -3827,6 +3827,12 @@ proc show_line_source {} {
 	lappend blameargs $id
     }
     lappend blameargs -- [file join $cdup $flist_menu_file]
+    startblaming $blameargs read_line_source
+}
+
+proc startblaming {blameargs blamecommand} {
+    global blamestuff blameinst
+
     if {[catch {
 	set f [open $blameargs r]
     } err]} {
@@ -3838,7 +3844,7 @@ proc show_line_source {} {
     set i [reg_instance $f]
     set blamestuff {}
     set blameinst $i
-    filerun $f [list read_line_source $f $i]
+    filerun $f [list blameiocallback $f $i $blamecommand]
 }
 
 proc stopblaming {} {
@@ -3852,8 +3858,8 @@ proc stopblaming {} {
     }
 }
 
-proc read_line_source {fd inst} {
-    global blamestuff curview commfd blameinst nullid nullid2
+proc blameiocallback {fd inst blamecommand} {
+    global blamestuff blameinst commfd
 
     while {[gets $fd line] >= 0} {
 	lappend blamestuff $line
@@ -3871,6 +3877,14 @@ proc read_line_source {fd inst} {
 	return 0
     }
 
+    $blamecommand
+    unset blamestuff
+    return 0
+}
+
+proc read_line_source {} {
+    global blamestuff curview nullid nullid2
+
     set fname {}
     set line [split [lindex $blamestuff 0] " "]
     set id [lindex $line 0]
@@ -3901,7 +3915,6 @@ proc read_line_source {fd inst} {
     } else {
 	puts "oops couldn't parse git blame output"
     }
-    unset blamestuff
     return 0
 }
 
-- 
1.8.5.2.421.g4cdf8d0
