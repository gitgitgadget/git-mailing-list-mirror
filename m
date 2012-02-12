From: Michael Lutz <michi@icosahedron.de>
Subject: [PATCH] git-gui: add configurable tab size to the diff view
Date: Sun, 12 Feb 2012 16:55:17 +0100
Message-ID: <1329062117-8076-1-git-send-email-michi@icosahedron.de>
Cc: git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 17:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwbwg-00088m-HU
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 17:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab2BLQGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 11:06:00 -0500
Received: from dude.icosahedron.de ([77.37.19.40]:58079 "EHLO
	mail.icosahedron.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2BLQF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 11:05:59 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Feb 2012 11:05:59 EST
Received: from localhost.localdomain (p5B0423BA.dip.t-dialin.net [91.4.35.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.icosahedron.de (Postfix) with ESMTPSA id B911864764;
	Sun, 12 Feb 2012 16:55:35 +0100 (CET)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190576>

For Tk 8.5 the "wordprocessor" mode allows us to get a bit fancy for merge
diffs and intend the tabs by one to compensate for the additional diff
marker at the line start.

The code is heavily based on how gitk handles tabs.

Signed-off-by: Michael Lutz <michi@icosahedron.de>
---
 git-gui.sh     |    1 +
 lib/diff.tcl   |   20 +++++++++++++++++++-
 lib/option.tcl |    1 +
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ba4e5c1..22d7665 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -892,6 +892,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
 set default_config(gui.warndetachedcommit) 1
+set default_config(gui.tabsize) 8
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index ec44055..f314197 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -1,6 +1,19 @@
 # git-gui diff viewer
 # Copyright (C) 2006, 2007 Shawn Pearce
 
+proc apply_tab_size {{firsttab {}}} {
+	global have_tk85 repo_config ui_diff
+
+	set w [font measure font_diff "0"]
+	if {$have_tk85 && $firsttab != 0} {
+		$ui_diff configure -tabs [list [expr {$firsttab * $w}] [expr {($firsttab + $repo_config(gui.tabsize)) * $w}]]
+	} elseif {$have_tk85 || $repo_config(gui.tabsize) != 8} {
+		$ui_diff configure -tabs [expr {$repo_config(gui.tabsize) * $w}]
+	} else {
+		$ui_diff configure -tabs {}
+	}
+}
+
 proc clear_diff {} {
 	global ui_diff current_diff_path current_diff_header
 	global ui_index ui_workdir
@@ -105,6 +118,8 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 
 	set cont_info [list $scroll_pos $callback]
 
+	apply_tab_size 0
+
 	if {[string first {U} $m] >= 0} {
 		merge_load_stages $path [list show_unmerged_diff $cont_info]
 	} elseif {$m eq {_O}} {
@@ -398,7 +413,10 @@ proc read_diff {fd conflict_size cont_info} {
 
 		# -- Automatically detect if this is a 3 way diff.
 		#
-		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
+		if {[string match {@@@ *} $line]} {
+			set is_3way_diff 1
+			apply_tab_size 1
+		}
 
 		if {$::current_diff_inheader} {
 
diff --git a/lib/option.tcl b/lib/option.tcl
index 0cf1da1..b940c44 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -159,6 +159,7 @@ proc do_options {} {
 		{c gui.encoding {mc "Default File Contents Encoding"}}
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
+		{i-1..99 gui.tabsize {mc "Tab spacing"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
-- 
1.7.5.1
