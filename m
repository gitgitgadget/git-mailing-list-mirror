Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25631F454
	for <e@80x24.org>; Sun,  3 Nov 2019 07:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKCHpB (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 02:45:01 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43343 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCHpB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 02:45:01 -0500
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 114D1240003;
        Sun,  3 Nov 2019 07:44:55 +0000 (UTC)
Date:   Sun, 3 Nov 2019 13:14:53 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH 2/2] git-gui: revert untracked files by deleting them
Message-ID: <20191103074453.56ubga6eitjhp6rf@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <0190f6f2f978a674a29a1e2013d00bc289851c76.1572418123.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0190f6f2f978a674a29a1e2013d00bc289851c76.1572418123.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the quality re-roll. It was a pleasant read :)

I would have suggested just handing off the paths to `git clean`, but it 
unfortunately does not do what we want it to do.

Say we have a directory 'foo' which has one file called 'bar.txt'. That 
file is untracked. Now, I expected `git clean -fd foo/bar.txt` to delete 
'bar.txt' _and_ 'foo/', but it only deletes bar.txt, and leaves 'foo/' 
intact. What's worse is that since 'foo' is an empty directory, it 
doesn't appear in git-status anymore, and so there is no way the user 
can tell the directory exists unless they go there and do a `ls`.

Maybe something to fix upstream?

On 30/10/19 06:48AM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Updates the revert_helper procedure to also detect untracked files. If

Typo: s/Updates/Update/ ?

