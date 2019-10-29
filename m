Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF621F4C1
	for <e@80x24.org>; Tue, 29 Oct 2019 21:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfJ2V1l (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 17:27:41 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46413 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2V1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 17:27:41 -0400
X-Originating-IP: 1.186.12.13
Received: from localhost (unknown [1.186.12.13])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C8853C0002;
        Tue, 29 Oct 2019 21:27:36 +0000 (UTC)
Date:   Wed, 30 Oct 2019 02:57:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH 1/1] git-gui: Revert untracked files by deleting them
Message-ID: <20191029212734.luledidagh7dnx5y@yadavpratyush.com>
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
 <56faba848676ffc5441f373bc2105392fc2a3e11.1572289087.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56faba848676ffc5441f373bc2105392fc2a3e11.1572289087.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the patch.

While git-gui is distributed in the main Git tree, the development 
happens on a separate repo, and the Git maintainer periodically pulls in 
changes from that repo. It can be found at [0]. For now, I munged your 
patch to apply on my tree, but please base it on the git-gui repo for 
your re-rolls or future patches. You can use GitGitGadget to do that 
[1].

Now, on to the patch.

Nitpick: Do not use a capital letter after 'git-gui:' in your subject. 
So the subject should look something like:

  git-gui: revert untracked files by deleting them

On 28/10/19 06:58PM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> My development environment sometimes makes automatic changes
> that I don't want to keep. In some cases, this involves new
> files being added that I don't want to commit or keep. I have
> typically had to explicitly delete those files externally to
> Git Gui, and I want to be able to just select those newly-
> created untracked files and "revert" them into oblivion.

I think the description of your workflow belongs in the cover letter 
more than here. The commit message should take a more neutral tone. So, 
describe the problem in an objective way that not only you, but other 
git-gui users might face.
 
> This change updates the revert_helper function to check for
> untracked files as well as changes, and then any changes to be
> reverted and untracked files are handled by independent
> blocks of code. The user is prompted independently for
> untracked files, since the underlying action is fundamentally
> different (rm -f). If after deleting untracked files, the
> directory containing them becomes empty, then the directory is
> removed as well.
> 
> This introduces new strings in index.tcl. I have been told that
> there is a separate process whereby the translations get updated.

I don't think this should be in the commit message. The commit message 
describes the change. The process of getting that change integrated 
should be discussed elsewhere (elsewhere == this list). But yes, there 
is a separate process to update translations (but unfortunately no one 
is actively doing that yet).
 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 104 insertions(+), 35 deletions(-)
