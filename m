Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6BC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CCE206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 15:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgKBPra (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:47:30 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54998 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 10:47:29 -0500
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 571163B0620
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:46:17 +0000 (UTC)
Received: from localhost (unknown [103.82.80.169])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 85BDB100019;
        Mon,  2 Nov 2020 15:45:53 +0000 (UTC)
Date:   Mon, 2 Nov 2020 21:15:50 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-gui: Delay rescan until idle time
Message-ID: <20201102154550.2tvvsswokscg42ba@yadavpratyush.com>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <20201101170505.71246-2-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170505.71246-2-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 01/11/20 06:05PM, Stefan Haller wrote:
> This is to ensure that a rescan is only performed once, even if it is
> requested multiple times during one event. We don't need this yet, because
> we only ever call do_rescan once per event so far; this is going to change
> with the next commit, when we also call it from FocusIn.

I don't understand what this is trying to achieve. The calls to 
do_rescan below only happen when the user explicitly does something, 
like stage/unstage selected lines. Why would that event coincide with 
the FocusIn event?

If you mean to account for a situation where the rescan for 
"Apply/Reverse Line" is executed before the rescan from FocusIn 
finishes, then in that case the procedure rescan already accounts for it 
by checking $rescan_active and the index lock.

Have you noticed multiple rescans in parallel? If yes then we might want 
to look at why the check is not working.
 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  git-gui.sh | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 867b8ce..8864c14 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2376,8 +2376,21 @@ proc do_quit {{rc {1}}} {
>  	destroy .
>  }
>  
> +# Not to be called directly; use schedule_rescan instead
>  proc do_rescan {} {
> +	global rescan_id
> +
>  	rescan ui_ready
> +	unset rescan_id

Not sure if you're aware of it already, but it is worth mentioning that 
rescan is asynchronous. The procedure call will return before the rescan 
in actually complete. See the `fileevent` calls in rescan and 
rescan_stage2.

So in this case, rescan_id will be unset before the rescan is actually 
done. This can be the right or wrong thing depending on what you want to 
accomplish, which I'm not clear on.

> +}
> +
> +proc schedule_rescan {} {
> +	global rescan_id
> +
> +	if {[info exists rescan_id]} {
> +		after cancel $rescan_id
> +	}
> +	set rescan_id [after idle do_rescan]
>  }
>  
>  proc ui_do_rescan {} {
> @@ -3683,7 +3696,7 @@ set ui_diff_applyhunk [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
>  $ctxm add command \
>  	-label [mc "Apply/Reverse Line"] \
> -	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; do_rescan}
> +	-command {apply_or_revert_range_or_line $cursorX $cursorY 0; schedule_rescan}
>  set ui_diff_applyline [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
>  $ctxm add separator
> @@ -3694,12 +3707,12 @@ set ui_diff_reverthunk [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_reverthunk -state]
>  $ctxm add command \
>  	-label [mc "Revert Line"] \
> -	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; do_rescan}
> +	-command {apply_or_revert_range_or_line $cursorX $cursorY 1; schedule_rescan}
>  set ui_diff_revertline [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_revertline -state]
>  $ctxm add command \
>  	-label [mc "Undo Last Revert"] \
> -	-command {undo_last_revert; do_rescan}
> +	-command {undo_last_revert; schedule_rescan}
>  set ui_diff_undorevert [$ctxm index last]
>  lappend diff_actions [list $ctxm entryconf $ui_diff_undorevert -state]
>  $ctxm add separator
> @@ -4171,7 +4184,7 @@ after 1 {
>  	if {[is_enabled initialamend]} {
>  		force_amend
>  	} else {
> -		do_rescan
> +		schedule_rescan
>  	}
>  
>  	if {[is_enabled nocommitmsg]} {
> -- 
> 2.29.2
> 

-- 
Regards,
Pratyush Yadav
