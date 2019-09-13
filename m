Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0511F463
	for <e@80x24.org>; Fri, 13 Sep 2019 14:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfIMOhs (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 10:37:48 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:55405 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIMOhr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 10:37:47 -0400
Received: from localhost (unknown [157.49.250.150])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 64F1A240002;
        Fri, 13 Sep 2019 14:37:45 +0000 (UTC)
Date:   Fri, 13 Sep 2019 20:07:41 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] git-gui: add hotkey to toggle "Amend Last Commit"
Message-ID: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com>
References: <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com>
 <20190912184100.8212-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912184100.8212-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

I'm afraid you are working on an older version of this patch. You should 
be re-rolling [0], which works well with Bert's "amend check button" 
change.

[0] https://public-inbox.org/git/b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com/

On 12/09/19 08:41PM, Birger Skogeng Pedersen wrote:
> Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
> a hotkey.
> 
> With this patch, the user may toggle between the two options with
> CTRL/CMD+e.
> 
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..ebe267f 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1445,7 +1445,7 @@ proc force_amend {} {
>  	set commit_type $newType
>  
>  	set selected_commit_type amend
> -	do_select_commit_type
> +	ui_select_commit_type
>  }
>  
>  proc rescan {after {honor_trustmtime 1}} {
> @@ -2640,6 +2640,16 @@ proc show_less_context {} {
>  	}
>  }
>  
> +proc toggle_commit_type {} {
> +	global selected_commit_type
> +	if {[string match amend* $selected_commit_type]} {
> +		set selected_commit_type new
> +	} else {
> +		set selected_commit_type amend
> +	}
> +	ui_select_commit_type
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -2824,13 +2834,31 @@ proc commit_btn_caption {} {
>  	}
>  }
>  
> +proc ui_select_commit_type {} {
> +	global selected_commit_type
> +	global ui_commit_type_commit ui_commit_type_amend
> +
> +	do_select_commit_type
> +	if {$selected_commit_type eq {new}} {
> +		.mbar.commit entryconf [mc "New Commit"] \
> +			-accelerator {}
> +		.mbar.commit entryconf [mc "Amend Last Commit"] \
> +			-accelerator $::M1T-E
> +	} elseif {$selected_commit_type eq {amend}} {
> +		.mbar.commit entryconf [mc "New Commit"] \
> +			-accelerator $::M1T-E
> +		.mbar.commit entryconf [mc "Amend Last Commit"] \
> +			-accelerator {}
> +	}
> +}
> +
>  if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>  	menu .mbar.commit
>  
>  	if {![is_enabled nocommit]} {
>  		.mbar.commit add radiobutton \
>  			-label [mc "New Commit"] \
> -			-command do_select_commit_type \
> +			-command ui_select_commit_type \
>  			-variable selected_commit_type \
>  			-value new
>  		lappend disable_on_lock \
> @@ -2838,7 +2866,8 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>  
>  		.mbar.commit add radiobutton \
>  			-label [mc "Amend Last Commit"] \
> -			-command do_select_commit_type \
> +			-accelerator $M1T-E \
> +			-command ui_select_commit_type \
>  			-variable selected_commit_type \
>  			-value amend
>  		lappend disable_on_lock \
> @@ -3315,14 +3344,14 @@ set ui_coml .vpane.lower.commarea.buffer.header.l
>  if {![is_enabled nocommit]} {
>  	${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
>  		-text [mc "New Commit"] \
> -		-command do_select_commit_type \
> +		-command ui_select_commit_type \
>  		-variable selected_commit_type \
>  		-value new
>  	lappend disable_on_lock \
>  		[list .vpane.lower.commarea.buffer.header.new conf -state]
>  	${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
>  		-text [mc "Amend Last Commit"] \
> -		-command do_select_commit_type \
> +		-command ui_select_commit_type \
>  		-variable selected_commit_type \
>  		-value amend
>  	lappend disable_on_lock \
> @@ -3837,6 +3866,8 @@ bind .   <$M1B-Key-j> do_revert_selection
>  bind .   <$M1B-Key-J> do_revert_selection
>  bind .   <$M1B-Key-i> do_add_all
>  bind .   <$M1B-Key-I> do_add_all
> +bind .   <$M1B-Key-e> toggle_commit_type
> +bind .   <$M1B-Key-E> toggle_commit_type
>  bind .   <$M1B-Key-minus> {show_less_context;break}
>  bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
>  bind .   <$M1B-Key-equal> {show_more_context;break}
> -- 
> 2.21.0.windows.1
> 

-- 
Regards,
Pratyush Yadav
