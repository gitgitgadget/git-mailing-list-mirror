From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Tue, 10 Sep 2013 21:37:45 +0200
Message-ID: <522F7509.1050100@web.de>
References: <cover.1378840318.git.john@keeping.me.uk> <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 10 21:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJTl2-0003pu-9w
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab3IJThs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:37:48 -0400
Received: from mout.web.de ([212.227.17.12]:60608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab3IJThr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:37:47 -0400
Received: from [192.168.178.41] ([91.3.174.212]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lc8rF-1VibJH0dbJ-00jVmA for <git@vger.kernel.org>;
 Tue, 10 Sep 2013 21:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:19ehKaF/UxIaA1O8zr2qXktU79B8AUj1lMRkCO3rkO6CHnVy40o
 w05b826Xyd5xYbZgGehaa2SoJn0VRux/1hnfzva96eMy7NWcBtVvhAaZJvs1knb+f24sJAO
 EQl+0RVyAnSjnoRboGv4TmyIf1HH3qEVk+/6PPDDMPEFuk6F2fe4MMWAmOinps4tBknqQ4G
 xpsJF7wbeLaB8aIZhAcDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234473>

Am 10.09.2013 21:13, schrieb John Keeping:
> When using tab-completion, a directory path will often end with a
> trailing slash which currently confuses "git rm" when dealing with

I think you meant to say "git reset" in the line above. Apart from
that I'm all for it.

> submodules.  Now that we have parse_pathspec we can easily handle this
> by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  builtin/reset.c            | 5 +++++
>  t/t7400-submodule-basic.sh | 6 ++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 5e4c551..9efac0f 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -220,8 +220,13 @@ static void parse_args(struct pathspec *pathspec,
>  		}
>  	}
>  	*rev_ret = rev;
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
>  	parse_pathspec(pathspec, 0,
>  		       PATHSPEC_PREFER_FULL |
> +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
>  		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
>  		       prefix, argv);
>  }
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 4192fe0..c268d3c 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -481,7 +481,7 @@ test_expect_success 'do not add files from a submodule' '
>  
>  '
>  
> -test_expect_success 'gracefully add submodule with a trailing slash' '
> +test_expect_success 'gracefully add/reset submodule with a trailing slash' '
>  
>  	git reset --hard &&
>  	git commit -m "commit subproject" init &&
> @@ -495,7 +495,9 @@ test_expect_success 'gracefully add submodule with a trailing slash' '
>  	git add init/ &&
>  	test_must_fail git diff --exit-code --cached init &&
>  	test $commit = $(git ls-files --stage |
> -		sed -n "s/^160000 \([^ ]*\).*/\1/p")
> +		sed -n "s/^160000 \([^ ]*\).*/\1/p") &&
> +	git reset init/ &&
> +	git diff --exit-code --cached init
>  
>  '
>  
> 
