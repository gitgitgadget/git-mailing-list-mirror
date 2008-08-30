From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 6/8] git-gui: Reimplement and enhance auto-selection of diffs.
Date: Sun, 31 Aug 2008 01:02:56 +0400
Organization: TEPKOM
Message-ID: <200808310102.56795.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310059.47327.angavrilov@gmail.com> <200808310100.49998.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo7-00089f-Fe
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbYH3VOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbYH3VOj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:58555 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbYH3VOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:31 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883439fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ge+whUvEQhXsOs9gKFQgwveaY6LXCMS4eZNSkoVc4sE=;
        b=Q/TdmUs3Nj1A/+NcMz7mIhAj40I1edzRttGzk1TA8JtAT4okOWlLLcOWIrlijaR8j5
         kuguBkxaMxkim6TdYyqbo9AQL9RnavpAAe65Q8s32IZC2h14i/OZ7q0urDVcq+D6RMCy
         qrr+MYJMpSOFUkzBgb90WOqiZCLkIIA0YvrB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nAX7BlmLnAti7102RdrM9W58ee0umhrQColTeFqgOv2gGk3SSRiLsqGDI3clwRe4jD
         xlZ8OYNeb4SCEM5Xlv6i34aqdsmLNNAyaRqIxLqtp/wMR4NdkRKUdpYfeBPaiIk+PnYt
         B4ahiWZQPyuhEMu8j7f0QAXMj20oWXmryS0Bo=
Received: by 10.180.241.8 with SMTP id o8mr4102934bkh.60.1220130870195;
        Sat, 30 Aug 2008 14:14:30 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:29 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310100.49998.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94431>

Generalize the next_diff system, and implement auto-reselection
for merge tool resolution and reshow_diff. Also add auto-selection
of diffs after rescan, if no diff is already selected.

New auto-select rules:

- Rescan auto-selects the first conflicting file, or if none
  a modified tracked file, if nothing was selected previously.
- Resolving a conflict auto-selects the nearest conflicting
  file, or nothing if everything is resolved.
- Staging the last remaining hunk auto-selects the nearest
  modified staged file.
- Staging a file through its icon auto-selects the nearest file.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |  122 +++++++++++++++++++++++++++++++++++++++++------------
 lib/diff.tcl      |   18 +++++---
 lib/mergetool.tcl |    8 +---
 3 files changed, 109 insertions(+), 39 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index a3000b6..f84f436 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1326,6 +1326,8 @@ proc rescan_done {fd buf after} {
 	unlock_index
 	display_all_files
 	if {$current_diff_path ne {}} reshow_diff
+	if {$current_diff_path eq {}} select_first_diff
+
 	uplevel #0 $after
 }
 
