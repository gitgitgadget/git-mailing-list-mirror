From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH v2] git-gui: display summary when showing diff of a submodule
Date: Tue, 07 Jul 2009 17:50:20 +0200
Message-ID: <4A536EBC.8080107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 17:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOCwG-0004U3-3Z
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 17:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268AbZGGPu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbZGGPu1
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 11:50:27 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57323 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbZGGPu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 11:50:26 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 26FCE107BC62C;
	Tue,  7 Jul 2009 17:50:23 +0200 (CEST)
Received: from [80.128.54.107] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MOCw2-0002AR-00; Tue, 07 Jul 2009 17:50:22 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18dZ9hbi44MO31bUiDkLIKFj5s7JYaltauOzJIj
	RywfPHp71cnEhn5JHtekRD2dSVXYlJYMjWCQX5nfJAoxAmXa0F
	6d/JAV1kk4ubWxEVI74w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122850>

As it is hard to say what changed in a submodule by looking at the hashes,
let's show the colored submodule summary instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

While working with this feature during the daytime i noticed a few
shortcomings that are fixed in this version:

- The newer commits in the submodule should be colored green, not red.

- Replaced the '*' in the first line of the output of git submodule
  with "Submodule" and changed the color of this line to blue.

- Warnings from git submodule are parsed and shown correctly now.

- When the submodule was staged, the git diff output was shown again.

- Disabled [un]stage commit & line popup menu items for submodules.


 git-gui/git-gui.sh   |    2 +-
 git-gui/lib/diff.tcl |   30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b92ba..3c0ce26 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3212,7 +3212,7 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 			set l [mc "Stage Hunk For Commit"]
 			set t [mc "Stage Line For Commit"]
 		}
-		if {$::is_3way_diff
+		if {$::is_3way_diff || $::is_submodule_diff
 			|| $current_diff_path eq {}
 			|| {__} eq $state
 			|| {_O} eq $state
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 925b3f5..ae1ea3a 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -255,7 +255,7 @@ proc show_other_diff {path w m cont_info} {

 proc start_show_diff {cont_info {add_opts {}}} {
 	global file_states file_lists
-	global is_3way_diff diff_active repo_config
+	global is_3way_diff is_submodule_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header

@@ -265,6 +265,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	set s $file_states($path)
 	set m [lindex $s 0]
 	set is_3way_diff 0
+	set is_submodule_diff 0
 	set diff_active 1
 	set current_diff_header {}

@@ -295,6 +296,11 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		lappend cmd $path
 	}

+	if {[string match {160000 *} [lindex $s 2]]
+        || [string match {160000 *} [lindex $s 3]]} {
+		set cmd {submodule summary -- $current_diff_path}
+	}
+
 	if {[catch {set fd [eval git_read --nice $cmd]} err]} {
 		set diff_active 0
 		unlock_index
@@ -312,7 +318,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 }

 proc read_diff {fd cont_info} {
-	global ui_diff diff_active
+	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
 	global diff_empty_count
@@ -337,6 +343,9 @@ proc read_diff {fd cont_info} {
 		}
 		set ::current_diff_inheader 0

+		if {[regexp {^\* } $line]} {
+			set is_submodule_diff 1
+		}
 		# -- Automatically detect if this is a 3 way diff.
 		#
 		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
@@ -374,6 +383,23 @@ proc read_diff {fd cont_info} {
 				set tags {}
 			}
 			}
+		} elseif {$is_submodule_diff} {
+			if {$line == ""} continue
+			if {[regexp {^\* } $line]} {
+				set line [string replace $line 0 1 {Submodule }]
+				set tags d_@
+			} else {
+				set op [string range $line 0 2]
+				switch -- $op {
+				{  <} {set tags d_-}
+				{  >} {set tags d_+}
+				{  W} {set tags {}}
+				default {
+					puts "error: Unhandled submodule diff marker: {$op}"
+					set tags {}
+				}
+				}
+			}
 		} else {
 			set op [string index $line 0]
 			switch -- $op {
-- 
1.6.3.3.386.g0f75a.dirty
