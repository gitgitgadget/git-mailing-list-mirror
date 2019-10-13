Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737001F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfJMUVO (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 16:21:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51733 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJMUVO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 16:21:14 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3B9A01BF206;
        Sun, 13 Oct 2019 20:21:11 +0000 (UTC)
Date:   Mon, 14 Oct 2019 01:51:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
Message-ID: <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007171145.1259-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

Your subject is a bit redundant. A reader of this commit can easily see 
the diff and know that you implemented "proc select_path_in_widget". 
What's more important is why you implemented it. That is what should go 
in the commit message. So for example in this patch, you can say 
something like:

  git-gui: move last clicked path selection logic to a separate function

  This same logic will be used elsewhere in a follow-up commit, so make 
  it re-useable.

This is what I came up with at first thought. Maybe something even 
better and concise can say the same thing.

On 07/10/19 07:11PM, Birger Skogeng Pedersen wrote:
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui.sh | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6..b7f4d1e 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2669,25 +2669,31 @@ proc show_less_context {} {
>  }
>  
>  proc focus_widget {widget} {
> -	global file_lists last_clicked selected_paths
> -	global file_lists_last_clicked
> +	global file_lists
>  
>  	if {[llength $file_lists($widget)] > 0} {
> -		set path $file_lists_last_clicked($widget)
> -		set index [lsearch -sorted -exact $file_lists($widget) $path]
> -		if {$index < 0} {
> -			set index 0
> -			set path [lindex $file_lists($widget) $index]
> -		}
> -
> +		select_path_in_widget $widget
>  		focus $widget
> -		set last_clicked [list $widget [expr $index + 1]]
> -		array unset selected_paths
> -		set selected_paths($path) 1
> -		show_diff $path $widget

There is a change in the order of events here. Earlier, we first 
focussed the widget, and then ran `show_diff`. Now we first run 
`show_diff` (via `select_path_in_widget`), and then focus the widget. 
This won't cause any problems, right?

>  	}
>  }
>  
> +proc select_path_in_widget {widget} {
> +	global file_lists last_clicked selected_paths
> +	global file_lists_last_clicked
> +
> +	set path $file_lists_last_clicked($widget)
> +	set index [lsearch -sorted -exact $file_lists($widget) $path]
> +	if {$index < 0} {
> +		set index 0
> +		set path [lindex $file_lists($widget) $index]
> +	}
> +
> +	set last_clicked [list $widget [expr $index + 1]]
> +	array unset selected_paths
> +	set selected_paths($path) 1
> +	show_diff $path $widget
> +}
> +
>  proc toggle_commit_type {} {
>  	global commit_type_is_amend
>  	set commit_type_is_amend [expr !$commit_type_is_amend]

Other than that, looks good. There isn't much changed here. Just some 
code moved around.

-- 
Regards,
Pratyush Yadav
