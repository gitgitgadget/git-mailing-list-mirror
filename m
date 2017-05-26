Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEABF1FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbdEZQbK (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:31:10 -0400
Received: from avasout08.plus.net ([212.159.14.20]:55888 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdEZQbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:31:09 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id R4X61v0061keHif014X7Fu; Fri, 26 May 2017 17:31:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=-2zxhVVe31I-dVeCMsMA:9
 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][PATCH v5 1/3] submodule: fix buggy $path and $sm_path
 variable's value
To:     Prathamesh Chavan <pc44800@gmail.com>, git@vger.kernel.org
Cc:     bmwill@google.com, christian.couder@gmail.com, sbeller@google.com
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <01e8c552-fd3a-ee05-1ff1-3b3ea0f7feeb@ramsayjones.plus.com>
Date:   Fri, 26 May 2017 17:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170526151713.10974-1-pc44800@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/05/17 16:17, Prathamesh Chavan wrote:
> According to the documentation about git-submodule foreach subcommand's
> $path variable:
> $path is the name of the submodule directory relative to the superproject
> 
> But it was observed when the value of the $path value deviates from this
> for the nested submodules when the <command> is run from a subdirectory.
> This patch aims for its correction.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> This series of patch is based on gitster/jk/bug-to-abort for untilizing its 
> BUG() macro.
> 
> The observation made was as follows:
> For a project - super containing dir (not a submodule) and a submodule sub 
> which contains another submodule subsub. When we run a command from super/dir:
> 
> git submodule foreach "echo \$path-\$sm_path"
> 
> actual results:
> Entering '../sub'
> ../sub-../sub
> Entering '../sub/subsub'
> ../subsub-../subsub
> 
> expected result wrt documentation and current test suite:
> Entering '../sub'
> sub-../sub
> Entering '../sub/subsub'
> subsub-../sub/subsub
> 
> This make the value of $path confusing and I also feel it deviates from its 
> documentation:
> $path is the name of the submodule directory relative to the superproject.
> Hence, this patch corrects the value assigned to the $path and $sm_path.
> 
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c0d0e9a4c..ea6f56337 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -344,9 +344,9 @@ cmd_foreach()
>  				prefix="$prefix$sm_path/"
>  				sanitize_submodule_env
>  				cd "$sm_path" &&
> -				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
>  				# we make $path available to scripts ...
>  				path=$sm_path &&
> +				sm_path=$displaypath &&
>  				if test $# -eq 1
>  				then
>  					eval "$1"
> 

Hmm, I'm not sure which documentation you are referring to, but if
$path != $sm_path then something is wrong. (unless their definition
has changed, of course). commit 091a6eb0fe may have muddied the water
a little by using $sm_path in the test in t7407, since (as far as I
know) $path is the user-facing variable (NOT $sm_path).

ATB,
Ramsay Jones


