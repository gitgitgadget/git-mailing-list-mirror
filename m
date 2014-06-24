From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 3/4] gitk: refactor: separate io from logic in the
 searching origin of line
Date: Tue, 24 Jun 2014 21:20:13 +0300
Message-ID: <20140624182013.GC23114@wheezy.local>
References: <20140624181514.GA23051@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:20:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVKc-0002C0-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 20:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbaFXSUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 14:20:30 -0400
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:50523
	"EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753542AbaFXSU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 14:20:27 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-03.prod.phx3.secureserver.net with 
	id JJLN1o00Q3gsSd601JLRiD; Tue, 24 Jun 2014 11:20:27 -0700
Content-Disposition: inline
In-Reply-To: <20140624181514.GA23051@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252415>

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
index 7fa7015..9c8dca8 100755
--- a/gitk
+++ b/gitk
@@ -3780,7 +3780,7 @@ proc external_blame {parent_idx {line {}}} {
 }
 
 proc show_line_source {} {
-    global cmitmode currentid parents curview blamestuff blameinst
+    global cmitmode currentid parents curview
     global diff_menu_line diff_menu_filebase flist_menu_file
     global nullid nullid2 gitdir cdup
 
@@ -3836,6 +3836,12 @@ proc show_line_source {} {
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
@@ -3847,7 +3853,7 @@ proc show_line_source {} {
     set i [reg_instance $f]
     set blamestuff {}
     set blameinst $i
-    filerun $f [list read_line_source $f $i]
+    filerun $f [list blameiocallback $f $i $blamecommand]
 }
 
 proc stopblaming {} {
@@ -3861,8 +3867,8 @@ proc stopblaming {} {
     }
 }
 
-proc read_line_source {fd inst} {
-    global blamestuff curview commfd blameinst nullid nullid2
+proc blameiocallback {fd inst blamecommand} {
+    global blamestuff blameinst commfd
 
     while {[gets $fd line] >= 0} {
 	lappend blamestuff $line
@@ -3880,6 +3886,14 @@ proc read_line_source {fd inst} {
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
@@ -3910,7 +3924,6 @@ proc read_line_source {fd inst} {
     } else {
 	puts "oops couldn't parse git blame output"
     }
-    unset blamestuff
     return 0
 }
 
-- 
2.0.0.526.g5318336
