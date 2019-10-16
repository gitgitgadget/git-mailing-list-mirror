Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538121F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406252AbfJPTZw (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:25:52 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59825 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403999AbfJPTZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:25:51 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 882DF240007;
        Wed, 16 Oct 2019 19:25:49 +0000 (UTC)
Date:   Thu, 17 Oct 2019 00:55:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-gui: select staged on ui_comm focus
Message-ID: <20191016192546.znhulmgxqqsjxy2u@yadavpratyush.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
 <20191007171145.1259-2-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007171145.1259-2-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/19 07:11PM, Birger Skogeng Pedersen wrote:
> When the user focuses the Commit Message widget (to write a message), the
> diff view may be blank.
> 
> With this patch a staged file is automatically selected when the Commit
> Message widget is focused, if no other file is selected (i.e. diff view
> is blank).
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index b7f4d1e..70b846a 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2700,6 +2700,15 @@ proc toggle_commit_type {} {
>  	do_select_commit_type
>  }
>  
> +proc check_diff_selected {} {
> +	global current_diff_path file_lists
> +	# If no diff path selected, select a staged file
> +	if {$current_diff_path eq {}
> +		&& [llength $file_lists($::ui_index)] > 0} {

Nitpick: Please declare ui_index to be global. That way we can just use 
$ui_index instead of the more tedious $::ui_index.

> +		select_path_in_widget $::ui_index
> +	}
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3437,6 +3446,8 @@ pack .vpane.lower.commarea.buffer.header -side top -fill x
>  pack .vpane.lower.commarea.buffer.frame -side left -fill y
>  pack .vpane.lower.commarea.buffer -side left -fill y
>  
> +bind $ui_comm <FocusIn> {check_diff_selected}
> +

This would mean the diff shows _only_ when you switch focus to the 
commit message buffer. If the buffer is already in focus, and you stage 
all files via Ctrl-I, the staged diff would not show.

IIRC you were having some trouble with this. A quick suggestion without 
looking too much into the problem is to try putting the logic inside 
`do_add_all` instead of inside the bind event handler.

>  # -- Commit Message Buffer Context Menu
>  #
>  set ctxm .vpane.lower.commarea.buffer.ctxm
> -- 
> 2.23.0.windows.1
> 

-- 
Regards,
Pratyush Yadav
