Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC86EEB566
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 19:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbjIHT6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245630AbjIHT6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 15:58:18 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76D10FC
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 12:57:54 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 70D3A1F55F;
        Fri,  8 Sep 2023 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1694203074;
        bh=lWX7oiCfURhFBhK9FxbCYjUcAYmzlFZY6Kx1GdBNUVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0imYa8aMUHGM0lmAOvyKgt5JOZXvaDaqtkWqJyKkF9PwyFQFCAAq9ZJT5qy/gtRB0
         3WZM0yTgRC1K9rtvC1+3cnIkF78ICJh3n7aJH6BN3TVTRkBHkylCdCawJ2/6vrZbYw
         JCgb4yZXKWzfLprlQr51fIAelhPZz2gKwZHUTX3U=
Date:   Fri, 8 Sep 2023 19:57:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
Message-ID: <20230908195754.M395591@dcvr>
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> In order to avoid invoking a signal handler in the child process between
> fork() and exec(), start_command() blocks all signals before calling
> fork and then in the child resets the disposition of all signals that
> are not ignored to SIG_DFL before unblocking them. The exception for
> ignored signals seems to been inspired by ruby's process handling[1]
> based on the misconception that execve() will reset them to
> SIG_DFL. Unfortunately this is not the case [2] and any signals that are
> ignored in the parent will default to being ignored by the program
> executed by start_command().
> 
> When git ignores SIGPIPE before forking a child process it is to stop
> git from being killed if the child exits while git is writing to the
> child's stdin. We do not want to ignore SIGPIPE in the child. When git
> ignores SIGINT and SIGQUIT before forking a child process it is to stop
> git from being killed if the user interrupts the child with Ctrl-C or
> Ctrl-\ we do not want the child to ignore those signals [3].
> Fortunately the fix is easy - reset the disposition of all signals
> regardless of their previous disposition.
> 
> [1] https://lore.kernel.org/git/20170413211428.GA5961@whir/
> 
> [2] The man page for execve(2) states:
> 
>         POSIX.1 specifies that the dispositions of any signals that are
> 	ignored or set to the default are left unchanged.  POSIX.1
> 	specifies one exception: if SIGCHLD is being ignored, then an
> 	implementation may leave the disposition unchanged or reset it
> 	to the default; Linux does the former.

Yeah, the old code seems like an error on my part.  Oops :x

> diff --git a/run-command.c b/run-command.c
> index a558042c876..765775a1f42 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -823,11 +823,8 @@ fail_pipe:
>  		 * restore default signal handlers here, in case
>  		 * we catch a signal right before execve below
>  		 */
> -		for (sig = 1; sig < NSIG; sig++) {
> -			/* ignored signals get reset to SIG_DFL on execve */
> -			if (signal(sig, SIG_DFL) == SIG_IGN)
> -				signal(sig, SIG_IGN);
> -		}
> +		for (sig = 1; sig < NSIG; sig++)
> +			signal(sig, SIG_DFL);

Looks good to me and matches what I did in some other (A)GPL-3
projects, actually.

Acked-by: Eric Wong <e@80x24.org>
