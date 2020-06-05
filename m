Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56051C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318D0206E6
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 20:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFEUsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:48:10 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49671 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgFEUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 16:48:10 -0400
X-Originating-IP: 157.36.158.100
Received: from localhost (unknown [157.36.158.100])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 917001C0002;
        Fri,  5 Jun 2020 20:48:06 +0000 (UTC)
Date:   Sat, 6 Jun 2020 02:18:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mikhail Terekhov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Mikhail Terekhov <termim@gmail.com>
Subject: Re: [PATCH] git-gui: allow opening work trees from the startup dialog
Message-ID: <20200605204803.lbolbny5m5dczynn@yadavpratyush.com>
References: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikhail,

Thanks for the patch.

On 26/05/20 03:33PM, Mikhail Terekhov via GitGitGadget wrote:
> From: Mikhail Terekhov <termim@gmail.com>
> 
> In proc _is_git check that supplied path is a valid work tree path.
> This allows the choose_repository::pick dialog to accept path to a
> work tree directory.

IIUC, you are referring to work trees other than the main work tree, 
correct?

I tested my theory, and you are right. Applying this patch allows me to 
open git-gui in a worktree.
 
> Signed-off-by: Mikhail Terekhov <termim@gmail.com>
> ---
>     git-gui: allow opening work trees from the startup dialog
>     
>     Trying to open a working tree from the "Open Existing Repository" link
>     of the git-gui startup dialog results in an error: Not a Git repository:
>     .... This patch fixes that error.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-644%2Ftermim%2Fgit-gui-open-worktree-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-644/termim/git-gui-open-worktree-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/644
> 
>  lib/choose_repository.tcl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index e54f3e66d8f..8f911e89fbb 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -362,8 +362,19 @@ proc _is_git {path {outdir_var ""}} {
>  		gets $fp line
>  		close $fp
>  		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
> +			set check_path [file normalize $path]
>  			set path [file join [file dirname $path] $link_target]
>  			set path [file normalize $path]
> +

This should have a comment explaining we are checking for a worktree. 
Will add it locally.

> +			if {[file exists [file join $path gitdir]]} {
> +				set fp [open [file join $path gitdir] r]
> +				gets $fp worktree_path
> +				close $fp
> +				if {[string equal $check_path $worktree_path]} {
> +					set outdir $path
> +					return 1
> +				}
> +			}

I wonder if there is a way of finding if the path is a worktree path 
using a Git plumbing command. That IMO would be better than rolling our 
own logic to check if something is a worktree.

I'll check once if I can figure something out (you do that too if you 
can). Otherwise I'll merge it in. Thanks.

-- 
Regards,
Pratyush Yadav
