From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [RFC PATCH (GIT-GUI/CORE BUG)] git-gui: Avoid an infinite rescan
 loop in handle_empty_diff.
Date: Fri, 23 Jan 2009 17:46:57 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901231743360.11562@kiwi.cs.ucla.edu>
References: <200901240052.58259.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Shawn O Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Davey <as.davey@gmail.com>,
	kbro <kevin.broadey@googlemail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXdX-0000hd-BA
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbZAXBrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 20:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZAXBrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:47:09 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:47544 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbZAXBrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:47:08 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0O1kwaM012049;
	Fri, 23 Jan 2009 17:46:58 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0O1kvOY012046;
	Fri, 23 Jan 2009 17:46:57 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <200901240052.58259.angavrilov@gmail.com>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106943>

Teach git-gui to check diff's exit code
in order to know whether a file actually
changed or not.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
Alexander,
I encountered the same problem and I tried a different way
to prevent it.  Could you please try this alternative patch
and see if it works in your setup?  If so, it might be
a lower-impact solution.  Even if it doesn't solve your
problem, I think it is still an improvement over what
exists and could co-exist with your patch.
                                     -- Keith Cascio

 git-gui/lib/diff.tcl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index bbbf15c..94faf95 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -276,6 +276,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	lappend cmd -p
+	lappend cmd --exit-code
 	lappend cmd --no-color
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
@@ -310,6 +311,7 @@ proc read_diff {fd cont_info} {
 	global ui_diff diff_active
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
+	global errorCode
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -397,7 +399,9 @@ proc read_diff {fd cont_info} {
 	$ui_diff conf -state disabled
 
 	if {[eof $fd]} {
-		close $fd
+		fconfigure $fd -blocking 1
+		catch { close $fd } err
+		set diff_exit_status $errorCode
 
 		if {$current_diff_queue ne {}} {
 			advance_diff_queue $cont_info
@@ -413,7 +417,7 @@ proc read_diff {fd cont_info} {
 		}
 		ui_ready
 
-		if {[$ui_diff index end] eq {2.0}} {
+		if {$diff_exit_status eq "NONE"} {
 			handle_empty_diff
 		}
 		set callback [lindex $cont_info 1]
-- 
1.6.1
