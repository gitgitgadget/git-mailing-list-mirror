Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774CAC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B9C20833
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfK3XFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:05:51 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50435 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfK3XFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:50 -0500
X-Originating-IP: 157.45.220.225
Received: from localhost (unknown [157.45.220.225])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 98D32E0002;
        Sat, 30 Nov 2019 23:05:47 +0000 (UTC)
Date:   Sun, 1 Dec 2019 04:35:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v6 2/3] git-gui: update status bar to track operations
Message-ID: <20191130230543.p5xtapnx5a56arng@yadavpratyush.com>
References: <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
 <ab3d8e54c3d3d5174fe222ee77101ab3b8e9cab8.1574929833.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3d8e54c3d3d5174fe222ee77101ab3b8e9cab8.1574929833.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the re-roll.

On 28/11/19 08:30AM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Update the status bar to track updates as individual "operations" that
> can overlap. Update all call sites to interact with the new status bar
> mechanism. Update initialization to explicitly clear status text,
> since otherwise it may persist across future operations.
> 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui.sh                |  31 +++---
>  lib/blame.tcl             |  24 ++--
>  lib/checkout_op.tcl       |  15 +--
>  lib/choose_repository.tcl | 120 +++++++++++++-------
>  lib/index.tcl             |  31 ++++--
>  lib/merge.tcl             |  14 ++-
>  lib/status_bar.tcl        | 229 +++++++++++++++++++++++++++++++++-----
>  7 files changed, 354 insertions(+), 110 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 0d21f5688b..6dcf6551b6 100755
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

Nitpick: Since TclOO is introduced in patch 3 (and the commit message of 
patch 3 mentions it), this hunk should be in that patch instead.

