From: Joergen Edelbo <jed@napatech.com>
Subject: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Fri, 6 Sep 2013 12:30:15 +0200
Message-ID: <20130906105022.0718C12156D@jed-dev-01.labnet>
Cc: j.sixt@viscovery.net, gitster@pobox.com, hvoigt@hvoigt.net,
	patthoyts@gmail.com, jed@napatech.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 12:50:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtcS-0003lL-I6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118Ab3IFKuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:50:24 -0400
Received: from nat.napatech.com ([188.120.77.114]:1864 "EHLO jed-dev-01.labnet"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751007Ab3IFKuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:50:24 -0400
Received: by jed-dev-01.labnet (Postfix, from userid 1000)
	id 0718C12156D; Fri,  6 Sep 2013 12:50:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234039>

Problem: It is not possible to push for Gerrit review as you will
always try to push to "refs/heads/..." on the remote.

Changes done:

Add an option to select "Gerrit review" and a corresponding entry
for a branch name. If this option is selected, push the changes to
"refs/for/<gerrit-branch>/<local branch>". In this way the local branch
names will be used as topic branches on Gerrit.
---
Hi all,

This is a second attempt to support Gerrit review. It is fully backwards
compatible as the Gerrit option is an addition only. It is also better
than the first approach as it supports pushing more local branches to
Gerrit - each having their own topic branch there.

Further improvement could be to make the Gerrit branch specification a
drop down list, but I would like to have this first simple approach 
evaluated first.

BR Joergen

 lib/transport.tcl |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/lib/transport.tcl b/lib/transport.tcl
index e5d211e..adf2bbb 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -61,6 +61,7 @@ proc push_to {remote} {
 
 proc start_push_anywhere_action {w} {
 	global push_urltype push_remote push_url push_thin push_tags
+	global gerrit_review gerrit_branch
 	global push_force
 	global repo_config
 
@@ -95,7 +96,15 @@ proc start_push_anywhere_action {w} {
 		set cnt 0
 		foreach i [$w.source.l curselection] {
 			set b [$w.source.l get $i]
-			lappend cmd "refs/heads/$b:refs/heads/$b"
+			if {$gerrit_review && $gerrit_branch ne {}} {
+				if {$gerrit_branch eq $b} {
+					lappend cmd "refs/heads/$b:refs/for/$b"
+				} else {
+					lappend cmd "refs/heads/$b:refs/for/$gerrit_branch/$b"
+				}
+			} else {
+				lappend cmd "refs/heads/$b:refs/heads/$b"
+			}
 			incr cnt
 		}
 		if {$cnt == 0} {
@@ -120,6 +129,7 @@ trace add variable push_remote write \
 proc do_push_anywhere {} {
 	global all_remotes current_branch
 	global push_urltype push_remote push_url push_thin push_tags
+	global gerrit_review gerrit_branch
 	global push_force use_ttk NS
 
 	set w .push_setup
@@ -215,6 +225,24 @@ proc do_push_anywhere {} {
 		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
+	${NS}::checkbutton $w.options.gerrit \
+		-text [mc "Gerrit review.  Branch: "] \
+		-variable gerrit_review
+	${NS}::entry $w.options.gerrit_br \
+		-width 50 \
+		-textvariable gerrit_branch \
+		-validate key \
+		-validatecommand {
+			if {%d == 1 && [regexp {\s} %S]} {return 0}
+			if {%d == 1 && [string length %S] > 0} {
+				set gerrit_review 1
+			}
+			if {[string length %P] == 0} {
+				set gerrit_review 0
+			}
+			return 1
+		}
+	grid $w.options.gerrit $w.options.gerrit_br -sticky we -padx {0 5}
 	grid columnconfigure $w.options 1 -weight 1
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
 
-- 
1.7.9.5
