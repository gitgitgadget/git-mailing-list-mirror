Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F66EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjGEUA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjGEUAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:00:52 -0400
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B3E3
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:00:51 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Qx9Wh70cMz5tlC;
        Wed,  5 Jul 2023 22:00:48 +0200 (CEST)
Message-ID: <bed39dd8-3520-b509-40cf-22390566951e@kdbg.org>
Date:   Wed, 5 Jul 2023 22:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 06/10] gitk: add keyboard bind for remove branch
 command
Content-Language: en-US
To:     Jens Lidestrom <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <ad6617a7badfe1d3ac252d9faabbe21b2b0f65f8.1688409958.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ad6617a7badfe1d3ac252d9faabbe21b2b0f65f8.1688409958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 104 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 15 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 8364033ad58..65ca11becca 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2692,6 +2692,8 @@ proc makewindow {} {
>      bind $ctext <<Selection>> rehighlight_search_results
>      bind . <$M1B-t> {resethead [selected_line_id]}
>      bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
> +    bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
> +    bind . <$M1B-b> {mkbranch [selected_line_id]}

This second line should not be in this commit, should it?

>      for {set i 1} {$i < 10} {incr i} {
>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>      }
> @@ -2735,7 +2737,7 @@ proc makewindow {} {
>      makemenu $headctxmenu {
>          {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
>          {mc "Rename this branch" command mvbranch}
> -        {mc "Remove this branch" command rmbranch}
> +        {mc "Remove this branch" command {rmbranch [list $headmenuhead] $headmenuid 0}}
>          {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
>      }
>      $headctxmenu configure -tearoff 0
> @@ -3185,6 +3187,8 @@ proc keys {} {
>  [mc "<F5>		Update"]
>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
>  [mc "<%s-O>		Check out selected commit" $M1T]
> +[mc "<%s-B>		Create branch on selected commit" $M1T]
> +[mc "<%s-M>		Remove selected branch" $M1T]

Same here.

>  " \
>              -justify left -bg $bgcolor -border 2 -relief groove
>      pack $w.m -side top -fill both -padx 2 -pady 2
> @@ -10121,32 +10125,102 @@ proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
>      }
>  }
>  
> -proc rmbranch {} {
> -    global headmenuid headmenuhead mainhead
> +proc rmbranch {heads_on_commit id shouldComfirm} {
> +    global mainhead
>      global idheads
> +    global confirm_ok sel_ix NS
>  
> -    set head $headmenuhead
> -    set id $headmenuid
> -    # this check shouldn't be needed any more...
> -    if {$head eq $mainhead} {
> +    if {[llength $heads_on_commit] == 0} {
> +        error_popup [mc "Cannot delete a detached head"]
> +        return
> +    }
> +
> +    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
>          error_popup [mc "Cannot delete the currently checked-out branch"]
>          return
>      }
> -    set dheads [descheads $id]
> -    if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
> -        # the stuff on this branch isn't on any other branch
> -        if {![confirm_popup [mc "The commits on branch %s aren't on any other\
> -                        branch.\nReally delete branch %s?" $head $head]]} return
> +
> +    # Filter out mainhead
> +    set mainhead_ix [lsearch $heads_on_commit $mainhead]
> +    if {$mainhead_ix != -1} {
> +        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
> +    }
> +
> +    # Filter out remote branches
> +    foreach head_ix [lsearch -all $heads_on_commit "remotes/*"] {
> +        set heads_on_commit [lreplace $heads_on_commit $head_ix $head_ix]
> +    }
> +
> +    if {[llength $heads_on_commit] == 0} {
> +        # Probably only current branch and its remote branch on commit
> +        error_popup [mc "Cannot delete branch"]
> +        return
>      }
> +
> +    set nr_heads_on_commit [llength $heads_on_commit]
> +    set first_head [lindex $heads_on_commit 0]
> +
> +    if {$nr_heads_on_commit == 1} {
> +        # Only a single head, simple comfirm dialogs
> +
> +        set head_to_remove $first_head
> +        set dheads [descheads $id]
> +
> +        if {[llength $dheads] == 1 && $idheads($dheads) eq $head_to_remove} {
> +            # the stuff on this branch isn't on any other branch
> +            if {![confirm_popup [mc "The commits on branch %s aren't on any other\
> +                            branch.\nReally delete branch %s?" $head_to_remove $head_to_remove]]} return
> +        } elseif {$shouldComfirm} {
> +            if {![confirm_popup [mc "Really delete branch %s?" $head_to_remove]]} return
> +        }
> +    } else {
> +        # Select branch dialog
> +
> +        set confirm_ok 0
> +
> +        set w ".selectbranch"
> +        ttk_toplevel $w
> +        make_transient $w .
> +        wm title $w [mc "Delete branch"]
> +        ${NS}::label $w.m -text [mc "Which branch to delete?"]
> +        pack $w.m -side top -fill x -padx 20 -pady 20
> +        ${NS}::frame $w.f
> +
> +        set sel_ix 0
> +        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
> +            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
> +                -text [lindex $heads_on_commit $i]

The same comment as in the earlier commit about the checkout command
applies here: I don't think that radio buttons are the correct UI for a
branch selection.

In general, such duplication of code should not happen. The dialog only
differs in the title and help text and should be factored into a helper
function.

> +            bind $w.f.id_$i <Key-Up> "set sel_ix [expr ($i - 1) % $nr_heads_on_commit]"
> +            bind $w.f.id_$i <Key-Down> "set sel_ix [expr ($i + 1) % $nr_heads_on_commit]"
> +            grid $w.f.id_$i -sticky w -padx 20
> +        }
> +
> +        pack $w.f -side top -fill x -padx 4
> +        ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
> +        bind $w <Key-Return> "set confirm_ok 1; destroy $w"
> +        pack $w.ok -side left -fill x -padx 20 -pady 20
> +        ${NS}::button $w.cancel -text [mc Cancel] -command "destroy $w"
> +        bind $w <Key-Escape> [list destroy $w]
> +        pack $w.cancel -side right -fill x -padx 20 -pady 20
> +        bind $w <Visibility> "grab $w; focus $w.f.id_$sel_ix"
> +
> +        tkwait window $w
> +        if {!$confirm_ok} return
> +
> +        set head_to_remove [lindex $heads_on_commit $sel_ix]
> +    }
> +
> +    # Perform the command
> +
>      nowbusy rmbranch
>      update
> -    if {[catch {exec git branch -D $head} err]} {
> +    if {[catch {exec git branch -D $head_to_remove} err]} {
>          notbusy rmbranch
>          error_popup $err
>          return
>      }
> -    removehead $id $head
> -    removedhead $id $head
> +    removehead $id $head_to_remove
> +    removedhead $id $head_to_remove
>      redrawtags $id
>      notbusy rmbranch
>      dispneartags 0