>  } {
>  	catch {wm withdraw .}
>  	tk_messageBox \
> @@ -1797,10 +1797,10 @@ proc ui_status {msg} {
>  	}
>  }
>  
> -proc ui_ready {{test {}}} {
> +proc ui_ready {} {
>  	global main_status
>  	if {[info exists main_status]} {
> -		$main_status show [mc "Ready."] $test
> +		$main_status show [mc "Ready."]
>  	}
>  }
>  
> @@ -2150,8 +2150,6 @@ proc incr_font_size {font {amt 1}} {
>  ##
>  ## ui commands
>  
> -set starting_gitk_msg [mc "Starting gitk... please wait..."]
> -
>  proc do_gitk {revs {is_submodule false}} {
>  	global current_diff_path file_states current_diff_side ui_index
>  	global _gitdir _gitworktree
> @@ -2206,10 +2204,11 @@ proc do_gitk {revs {is_submodule false}} {
>  		set env(GIT_WORK_TREE) $_gitworktree
>  		cd $pwd
>  
> -		ui_status $::starting_gitk_msg
> -		after 10000 {
> -			ui_ready $starting_gitk_msg
> -		}
> +		set status_operation [$::main_status \
> +			start \
> +			[mc "Starting %s... please wait..." "gitk"]]
> +
> +		after 3500 [list $status_operation stop]
>  	}
>  }
>  
> @@ -2240,10 +2239,11 @@ proc do_git_gui {} {
>  		set env(GIT_WORK_TREE) $_gitworktree
>  		cd $pwd
>  
> -		ui_status $::starting_gitk_msg
> -		after 10000 {
> -			ui_ready $starting_gitk_msg
> -		}
> +		set status_operation [$::main_status \
> +			start \
> +			[mc "Starting %s... please wait..." "git-gui"]]
> +
> +		after 3500 [list $status_operation stop]
>  	}
>  }

Looks good. Thanks for the cleanup.

>  
> @@ -4159,6 +4159,9 @@ if {$picked && [is_config_true gui.autoexplore]} {
>  	do_explore
>  }
>  
> +# Clear "Initializing..." status
> +after 500 {$main_status show ""}
> +
>  # Local variables:
>  # mode: tcl
>  # indent-tabs-mode: t
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index a1aeb8b96e..bfcacd5584 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -24,6 +24,7 @@ field w_cviewer  ; # pane showing commit message
>  field finder     ; # find mini-dialog frame
>  field gotoline   ; # line goto mini-dialog frame
>  field status     ; # status mega-widget instance
> +field status_operation ; # operation displayed by status mega-widget
>  field old_height ; # last known height of $w.file_pane
>  
>  
> @@ -274,6 +275,7 @@ constructor new {i_commit i_path i_jump} {
>  	pack $w_cviewer -expand 1 -fill both
>  
>  	set status [::status_bar::new $w.status]
> +	set status_operation {}
>  
>  	menu $w.ctxm -tearoff 0
>  	$w.ctxm add command \
> @@ -602,16 +604,23 @@ method _exec_blame {cur_w cur_d options cur_s} {
>  	} else {
>  		lappend options $commit
>  	}
> +
> +	# We may recurse in from another call to _exec_blame and already have
> +	# a status operation.
> +	if {$status_operation == {}} {
> +		set status_operation [$status start \
> +			$cur_s \
> +			[mc "lines annotated"]]
> +	} else {
> +		$status_operation show $cur_s
> +	}

IIUC, in the previous version, a 'start' would reset the 
progress/"meter". But this change only resets the label, not the actual 
progress, which I think is what the caller wanted. So I think this 
should be a full re-start instead.

> +
>  	lappend options -- $path
>  	set fd [eval git_read --nice blame $options]
>  	fconfigure $fd -blocking 0 -translation lf -encoding utf-8
>  	fileevent $fd readable [cb _read_blame $fd $cur_w $cur_d]
>  	set current_fd $fd
>  	set blame_lines 0
> -
> -	$status start \
> -		$cur_s \
> -		[mc "lines annotated"]
>  }
>  
>  method _read_blame {fd cur_w cur_d} {
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index 80f5a59bbb..1ea0c9f7b8 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -9,6 +9,18 @@ field w_body      ; # Widget holding the center content
>  field w_next      ; # Next button
>  field w_quit      ; # Quit button
>  field o_cons      ; # Console object (if active)
> +
> +# Status mega-widget instance during _do_clone2 (used by _copy_files and
> +# _link_files). Widget is destroyed before _do_clone2 calls
> +# _do_clone_checkout
> +field o_status
> +
> +# Operation displayed by status mega-widget during _do_clone_checkout =>
> +# _readtree_wait => _postcheckout_wait => _do_clone_submodules =>
> +# _do_validate_submodule_cloning. The status mega-widget is a difference
> +# instance than that stored in $o_status in earlier operations.

The last sentence doesn't make a lot of sense to me. What is "earlier 
operations"? If this refers to previous versions of this file, then I 
don't think such a comment belongs here. It should be in the commit 
message instead.

> +field o_status_op
> +
>  field w_types     ; # List of type buttons in clone
>  field w_recentlist ; # Listbox containing recent repositories
>  field w_localpath  ; # Entry widget bound to local_path
> @@ -659,12 +671,12 @@ method _do_clone2 {} {
>  
>  	switch -exact -- $clone_type {
>  	hardlink {
> -		set o_cons [status_bar::two_line $w_body]
> +		set o_status [status_bar::two_line $w_body]
>  		pack $w_body -fill x -padx 10 -pady 10
>  
> -		$o_cons start \
> +		set status_op [$o_status start \
>  			[mc "Counting objects"] \
> -			[mc "buckets"]
> +			[mc "buckets"]]
>  		update
>  
>  		if {[file exists [file join $objdir info alternates]]} {
> @@ -689,6 +701,7 @@ method _do_clone2 {} {
>  			} err]} {
>  				catch {cd $pwd}
>  				_clone_failed $this [mc "Unable to copy objects/info/alternates: %s" $err]
> +				$status_op stop
>  				return
>  			}
>  		}
> @@ -700,7 +713,7 @@ method _do_clone2 {} {
>  			-directory [file join $objdir] ??]
>  		set bcnt [expr {[llength $buckets] + 2}]
>  		set bcur 1
> -		$o_cons update $bcur $bcnt
> +		$status_op update $bcur $bcnt
>  		update
>  
>  		file mkdir [file join .git objects pack]
> @@ -708,7 +721,7 @@ method _do_clone2 {} {
>  			-directory [file join $objdir pack] *] {
>  			lappend tolink [file join pack $i]
>  		}
> -		$o_cons update [incr bcur] $bcnt
> +		$status_op update [incr bcur] $bcnt
>  		update
>  
>  		foreach i $buckets {
> @@ -717,10 +730,10 @@ method _do_clone2 {} {
>  				-directory [file join $objdir $i] *] {
>  				lappend tolink [file join $i $j]
>  			}
> -			$o_cons update [incr bcur] $bcnt
> +			$status_op update [incr bcur] $bcnt
>  			update
>  		}
> -		$o_cons stop
> +		$status_op stop
>  
>  		if {$tolink eq {}} {
>  			info_popup [strcat \
> @@ -747,6 +760,8 @@ method _do_clone2 {} {
>  		if {!$i} return
>  
>  		destroy $w_body
> +
> +		set o_status {}

Should we be calling a destructor for this here? There is the '_delete' 
method in status_bar.tcl, but I don't see any usages of it so I'm not 
sure what exactly it is supposed to do.

That said, the previous version of this file doesn't call any sort of 
destructor either, so maybe we should just leave it like it is for now. 
I dunno.

>  	}
>  	full {
>  		set o_cons [console::embed \
> @@ -976,33 +1010,9 @@ method _do_clone_checkout {HEAD} {
>  	fileevent $fd readable [cb _readtree_wait $fd]
>  }
>  
> -method _do_validate_submodule_cloning {ok} {
> -	if {$ok} {
> -		$o_cons done $ok
> -		set done 1
> -	} else {
> -		_clone_failed $this [mc "Cannot clone submodules."]
> -	}
> -}
> -
> -method _do_clone_submodules {} {
> -	if {$recursive eq {true}} {
> -		destroy $w_body
> -		set o_cons [console::embed \
> -			$w_body \
> -			[mc "Cloning submodules"]]
> -		pack $w_body -fill both -expand 1 -padx 10
> -		$o_cons exec \
> -			[list git submodule update --init --recursive] \
> -			[cb _do_validate_submodule_cloning]
> -	} else {
> -		set done 1
> -	}
> -}
> -

Is there a reason for moving these two methods around? Not that its a 
bad thing, I'm just curious.

>  method _readtree_wait {fd} {
>  	set buf [read $fd]
> -	$o_cons update_meter $buf
> +	$o_status_op update_meter $buf
>  	append readtree_err $buf
>  
>  	fconfigure $fd -blocking 1

Everything other than a couple of minor comments above looks good. 
Thanks for the quality contribution. Looking forward to finally merging 
the next and final version of the series :)

-- 
Regards,
Pratyush Yadav
