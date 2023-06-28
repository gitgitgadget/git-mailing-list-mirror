Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE6EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 09:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjF1Jm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 05:42:56 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:46264 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbjF1H4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:08 -0400
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4QrWBT3N2Nz5tnC
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 07:59:45 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4QrW9t5FhXz5tlC;
        Wed, 28 Jun 2023 07:59:14 +0200 (CEST)
Message-ID: <7c73cc47-302d-8706-dd7f-fd034ef8d945@kdbg.org>
Date:   Wed, 28 Jun 2023 07:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/9] gitk: add keyboard bind for create and remove branch
Content-Language: en-US
To:     Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom <jens@lidestrom.se>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
> From: Jens Lidestrom <jens@lidestrom.se>
> 
> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
> ---
>  gitk-git/gitk | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 596977abe89..0d83a72a424 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2692,6 +2692,8 @@ proc makewindow {} {
>      bind $ctext <<Selection>> rehighlight_search_results
>      bind . <$M1B-t> {resethead [selected_line_id]}
>      bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
> +    bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 1}
> +    bind . <$M1B-b> {mkbranch [selected_line_id]}

"b" vs...

>      for {set i 1} {$i < 10} {incr i} {
>          bind . <$M1B-Key-$i> [list go_to_parent $i]
>      }
> @@ -2735,7 +2737,7 @@ proc makewindow {} {
>      makemenu $headctxmenu {
>          {mc "Check out this branch" command {checkout $headmenuhead $headmenuid}}
>          {mc "Rename this branch" command mvbranch}
> -        {mc "Remove this branch" command rmbranch}
> +        {mc "Remove this branch" command {rmbranch $headmenuhead $headmenuid 0}}
>          {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
>      }
>      $headctxmenu configure -tearoff 0
> @@ -3185,6 +3187,8 @@ proc keys {} {
>  [mc "<F5>		Update"]
>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
>  [mc "<%s-O>		Check out selected commit" $M1T]
> +[mc "<%s-C>		Create branch on selected commit" $M1T]

... "C"? Which one is it?

> +[mc "<%s-M>		Remove selected branch" $M1T]
>  " \
>              -justify left -bg $bgcolor -border 2 -relief groove
>      pack $w.m -side top -fill both -padx 2 -pady 2
> @@ -9576,13 +9580,13 @@ proc wrcomcan {} {
>      unset wrcomtop
>  }
>  
> -proc mkbranch {} {
> -    global NS rowmenuid
> +proc mkbranch {id} {
> +    global NS
>  
>      set top .branchdialog
>  
>      set val(name) ""
> -    set val(id) $rowmenuid
> +    set val(id) $id
>      set val(command) [list mkbrgo $top]
>  
>      set ui(title) [mc "Create branch"]
> @@ -10054,13 +10058,14 @@ proc readcheckoutstat {fd newhead newheadref newheadid} {
>      }
>  }
>  
> -proc rmbranch {} {
> -    global headmenuid headmenuhead mainhead
> +proc rmbranch {head id shouldComfirm} {
> +    global mainhead
>      global idheads
> -
> -    set head $headmenuhead
> -    set id $headmenuid
>      # this check shouldn't be needed any more...
> +    if {$head eq ""} {
> +        error_popup [mc "Cannot delete a detached head"]
> +        return
> +    }
>      if {$head eq $mainhead} {
>          error_popup [mc "Cannot delete the currently checked-out branch"]
>          return
> @@ -10070,6 +10075,8 @@ proc rmbranch {} {
>          # the stuff on this branch isn't on any other branch
>          if {![confirm_popup [mc "The commits on branch %s aren't on any other\
>                          branch.\nReally delete branch %s?" $head $head]]} return
> +    } elseif {$shouldComfirm} {
> +        if {![confirm_popup [mc "Really delete branch %s?" $head]]} return
>      }
>      nowbusy rmbranch
>      update

The key binding to remove a branch does not make sense to me. It does
happen that I have more than one branch on a commit, but there is no way
to select which one to remove via the keyboard. I have to use the
context menu. This needs more thought IMHO. At a minimum, separate it
out into its own commit.

-- Hannes
