From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH git-gui v2 1/2] Teach git-gui to use --primer.
Date: Mon,  2 Feb 2009 11:32:00 -0800
Message-ID: <1233603121-1430-2-git-send-email-keith@cs.ucla.edu>
References: <1233603121-1430-1-git-send-email-keith@cs.ucla.edu>
Cc: git@vger.kernel.org
To: Shawn O Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU4oU-0005fn-9t
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 20:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZBBTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 14:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZBBTtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 14:49:09 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:45628 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZBBTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 14:49:08 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n12Jn5AV001505;
	Mon, 2 Feb 2009 11:49:05 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n12Jn5Y4001504;
	Mon, 2 Feb 2009 11:49:05 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1233603121-1430-1-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108112>

Teach git-gui to use --primer.
Also teach it to check diff's exit code instead of relying on piped
output, which could be altered as a consequence of primer options.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 lib/diff.tcl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index bbbf15c..0e1e4a3 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -276,6 +276,8 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	lappend cmd -p
+	lappend cmd --exit-code
+	lappend cmd --primer
 	lappend cmd --no-color
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
@@ -310,6 +312,7 @@ proc read_diff {fd cont_info} {
 	global ui_diff diff_active
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
+	global errorCode
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -397,7 +400,9 @@ proc read_diff {fd cont_info} {
 	$ui_diff conf -state disabled
 
 	if {[eof $fd]} {
-		close $fd
+		fconfigure $fd -blocking 1
+		catch { close $fd } err
+		set diff_exit_status $errorCode
 
 		if {$current_diff_queue ne {}} {
 			advance_diff_queue $cont_info
@@ -413,7 +418,7 @@ proc read_diff {fd cont_info} {
 		}
 		ui_ready
 
-		if {[$ui_diff index end] eq {2.0}} {
+		if {$diff_exit_status eq "NONE"} {
 			handle_empty_diff
 		}
 		set callback [lindex $cont_info 1]
-- 
1.6.1
