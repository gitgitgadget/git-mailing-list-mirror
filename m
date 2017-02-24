Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89E1201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBXTsk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:48:40 -0500
Received: from avasout01.plus.net ([84.93.230.227]:54014 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdBXTsj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:48:39 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id ojob1u00522aPyA01jocUb; Fri, 24 Feb 2017 19:48:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=IItyMknG c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=NiL4Km4R1Mc0tGvJ__UA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 1/1] config: add conditional include
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170224131425.32409-1-pclouds@gmail.com>
 <20170224131425.32409-2-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f1c87812-3dc1-fbfa-d12a-c9e7ddf9bb4e@ramsayjones.plus.com>
Date:   Fri, 24 Feb 2017 19:48:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170224131425.32409-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/02/17 13:14, Nguyễn Thái Ngọc Duy wrote:
[snip] 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt  | 61 +++++++++++++++++++++++++++++
>  config.c                  | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>  t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 015346c417..6c0cd2a273 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -91,6 +91,56 @@ found at the location of the include directive. If the value of the
>  relative to the configuration file in which the include directive was
>  found.  See below for examples.
>  
> +Conditional includes
> +~~~~~~~~~~~~~~~~~~~~
> +
> +You can include one config file from another conditionally by setting
> +a `includeIf.<condition>.path` variable to the name of the file to be
> +included. The variable's value is treated the same way as `include.path`.
> +
> +The condition starts with a keyword followed by a colon and some data
> +whose format and meaning depends on the keyword. Supported keywords
> +are:
> +
> +`gitdir`::
> +
> +	The data that follows the keyword `gitdir:` is used as a glob
> +	pattern. If the location of the .git directory match the
> +	pattern, the include condition is met.
> ++
> +The .git location which may be auto-discovered, or come from
> +`$GIT_DIR` environment variable. If the repository auto discovered via
> +a .git file (e.g. from submodules, or a linked worktree), the .git
> +location would be the final location, not where the .git file is.
> ++
> +The pattern can contain standard globbing wildcards and two additional
> +ones, `**/` and `/**`, that can match multiple path components. Please
> +refer to linkgit:gitignore[5] for details. For convenience:
> +
> + * If the pattern starts with `~/`, `~` will be substituted with the
> +   content of the environment variable `HOME`.
> +
> + * If the pattern starts with `./`, it is replaced with the directory
> +   containing the current config file.
> +
> + * If the pattern does not start with either `~/`, `./` or `/`, `**/`
> +   will be automatically prepended. For example, the pattern `foo/bar`
> +   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
> +
> + * If the pattern ends with `/`, `**` will be automatically added. For
> +   example, the pattern `foo/` becomes `foo/**`. In other words, it
> +   matches "foo" and everything inside, recursively.
> +
> +`gitdir/i`::
> +	This is the same as `gitdir` except that matching is done
> +	case-insensitively (e.g. on case-insensitive file sytems)
> +
> +A few more notes on matching with `gitdir` and `gitdir/i`:
> +
> + * Symlinks in `$GIT_DIR` are not resolved before matching.
> +
> + * Note that "../" is not special and will match literally, which is
> +   unlikely what you want.
>  
>  Example
>  ~~~~~~~
> @@ -119,6 +169,17 @@ Example
>  		path = foo ; expand "foo" relative to the current file
>  		path = ~/foo ; expand "foo" in your `$HOME` directory
>  
> +	; include if $GIT_DIR is /path/to/foo/.git
> +	[include-if "gitdir:/path/to/foo/.git"]

s/include-if/includeIf/

> +		path = /path/to/foo.inc
> +
> +	; include for all repositories inside /path/to/group
> +	[include-if "gitdir:/path/to/group/"]

ditto

> +		path = /path/to/foo.inc
> +
> +	; include for all repositories inside $HOME/to/group
> +	[include-if "gitdir:~/to/group/"]

ditto

ATB,
Ramsay Jones
