From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Mon, 09 Sep 2013 17:23:54 -0400
Message-ID: <522E3C6A.3070409@bbn.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com> <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8wM-0003RL-3K
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab3IIVYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:24:05 -0400
Received: from smtp.bbn.com ([128.33.0.80]:53498 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557Ab3IIVYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:24:04 -0400
Received: from socket.bbn.com ([192.1.120.102]:55424)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VJ8w7-000Kmt-6r; Mon, 09 Sep 2013 17:23:55 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id ED8363FFAE
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234379>

On 2013-09-08 21:23, Felipe Contreras wrote:
> The old configurations still work, but get deprecated.

Should some tests for the deprecated configs be added?  We wouldn't want
to accidentally break those.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ec57a15..9489a59 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -760,11 +760,11 @@ branch.<name>.mergeoptions::
>  	option values containing whitespace characters are currently not
>  	supported.
>  
> -branch.<name>.rebase::
> -	When true, rebase the branch <name> on top of the fetched branch,
> -	instead of merging the default branch from the default remote when
> -	"git pull" is run. See "pull.rebase" for doing this in a non
> -	branch-specific manner.
> +branch.<name>.pullmode::
> +	When "git pull" is run, this determines if it would either merge or
> +	rebase the fetched branch. The possible values are 'merge' and
> +	'rebase'. See "pull.mode" for doing this in a non branch-specific
> +	manner.
>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]
> @@ -1820,11 +1820,11 @@ pretty.<name>::
>  	Note that an alias with the same name as a built-in format
>  	will be silently ignored.
>  
> -pull.rebase::
> -	When true, rebase branches on top of the fetched branch, instead
> -	of merging the default branch from the default remote when "git
> -	pull" is run. See "branch.<name>.rebase" for setting this on a
> -	per-branch basis.
> +pull.mode::
> +	When "git pull" is run, this determines if it would either merge or
> +	rebase the fetched branch. The possible values are 'merge' and
> +	'rebase'. See "branch.<name>.pullmode" for doing this in a non
> +	branch-specific manner.
>  +
>  *NOTE*: this is a possibly dangerous operation; do *not* use
>  it unless you understand the implications (see linkgit:git-rebase[1]

Somewhere something should mention what the default values are
(branch.<name>.pullmode defaults to pull.mode and pull.mode defaults to
merge).

> diff --git a/git-pull.sh b/git-pull.sh
> index f0df41c..de57c1d 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -43,10 +43,24 @@ log_arg= verbosity= progress= recurse_submodules= verify_signatures=
>  merge_args= edit=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
> -rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +mode=$(git config branch.${curr_branch_short}.pullmode)
> +if test -z "$mode"
> +then
> +	mode=$(git config pull.mode)
> +fi
> +test "$mode" == 'rebase' && rebase="true"
>  if test -z "$rebase"
>  then
> -	rebase=$(git config --bool pull.rebase)
> +	rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +	if test -z "$rebase"
> +	then
> +		rebase=$(git config --bool pull.rebase)
> +	fi
> +	if test "$rebase" = 'true'
> +	then
> +		echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
> +		echo "Please use pull.mode and branch.<name>.pullmode instead."
> +	fi
>  fi
>  dry_run=
>  while :

These deprecation warning messages should be written to stderr, and
should probably be prefixed with "WARNING: ".

-Richard
