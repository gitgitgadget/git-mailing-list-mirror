From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 3/8] git-gui: Support calling merge tools.
Date: Sun, 31 Aug 2008 00:56:51 +0400
Organization: TEPKOM
Message-ID: <200808310056.51324.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310054.19732.angavrilov@gmail.com> <200808310055.45679.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo5-00089f-RN
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbYH3VOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbYH3VOe
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:59109 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbYH3VO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883449fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WY8u2KuczllfRXiuAnlv8ttFN5vA1cRSVVNi4POQf8Q=;
        b=xfnzo0fL94YqwN6bwPCOoqZxfBDDPa1Ufx27QbM/rglBflHoYtLqWqomeD03dKw8EO
         GIIxWzCfsbGNyI6dYgbG3YS15XmhrVeBl8OCa9hihBym82WEJ0cVOLqP519KNLtJEx2E
         KNBJHG5/Ugw841qAl6k6Fp9RusvDPQsybo1RI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fZyzqnYqVHB5j2CrOggErKurp76L0GWJtGaujnT50k1iHTBd6UowWDvHhTI3PTFL8D
         B1D9OmZjtD75HDFp3pLkQi0wKJqIxGoNoelPi2efp8iSKTxHO++gh18GdP2YjsK5N3co
         RQeDg063VTjEGwMG11MK/WlHy2BB5rnghSjO4=
Received: by 10.181.30.10 with SMTP id h10mr4110466bkj.41.1220130867029;
        Sat, 30 Aug 2008 14:14:27 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:26 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310055.45679.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94429>

Adds an item to the diff context menu in conflict mode,
which invokes a merge tool for the selected file. Tool
command-line handling code was ported from git-mergetool.

Automatic default tool selection and custom merge tools
are not supported. If merge.tool is not set, git-gui
defaults to meld.

This implementation uses a checkout-index hack in order
to retrieve all stages with autocrlf and filters properly
applied. It requires temporarily moving the original
conflict file out of the way.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |    7 ++
 lib/mergetool.tcl |  252 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/option.tcl    |    1 +
 3 files changed, 260 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 90d597e..8d4f715 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -657,6 +657,8 @@ proc apply_config {} {
 }
 
 set default_config(branch.autosetupmerge) true
+set default_config(merge.tool) {}
+set default_config(merge.keepbackup) true
 set default_config(merge.diffstat) true
 set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
@@ -2784,6 +2786,11 @@ create_common_diff_popup $ctxm
 set ctxmmg .vpane.lower.diff.body.ctxmmg
 menu $ctxmmg -tearoff 0
 $ctxmmg add command \
+	-label [mc "Run Merge Tool"] \
+	-command {merge_resolve_tool}
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add separator
+$ctxmmg add command \
 	-label [mc "Use Remote Version"] \
 	-command {merge_resolve_one 3}
 lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 7945d74..ba9e8ce 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -96,3 +96,255 @@ proc read_merge_stages {fd cont} {
 		eval $cont
 	}
 }
