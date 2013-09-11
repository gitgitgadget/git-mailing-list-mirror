From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 08:05:44 +0200
Message-ID: <52300838.5040703@kdbg.org>
References: <cover.1378840318.git.john@keeping.me.uk> <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 08:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdYl-0002vP-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab3IKGFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 02:05:47 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:60640 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752658Ab3IKGFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:05:46 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 08223CDF87;
	Wed, 11 Sep 2013 08:05:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6387719F626;
	Wed, 11 Sep 2013 08:05:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234523>

Am 10.09.2013 21:13, schrieb John Keeping:
> When using tab-completion, a directory path will often end with a
> trailing slash which currently confuses "git rm" when dealing with
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

When the index is now read here, I would have expected hunk in this
patch that removes a read_cache() invocation.

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
