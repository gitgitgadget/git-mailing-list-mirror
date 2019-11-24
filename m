Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD20C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17EB2073F
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKXNJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 08:09:55 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52053 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfKXNJz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 08:09:55 -0500
X-Originating-IP: 157.45.116.58
Received: from localhost (unknown [157.45.116.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 02B9E240002;
        Sun, 24 Nov 2019 13:09:49 +0000 (UTC)
Date:   Sun, 24 Nov 2019 18:39:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v4 2/2] git-gui: revert untracked files by deleting them
Message-ID: <20191124130845.eawt4hg73hth2uro@yadavpratyush.com>
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
 <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
 <23d4f5d829cb705441394186d274620b46bae8fb.1573973770.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d4f5d829cb705441394186d274620b46bae8fb.1573973770.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the re-roll. Sorry for taking so long to review. I couldn't 
find too much free time past few days.

On 17/11/19 06:56AM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Update the revert_helper proc to check for untracked files as well as
> changes, and then handle changes to be reverted and untracked files with
> independent blocks of code. Prompt the user independently for untracked
> files, since the underlying action is fundamentally different (rm -f).
> If after deleting untracked files, the directory containing them becomes
> empty, then remove the directory as well. Migrate unlocking of the index
> out of _close_updateindex to a responsibility of the caller, to permit
> paths that don't directly unlock the index, and refactor the error
> handling added in d4e890e5 so that callers can make flow control
> decisions in the event of errors. Rework status_bar to explicitly handle
> multiple overlapping operations, and update all call sites.
> 
> A new proc delete_files takes care of actually deleting the files in
> batches, using the Tcler's Wiki recommended approach for keeping the UI
> responsive.
> 
> Since the checkout_index and delete_files calls are both asynchronous
> and could potentially complete in any order, a "chord" is used to
> coordinate unlocking the index and returning the UI to a usable state
> only after both operations are complete. The `SimpleChord` class,
> based on TclOO (Tcl/Tk 8.6), is added in this commit.
> 
> Since the checkout_index and delete_files calls are both asynchronous
> and overlap, they clash in wanting to update the status bar. This commit
> reworks the status bar so that when an operation wants to display
> ongoing updates/progress, it explicitly starts an "operation", which is
> tracked by its own object, and the status bar handles multiple
> concurrent operations by merging their progress and concatenating their
> text.

The status bar is a major change, so I think it should be in a separate 
commit. That would make it easier to debug it when bisecting, and to 
revert it in case we discover a bug later.

Unfortunately, this change breaks things. The users of 'status_bar' that 
aren't updated don't work. As an example, if I run 'git gui blame 
git-gui.sh' with your patch applied, I get the following error:

  invalid command name "::status_bar::update"
  invalid command name "::status_bar::update"
      while executing
  "::status_bar::update ::status_bar::__o1::__d 5 4169"
      ("eval" body line 1)
      invoked from within
  "eval [list ::status_bar::$name ::status_bar::__o1::__d] $args"
      (procedure "::status_bar::__o1::__d" line 1)
      invoked from within
  "$status update $blame_lines [set ${__this}::total_lines]"
      (procedure "blame::_read_blame" line 184)
      invoked from within
  "blame::_read_blame ::blame::__o1::__d file7 .file_pane.out.asimple_t ::blame::__o1::asim_data"

This error is raised because of lib/blame.tcl:812, and causes blame to 
not annotate lines properly, which is the entire reason to use blame.

Another caller that would probably break is 'lib/choose_repository.tcl'. 
These are the only two broken callsites I can spot after some quick 
looking around.

Are there any other backward-compatibility breaking changes to 
status_bar? I have a feeling that this changeset is already getting a 
bit too large in scope. Maybe we should figure out a simpler compromise 
instead of making a huge re-work like this.

If the existing callsites can be updated without much trouble, then its 
fine. Otherwise, maybe reducing the scope of this change would be a 
better idea.

Either way, please split the status bar refactor in a separate commit 
such that the entire system still works properly (so this means the 
commit would include updating the existing callsites).
 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui.sh          |   7 +-
>  lib/checkout_op.tcl |  15 +-
>  lib/chord.tcl       | 160 ++++++++++++++++
>  lib/index.tcl       | 443 +++++++++++++++++++++++++++++++++++---------
>  lib/merge.tcl       |  14 +-
>  lib/status_bar.tcl  | 221 +++++++++++++++++++---
>  6 files changed, 734 insertions(+), 126 deletions(-)
>  create mode 100644 lib/chord.tcl
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 0d21f5688b..dc4ac577ac 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -30,8 +30,8 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.}]
>  ##
>  ## Tcl/Tk sanity check
>  
> -if {[catch {package require Tcl 8.4} err]
> - || [catch {package require Tk  8.4} err]
> +if {[catch {package require Tcl 8.6} err]
> + || [catch {package require Tk  8.6} err]
>  } {
>  	catch {wm withdraw .}
>  	tk_messageBox \
> @@ -4159,6 +4159,9 @@ if {$picked && [is_config_true gui.autoexplore]} {
>  	do_explore
>  }
>  
> +# Clear "Initializing..." status
> +after idle {after 500 {$main_status show ""}}

Why put this in an 'after idle'? What's wrong with just 'after 500'? 
This is not an expensive operation so we shouldn't really require the 
application to be idle to run it.

> +
>  # Local variables:
>  # mode: tcl
>  # indent-tabs-mode: t
> diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
> index a5228297db..21ea768d80 100644
> --- a/lib/checkout_op.tcl
> +++ b/lib/checkout_op.tcl
> @@ -341,9 +341,9 @@ method _readtree {} {
>  	global HEAD
>  
>  	set readtree_d {}
> -	$::main_status start \
> +	set status_bar_operation [$::main_status start \
>  		[mc "Updating working directory to '%s'..." [_name $this]] \
> -		[mc "files checked out"]
> +		[mc "files checked out"]]
>  
>  	set fd [git_read --stderr read-tree \
>  		-m \
> @@ -354,26 +354,27 @@ method _readtree {} {
>  		$new_hash \
>  		]
>  	fconfigure $fd -blocking 0 -translation binary
> -	fileevent $fd readable [cb _readtree_wait $fd]
> +	fileevent $fd readable [cb _readtree_wait $fd $status_bar_operation]
>  }
>  
> -method _readtree_wait {fd} {
> +method _readtree_wait {fd status_bar_operation} {
>  	global current_branch
>  
>  	set buf [read $fd]
> -	$::main_status update_meter $buf
> +	$status_bar_operation update_meter $buf
>  	append readtree_d $buf
>  
>  	fconfigure $fd -blocking 1
>  	if {![eof $fd]} {
>  		fconfigure $fd -blocking 0
> +		$status_bar_operation stop
>  		return
>  	}
>  
>  	if {[catch {close $fd}]} {
>  		set err $readtree_d
>  		regsub {^fatal: } $err {} err
> -		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
> +		$status_bar_operation stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
>  		warn_popup [strcat [mc "File level merge required."] "
>  
>  $err
> @@ -384,7 +385,7 @@ $err
>  		return
>  	}
>  
> -	$::main_status stop
> +	$status_bar_operation stop
>  	_after_readtree $this
>  }
>  
> diff --git a/lib/index.tcl b/lib/index.tcl
> index 28d4d2a54e..8d7590241e 100644
> --- a/lib/index.tcl
> +++ b/lib/index.tcl
> @@ -7,53 +7,63 @@ proc _delete_indexlock {} {
>  	}
>  }
>  
> -proc _close_updateindex {fd after} {
> -	global use_ttk NS
> -	fconfigure $fd -blocking 1
> -	if {[catch {close $fd} err]} {
> -		set w .indexfried
> -		Dialog $w
> -		wm withdraw $w
> -		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
> -		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
> -		set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
> -		text $w.msg -yscrollcommand [list $w.vs set] \
> -			-width [string length $s] -relief flat \
> -			-borderwidth 0 -highlightthickness 0 \
> -			-background [get_bg_color $w]
> -		$w.msg tag configure bold -font font_uibold -justify center
> -		${NS}::scrollbar $w.vs -command [list $w.msg yview]
> -		$w.msg insert end $s bold \n\n$err {}
> -		$w.msg configure -state disabled
> -
> -		${NS}::button $w.continue \
> -			-text [mc "Continue"] \
> -			-command [list destroy $w]
> -		${NS}::button $w.unlock \
> -			-text [mc "Unlock Index"] \
> -			-command "destroy $w; _delete_indexlock"
> -		grid $w.msg - $w.vs -sticky news
> -		grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
> -		grid columnconfigure $w 0 -weight 1
> -		grid rowconfigure $w 0 -weight 1
> -
> -		wm protocol $w WM_DELETE_WINDOW update
> -		bind $w.continue <Visibility> "
> -			grab $w
> -			focus %W
> -		"
> -		wm deiconify $w
> -		tkwait window $w
> -
> -		$::main_status stop
> +# Returns true if the operation succeeded, false if a rescan has been initiated.
> +proc close_and_unlock_updateindex_rescan_on_error {fd after} {

Nitpick: That name is a bit too unwieldy. Maybe something a bit more 
concise like 'close_and_unlock_index' (I'm not great at naming things. 
Maybe you can figure out something better)? Let the readers figure out 
what happens on error.

> +	if {![catch {_close_updateindex $fd} err]} {
>  		unlock_index
> -		rescan $after 0
> -		return
> +		uplevel #0 $after
> +		return 1
> +	} else {
> +		rescan_on_error $err $after
> +		return 0

Neither of the two callers use the return value. Are these really 
needed?

>  	}
> +}
>  
> -	$::main_status stop
> +proc _close_updateindex {fd} {
> +	fconfigure $fd -blocking 1
> +	close $fd
> +}
> +
> +proc rescan_on_error {err {after {}}} {
> +	global use_ttk NS
> +
> +	set w .indexfried
> +	Dialog $w
> +	wm withdraw $w
> +	wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
> +	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
> +	set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
> +	text $w.msg -yscrollcommand [list $w.vs set] \
> +		-width [string length $s] -relief flat \
> +		-borderwidth 0 -highlightthickness 0 \
> +		-background [get_bg_color $w]
> +	$w.msg tag configure bold -font font_uibold -justify center
> +	${NS}::scrollbar $w.vs -command [list $w.msg yview]
> +	$w.msg insert end $s bold \n\n$err {}
> +	$w.msg configure -state disabled
> +
> +	${NS}::button $w.continue \
> +		-text [mc "Continue"] \
> +		-command [list destroy $w]
> +	${NS}::button $w.unlock \
> +		-text [mc "Unlock Index"] \
> +		-command "destroy $w; _delete_indexlock"
> +	grid $w.msg - $w.vs -sticky news
> +	grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
> +	grid columnconfigure $w 0 -weight 1
> +	grid rowconfigure $w 0 -weight 1
> +
> +	wm protocol $w WM_DELETE_WINDOW update
> +	bind $w.continue <Visibility> "
> +		grab $w
> +		focus %W
> +	"
> +	wm deiconify $w
> +	tkwait window $w
> +
> +	$::main_status stop_all
>  	unlock_index
> -	uplevel #0 $after
> +	rescan [concat $after [list ui_ready]] 0
>  }
>  
>  proc update_indexinfo {msg path_list after} {
> @@ -67,7 +77,7 @@ proc update_indexinfo {msg path_list after} {
>  	set batch [expr {int($total_cnt * .01) + 1}]
>  	if {$batch > 25} {set batch 25}
>  
> -	$::main_status start $msg [mc "files"]
> +	set status_bar_operation [$::main_status start $msg [mc "files"]]
>  	set fd [git_write update-index -z --index-info]
>  	fconfigure $fd \
>  		-blocking 0 \
> @@ -81,16 +91,19 @@ proc update_indexinfo {msg path_list after} {
>  		$path_list \
>  		$total_cnt \
>  		$batch \
> +		$status_bar_operation \
>  		$after \
>  		]
>  }
>  
> -proc write_update_indexinfo {fd path_list total_cnt batch after} {
> +proc write_update_indexinfo {fd path_list total_cnt batch status_bar_operation \
> +	after} {
>  	global update_index_cp
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		$status_bar_operation stop
> +		close_and_unlock_updateindex_rescan_on_error $fd $after
>  		return
>  	}
>  
> @@ -119,7 +132,7 @@ proc write_update_indexinfo {fd path_list total_cnt batch after} {
>  		display_file $path $new
>  	}
>  
> -	$::main_status update $update_index_cp $total_cnt
> +	$status_bar_operation update $update_index_cp $total_cnt
>  }
>  
>  proc update_index {msg path_list after} {
> @@ -133,7 +146,7 @@ proc update_index {msg path_list after} {
>  	set batch [expr {int($total_cnt * .01) + 1}]
>  	if {$batch > 25} {set batch 25}
>  
> -	$::main_status start $msg [mc "files"]
> +	set status_bar_operation [$::main_status start $msg [mc "files"]]
>  	set fd [git_write update-index --add --remove -z --stdin]
>  	fconfigure $fd \
>  		-blocking 0 \
> @@ -147,16 +160,19 @@ proc update_index {msg path_list after} {
>  		$path_list \
>  		$total_cnt \
>  		$batch \
> +		$status_bar_operation \
>  		$after \
>  		]
>  }
>  
> -proc write_update_index {fd path_list total_cnt batch after} {
> +proc write_update_index {fd path_list total_cnt batch status_bar_operation \
> +	after} {
>  	global update_index_cp
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		$status_bar_operation stop
> +		close_and_unlock_updateindex_rescan_on_error $fd $after
>  		return
>  	}
>  
> @@ -190,10 +206,10 @@ proc write_update_index {fd path_list total_cnt batch after} {
>  		display_file $path $new
>  	}
>  
> -	$::main_status update $update_index_cp $total_cnt
> +	$status_bar_operation update $update_index_cp $total_cnt
>  }
>  
> -proc checkout_index {msg path_list after} {
> +proc checkout_index {msg path_list after capture_error} {
>  	global update_index_cp
>  
>  	if {![lock_index update]} return
> @@ -204,7 +220,7 @@ proc checkout_index {msg path_list after} {
>  	set batch [expr {int($total_cnt * .01) + 1}]
>  	if {$batch > 25} {set batch 25}
>  
> -	$::main_status start $msg [mc "files"]
> +	set status_bar_operation [$::main_status start $msg [mc "files"]]
>  	set fd [git_write checkout-index \
>  		--index \
>  		--quiet \
> @@ -224,16 +240,26 @@ proc checkout_index {msg path_list after} {
>  		$path_list \
>  		$total_cnt \
>  		$batch \
> +		$status_bar_operation \
>  		$after \
> +		$capture_error \
>  		]
>  }
>  
> -proc write_checkout_index {fd path_list total_cnt batch after} {
> +proc write_checkout_index {fd path_list total_cnt batch status_bar_operation \
> +	after capture_error} {
>  	global update_index_cp
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		$status_bar_operation stop
> +
> +		if {[catch {_close_updateindex $fd} err]} {

Nitpick: Please mention exactly why we don't use 
'close_and_unlock_updateindex_rescan_on_error' (or whatever its new name 
would be) here. This function is very similar to 'write_update_index' 
and 'write_checkout_index', so this subtle difference is not very easily 
apparent.

> +			uplevel #0 $capture_error [list $err]
> +		}
> +
> +		uplevel #0 $after
> +
>  		return
>  	}
>  
> diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
> index 02111a1742..6a73988b23 100644
> --- a/lib/status_bar.tcl
> +++ b/lib/status_bar.tcl
> @@ -1,16 +1,42 @@
>  # git-gui status bar mega-widget
>  # Copyright (C) 2007 Shawn Pearce
>  
> +# The status_bar class manages the entire status bar. It is possible for
> +# multiple overlapping asynchronous operations to want to display status
> +# simultaneously. Each one receives a status_bar_operation when it calls the
> +# start method, and the status bar combines all active operations into the
> +# line of text it displays. Most of the time, there will be at most one
> +# ongoing operation.
> +#
> +# Note that the entire status bar can be either in single-line or two-line
> +# mode, depending on the constructor. Multiple active operations are only
> +# supported for single-line status bars.
> +
>  class status_bar {
>  
> +field allow_multiple ; # configured at construction
> +
>  field w         ; # our own window path
>  field w_l       ; # text widget we draw messages into
>  field w_c       ; # canvas we draw a progress bar into
>  field c_pack    ; # script to pack the canvas with
> -field status  {}; # single line of text we show

The field 'status' is removed, but the procedure 'show' still uses it. 
The if condition needs to be refactored.

> -field prefix  {}; # text we format into status
> -field units   {}; # unit of progress
> -field meter   {}; # current core git progress meter (if active)
> +
> +field baseline_text   ; # text to show if there are no operations
> +field status_bar_text ; # combined text for all operations
> +
> +field operations ; # list of current ongoing operations
> +
> +# The status bar can display a progress bar, updated when consumers call the
> +# update method on their status_bar_operation. When there are multiple
> +# operations, the status bar shows the combined status of all operations.
> +#
> +# When an overlapping operation completes, the progress bar is going to
> +# abruptly have one fewer operation in the calculation, causing a discontinuity.
> +# Therefore, whenever an operation completes, if it is not the last operation,
> +# this counter is increased, and the progress bar is calculated as though there
> +# were still another operation at 100%. When the last operation completes, this
> +# is reset to 0.
> +field completed_operation_count
>  
>  constructor new {path} {
>  	global use_ttk NS
> @@ -18,12 +44,19 @@ constructor new {path} {
>  	set w_l $w.l
>  	set w_c $w.c
>  
> +	# Standard single-line status bar: Permit overlapping operations
> +	set allow_multiple 1
> +
> +	set baseline_text ""
> +	set operations [list]
> +	set completed_operation_count 0
> +
>  	${NS}::frame $w
>  	if {!$use_ttk} {
>  		$w configure -borderwidth 1 -relief sunken
>  	}
>  	${NS}::label $w_l \
> -		-textvariable @status \
> +		-textvariable @status_bar_text \
>  		-anchor w \
>  		-justify left
>  	pack $w_l -side left
> @@ -44,9 +77,15 @@ constructor two_line {path} {
>  	set w_l $w.l
>  	set w_c $w.c
>  
> +	# Two-line status bar: Only one ongoing operation permitted.
> +	set allow_multiple 0
> +
> +	set baseline_text ""
> +	set operations [list]
> +
>  	${NS}::frame $w
>  	${NS}::label $w_l \
> -		-textvariable @status \
> +		-textvariable @status_bar_text \
>  		-anchor w \
>  		-justify left
>  	pack $w_l -anchor w -fill x
> @@ -56,7 +95,7 @@ constructor two_line {path} {
>  	return $this
>  }
>  
> -method start {msg uds} {
> +method ensure_canvas {} {
>  	if {[winfo exists $w_c]} {
>  		$w_c coords bar 0 0 0 20
>  	} else {
> @@ -68,31 +107,169 @@ method start {msg uds} {
>  		$w_c create rectangle 0 0 0 20 -tags bar -fill navy
>  		eval $c_pack
>  	}
> +}
> +
> +method show {msg {test {}}} {
> +	if {$test eq {} || $status eq $test} {
> +		$this ensure_canvas
> +		set baseline_text $msg
> +		$this refresh
> +	}
> +}
> +
> +method start {msg uds} {
> +	set baseline_text ""
> +
> +	if {!$allow_multiple && [llength $operations]} {

This silently ignores multiple 'start's on a status bar that doesn't 
allow it, correct?

> +		return [lindex $operations 0]
> +	}
> +
> +	$this ensure_canvas
> +
> +	set operation [status_bar_operation::new $this $msg $uds]
> +
> +	lappend operations $operation
> +
> +	$this refresh
> +
> +	return $operation
> +}
> +
> +method refresh {} {
> +	set new_text ""
> +
> +	set total [expr $completed_operation_count * 100]
> +	set have $total
> +
> +	foreach operation $operations {
> +		if {$new_text != ""} {
> +			append new_text " / "
> +		}
> +
> +		append new_text [$operation get_status]
> +
> +		set total [expr $total + 100]
> +		set have [expr $have + [$operation get_progress]]
> +	}
> +
> +	if {$new_text == ""} {
> +		set new_text $baseline_text
> +	}
> +
> +	set status_bar_text $new_text
> +
> +	set pixel_width 0
> +	if {$have > 0} {
> +		set pixel_width [expr {[winfo width $w_c] * $have / $total}]
> +	}
> +
> +	$w_c coords bar 0 0 $pixel_width 20
> +}
> +
> +method stop {operation stop_msg} {
> +	set idx [lsearch $operations $operation]
> +
> +	if {$idx >= 0} {
> +		set operations [lreplace $operations $idx $idx]
> +		set completed_operation_count [expr \
> +			$completed_operation_count + 1]
> +
> +		if {[llength operations] == 0} {
> +			set completed_operation_count 0
> +
> +			destroy $w_c
> +			if {$stop_msg ne {}} {
> +				set baseline_text $stop_msg
> +			}
> +		}
> +
> +		$this refresh
> +	}
> +}
> +
> +method stop_all {{stop_msg {}}} {
> +	set operations_copy $operations
> +	set operations [list] # This makes the operation's call to stop a no-op.
> +
> +	foreach $operation operations_copy {
> +		$operation stop
> +	}
> +
> +	if {$stop_msg ne {}} {
> +		set baseline_text $stop_msg
> +	}
> +
> +	$this refresh
> +}
> +
> +method _delete {current} {
> +	if {$current eq $w} {
> +		delete_this
> +	}
> +}
> +
> +}
> +
> +# The status_bar_operation class tracks a single consumer's ongoing status bar
> +# activity, with the context that there are a few situations where multiple
> +# overlapping asynchronous operations might want to display status information
> +# simultaneously. Instances of status_bar_operation are created by calling
> +# start on the status_bar, and when the caller is done with its stauts bar
> +# operation, it calls stop on the operation.
> +
> +class status_bar_operation {
> +
> +field status_bar; # reference back to the status_bar that owns this object
> +
> +field is_active;
> +
> +field status   {}; # single line of text we show
> +field progress {}; # current progress (0 to 100)
> +field prefix   {}; # text we format into status
> +field units    {}; # unit of progress
> +field meter    {}; # current core git progress meter (if active)
> +
> +constructor new {owner msg uds} {
> +	set status_bar $owner
>  
>  	set status $msg
> +	set progress 0
>  	set prefix $msg
>  	set units  $uds
>  	set meter  {}
> +
> +	set is_active 1
> +
> +	return $this
>  }
>  
> +method get_is_active {} { return $is_active }
> +method get_status {} { return $status }
> +method get_progress {} { return $progress }
> +
>  method update {have total} {
> -	set pdone 0
> -	set cdone 0
> +	if {!$is_active} { return }
> +
> +	set progress 0
> +
>  	if {$total > 0} {
> -		set pdone [expr {100 * $have / $total}]
> -		set cdone [expr {[winfo width $w_c] * $have / $total}]
> +		set progress [expr {100 * $have / $total}]
>  	}
>  
>  	set prec [string length [format %i $total]]
> +
>  	set status [mc "%s ... %*i of %*i %s (%3i%%)" \
>  		$prefix \
>  		$prec $have \
>  		$prec $total \
> -		$units $pdone]
> -	$w_c coords bar 0 0 $cdone 20
> +		$units $progress]
> +
> +	$status_bar refresh
>  }
>  
>  method update_meter {buf} {
> +	if {!$is_active} { return }
> +
>  	append meter $buf
>  	set r [string last "\r" $meter]
>  	if {$r == -1} {
> @@ -109,23 +286,25 @@ method update_meter {buf} {
>  	}
>  }
>  
> -method stop {{msg {}}} {
> -	destroy $w_c
> -	if {$msg ne {}} {
> -		set status $msg
> +method stop {{stop_msg {}}} {
> +	if {$is_active} {
> +		set is_active 0
> +		$status_bar stop $this $stop_msg
>  	}
>  }
>  
>  method show {msg {test {}}} {
> +	if {!$is_active} { return }
> +
>  	if {$test eq {} || $status eq $test} {
>  		set status $msg
> +		$status_bar refresh
>  	}
>  }
>  
> -method _delete {current} {
> -	if {$current eq $w} {
> -		delete_this
> -	}
> +method _delete {} {
> +	stop
> +	delete_this
>  }
>  
>  }

One quick question: the consumers of status_bar who don't run multiple 
operations in parallel would still continue working exactly the same 
(after refactoring them to use 'status_bar_operation'), right?

Works fine on some quick testing, though I haven't done anything too 
thorough. Thanks.

-- 
Regards,
Pratyush Yadav
