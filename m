Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BA31F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKPPLU (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 10:11:20 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60185 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKPPLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 10:11:20 -0500
X-Originating-IP: 1.186.12.29
Received: from localhost (unknown [1.186.12.29])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7011F20004;
        Sat, 16 Nov 2019 15:11:16 +0000 (UTC)
Date:   Sat, 16 Nov 2019 20:41:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v3 2/2] git-gui: revert untracked files by deleting them
Message-ID: <20191116151113.mwbaendh6lgykfw3@yadavpratyush.com>
References: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
 <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
 <dc12c1668dce875c99a45fb49ad5854a13ef4f35.1573638988.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc12c1668dce875c99a45fb49ad5854a13ef4f35.1573638988.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the re-roll.

[I removed some parts of the diff to make the reply easier to read. I am 
implicitly OK with the removed parts.]

On 13/11/19 09:56AM, Jonathan Gilbert via GitGitGadget wrote:
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
> decisions in the event of errors.
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

Looks much better!
 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui.sh    |   4 +-
>  lib/chord.tcl | 160 +++++++++++++++++++
>  lib/index.tcl | 416 ++++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 496 insertions(+), 84 deletions(-)
>  create mode 100644 lib/chord.tcl
> 
> diff --git a/lib/index.tcl b/lib/index.tcl
> index 28d4d2a54e..3ac08281c2 100644
> --- a/lib/index.tcl
> +++ b/lib/index.tcl
> @@ -7,53 +7,62 @@ proc _delete_indexlock {} {
>  	}
>  }
>  
> -proc _close_updateindex {fd after} {
> -	global use_ttk NS
> +# Returns true if the operation succeeded, false if a rescan has been initiated.
> +proc _close_updateindex_rescan_on_error {fd} {
> +	if {![catch {_close_updateindex $fd} err]} {
> +		return true
> +	} else {
> +		rescan_on_error $err
> +		return false
> +	}
> +}
> +
> +proc _close_updateindex {fd} {
>  	fconfigure $fd -blocking 1
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
> +	close $fd
> +	$::main_status stop

I didn't spot this earlier. Will this call to 'stop' interfere with the 
'start' in 'delete_files'?

> +}
>  
> -		$::main_status stop
> -		unlock_index
> -		rescan $after 0
> -		return
> -	}
> +proc rescan_on_error {err} {
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
>  
>  	$::main_status stop

Same question here.

>  	unlock_index
> -	uplevel #0 $after
> +	rescan ui_ready 0
>  }
>  
>  proc update_indexinfo {msg path_list after} {
> @@ -90,7 +99,11 @@ proc write_update_indexinfo {fd path_list total_cnt batch after} {
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		if {[_close_updateindex_rescan_on_error $fd]} {
> +			unlock_index
> +		}
> +
> +		uplevel #0 $after

This changes when $after is called. If you pass it to 'rescan', it runs 
_after_ the rescan is finished. Now it runs "in parallel" with it. Are 
you sure that is the intended behaviour? Should we just stick to passing 
$after to rescan on failure?

>  		return
>  	}
>  
> @@ -156,7 +169,11 @@ proc write_update_index {fd path_list total_cnt batch after} {
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		if {[_close_updateindex_rescan_on_error $fd]} {
> +			unlock_index
> +		}
> +
> +		uplevel #0 $after

While we're here, how about just moving this entire thing to 
'_close_updateindex_rescan_on_error', since the only two consumers of 
the function do the _exact_ same thing?

This would also allow us to pass $after to 'rescan'. It would also 
hopefully make the code a bit easier to follow because you can clearly 
see that we only unlock the index when there is no error.

Even better, unlock the index unconditionally in 
'_close_updateindex_rescan_on_error', and remove the 'unlock_index' call 
from 'rescan_on_error'. I generally prefer to keep locking/unlocking 
paths as simple as possible.

>  		return
>  	}
>  
> @@ -193,7 +210,7 @@ proc write_update_index {fd path_list total_cnt batch after} {
>  	$::main_status update $update_index_cp $total_cnt
>  }
>  
> -proc checkout_index {msg path_list after} {
> +proc checkout_index {msg path_list after capture_error} {
>  	global update_index_cp
>  
>  	if {![lock_index update]} return
> @@ -225,15 +242,21 @@ proc checkout_index {msg path_list after} {
>  		$total_cnt \
>  		$batch \
>  		$after \
> +		$capture_error \
>  		]
>  }
>  
> -proc write_checkout_index {fd path_list total_cnt batch after} {
> +proc write_checkout_index {fd path_list total_cnt batch after capture_error} {
>  	global update_index_cp
>  	global file_states current_diff_path
>  
>  	if {$update_index_cp >= $total_cnt} {
> -		_close_updateindex $fd $after
> +		if {[catch {_close_updateindex $fd} err]} {
> +			uplevel #0 $capture_error [list $err]
> +		}
> +
> +		uplevel #0 $after
> +

Nitpick: Please explicitly mention why we _don't_ want to unlock the 
index here.

There are two function very similar to this one: 'write_update_index' 
and 'write_update_indexinfo'. This subtle but important difference is 
very easy to gloss over.

>  		return
>  	}
>  

This patch is almost ready to be merged. Looking forward to the 
(hopefully) final iteration of this topic :)

-- 
Regards,
Pratyush Yadav