+
+proc merge_resolve_tool {} {
+	global current_diff_path
+
+	merge_load_stages $current_diff_path [list merge_resolve_tool2]
+}
+
+proc merge_resolve_tool2 {} {
+	global current_diff_path merge_stages
+
+	# Validate the stages
+	if {$merge_stages(2) eq {} ||
+	    [lindex $merge_stages(2) 0] eq {120000} ||
+	    [lindex $merge_stages(2) 0] eq {160000} ||
+	    $merge_stages(3) eq {} ||
+	    [lindex $merge_stages(3) 0] eq {120000} ||
+	    [lindex $merge_stages(3) 0] eq {160000}
+	} {
+		error_popup [mc "Cannot resolve deletion or link conflicts using a tool"]
+		return
+	}
+
+	if {![file exists $current_diff_path]} {
+		error_popup [mc "Conflict file does not exist"]
+		return
+	}
+
+	# Determine the tool to use
+	set tool [get_config merge.tool]
+	if {$tool eq {}} { set tool meld }
+
+	set merge_tool_path [get_config "mergetool.$tool.path"]
+	if {$merge_tool_path eq {}} {
+		switch -- $tool {
+		emerge { set merge_tool_path "emacs" }
+		default { set merge_tool_path $tool }
+		}
+	}
+
+	# Make file names
+	set filebase [file rootname $current_diff_path]
+	set fileext  [file extension $current_diff_path]
+	set basename [lindex [file split $current_diff_path] end]
+
+	set MERGED   $current_diff_path
+	set BASE     "./$MERGED.BASE$fileext"
+	set LOCAL    "./$MERGED.LOCAL$fileext"
+	set REMOTE   "./$MERGED.REMOTE$fileext"
+	set BACKUP   "./$MERGED.BACKUP$fileext"
+
+	set base_stage $merge_stages(1)
+
+	# Build the command line
+	switch -- $tool {
+	kdiff3 {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Base)" \
+				--L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" -o "$MERGED" "$BASE" "$LOCAL" "$REMOTE"]
+		} else {
+			set cmdline [list "$merge_tool_path" --auto --L1 "$MERGED (Local)" \
+				--L2 "$MERGED (Remote)" -o "$MERGED" "$LOCAL" "$REMOTE"]
+		}
+	}
+	tkdiff {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -a "$BASE" -o "$MERGED" "$LOCAL" "$REMOTE"]
+		} else {
+			set cmdline [list "$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"]
+		}
+	}
+	meld {
+		set cmdline [list "$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"]
+	}
+	gvimdiff {
+		set cmdline [list "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"]
+	}
+	xxdiff {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
+					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
+					    -R {Accel.Search: "Ctrl+F"} \
+					    -R {Accel.SearchForward: "Ctrl-G"} \
+					    --merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"]
+		} else {
+			set cmdline [list "$merge_tool_path" -X --show-merged-pane \
+					    -R {Accel.SaveAsMerged: "Ctrl-S"} \
+					    -R {Accel.Search: "Ctrl+F"} \
+					    -R {Accel.SearchForward: "Ctrl-G"} \
+					    --merged-file "$MERGED" "$LOCAL" "$REMOTE"]
+		}
+	}
+	opendiff {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED"]
+		}
+	}
+	ecmerge {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
+		} else {
+			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" --default --mode=merge2 --to="$MERGED"]
+		}
+	}
+	emerge {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -f emerge-files-with-ancestor-command \
+					"$LOCAL" "$REMOTE" "$BASE" "$basename"]
+		} else {
+			set cmdline [list "$merge_tool_path" -f emerge-files-command \
+					"$LOCAL" "$REMOTE" "$basename"]
+		}
+	}
+	vimdiff {
+		error_popup [mc "Not a GUI merge tool: '%s'" $tool]
+		return
+	}
+	default {
+		error_popup [mc "Unsupported merge tool '%s'" $tool]
+		return
+	}
+	}
+
+	merge_tool_start $cmdline $MERGED $BACKUP [list $BASE $LOCAL $REMOTE]
+}
+
+proc delete_temp_files {files} {
+	foreach fname $files {
+		file delete $fname
+	}
+}
+
+proc merge_tool_get_stages {target stages} {
+	global merge_stages
+
+	set i 1
+	foreach fname $stages {
+		if {$merge_stages($i) eq {}} {
+			file delete $fname
+		} else {
+			# A hack to support autocrlf properly
+			git checkout-index -f --stage=$i -- $target
+			file rename -force -- $target $fname
+		}
+		incr i
+	}
+}
+
+proc merge_tool_start {cmdline target backup stages} {
+	global merge_stages mtool_target mtool_tmpfiles mtool_fd mtool_mtime
+
+	if {[info exists mtool_fd]} {
+		if {[ask_popup [mc "Merge tool is already running, terminate it?"]] eq {yes}} {
+			catch { kill_file_process $mtool_fd }
+			catch { close $mtool_fd }
+			unset mtool_fd
+
+			set old_backup [lindex $mtool_tmpfiles end]
+			file rename -force -- $old_backup $mtool_target
+			delete_temp_files $mtool_tmpfiles
+		} else {
+			return
+		}
+	}
+
+	# Save the original file
+	file rename -force -- $target $backup
+
+	# Get the blobs; it destroys $target
+	if {[catch {merge_tool_get_stages $target $stages} err]} {
+		file rename -force -- $backup $target
+		delete_temp_files $stages
+		error_popup [mc "Error retrieving versions:\n%s" $err]
+		return
+	}
+
+	# Restore the conflict file
+	file copy -force -- $backup $target
+
+	# Initialize global state
+	set mtool_target $target
+	set mtool_mtime [file mtime $target]
+	set mtool_tmpfiles $stages
+
+	lappend mtool_tmpfiles $backup
+
+	# Force redirection to avoid interpreting output on stderr
+	# as an error, and launch the tool
+	lappend cmdline {2>@1}
+
+	if {[catch { set mtool_fd [_open_stdout_stderr $cmdline] } err]} {
+		delete_temp_files $mtool_tmpfiles
+		error_popup [mc "Could not start the merge tool:\n\n%s" $err]
+		return
+	}
+
+	ui_status [mc "Running merge tool..."]
+
+	fconfigure $mtool_fd -blocking 0 -translation binary -encoding binary
+	fileevent $mtool_fd readable [list read_mtool_output $mtool_fd]
+}
+
+proc read_mtool_output {fd} {
+	global mtool_fd mtool_tmpfiles
+
+	read $fd
+	if {[eof $fd]} {
+		unset mtool_fd
+
+		fconfigure $fd -blocking 1
+		merge_tool_finish $fd
+	}
+}
+
+proc merge_tool_finish {fd} {
+	global mtool_tmpfiles mtool_target mtool_mtime
+
+	set backup [lindex $mtool_tmpfiles end]
+	set failed 0
+
+	# Check the return code
+	if {[catch {close $fd} err]} {
+		set failed 1
+		if {$err ne {child process exited abnormally}} {
+			error_popup [strcat [mc "Merge tool failed."] "\n\n$err"]
+		}
+	}
+
+	# Check the modification time of the target file
+	if {!$failed && [file mtime $mtool_target] eq $mtool_mtime} {
+		if {[ask_popup [mc "File %s unchanged, still accept as resolved?" \
+				[short_path $mtool_target]]] ne {yes}} {
+			set failed 1
+		}
+	}
+
+	# Finish
+	if {$failed} {
+		file rename -force -- $backup $mtool_target
+		delete_temp_files $mtool_tmpfiles
+		ui_status [mc "Merge tool failed."]
+	} else {
+		if {[is_config_true merge.keepbackup]} {
+			file rename -force -- $backup "$mtool_target.orig"
+		}
+
+		delete_temp_files $mtool_tmpfiles
+
+		merge_add_resolution $mtool_target
+	}
+}
diff --git a/lib/option.tcl b/lib/option.tcl
index eb958ff..dd979e2 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -119,6 +119,7 @@ proc do_options {} {
 		{b merge.summary {mc "Summarize Merge Commits"}}
 		{i-1..5 merge.verbosity {mc "Merge Verbosity"}}
 		{b merge.diffstat {mc "Show Diffstat After Merge"}}
+		{t merge.tool {mc "Use Merge Tool"}}
 
 		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
-- 
1.6.0.20.g6148bc
