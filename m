Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D021F464
	for <e@80x24.org>; Tue, 10 Sep 2019 19:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfIJTMX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 15:12:23 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44065 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJTMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 15:12:23 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 299E01C0004;
        Tue, 10 Sep 2019 19:12:19 +0000 (UTC)
Date:   Wed, 11 Sep 2019 00:42:18 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
Message-ID: <20190910191217.qgb23x5tvaajppfh@yadavpratyush.com>
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904143055.11400-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Cc j6t

This patch LGTM, but I'm not sure how to resolve the keybindings 
problem. Junio suggested we have configurable keybindings, and I agree 
with him, but until we do, something has to be agreed upon. And we also 
need to come up with a reasonable default.

So, I don't have any preferences for either using Alt+3 for the commit 
message buffer, or Alt+4. Unless someone has objections, I'll go with 
Alt+3 for the commit message buffer, and Alt+4 for the diff.

Thanks for the patch Birger. I'll change the keybindings locally before 
pushing out, no need to send a re-roll for something so trivial.

On 04/09/19 04:30PM, Birger Skogeng Pedersen wrote:
> The user cannot change focus between the list of files, the diff view and
> the commit message widgets without using the mouse (clicking either of
> the four widgets).
> 
> With this patch, the user may set ui focus to the previously selected path
> in either the "Unstaged Changes" or "Staged Changes" widgets, using
> ALT+1 or ALT+2.
> 
> The user may also set the ui focus to the diff view widget with
> ALT+3, or to the commit message widget with ALT+4.
> 
> This enables the user to select/unselect files, view the diff and create a
> commit in git-gui using keyboard-only.
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui.sh | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..5dae8da 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2495,7 +2495,7 @@ proc force_first_diff {after} {
>  
>  proc toggle_or_diff {mode w args} {
>  	global file_states file_lists current_diff_path ui_index ui_workdir
> -	global last_clicked selected_paths
> +	global last_clicked selected_paths file_lists_last_clicked
>  
>  	if {$mode eq "click"} {
>  		foreach {x y} $args break
> @@ -2527,6 +2527,8 @@ proc toggle_or_diff {mode w args} {
>  	$ui_index tag remove in_sel 0.0 end
>  	$ui_workdir tag remove in_sel 0.0 end
>  
> +	set file_lists_last_clicked($w) $path
> +
>  	# Determine the state of the file
>  	if {[info exists file_states($path)]} {
>  		set state [lindex $file_states($path) 0]
> @@ -2640,6 +2642,26 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc focus_widget {widget} {
> +	global file_lists last_clicked selected_paths
> +	global file_lists_last_clicked
> +
> +	if {[llength $file_lists($widget)] > 0} {
> +		set path $file_lists_last_clicked($widget)
> +		set index [lsearch -sorted -exact $file_lists($widget) $path]
> +		if {$index < 0} {
> +			set index 0
> +			set path [lindex $file_lists($widget) $index]
> +		}
> +
> +		focus $widget
> +		set last_clicked [list $widget [expr $index + 1]]
> +		array unset selected_paths
> +		set selected_paths($path) 1
> +		show_diff $path $widget
> +	}
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3852,6 +3874,14 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>  
> +bind .   <Alt-Key-1> {focus_widget $::ui_workdir}
> +bind .   <Alt-Key-2> {focus_widget $::ui_index}
> +bind .   <Alt-Key-3> {focus $::ui_diff}
> +bind .   <Alt-Key-4> {focus $::ui_comm}
> +
> +set file_lists_last_clicked($ui_index) {}
> +set file_lists_last_clicked($ui_workdir) {}
> +
>  set file_lists($ui_index) [list]
>  set file_lists($ui_workdir) [list]
>  
> -- 
> 2.21.0.windows.1
> 

-- 
Regards,
Pratyush Yadav