> 
> diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
> index e07b7a3762..cc1b651d56 100644
> --- a/git-gui/lib/index.tcl
> +++ b/git-gui/lib/index.tcl
> @@ -393,11 +393,24 @@ proc revert_helper {txt paths} {
>  
>  	if {![lock_index begin-update]} return
>  
> +	# If an action is taken that implicitly unlocks the index, this gets cleared. Either way, it is executed at the end of the procedure.

The convention is to wrap lines at 80 columns wherever possible. Please 
follow that. You can look at the rest of the code for examples.

You have other lines too that are too long. The same comment applies to 
all those.

> +	set epilogue [list]
> +	lappend epilogue {unlock_index}
> +
> +	proc already_unlocked {} { upvar epilogue epilogue; set epilogue [lsearch -inline -all -not -exact $epilogue {unlock_index}] }

A procedure defined inside a procedure? Please don't do that. Define it 
outside.

Also, what is this procedure supposed to do? It is not very clear at 
first read.

> +
>  	set pathList [list]
> +	set untrackedList [list]

Nitpick: Ugh! camelCase in a sea of snake_cases. What's even more 
unfortunate is that `pathList` itself is in camelCase, so that's 
probably the reason you went with camelCase in the first place. Maybe 
re-name `pathList` to `path_list` while we're at it, and then use 
snake_case everywhere?

>  	set after {}
>  	foreach path $paths {
>  		switch -glob -- [lindex $file_states($path) 0] {
>  		U? {continue}
> +		?O {
> +			lappend untrackedList $path
> +			if {$path eq $current_diff_path} {
> +				set after {reshow_diff;}
> +			}
> +		}
>  		?M -
>  		?T -
>  		?D {
> @@ -410,45 +423,101 @@ proc revert_helper {txt paths} {
>  	}
>  
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
> -	set n [llength $pathList]
> -	if {$n == 0} {
> -		unlock_index
> -		return
> -	} elseif {$n == 1} {
> -		set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
> -	} else {
> -		set query [mc "Revert changes in these %i files?" $n]
> -	}
> +	set numPaths [llength $pathList]
> +	set numUntracked [llength $untrackedList]
>  
> -	set reply [tk_dialog \
> -		.confirm_revert \
> -		"[appname] ([reponame])" \
> -		"$query
> +	if {$numPaths > 0} {
> +		# Split question between singular and plural cases, because
> +		# such distinction is needed in some languages. Previously, the
> +		# code used "Revert changes in" for both, but that can't work
> +		# in languages where 'in' must be combined with word from
> +		# rest of string (in different way for both cases of course).
> +		#
> +		# FIXME: Unfortunately, even that isn't enough in some languages
> +		# as they have quite complex plural-form rules. Unfortunately,
> +		# msgcat doesn't seem to support that kind of string translation.
> +		if {$numPaths == 1} {
> +			set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
> +		} else {
> +			set query [mc "Revert changes in these %i files?" $numPaths]
> +		}
> +
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
> -			$pathList \
> -			[concat $after [list ui_ready]]
> -	} else {
> -		unlock_index
> +			question \
> +			1 \
> +			[mc "Do Nothing"] \
> +			[mc "Revert Changes"] \
> +			]
> +
> +		if {$reply == 1} {
> +			checkout_index \
> +				$txt \
> +				$pathList \
> +				[concat $after [list ui_ready]]
> +
> +			already_unlocked
> +		}
> +	}
> +
> +	if {$numUntracked > 0} {
> +		# Split question between singular and plural cases, because
> +		# such distinction is needed in some languages.
> +		#
> +		# FIXME: Unfortunately, even that isn't enough in some languages
> +		# as they have quite complex plural-form rules. Unfortunately,
> +		# msgcat doesn't seem to support that kind of string translation.
> +		if {$numUntracked == 1} {
> +			set query [mc "Delete untracked file %s?" [short_path [lindex $untrackedList]]]
> +		} else {
> +			set query [mc "Delete these %i untracked files?" $numUntracked]
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
> +			file delete -- {*}$untrackedList
> +
> +			foreach path $untrackedList {
> +				set directoryPath [file dirname $path]
> +
> +				while {$directoryPath != $path} {
> +					set contents [glob -nocomplain -dir $path *]
> +
> +					if {[llength $contents] > 0} { break }
> +
> +					try {
> +						file delete -- $path
> +					}
> +					catch {
> +						# This is just a best effort, don't annoy the user with failure to remove empty directories.
> +						break
> +					}

The convention in this project is to just use `catch`, and not try. So 
something like:

  catch {file delete -- $path}

> +
> +					set path $directoryPath
> +					set directoryPath [file dirname $path]

I read this loop as "if all the paths in a directory are removed, remove 
the empty directory as well". Do I read correctly?

Will there be problems in deleting the directory? What if the user wants 
to keep the directory, and just delete the files? Is that even a valid 
use-case?

> +				}
> +			}
> +
> +			lappend epilogue {ui_do_rescan}

A rescan is an expensive operation, so we should use it judiciously. Are 
you sure it is really needed? The "Revert" code does not do a rescan but 
still manages to update the list of "unstaged files". How does it manage 
that? Can the new code do something similar?

> +		}
>  	}
> +
> +	foreach epilogueCommand $epilogue { {*}$epilogueCommand }

Why not use `eval` [2]? Are there any downsides to that compared to your 
way? If not, use `eval`. At least it means better readability if nothing 
else.

As far as I see, you use $epilogue for two things: unlocking the index 
and rescanning. Can you move the control flow around that both can be 
done in the "normal" way. That is, they are not a part of a list of 
things to do at the end, but instead are done when needed. For example, 
just move the call to `unlock_index` at the end instead of putting it in 
epilogue. Can the same be done for `ui_do_rescan` (if you do go with a 
rescan instead of doing it like the existing revert does)?

>  }
>  
>  proc do_revert_selection {} {

While I appreciate the idea of such a feature, I'm surprised by how 
complex the implementation is. I expected something much simpler. The 
complexity can probably be managed a bit better by moving the control 
flow around.

I couldn't dive in the code as deep as I wanted to because I don't have 
too much time on my hands. But maybe I'll look further by the time your 
re-roll arrives. Thanks.

[0] https://github.com/prati0100/git-gui
[1] https://github.com/prati0100/git-gui#using-gitgitgadget
[2] https://www.tcl.tk/man/tcl8.6/TclCmd/eval.htm

-- 
Regards,
Pratyush Yadav