@@ -1821,7 +1823,98 @@ proc do_commit {} {
 
 proc next_diff {} {
 	global next_diff_p next_diff_w next_diff_i
-	show_diff $next_diff_p $next_diff_w $next_diff_i
+	show_diff $next_diff_p $next_diff_w {}
+}
+
+proc find_anchor_pos {lst name} {
+	set lid [lsearch -sorted -exact $lst $name]
+
+	if {$lid == -1} {
+		set lid 0
+		foreach lname $lst {
+			if {$lname >= $name} break
+			incr lid
+		}
+	}
+
+	return $lid
+}
+
+proc find_file_from {flist idx delta path mmask} {
+	global file_states
+
+	set len [llength $flist]
+	while {$idx >= 0 && $idx < $len} {
+		set name [lindex $flist $idx]
+
+		if {$name ne $path && [info exists file_states($name)]} {
+			set state [lindex $file_states($name) 0]
+
+			if {$mmask eq {} || [regexp $mmask $state]} {
+				return $idx
+			}
+		}
+
+		incr idx $delta
+	}
+
+	return {}
+}
+
+proc find_next_diff {w path {lno {}} {mmask {}}} {
+	global next_diff_p next_diff_w next_diff_i
+	global file_lists ui_index ui_workdir
+
+	set flist $file_lists($w)
+	if {$lno eq {}} {
+		set lno [find_anchor_pos $flist $path]
+	} else {
+		incr lno -1
+	}
+
+	if {$mmask ne {} && ![regexp {(^\^)|(\$$)} $mmask]} {
+		if {$w eq $ui_index} {
+			set mmask "^$mmask"
+		} else {
+			set mmask "$mmask\$"
+		}
+	}
+
+	set idx [find_file_from $flist $lno 1 $path $mmask]
+	if {$idx eq {}} {
+		incr lno -1
+		set idx [find_file_from $flist $lno -1 $path $mmask]
+	}
+
+	if {$idx ne {}} {
+		set next_diff_w $w
+		set next_diff_p [lindex $flist $idx]
+		set next_diff_i [expr {$idx+1}]
+		return 1
+	} else {
+		return 0
+	}
+}
+
+proc next_diff_after_action {w path {lno {}} {mmask {}}} {
+	global current_diff_path
+
+	if {$path ne $current_diff_path} {
+		return {}
+	} elseif {[find_next_diff $w $path $lno $mmask]} {
+		return {next_diff;}
+	} else {
+		return {reshow_diff;}
+	}
+}
+
+proc select_first_diff {} {
+	global ui_workdir
+
+	if {[find_next_diff $ui_workdir {} 1 {^_?U}] ||
+	    [find_next_diff $ui_workdir {} 1 {[^O]$}]} {
+		next_diff
+	}
 }
 
 proc toggle_or_diff {w x y} {
@@ -1851,32 +1944,7 @@ proc toggle_or_diff {w x y} {
 	}
 
 	if {$col == 0 && $y > 1} {
-		set i [expr {$lno-1}]
-		set ll [expr {[llength $file_lists($w)]-1}]
-
-		if {$i == $ll && $i == 0} {
-			set after {reshow_diff;}
-		} else {
-			global next_diff_p next_diff_w next_diff_i
-
-			set next_diff_w $w
-
-			if {$i < $ll} {
-				set i [expr {$i + 1}]
-				set next_diff_i $i
-			} else {
-				set next_diff_i $i
-				set i [expr {$i - 1}]
-			}
-
-			set next_diff_p [lindex $file_lists($w) $i]
-
-			if {$next_diff_p ne {} && $current_diff_path ne {}} {
-				set after {next_diff;}
-			} else {
-				set after {}
-			}
-		}
+		set after [next_diff_after_action $w $path $lno]
 
 		if {$w eq $ui_index} {
 			update_indexinfo \
diff --git a/lib/diff.tcl b/lib/diff.tcl
index a7fcdc6..95998b4 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -24,10 +24,16 @@ proc reshow_diff {} {
 	set p $current_diff_path
 	if {$p eq {}} {
 		# No diff is being shown.
-	} elseif {$current_diff_side eq {}
-		|| [catch {set s $file_states($p)}]
-		|| [lsearch -sorted -exact $file_lists($current_diff_side) $p] == -1} {
+	} elseif {$current_diff_side eq {}} {
 		clear_diff
+	} elseif {[catch {set s $file_states($p)}]
+		|| [lsearch -sorted -exact $file_lists($current_diff_side) $p] == -1} {
+
+		if {[find_next_diff $current_diff_side $p {} {[^O]}]} {
+			next_diff
+		} else {
+			clear_diff
+		}
 	} else {
 		set save_pos [lindex [$ui_diff yview] 0]
 		show_diff $p $current_diff_side {} $save_pos
@@ -71,6 +77,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 	}
 	if {$lno >= 1} {
 		$w tag add in_diff $lno.0 [expr {$lno + 1}].0
+		$w see $lno.0
 	}
 
 	set s $file_states($path)
@@ -366,10 +373,9 @@ proc apply_hunk {x y} {
 	}
 	unlock_index
 	display_file $current_diff_path $mi
+	# This should trigger shift to the next changed file
 	if {$o eq {_}} {
-		clear_diff
-	} else {
-		set current_diff_path $current_diff_path
+		reshow_diff
 	}
 }
 
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 5f3da1f..79c58bc 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -24,13 +24,9 @@ This operation can be undone only by restarting the merge." \
 }
 
 proc merge_add_resolution {path} {
-	global current_diff_path
+	global current_diff_path ui_workdir
 
-	if {$path eq $current_diff_path} {
-		set after {reshow_diff;}
-	} else {
-		set after {}
-	}
+	set after [next_diff_after_action $ui_workdir $path {} {^_?U}]
 
 	update_index \
 		[mc "Adding resolution for %s" [short_path $path]] \
-- 
1.6.0.20.g6148bc
