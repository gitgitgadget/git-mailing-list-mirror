Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98693C55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79623206EC
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDVNHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:07:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40179 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVNHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 09:07:20 -0400
Received: from localhost (unknown [42.109.206.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3C029200004;
        Wed, 22 Apr 2020 13:07:15 +0000 (UTC)
Date:   Wed, 22 Apr 2020 18:37:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Ansgar =?utf-8?B?UsO2YmVy?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Ansgar =?utf-8?B?UsO2YmVy?= <ansgar.roeber@rwth-aachen.de>
Subject: Re: [PATCH] git-gui: fix concatenation of ui_ready by adding ";"
Message-ID: <20200422130710.stwob3bniyj2wvm3@yadavpratyush.com>
References: <pull.607.git.1586455405590.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.607.git.1586455405590.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ansgar,

Sorry for the late reply. Thanks for the patch. The code changes all 
look correct, other than one extra hunk I suggest (see below). The 
commit subject and message not so much.

> Subject: [PATCH] git-gui: fix concatenation of ui_ready by adding ";"

We aren't fixing concatenation of "ui_ready". We are fixing a syntax 
error because we didn't add a statement separator (semicolon), and so if 
we later append something else, it would be treated as an argument to 
the ui_ready call by Tcl, causing a syntax error.

On 09/04/20 06:03PM, Ansgar Röber via GitGitGadget wrote:
> From: =?UTF-8?q?Ansgar=20R=C3=B6ber?= <ansgar.roeber@rwth-aachen.de>
> 
> This fixes https://github.com/git-for-windows/git/issues/2469

Instead of linking to another project's GitHub, describe the problem and 
its solution in the commit message.

> Signed-off-by: Ansgar Röber <ansgar.roeber@rwth-aachen.de>

So, based on the suggestions, I propose the following commit message:

  Subject: git-gui: fix syntax error because of missing semicolon
  
  For some asynchronous operations, we build a chain of callbacks to 
  execute when the operation is done. These callbacks are held in $after, 
  and a new callback can be added by appending to $after. Once the 
  operation is done, $after is executed as a script.
  
  But if we don't append a semi-colon after the procedure calls, they will 
  appear to Tcl as arguments to the previous procedure's arguments. So, 
  for example, if $after is "foo", and we just append "bar", then $after 
  becomes "foo bar", and bar will be treated as an argument to foo. If foo 
  does not accept any optional arguments, it would result in Tcl throwing 
  an error. If instead we do append a semi-colon, $after will look like 
  "foo;bar;", and these will be treated as two separate procedure calls.
  
  Before d9c6469 (git-gui: update status bar to track operations, 
  2019-12-01), this problem was masked because ui_ready/ui_status did 
  accept an optional argument. In d9c6469, ui_ready stopped accepting an 
  optional argument, and this error started showing up.
  
  Another instance of this problem is when a call to ui_status without a 
  trailing semicolon. ui_status never accepted an optional argument to 
  begin with, but the issue never managed to surface.
  
  So, fix these errors by making sure we always append a semi-colon after 
  procedure calls when multiple callbacks are involved in $after.

> ---
>  git-gui.sh        | 4 ++--
>  lib/index.tcl     | 4 ++--
>  lib/mergetool.tcl | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 4610e4ca72a..faaf93b431a 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2600,12 +2600,12 @@ proc toggle_or_diff {mode w args} {
>  			update_indexinfo \
>  				"Unstaging [short_path $path] from commit" \
>  				[list $path] \
> -				[concat $after [list ui_ready]]
> +				[concat $after {ui_ready;}]
>  		} elseif {$w eq $ui_workdir} {
>  			update_index \
>  				"Adding [short_path $path]" \
>  				[list $path] \
> -				[concat $after [list ui_ready]]
> +				[concat $after {ui_ready;}]
>  		}
>  	} else {
>  		set selected_paths($path) 1
> diff --git a/lib/index.tcl b/lib/index.tcl
> index 1fc5b42300d..59d1f7542a8 100644
> --- a/lib/index.tcl
> +++ b/lib/index.tcl
> @@ -60,7 +60,7 @@ proc rescan_on_error {err {after {}}} {
>  
>  	$::main_status stop_all
>  	unlock_index
> -	rescan [concat $after [list ui_ready]] 0
> +	rescan [concat $after {ui_ready;}] 0
>  }
>  
>  proc update_indexinfo {msg path_list after} {
> @@ -314,7 +314,7 @@ proc unstage_helper {txt paths} {
>  		update_indexinfo \
>  			$txt \
>  			$path_list \
> -			[concat $after [list ui_ready]]
> +			[concat $after {ui_ready;}]
>  	}
>  }
  
Another hunk I think we should add here is:

  @@ -366,7 +366,7 @@ proc add_helper {txt paths} {
   		update_index \
   			$txt \
   			$path_list \
  -			[concat $after {ui_status [mc "Ready to commit."]}]
  +			[concat $after {ui_status [mc "Ready to commit."];}]
   	}
   }

I've changed the commit message and added this hunk locally, so no need 
to send another version. You can find the final commit here [0]. If you 
have any comments/suggestions, please let me know. Otherwise, I'll merge 
it in a few days.

[0] https://github.com/prati0100/git-gui/commit/19195fbd73994d05abaa0a2976143da96b320f47

-- 
Regards,
Pratyush Yadav