> files are present, the user is asked if they want them deleted. A new
> proc delete_files with helper delete_helper performs the deletion in
> batches, to allow the UI to remain responsive.
> 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  lib/index.tcl | 255 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 222 insertions(+), 33 deletions(-)
> 
> diff --git a/lib/index.tcl b/lib/index.tcl
> index 28d4d2a54e..9661ddb556 100644
> --- a/lib/index.tcl
> +++ b/lib/index.tcl
> @@ -393,11 +393,20 @@ proc revert_helper {txt paths} {
>  
>  	if {![lock_index begin-update]} return
>  
> +	# The index is now locked. Some of the paths below include calls that
> +	# unlock the index (e.g. checked_index). If we reach the end and the

Typo: s/checked_index/checkout_index/

> +	# index is still locked, we need to unlock it before returning.
> +	set need_unlock_index 1
> +
>  	set path_list [list]
> +	set untracked_list [list]
>  	set after {}
>  	foreach path $paths {
>  		switch -glob -- [lindex $file_states($path) 0] {
>  		U? {continue}
> +		?O {
> +			lappend untracked_list $path
> +		}
>  		?M -
>  		?T -
>  		?D {
> @@ -409,45 +418,225 @@ proc revert_helper {txt paths} {
>  		}
>  	}
>  
> +	set path_cnt [llength $path_list]
> +	set untracked_cnt [llength $untracked_list]
>  
> -	# Split question between singular and plural cases, because
> -	# such distinction is needed in some languages. Previously, the
> -	# code used "Revert changes in" for both, but that can't work
> -	# in languages where 'in' must be combined with word from
> -	# rest of string (in different way for both cases of course).
> -	#
> -	# FIXME: Unfortunately, even that isn't enough in some languages
> -	# as they have quite complex plural-form rules. Unfortunately,
> -	# msgcat doesn't seem to support that kind of string translation.
> -	#
> -	set n [llength $path_list]
> -	if {$n == 0} {
> -		unlock_index
> -		return
> -	} elseif {$n == 1} {
> -		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
> -	} else {
> -		set query [mc "Revert changes in these %i files?" $n]
> -	}
> +	if {$path_cnt > 0} {
> +		# Split question between singular and plural cases, because
> +		# such distinction is needed in some languages. Previously, the
> +		# code used "Revert changes in" for both, but that can't work
> +		# in languages where 'in' must be combined with word from
> +		# rest of string (in different way for both cases of course).
> +		#
> +		# FIXME: Unfortunately, even that isn't enough in some languages
> +		# as they have quite complex plural-form rules. Unfortunately,
> +		# msgcat doesn't seem to support that kind of string
> +		# translation.
> +		#
> +		if {$path_cnt == 1} {
> +			set query [mc \
> +				"Revert changes in file %s?" \
> +				[short_path [lindex $path_list]] \
> +				]
> +		} else {
> +			set query [mc \
> +				"Revert changes in these %i files?" \
> +				$path_cnt]
> +		}
>  
> -	set reply [tk_dialog \
> -		.confirm_revert \
> -		"[appname] ([reponame])" \
> -		"$query
> +		set reply [tk_dialog \
> +			.confirm_revert \
> +			"[appname] ([reponame])" \
> +			"$query
>  
>  [mc "Any unstaged changes will be permanently lost by the revert."]" \
> -		question \
> -		1 \
> -		[mc "Do Nothing"] \
> -		[mc "Revert Changes"] \
> -		]
> -	if {$reply == 1} {
> -		checkout_index \
> -			$txt \
> +			question \
> +			1 \
> +			[mc "Do Nothing"] \
> +			[mc "Revert Changes"] \
> +			]
> +
> +		if {$reply == 1} {
> +			checkout_index \
> +				$txt \
> +				$path_list \
> +				[concat $after [list ui_ready]]
> +
> +			set need_unlock_index 0
> +		}
> +	}
> +
> +	if {$need_unlock_index} { unlock_index }

Are you sure you want to unlock the index _before_ the cleanup of 
untracked files is done? While it makes sense to unlock the index since 
our "clean" operation would only touch the working tree, and not the 
index, it would also mean people can do things like "Revert hunk" (from 
the context menu). Right now, this operation can not be done on 
untracked files (so this won't be a problem for now), but I do plan on 
adding this in the future, and it wouldn't be obvious from that patch's 
POV that this could be an issue. If someone does a "Revert hunk" on a 
while that is queued for deletion, there might be problems.

Also, would doing an `unlock_index` early allow people to run multiple 
"clean" jobs at the same time? Will that create race conditions that we 
aren't ready to handle?

It also makes sense to evaluate what the downsides of keeping the index 
locked are. So, does keeping the index locked prevent meaningful usage 
of git-gui, making your batched deletion pointless? Is there some reason 
for unlocking it early that I'm missing?

If we do decide keeping the index locked is a good idea, it would be 
troublesome to implement. `checkout_index` is asynchronous. So, when it 
returns, the index won't necessarily be unlocked. It would get unlocked 
some time _after_ the return. I'm not sure how to work around this.

> +
> +	if {$untracked_cnt > 0} {
> +		# Split question between singular and plural cases, because
> +		# such distinction is needed in some languages.
> +		#
> +		# FIXME: Unfortunately, even that isn't enough in some languages
> +		# as they have quite complex plural-form rules. Unfortunately,
> +		# msgcat doesn't seem to support that kind of string
> +		# translation.
> +		#
> +		if {$untracked_cnt == 1} {
> +			set query [mc \
> +				"Delete untracked file %s?" \
> +				[short_path [lindex $untracked_list]] \
> +				]
> +		} else {
> +			set query [mc \
> +				"Delete these %i untracked files?" \
> +				$untracked_cnt \
> +				]
> +		}
> +
> +		set reply [tk_dialog \
> +			.confirm_revert \
> +			"[appname] ([reponame])" \
> +			"$query
> +
> +[mc "Files will be permanently deleted."]" \
> +			question \
> +			1 \
> +			[mc "Do Nothing"] \
> +			[mc "Delete Files"] \
> +			]
> +
> +		if {$reply == 1} {
> +			delete_files $untracked_list
> +		}
> +	}
> +}
> +
> +# Delete all of the specified files, performing deletion in batches to allow the
> +# UI to remain responsive and updated.
> +proc delete_files {path_list} {
> +	# Enable progress bar status updates
> +	$::main_status start [mc "Deleting"] [mc "files"]
> +
> +	set path_index 0
> +	set deletion_errors [list]
> +	set deletion_error_path "not yet captured"
> +	set batch_size 50
> +
> +	delete_helper \
> +		$path_list \
> +		$path_index \
> +		$deletion_errors \
> +		$deletion_error_path \
> +		$batch_size
> +}
> +
> +# Helper function to delete a list of files in batches. Each call deletes one
> +# batch of files, and then schedules a call for the next batch after any UI
> +# messages have been processed.
> +proc delete_helper \
> +	{path_list path_index deletion_errors deletion_error_path batch_size} {
> +	global file_states
> +
> +	set path_cnt [llength $path_list]
> +
> +	set batch_remaining $batch_size
> +
> +	while {$batch_remaining > 0} {
> +		if {$path_index >= $path_cnt} { break }
> +
> +		set path [lindex $path_list $path_index]
> +
> +		set deletion_failed [catch {file delete -- $path} deletion_error]
> +
> +		if {$deletion_failed} {
> +			lappend deletion_errors $deletion_error
> +
> +			# Optimistically capture the path that failed, in case
> +			# there's only one.
> +			set deletion_error_path $path

I don't see why you would do this for _only_ one path. Either do it for 
every path. And since you're recording errors for each path, it makes 
sense to record the corresponding path too. Or, just count how many 
paths failed, and report that. I don't see why we'd want to be between 
those two.

> +		} else {
> +			remove_empty_directories [file dirname $path]
> +
> +			# Don't assume the deletion worked. Remove the file from
> +			# the UI, but only if it no longer exists.
> +			if {![lexists $path]} {
> +				unset file_states($path)
> +				display_file $path __
> +			}
> +		}
> +
> +		incr path_index 1
> +		incr batch_remaining -1
> +	}
> +
> +	# Update the progress bar to indicate that this batch has been
> +	# completed. The update will be visible when this procedure returns
> +	# and allows the UI thread to process messages.
> +	$::main_status update $path_index $path_cnt
> +
> +	if {$path_index < $path_cnt} {
> +		# The Tcler's Wiki lists this as the best practice for keeping
> +		# a UI active and processing messages during a long-running
> +		# operation.
> +
> +		after idle [list after 0 [list \
> +			delete_helper \
>  			$path_list \
> -			[concat $after [list ui_ready]]
> +			$path_index \
> +			$deletion_errors \
> +			$deletion_error_path \
> +			$batch_size \
> +			]]

Using `after idle` means in theory we put an undefined maximum time 
limit on the deletion process. Though I suspect in real life it would be 
a pretty short time.

Nonetheless, should you instead do this asynchronously, instead of 
waiting for the event loop to enter an idle state? This means using 
`after 0` directly, instead of doing `after idle [list after 0...`. I 
haven't tested it, but AFAIK this should also keep the UI active while 
not depending on the state of the event loop.

What benefits does your way have over just passing the entire list 
(without batching) to an async script to do processing in the 
background?

>  	} else {
> -		unlock_index
> +		# Finish the status bar operation.
> +		$::main_status stop
> +
> +		# Report error, if any, based on how many deletions failed.
> +		set deletion_error_cnt [llength $deletion_errors]
> +
> +		if {$deletion_error_cnt == 1} {
> +			error_popup [mc \
> +				"File %s could not be deleted: %s" \
> +				$deletion_error_path \
> +				[lindex $deletion_errors 0] \
> +				]
> +		} elseif {$deletion_error_cnt == $path_cnt} {
> +			error_popup [mc \
> +				"None of the selected files could be deleted." \
> +				]
> +		} elseif {$deletion_error_cnt > 1} {
> +			error_popup [mc \
> +				"%d of the selected files could not be deleted." \
> +				$deletion_error_cnt]
> +		}

The same comment as above applies here: either show error messages for 
all paths, or for none. I don't see why you want to make a single error 
path a special case.

> +
> +		reshow_diff
> +		ui_ready
> +	}
> +}
> +
> +# This function is from the TCL documentation:
> +#
> +#   https://wiki.tcl-lang.org/page/file+exists

Why include the link? My guess is "to give proper credit". Do I guess 
correctly?

> +#
> +# [file exists] returns false if the path does exist but is a symlink to a path
> +# that doesn't exist. This proc returns true if the path exists, regardless of
> +# whether it is a symlink and whether it is broken.
> +proc lexists name {

Nitpick: wrap the "name" in braces like:

  proc lexists {name} {

Also, maybe re-name it to 'path_exists'? 'lexists' is not very intuitive 
unless being used _specifically_ in the context of links. Its _use_ is 
in context of paths, even though it is used to work around links.

> +	expr {![catch {file lstat $name finfo}]}
> +}
> +
> +# Remove as many empty directories as we can starting at the specified path.

Nitpick: maybe change it to something like this?

  Remove as many empty directories as we can starting at the specified 
  path, going up in the directory tree.

It was not obvious to me from reading the comment that you were going up 
the directory tree. I thought you were going across the breadth of the 
directory, and was puzzled why you'd do that.

But maybe that's just me. So, I don't mind if you keep it the way it is 
either.

> +# If we encounter a directory that is not empty, or if a directory deletion
> +# fails, then we stop the operation and return to the caller. Even if this
> +# procedure fails to delete any directories at all, it does not report failure.
> +proc remove_empty_directories {directory_path} {
> +	set parent_path [file dirname $directory_path]
> +
> +	while {$parent_path != $directory_path} {
> +		set contents [glob -nocomplain -dir $directory_path *]
> +
> +		if {[llength $contents] > 0} { break }
> +		if {[catch {file delete -- $directory_path}]} { break }
> +
> +		set directory_path $parent_path
> +		set parent_path [file dirname $directory_path]
>  	}
>  }

I did some quick testing on my system, and it works fine. Thanks.

-- 
Regards,
Pratyush Yadav
