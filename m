Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D03EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGERaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjGERaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:30:03 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B719A0
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:29:32 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Qx6950TkDz5tl9;
        Wed,  5 Jul 2023 19:29:28 +0200 (CEST)
Message-ID: <dc76bbf3-cf35-4e7b-bed5-2de9c13eee37@kdbg.org>
Date:   Wed, 5 Jul 2023 19:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 05/10] gitk: add keyboard bind for checkout command
To:     Jens Lidestrom <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <aaca07db597d9eb870f3253887d30b3b38a9ea0c.1688409958.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <aaca07db597d9eb870f3253887d30b3b38a9ea0c.1688409958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.23 um 20:45 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> This also introduces the ability to check out detatched heads. This
> shouldn't result any problems, because gitk already works with
> detatched heads if they are checked out using the terminal.

I find it irritating that it is possible to check out a detached head
with Ctrl-O, but not via the context menu.

Playing around a bit with this feature, it may be a bit too easy to
check out a different commit with a simple key press and without
confirmation. At a minimum, there should be a confirmation when a
transition from a branch to a detached head happens, because otherwise
inexperienced users end up in inconvenient territories.

I propose that you do not include the ability to check out a detached
head in this commit, but make it a new feature once this series has settled.

> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 125 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 27 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 642cd7f652a..8364033ad58 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2691,6 +2691,7 @@ proc makewindow {} {
>      bind $ctext <Button-1> {focus %W}
>      bind $ctext <<Selection>> rehighlight_search_results
>      bind . <$M1B-t> {resethead [selected_line_id]}
> +    bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
>      for {set i 1} {$i < 10} {incr i} {
>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>      }
> @@ -2732,7 +2733,7 @@ proc makewindow {} {
>  
>      set headctxmenu .headctxmenu
>      makemenu $headctxmenu {
> -        {mc "Check out this branch" command cobranch}
> +        {mc "Check out this branch" command {checkout [list $headmenuhead] $headmenuid}}
>          {mc "Rename this branch" command mvbranch}
>          {mc "Remove this branch" command rmbranch}
>          {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
> @@ -3183,6 +3184,7 @@ proc keys {} {
>  [mc "<%s-minus>	Decrease font size" $M1T]
>  [mc "<F5>		Update"]
>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
> +[mc "<%s-O>		Check out selected commit" $M1T]
>  " \
>              -justify left -bg $bgcolor -border 2 -relief groove
>      pack $w.m -side top -fill both -padx 2 -pady 2
> @@ -9978,25 +9980,93 @@ proc headmenu {x y id head} {
>      tk_popup $headctxmenu $x $y
>  }
>  
> -proc cobranch {} {
> -    global headmenuid headmenuhead headids
> +proc checkout {heads_on_commit id_to_checkout} {
> +    global headids mainhead
>      global showlocalchanges
> +    global sel_ix confirm_ok NS
>  
>      # check the tree is clean first??
> -    set newhead $headmenuhead
> +
> +    # Filter out remote branches if local branch is also present
> +    foreach remote_ix [lsearch -all $heads_on_commit "remotes/*"] {
> +        set remote_head [lindex $heads_on_commit $remote_ix]
> +        set local_head [string range $remote_head [expr [string last / $remote_head] + 1] end]
> +        if {$local_head in $heads_on_commit} {
> +            set heads_on_commit [lreplace $heads_on_commit $remote_ix $remote_ix]
> +        }
> +    }
> +
> +    if {[llength $heads_on_commit] == 1 && [lindex $heads_on_commit 0] eq $mainhead} {
> +        # Only the currently active branch
> +        return
> +    }
> +
> +    # Filter out mainhead
> +    set mainhead_ix [lsearch $heads_on_commit $mainhead]
> +    if {$mainhead_ix != -1} {
> +        set heads_on_commit [lreplace $heads_on_commit $mainhead_ix $mainhead_ix]
> +    }
> +    set nr_heads_on_commit [llength $heads_on_commit]
> +
> +    # The number of heads on the commit determines how to select what to checkout
> +    if {$nr_heads_on_commit == 0} {
> +        set head_to_checkout ""
> +        set ref_to_checkout $id_to_checkout
> +    } elseif {$nr_heads_on_commit == 1} {
> +        set head_to_checkout [lindex $heads_on_commit 0]
> +        set ref_to_checkout $head_to_checkout
> +    } else {
> +        # Branch selection dialog
> +
> +        set confirm_ok 0
> +
> +        set w ".selectbranch"
> +        ttk_toplevel $w
> +        make_transient $w .
> +        wm title $w [mc "Check out branch"]

There is already a branch selection dialog (hit F2 to bring it up).
Could you please have a look whether it can be reused here? Because...

> +        ${NS}::label $w.m -text [mc "Check out which branch?"]
> +        pack $w.m -side top -fill x -padx 20 -pady 20
> +        ${NS}::frame $w.f
> +
> +        set sel_ix 0
> +        for {set i 0} {$i < $nr_heads_on_commit} {incr i} {
> +            ${NS}::radiobutton $w.f.id_$i -value $i -variable sel_ix \
> +                -text [lindex $heads_on_commit $i]

... presenting a list of items in the form of radio buttons is a very
non-standard user-interface, IMO. I would have expected a list widget in
which an entry is highlighted. Also, if the list is long, a list would
have a scroll bar, but a radio button group is limited to the available
screen height.

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
> +
> +        if {!$confirm_ok} return
> +
> +        set head_to_checkout [lindex $heads_on_commit $sel_ix]
> +        set ref_to_checkout $head_to_checkout
> +    }
> +
> +    # Handle remote branches
>      set command [list | git checkout]
> -    if {[string match "remotes/*" $newhead]} {
> -        set remote $newhead
> -        set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
> -        # The following check is redundant - the menu option should
> -        # be disabled to begin with...
> -        if {[info exists headids($newhead)]} {
> -            error_popup [mc "A local branch named %s exists already" $newhead]
> +    if {[string match "remotes/*" $head_to_checkout]} {
> +        set remote $head_to_checkout
> +        set head_to_checkout [string range $head_to_checkout [expr [string last / $head_to_checkout] + 1] end]
> +        set ref_to_checkout $head_to_checkout
> +        if {[info exists headids($head_to_checkout)]} {
> +            error_popup [mc "A local branch named %s exists already" $head_to_checkout]
>              return
>          }
> -        lappend command -b $newhead --track $remote
> +        lappend command -b $head_to_checkout --track $remote
>      } else {
> -        lappend command $newhead
> +        lappend command $ref_to_checkout
>      }
>      lappend command 2>@1
>      nowbusy checkout [mc "Checking out"]
> @@ -10011,11 +10081,11 @@ proc cobranch {} {
>              dodiffindex
>          }
>      } else {
> -        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
> +        filerun $fd [list readcheckoutstat $fd $head_to_checkout $ref_to_checkout $id_to_checkout]
>      }
>  }
>  
> -proc readcheckoutstat {fd newhead newheadid} {
> +proc readcheckoutstat {fd head_to_checkout ref_to_checkout id_to_checkout} {
>      global mainhead mainheadid headids idheads showlocalchanges progresscoords
>      global viewmainheadid curview
>  
> @@ -10033,18 +10103,19 @@ proc readcheckoutstat {fd newhead newheadid} {
>          error_popup $err
>          return
>      }
> -    set oldmainid $mainheadid
> -    if {! [info exists headids($newhead)]} {
> -        set headids($newhead) $newheadid
> -        lappend idheads($newheadid) $newhead
> -        addedhead $newheadid $newhead
> -    }
> -    set mainhead $newhead
> -    set mainheadid $newheadid
> -    set viewmainheadid($curview) $newheadid
> -    redrawtags $oldmainid
> -    redrawtags $newheadid
> -    selbyid $newheadid
> +    set old_main_id $mainheadid
> +
> +    if {$head_to_checkout ne "" && ! [info exists headids($head_to_checkout)]} {
> +        set headids($head_to_checkout) $id_to_checkout
> +        lappend idheads($id_to_checkout) $head_to_checkout
> +        addedhead $id_to_checkout $head_to_checkout
> +    }
> +    set mainhead $ref_to_checkout
> +    set mainheadid $id_to_checkout
> +    set viewmainheadid($curview) $id_to_checkout
> +    redrawtags $old_main_id
> +    redrawtags $id_to_checkout
> +    selbyid $id_to_checkout
>      if {$showlocalchanges} {
>          dodiffindex
>      }

