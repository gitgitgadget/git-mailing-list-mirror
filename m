Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361D71F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 23:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfJBXyR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 19:54:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43339 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJBXyR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 19:54:17 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E71B320002;
        Wed,  2 Oct 2019 23:54:13 +0000 (UTC)
Date:   Thu, 3 Oct 2019 05:24:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 2/2] git-gui: support for diff3 conflict style
Message-ID: <20191002235411.bfkrjc6cgyayqwud@yadavpratyush.com>
References: <14754a59ecf15194dccc659072e2bc180280d097.1569845908.git.bert.wesarg@googlemail.com>
 <a7cff5097eaf29a80c822cb37b537b3859d06ad7.1569873171.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cff5097eaf29a80c822cb37b537b3859d06ad7.1569873171.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I made some fixes to the punctuation and capitalization in the comments 
you added. You can take a look at [0].

Just to be sure, I get the following text in git-gui when I ran your 
example:

  <<<<<<< HEAD
 +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
  ||||||| merged common ancestors
--Proin in felis eu elit suscipit rhoncus vel ut metus.
  =======
+ Proin placerat leo malesuada lacinia lobortis.
  >>>>>>> branch

I noticed that the line after '<<<<<<< HEAD' starts with ' +' and the 
line after '=======' starts with '+ '.

So on the "HEAD" version, the space is before the '+', and on the 
"branch" version, the space is after the '+'. This is the intended 
behaviour, right?

It is not strictly related to your patch because it happens without 
diff3 conflict style enabled as well, but I just want to make sure this 
is not a bug.

The patch looks good. Will queue. Thanks.

[0] https://github.com/prati0100/git-gui/commit/d6e413c7cff6d09a0089d7a5de115ad438b42e81

On 02/10/19 09:36AM, Bert Wesarg wrote:
> This adds highlight support for the diff3 conflict style.
> 
> The common pre-image will be reversed to --, because it has been removed
> and replaced with ours or theirs side respectively.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh   |  3 +++
>  lib/diff.tcl | 17 ++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> --- 
> 
> v3: Fixed a syntax error
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
> index 0fd4600..dacdda2 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -347,6 +347,10 @@ proc start_show_diff {cont_info {add_opts {}}} {
>  	}
>  
>  	set ::current_diff_inheader 1
> +	# detect pre-image lines of the diff3 conflict-style, they are just '++'
> +	# lines which is not bijective, thus we need to maintain a state across
> +	# lines
> +	set ::conflict_in_pre_image 0
>  	fconfigure $fd \
>  		-blocking 0 \
>  		-encoding [get_path_encoding $path] \
> @@ -449,11 +453,22 @@ proc read_diff {fd conflict_size cont_info} {
>  			{--} {set tags d_--}
>  			{++} {
>  				set regexp [string map [list %conflict_size $conflict_size]\
> -								{^\+\+([<>=]){%conflict_size}(?: |$)}]
> +								{^\+\+([<>=|]){%conflict_size}(?: |$)}]
>  				if {[regexp $regexp $line _g op]} {
>  					set is_conflict_diff 1
>  					set line [string replace $line 0 1 {  }]
>  					set tags d$op
> +					# the ||| conflict-marker marks the start of the pre-image,
> +					# all those lines are also prefixed with '++', thus we need
> +					# to maintain this state
> +					set ::conflict_in_pre_image [expr {$op eq {|}}]
> +				} elseif {$::conflict_in_pre_image} {
> +					# this is a pre-image line, it is the one which both sides
> +					# are based on. As it has also the '++' line start, it is
> +					# normally shown as 'added', invert this to '--' to make
> +					# it a 'removed' line
> +					set line [string replace $line 0 1 {--}]
> +					set tags d_--
>  				} else {
>  					set tags d_++
>  				}

-- 
Regards,
Pratyush Yadav
