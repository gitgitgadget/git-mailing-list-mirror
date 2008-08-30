From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 8/8] git-gui: Show special diffs for complex conflict cases.
Date: Sun, 31 Aug 2008 01:05:22 +0400
Organization: TEPKOM
Message-ID: <200808310105.23106.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310102.56795.angavrilov@gmail.com> <200808310104.11048.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo8-00089f-Vk
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbYH3VOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYH3VOo
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:57628 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258AbYH3VOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883437fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2XCz0M3Ca9cQD8k1qazISCGdbwkJzuPaYDJCIWcn8DE=;
        b=qTq0LPkxMUMP6cb5takkqZl6BcKIQH0v6oEaVoN8OUxpxyCDLcWIet0yi6sUIjv9+r
         IDh3LN1/ec5oeoMsE7Q+k6tTbx7tRCB7B/8Ol3P6vNOswoVEmUVJ+/+toMWsBNJQ1TtC
         KEoStaHfIsp6e9l5MNCFo20pF4tLL/SO62n5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pku0q80vVteFmzz5g/UMFFcU9DIR0lojQT7JgaShOjo/Y5/OTZcGSqPtVuSsHtDdCY
         tKNT+5KWfMf84os5nx+T57FVdE3cOb7unJdwMpUwXdlSBHFK9flXQdP74kgiT565Dg1D
         BHdAUF4CezVsctqRCm4ddnOwD6g57qRJD+1o8=
Received: by 10.180.242.5 with SMTP id p5mr4085625bkh.76.1220130872433;
        Sat, 30 Aug 2008 14:14:32 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:31 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310104.11048.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94432>

Add special handling for displaying diffs of modified/deleted,
and symlink/mode conflicts. Currently the display is completely
unusable for deciding how to resolve the conflict.

New display modes:

1) Deleted/Modified conflict: e.g.
	LOCAL: deleted
	REMOTE:
	[diff :1:$path :3:$path]

2) Conflict involving symlinks:
	LOCAL:
	[diff :1:$path :2:$path]
	REMOTE:
	[diff :1:$path :3:$path]

In order to be able to display multiple diffs, this
patch adds a queue of commands to call.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/diff.tcl |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 95998b4..c67b020 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -65,6 +65,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 	global is_3way_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
 	global current_diff_path current_diff_side current_diff_header
+	global current_diff_queue
 
 	if {$diff_active || ![lock_index read]} return
 
@@ -82,13 +83,69 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 
 	set s $file_states($path)
 	set m [lindex $s 0]
-	set is_3way_diff 0
-	set diff_active 1
 	set current_diff_path $path
 	set current_diff_side $w
-	set current_diff_header {}
+	set current_diff_queue {}
 	ui_status [mc "Loading diff of %s..." [escape_path $path]]
 
+	if {[string first {U} $m] >= 0} {
+		merge_load_stages $path [list show_unmerged_diff $scroll_pos]
+	} elseif {$m eq {_O}} {
+		show_other_diff $path $w $m $scroll_pos
+	} else {
+		start_show_diff $scroll_pos
+	}
+}
+
+proc show_unmerged_diff {scroll_pos} {
+	global current_diff_path current_diff_side
+	global merge_stages ui_diff
+	global current_diff_queue
+
+	if {$merge_stages(2) eq {}} {
+		lappend current_diff_queue \
+			[list "LOCAL: deleted\nREMOTE:\n" d======= \
+			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
+	} elseif {$merge_stages(3) eq {}} {
+		lappend current_diff_queue \
+			[list "REMOTE: deleted\nLOCAL:\n" d======= \
+			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
+	} elseif {[lindex $merge_stages(1) 0] eq {120000}
+		|| [lindex $merge_stages(2) 0] eq {120000}
+		|| [lindex $merge_stages(3) 0] eq {120000}} {
+		lappend current_diff_queue \
+			[list "LOCAL:\n" d======= \
+			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
+		lappend current_diff_queue \
+			[list "REMOTE:\n" d======= \
+			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
+	} else {
+		start_show_diff $scroll_pos
+		return
+	}
+
+	advance_diff_queue $scroll_pos
+}
+
+proc advance_diff_queue {scroll_pos} {
+	global current_diff_queue ui_diff
+
+	set item [lindex $current_diff_queue 0]
+	set current_diff_queue [lrange $current_diff_queue 1 end]
+
+	$ui_diff conf -state normal
+	$ui_diff insert end [lindex $item 0] [lindex $item 1]
+	$ui_diff conf -state disabled
+
+	start_show_diff $scroll_pos [lindex $item 2]
+}
+
+proc show_other_diff {path w m scroll_pos} {
+	global file_states file_lists
+	global is_3way_diff diff_active repo_config
+	global ui_diff ui_index ui_workdir
+	global current_diff_path current_diff_side current_diff_header
+
 	# - Git won't give us the diff, there's nothing to compare to!
 	#
 	if {$m eq {_O}} {
@@ -167,6 +224,22 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 		ui_ready
 		return
 	}
+}
+
+proc start_show_diff {scroll_pos {add_opts {}}} {
+	global file_states file_lists
+	global is_3way_diff diff_active repo_config
+	global ui_diff ui_index ui_workdir
+	global current_diff_path current_diff_side current_diff_header
+
+	set path $current_diff_path
+	set w $current_diff_side
+
+	set s $file_states($path)
+	set m [lindex $s 0]
+	set is_3way_diff 0
+	set diff_active 1
+	set current_diff_header {}
 
 	set cmd [list]
 	if {$w eq $ui_index} {
@@ -188,8 +261,12 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 	if {$w eq $ui_index} {
 		lappend cmd [PARENT]
 	}
-	lappend cmd --
-	lappend cmd $path
+	if {$add_opts ne {}} {
+		eval lappend cmd $add_opts
+	} else {
+		lappend cmd --
+		lappend cmd $path
+	}
 
 	if {[catch {set fd [eval git_read --nice $cmd]} err]} {
 		set diff_active 0
@@ -209,6 +286,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 proc read_diff {fd scroll_pos} {
 	global ui_diff diff_active
 	global is_3way_diff current_diff_header
+	global current_diff_queue
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -293,6 +371,12 @@ proc read_diff {fd scroll_pos} {
 
 	if {[eof $fd]} {
 		close $fd
+
+		if {$current_diff_queue ne {}} {
+			advance_diff_queue $scroll_pos
+			return
+		}
+
 		set diff_active 0
 		unlock_index
 		if {$scroll_pos ne {}} {
-- 
1.6.0.20.g6148bc
