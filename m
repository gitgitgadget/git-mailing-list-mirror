From: pb158 <pb158@tlen.pl>
Subject: [PATCH] git-gui: add configurable tab size to the diff view
 git-gui - why not added to git-gui ?
Date: Fri, 19 Sep 2014 16:33:53 +0200
Message-ID: <lvhesi$qqs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 16:38:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUzKd-0007gp-80
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 16:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418AbaISOfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 10:35:22 -0400
Received: from plane.gmane.org ([80.91.229.3]:46246 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553AbaISOfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 10:35:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XUzH6-0006QE-OJ
	for git@vger.kernel.org; Fri, 19 Sep 2014 16:35:04 +0200
Received: from static-78-9-71-254.ssp.dialog.net.pl ([78.9.71.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 16:35:04 +0200
Received: from pb158 by static-78-9-71-254.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 16:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-9-71-254.ssp.dialog.net.pl
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:35.0) Gecko/20100101 Thunderbird/35.0a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257288>

Home of the original description and the author of the patch:

http://www.spinics.net/lists/git/msg174415.html

Why not added this useful little patch for git-gui ?

( this patch resolve my problem with 8 spaces tab Linux Eclipse + Java 
program source + git gui
and I apply locally it to each new version git before source compilation )

original content of the message from the link above:

----------------------

For Tk 8.5 the "wordprocessor" mode allows us to get a bit fancy for merge
diffs and intend the tabs by one to compensate for the additional diff
marker at the line start.

The code is heavily based on how gitk handles tabs.

Signed-off-by: Michael Lutz <michi@xxxxxxxxxxxxxx>
---
  git-gui.sh     |    1 +
  lib/diff.tcl   |   20 +++++++++++++++++++-
  lib/option.tcl |    1 +
  3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ba4e5c1..22d7665 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -892,6 +892,7 @@ set default_config(gui.fontdiff) [font configure 
font_diff]
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
+		$ui_diff configure -tabs [list [expr {$firsttab * $w}] [expr 
{($firsttab + $repo_config(gui.tabsize)) * $w}]]
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
@@ -105,6 +118,8 @@ proc show_diff {path w {lno {}} {scroll_pos {}} 
{callback {}}} {

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
  		{b gui.warndetachedcommit {mc "Warn before committing to a detached 
head"}}
  		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" 
"no" "ask"}}
+		{i-1..99 gui.tabsize {mc "Tab spacing"}}
  		} {
  		set type [lindex $option 0]
  		set name [lindex $option 1]

---------------

Regards,

Krzysztof
