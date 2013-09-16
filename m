From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/3] git submodule update should give notice when run
 without init beforehand
Date: Mon, 16 Sep 2013 19:06:42 +0200
Message-ID: <52373AA2.9050807@web.de>
References: <1379266703-29808-1-git-send-email-rctay89@gmail.com> <1379266703-29808-2-git-send-email-rctay89@gmail.com> <1379266703-29808-3-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 16 19:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLcGD-0003C5-2H
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 19:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab3IPRGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 13:06:49 -0400
Received: from mout.web.de ([212.227.17.12]:62375 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982Ab3IPRGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 13:06:48 -0400
Received: from [192.168.178.41] ([91.3.180.25]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LxJVq-1W10V20r8s-0171Bn for <git@vger.kernel.org>;
 Mon, 16 Sep 2013 19:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1379266703-29808-3-git-send-email-rctay89@gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:j7QCj8qEqsgD/fqwTXIkYvOPoI213WMhTzxBKON/e6+V/WjBnch
 T9bJkqWkATzD6JIIBQWr8rBuWk3gEOee+deBewNz+asYe7G3JQ1xipftIoyVk3Grlq1vD8F
 NSmXAFJcBs8j1xIJqRdRAX97rOdoeBBZ76alz3waoSvDbtzCcOap+CZv0/ed1g5cq8fsi9y
 U35kyoXgeQqNSSHBOzkMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234838>

Am 15.09.2013 19:38, schrieb Tay Ray Chuan:
> When 'update' is run with no path in a repository with uninitialized
> submodules, the program terminates with no output, and zero status code.
> Be more helpful to users by mentioning this.

Hmm, this patch is changing the default behavior, right? I assume the
motivation for this patch is to help people who tend to forget to init
submodules they need to have checked out, which is a good idea. But I
think this should not be enabled by default, as in a lot of use cases
one or more uninitialized submodules are present on purpose. In those
use cases it would be rather nasty to error out on every submodule
update.

After the 'autoinit' configuration (which lets upstream hint that
certain submodules should be initialized on clone) has materialzed we
might want to enable this error for these specific submodules. But in
any case the error message should contain a hint on how you can get
rid of the error in case you know what you are doing ;-).

> This may be controlled by an advice.* option.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  Documentation/config.txt    |  5 +++++
>  git-submodule.sh            | 16 ++++++++++++++--
>  t/t7406-submodule-update.sh |  5 ++++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ec57a15..79313f9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -202,6 +202,11 @@ advice.*::
>  	rmHints::
>  		In case of failure in the output of linkgit:git-rm[1],
>  		show directions on how to proceed from the current state.
> +	submoduleUpdateUninit::
> +		When linkgit:git-submodule[1] `update` is run with no `path`
> +		arguments in a repository with uninitialized submodules,
> +		mention that uninitalized submodules are indeed present, and
> +		that they may be initialized with the `--init` option.
>  --
>  
>  core.fileMode::
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..56f3dc2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -777,6 +777,7 @@ cmd_update()
>  	cloned_modules=
>  	module_list "$@" | {
>  	err=
> +	has_uninit=
>  	while read mode sha1 stage sm_path
>  	do
>  		die_if_unmatched "$mode"
> @@ -807,9 +808,13 @@ cmd_update()
>  		then
>  			# Only mention uninitialized submodules when its
>  			# path have been specified
> -			test "$#" != "0" &&
> -			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
> +			if test "$#" != "0"
> +			then
> +				say "$(eval_gettext "Submodule path '\$displaypath' not initialized
>  Maybe you want to use 'update --init'?")"
> +			else
> +				has_uninit=1
> +			fi
>  			continue
>  		fi
>  
> @@ -940,6 +945,13 @@ Maybe you want to use 'update --init'?")"
>  		IFS=$OIFS
>  		exit 1
>  	fi
> +
> +	if test -n "$has_uninit" \
> +		-a "$(git config --bool --get advice.submoduleUpdateUninit)" != "false"
> +	then
> +		say "$(eval_gettext "Uninitialized submodules were detected;
> +Maybe you want to use 'update --init'?")"
> +	fi
>  	}
>  }
>  
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 00475eb..8dbe410 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -76,8 +76,11 @@ test_expect_success 'submodule update <path> warns without init beforehand' '
>  	)
>  '
>  
> -test_expect_success 'submodule update is silent without init beforehand' '
> +test_expect_success 'submodule update warns without init beforehand' '
>  	(cd super2 &&
> +	 test_must_fail git config --get advice.submoduleUpdateUninit &&
> +	 test -n "$(git submodule update)" &&
> +	 git config advice.submoduleUpdateUninit false &&
>  	 test -z "$(git submodule update)"
>  	)
>  '
> 
