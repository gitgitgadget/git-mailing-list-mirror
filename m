Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28D21F461
	for <e@80x24.org>; Sun,  1 Sep 2019 11:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfIALcX (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 07:32:23 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37693 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfIALcX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 07:32:23 -0400
X-Originating-IP: 1.186.12.40
Received: from localhost (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 02EEDE0004;
        Sun,  1 Sep 2019 11:32:20 +0000 (UTC)
Date:   Sun, 1 Sep 2019 17:02:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
Message-ID: <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
 <20190831122326.9071-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831122326.9071-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

In case you haven't been following the list, Pat has been inactive 
recently, so I am acting as the interim maintainer of git-gui for now, 
because no one else stepped up and Junio would rather not maintain it.

You can find my fork over at https://github.com/prati0100/git-gui. I 
munged your patches to apply on my tree (which is separate from the 
git.git tree), but it would be great if you base them on my tree next 
time around.

On 31/08/19 02:23PM, Birger Skogeng Pedersen wrote:
> The user cannot change focus between the list of files, the diff view and
> the commit message widgets without using the mouse (clicking either of
> the four widgets ).

Nit: s/widgets )/widgets)/

> 
> Hotkeys CTRL/CMD+number (1-4) now focuses a previously selected path from
> either the "Unstaged Changes" or "Staged Changes", the diff view or the
> commit message dialog widgets, respectively. This enables the user to
> select/unselect files, view the diff and create a commit in git-gui
> using keyboard-only.
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui/git-gui.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 6de74ce639..cbd0b69804 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2494,7 +2494,7 @@ proc force_first_diff {after} {
>  
>  proc toggle_or_diff {mode w args} {
>  	global file_states file_lists current_diff_path ui_index ui_workdir
> -	global last_clicked selected_paths
> +	global last_clicked selected_paths file_lists_last_clicked
>  
>  	if {$mode eq "click"} {
>  		foreach {x y} $args break
> @@ -2551,6 +2551,8 @@ proc toggle_or_diff {mode w args} {
>  	$ui_index tag remove in_sel 0.0 end
>  	$ui_workdir tag remove in_sel 0.0 end
>  
> +	set file_lists_last_clicked($w) $lno
> +
>  	# Determine the state of the file
>  	if {[info exists file_states($path)]} {
>  		set state [lindex $file_states($path) 0]
> @@ -2664,6 +2666,51 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc select_first_path {w} {

I have recently been going through the git-gui code, and my biggest 
gripe was non-descriptive single letter variable names. So maybe 
s/w/window/

> +	global file_lists last_clicked selected_paths ui_workdir
> +	global file_lists_last_clicked

Aside: this almost made me ask why you declared file_lists_last_clicked 
twice :D

> +
> +	set _list_length [llength $file_lists($w)]
> +
> +	if {$_list_length > 0} {
> +

Nit: Drop the blank line.

> +		set _index $file_lists_last_clicked($w)

If some files are added/removed via an external command, that means the 
index we choose won't be the file the user last looked at, correct? What 
about using path names instead, so we know exactly which file to 
display, even though its index might have changed?

But if it is not a trivial change, and needs a lot of work, I'm fine 
with the way things are. If the user changes stuff outside of git-gui, 
some side effects are to be expected.

> +
> +		if {$_index eq {}} {
> +			set _index 1
> +		} elseif {$_index > $_list_length} {
> +			set _index $_list_length

Just to be sure: _index should start at 1 right, and not 0?

> +		}
> +
> +		focus $w
> +		set last_clicked [list $w $_index]
> +		set path [lindex $file_lists($w) [expr $_index - 1]]
> +		array unset selected_paths
> +		set selected_paths($path) 1
> +		show_diff $path $w
> +	}

If _list_length is 0 (iow, no files are staged/unstaged), this won't 
change the focus at all. Are you sure this is the desired behaviour?  
Would it make no sense if we switch to an empty pane? The user did 
explicitly hit the button combo to go there. Yes, they won't be able to 
actually do anything, but what is the harm in switching focus if the 
user explicitly requests it?

> +}
> +
> +proc select_first_unstaged_changes_path {} {
> +	global ui_workdir
> +	select_first_path $ui_workdir
> +}
> +
> +proc select_first_staged_changes_path {} {
> +	global ui_index
> +	select_first_path $ui_index
> +}
> +
> +proc focus_diff {} {
> +	global ui_diff
> +	focus $ui_diff
> +}
> +
> +proc focus_commit_message {} {
> +	global ui_comm
> +	focus $ui_comm
> +}
> +

Do you expect these functions to be re-used somewhere in the near 
future? Otherwise...

>  ######################################################################
>  ##
>  ## ui construction
> @@ -3877,6 +3924,14 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>  
> +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
> +bind . <$M1B-Key-2> {select_first_staged_changes_path}
> +bind . <$M1B-Key-3> {focus_diff}
> +bind . <$M1B-Key-4> {focus_commit_message}

... why not just put their bodies directly in here? Something like:

  bind . <$M1B-Key-1> {
	global $ui_workdir
	select_first_path $ui_workdir
  }

> +
> +set file_lists_last_clicked($ui_index) {}
> +set file_lists_last_clicked($ui_workdir) {}
> +
>  set file_lists($ui_index) [list]
>  set file_lists($ui_workdir) [list]

Overall, IMO it is a great idea. I tested it, and it works fine on my 
setup. Thanks.

-- 
Regards,
Pratyush Yadav
