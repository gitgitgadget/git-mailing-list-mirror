Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C261F463
	for <e@80x24.org>; Sun, 29 Sep 2019 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfI2PEN (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 11:04:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51339 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2PEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 11:04:13 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A2FDE20003;
        Sun, 29 Sep 2019 15:04:09 +0000 (UTC)
Date:   Sun, 29 Sep 2019 20:34:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
Message-ID: <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
 <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip, Bert,

Is there any way I can test this change? Philip, I ran the rebase you 
mention in the GitHub issue [0], and I get that '9c8cba6862abe5ac821' is 
an unknown revision.

Is there any quick way I can reproduce this (maybe on a sample repo)?

[0] https://github.com/git-for-windows/git/issues/2340

On 25/09/19 10:38PM, Bert Wesarg wrote:
> This adds highlight support for the diff3 conflict style.
> 
> The common pre-image will be reversed to --, because it has been removed
> and either replaced with ours or theirs side.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh   |  3 +++
>  lib/diff.tcl | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6..6d80f82 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3581,6 +3581,9 @@ $ui_diff tag conf d_s- \
>  $ui_diff tag conf d< \
>  	-foreground orange \
>  	-font font_diffbold
> +$ui_diff tag conf d| \
> +	-foreground orange \
> +	-font font_diffbold
>  $ui_diff tag conf d= \
>  	-foreground orange \
>  	-font font_diffbold
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 0fd4600..6caf4e7 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -347,6 +347,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
>  	}
>  
>  	set ::current_diff_inheader 1
> +	set ::conflict_state {CONTEXT}
>  	fconfigure $fd \
>  		-blocking 0 \
>  		-encoding [get_path_encoding $path] \
> @@ -450,10 +451,28 @@ proc read_diff {fd conflict_size cont_info} {
>  			{++} {
>  				set regexp [string map [list %conflict_size $conflict_size]\
>  								{^\+\+([<>=]){%conflict_size}(?: |$)}]
> +				set regexp_pre_image [string map [list %conflict_size $conflict_size]\
> +								{^\+\+\|{%conflict_size}(?: |$)}]
>  				if {[regexp $regexp $line _g op]} {
>  					set is_conflict_diff 1
>  					set line [string replace $line 0 1 {  }]
> +					set markup {}
>  					set tags d$op
> +					switch -exact -- $op {
> +					< { set ::conflict_state {OURS} }
> +					= { set ::conflict_state {THEIRS} }
> +					> { set ::conflict_state {CONTEXT} }
> +					}
> +				} elseif {[regexp $regexp_pre_image $line]} {
> +					set is_conflict_diff 1
> +					set line [string replace $line 0 1 {  }]
> +					set markup {}
> +					set tags d|
> +					set ::conflict_state {BASE}
> +				} elseif {$::conflict_state eq {BASE}} {
> +					set line [string replace $line 0 1 {--}]
> +					set markup {}
> +					set tags d_--

I'm afraid I don't follow what this hunk is supposed to do.

You set the variable ::conflict_state to the values like OURS, THEIRS, 
CONTEXT, but I don't see those values being used anywhere. A quick 
search for these words shows me that you only set them, never read them.

Is there some extra code that you have and I don't?

Also, this function is long and complicated already. A comment 
explaining what this code is doing would be nice, since it is not at all 
obvious at first read-through.

>  				} else {
>  					set tags d_++
>  				}
> @@ -505,6 +524,9 @@ proc read_diff {fd conflict_size cont_info} {
>  			}
>  		}
>  		set mark [$ui_diff index "end - 1 line linestart"]
> +		if {[llength $markup] > 0} {
> +			set tags {}
> +		}
>  		$ui_diff insert end $line $tags
>  		if {[string index $line end] eq "\r"} {
>  			$ui_diff tag add d_cr {end - 2c}
> -- 
> 2.21.0.789.ga095d9d866
> 

-- 
Regards,
Pratyush Yadav
