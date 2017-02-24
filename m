Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B23201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 08:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdBXIxu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 03:53:50 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:60964 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751294AbdBXIwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 03:52:54 -0500
Received: from bsmtp7.bon.at (unknown [192.168.181.102])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3vV4bw43B3z5vvT
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:52:12 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vV4Zk1cBMz5tlB;
        Fri, 24 Feb 2017 09:51:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3EA39370;
        Fri, 24 Feb 2017 09:51:09 +0100 (CET)
Subject: Re: [PATCH] submodule init: warn about falling back to a local path
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kYXyk=giuM6CnU=gnvkCw3aaVEn=WbJ6tjhn8kZumrmTA@mail.gmail.com>
 <20170224001704.23854-1-sbeller@google.com>
Cc:     philipoakley@iee.org, git@vger.kernel.org, gitster@pobox.com,
        sop@google.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ae377bda-0776-f98b-5b6f-afa198647400@kdbg.org>
Date:   Fri, 24 Feb 2017 09:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170224001704.23854-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.2017 um 01:17 schrieb Stefan Beller:
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -73,13 +73,17 @@ configuration entries unless `--name` is used to specify a logical name.
> ...
> +The default remote is the remote of the remote tracking branch
> +of the current branch. If no such remote tracking branch exists or
> +the in detached HEAD mode, "origin" is assumed to be the default remote.

The part after "or" does not quite parse.

> +If the superproject doesn't have a default remote configured
>  the superproject is its own authoritative upstream and the current
>  working directory is used instead.
>  +
> @@ -118,18 +122,22 @@ too (and can also report changes to a submodule's work tree).
>
>  init [--] [<path>...]::
>  	Initialize the submodules recorded in the index (which were
> -	added and committed elsewhere) by copying submodule
> -	names and urls from .gitmodules to .git/config.
> +	added and committed elsewhere) by copying `submodule.$name.url`
> +	from .gitmodules to .git/config, resolving relative urls to be
> +	relative to the default remote.
> ++
>  	Optional <path> arguments limit which submodules will be initialized.
> -	It will also copy the value of `submodule.$name.update` into
> -	.git/config.
> -	The key used in .git/config is `submodule.$name.url`.
> +	If no path is specified all submodules are initialized.
> ++
> +	When present, it will also copy the value of `submodule.$name.update`.
>  	This command does not alter existing information in .git/config.
>  	You can then customize the submodule clone URLs in .git/config
>  	for your local setup and proceed to `git submodule update`;
>  	you can also just use `git submodule update --init` without
>  	the explicit 'init' step if you do not intend to customize
>  	any submodule locations.
> ++
> +	See the add subcommand for the defintion of default remote.

To be rendered correctly, I think you must remove the indentation from 
continuation paragraphs.

>
>  deinit [-f|--force] (--all|[--] <path>...)::
>  	Unregister the given submodules, i.e. remove the whole
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 899dc334e3..44c11dd91e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  			strbuf_addf(&remotesb, "remote.%s.url", remote);
>  			free(remote);
>
> -			if (git_config_get_string(remotesb.buf, &remoteurl))
> -				/*
> -				 * The repository is its own
> -				 * authoritative upstream
> -				 */
> +			if (git_config_get_string(remotesb.buf, &remoteurl)) {
>  				remoteurl = xgetcwd();
> +				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
> +			}

If you re-roll this patch, please place the warning before xgetcwd, 
which can potentially fail.

-- Hannes

