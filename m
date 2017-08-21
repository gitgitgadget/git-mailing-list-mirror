Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2F4208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 16:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbdHUQrh (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:47:37 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:47216 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdHUQrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:47:36 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1djprQ-00040f-1Q; Mon, 21 Aug 2017 18:47:32 +0200
Date:   Mon, 21 Aug 2017 18:47:30 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH 3/4] submodule: port set_name_rev() from shell to C
Message-ID: <20170821164730.GC1618@book.hvoigt.net>
References: <20170821161515.23775-1-pc44800@gmail.com>
 <20170821161515.23775-3-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170821161515.23775-3-pc44800@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 09:45:14PM +0530, Prathamesh Chavan wrote:
> Function set_name_rev() is ported from git-submodule to the
> submodule--helper builtin. The function get_name_rev() generates the
> value of the revision name as required, and the function
> print_name_rev() handles the formating and printing of the obtained
> revision name.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 16 ++----------
>  2 files changed, 65 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7803457ba..a4bff3f38 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c

[...]

> @@ -1242,6 +1304,7 @@ static struct cmd_struct commands[] = {
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> +	{"print-name-rev", print_name_rev, 0},

I see the function in git-submodule.sh was named kind of reverse. How
about we do it more naturally here and call this 'rev-name' instead?
That makes is more clear to me and is also similar to the used variable
name 'revname'.

I would also prefix it differently like 'get' or 'calculate' instead of
'print' since it tries to find a name and is not just a simple lookup.

So in summary I would prefer something like 'get-rev-name' as a name for
the subcommand here.

>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>  	{"remote-branch", resolve_remote_submodule_branch, 0},
>  	{"push-check", push_check, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index e131760ee..e988167e0 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -759,18 +759,6 @@ cmd_update()
>  	}
>  }
>  
> -set_name_rev () {
> -	revname=$( (
> -		sanitize_submodule_env
> -		cd "$1" && {
> -			git describe "$2" 2>/dev/null ||
> -			git describe --tags "$2" 2>/dev/null ||
> -			git describe --contains "$2" 2>/dev/null ||
> -			git describe --all --always "$2"
> -		}
> -	) )
> -	test -z "$revname" || revname=" ($revname)"
> -}
>  #
>  # Show commit summary for submodules in index or working tree
>  #
> @@ -1042,14 +1030,14 @@ cmd_status()
>  		fi
>  		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
>  		then
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say " $sha1 $displaypath$revname"
>  		else
>  			if test -z "$cached"
>  			then
>  				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
>  			fi
> -			set_name_rev "$sm_path" "$sha1"
> +			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
>  			say "+$sha1 $displaypath$revname"
>  		fi
>  
> -- 
> 2.13.0
> 
