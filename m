Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE10EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGEUHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjGEUHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:07:21 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8CB1723
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:07:19 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Qx9gB2PMfz5tlB;
        Wed,  5 Jul 2023 22:07:18 +0200 (CEST)
Message-ID: <3d3dd74a-aed3-b2cf-1be3-8a14129e3f4a@kdbg.org>
Date:   Wed, 5 Jul 2023 22:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 07/10] gitk: add keyboard bind for cherry-pick command
Content-Language: en-US
To:     Jens Lidestrom <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
 <54afa8fe9e831f5381d045bc24464ff2d6246118.1688409958.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <54afa8fe9e831f5381d045bc24464ff2d6246118.1688409958.git.gitgitgadget@gmail.com>
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
>  gitk-git/gitk | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 65ca11becca..351b88f10c0 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2690,6 +2690,7 @@ proc makewindow {} {
>      bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
>      bind $ctext <Button-1> {focus %W}
>      bind $ctext <<Selection>> rehighlight_search_results
> +    bind . <$M1B-p> {cherrypick [selected_line_id]}
>      bind . <$M1B-t> {resethead [selected_line_id]}
>      bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
>      bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
> @@ -2710,8 +2711,8 @@ proc makewindow {} {
>          {mc "Create tag" command mktag}
>          {mc "Copy commit reference" command copyreference}
>          {mc "Write commit to file" command writecommit}
> -        {mc "Create new branch" command mkbranch}
> -        {mc "Cherry-pick this commit" command cherrypick}
> +        {mc "Create new branch" command {mkbranch $rowmenuid}}
> +        {mc "Cherry-pick this commit" command {cherrypick $rowmenuid}}

The change regarding Create new branch is not related to this commit's
topic and should be elsewhere.

>          {mc "Reset current branch to here" command {resethead $rowmenuid}}
>          {mc "Mark this commit" command markhere}
>          {mc "Return to mark" command gotomark}
> @@ -3186,6 +3187,7 @@ proc keys {} {
>  [mc "<%s-minus>	Decrease font size" $M1T]
>  [mc "<F5>		Update"]
>  [mc "<%s-T>		Reset current branch to selected commit" $M1T]
> +[mc "<%s-P>		Cherry-pick selected commit to current branch" $M1T]
>  [mc "<%s-O>		Check out selected commit" $M1T]
>  [mc "<%s-B>		Create branch on selected commit" $M1T]
>  [mc "<%s-M>		Remove selected branch" $M1T]
> @@ -9758,24 +9760,29 @@ proc exec_citool {tool_args {baseid {}}} {
>      array set env $save_env
>  }
>  
> -proc cherrypick {} {
> -    global rowmenuid curview
> +proc cherrypick {id} {
> +    global curview headids
>      global mainhead mainheadid
>      global gitdir
>  
> +    if {! [info exists headids($mainhead)]} {
> +        error_popup [mc "Cannot cherry-pick to a detached head"]
> +        return
> +    }

Why is it necessary to forbid this now? It was not forbidden before.

> +
>      set oldhead [exec git rev-parse HEAD]
> -    set dheads [descheads $rowmenuid]
> +    set dheads [descheads $id]
>      if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >= 0} {
>          set ok [confirm_popup [mc "Commit %s is already\
>                  included in branch %s -- really re-apply it?" \
> -                                   [string range $rowmenuid 0 7] $mainhead]]
> +                                   [string range $id 0 7] $mainhead]]
>          if {!$ok} return
>      }
>      nowbusy cherrypick [mc "Cherry-picking"]
>      update
>      # Unfortunately git-cherry-pick writes stuff to stderr even when
>      # no error occurs, and exec takes that as an indication of error...
> -    if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
> +    if {[catch {exec sh -c "git cherry-pick -r $id 2>&1"} err]} {
>          notbusy cherrypick
>          if {[regexp -line \
>                   {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
> @@ -9791,7 +9798,7 @@ proc cherrypick {} {
>                          resolve it?"]]} {
>                  # Force citool to read MERGE_MSG
>                  file delete [file join $gitdir "GITGUI_MSG"]
> -                exec_citool {} $rowmenuid
> +                exec_citool {} $id
>              }
>          } else {
>              error_popup $err

