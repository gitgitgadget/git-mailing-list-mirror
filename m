From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] gitk: properly resolve ambiguity if argument is both, revision and filename
Date: Tue, 22 May 2007 12:42:06 +0000
Message-ID: <20070522124206.11678.qmail@5d12ed598bf56a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 425491@bugs.debian.org
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 14:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTgW-0007Es-TO
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591AbXEVMls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 08:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756617AbXEVMlr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:41:47 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:44429 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756591AbXEVMlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:41:47 -0400
Received: (qmail 11679 invoked by uid 1000); 22 May 2007 12:42:06 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	425491@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48102>

If a repository contains a file and a branch with the same name, have
gitk recognize the '--' separator as final command line argument, as
documented in gitk(1); previously 'gitk <name> --' failed.  Additionally
have gitk insert '--' automatically for views created or edited through
the View menu.

The bug was noticed and reported by Josh Triplett through
 http://bugs.debian.org/425491

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index a57e84c..7e8d426 100755
--- a/gitk
+++ b/gitk
@@ -19,15 +19,12 @@ proc gitdir {} {
 proc start_rev_list {view} {
     global startmsecs nextupdate
     global commfd leftover tclencoding datemode
-    global viewargs viewfiles commitidx
+    global viewargs viewfiles viewargsep commitidx
 
     set startmsecs [clock clicks -milliseconds]
     set nextupdate [expr {$startmsecs + 100}]
     set commitidx($view) 0
-    set args $viewargs($view)
-    if {$viewfiles($view) ne {}} {
-	set args [concat $args "--" $viewfiles($view)]
-    }
+    set args [concat $viewargs($view) $viewargsep($view) $viewfiles($view)]
     set order "--topo-order"
     if {$datemode} {
 	set order "--date-order"
@@ -1536,7 +1533,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs viewargsep newviewargs viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1560,6 +1557,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargsep($n) "--"
 	addviewmenu $n
 	if {!$newishighlight} {
 	    after idle showview $n
@@ -1579,6 +1577,7 @@ proc newviewok {top n} {
 	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n)} {
 	    set viewfiles($n) $files
 	    set viewargs($n) $newargs
+	    set viewargsep($n) "--"
 	    if {$curview == $n} {
 		after idle updatecommits
 	    }
@@ -6316,10 +6315,12 @@ if {![file isdirectory $gitdir]} {
 }
 
 set cmdline_files {}
+set cmdline_sep ""
 set i [lsearch -exact $revtreeargs "--"]
 if {$i >= 0} {
     set cmdline_files [lrange $revtreeargs [expr {$i + 1}] end]
     set revtreeargs [lrange $revtreeargs 0 [expr {$i - 1}]]
+    set cmdline_sep "--"
 } elseif {$revtreeargs ne {}} {
     if {[catch {
 	set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
@@ -6357,6 +6358,7 @@ set selectedhlview None
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargsep(0) {}
 
 set cmdlineok 0
 set stopped 0
@@ -6375,6 +6377,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargsep(1) $cmdline_sep
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
-- 
1.5.2
