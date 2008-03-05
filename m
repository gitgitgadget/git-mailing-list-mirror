From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-submodule: Don't die when command fails for one
 submodule
Date: Wed, 5 Mar 2008 17:48:37 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803051742290.15786@racer.site>
References: <1204730478-22027-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWwo7-0006f6-4W
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYCEQsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755833AbYCEQsh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:48:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756702AbYCEQsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:48:36 -0500
Received: (qmail invoked by alias); 05 Mar 2008 16:48:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 05 Mar 2008 17:48:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CJZdKXiIC0Sb1h008Fx4cQj2M1mnqPggvW+tjwP
	ArURjzABDouo4M
X-X-Sender: gene099@racer.site
In-Reply-To: <1204730478-22027-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76243>

Hi,

On Wed, 5 Mar 2008, Ping Yin wrote:

> @@ -221,29 +229,40 @@ cmd_init()
>  	done
>  
>  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> +	{
> +	total=0
> +	success=0
>  	while read mode sha1 stage path
>  	do
> +		total=$(( $total + 1 ))
>  		# Skip already registered paths
> -		name=$(module_name "$path") || exit
> +		name=$(module_name "$path") || continue

What about this case?  Was the comment misleading?

>  		url=$(git config submodule."$name".url)
> -		test -z "$url" || continue
> +		test -n "$url" && success=$(( $success + 1 )) && continue

Why counting?  Why not just 'status=0 && continue'?

>  
> -		git config submodule."$name".url "$url" ||
> -		die "Failed to register url for submodule path '$path'"
> -
> -		say "Submodule '$name' ($url) registered for path '$path'"
> +		if git config submodule."$name".url "$url"
> +		then
> +			say "Submodule '$name' ($url) registered for path '$path'"
> +		else
> +			say "Failed to register url for submodule path '$path'"
> +			continue
> +		fi
> +		success=$(( $success + 1 ))
>  	done
> +	test $success = $total
> +	}
>  }
>  
>  #

Note: I have not even begun to audit if one of your returns should not 
have been a "status=0 && continue" instead.

> @@ -358,9 +392,11 @@ cmd_status()
>  	done
>  
>  	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> +	{
> +	exit_status=0
>  	while read mode sha1 stage path
>  	do
> -		name=$(module_name "$path") || exit
> +		! name=$(module_name "$path") && exit_status=1 && continue
>  		url=$(git config submodule."$name".url)
>  		if test -z "$url" || ! test -d "$path"/.git
>  		then
> @@ -380,6 +416,8 @@ cmd_status()
>  			say "+$sha1 $path$revname"
>  		fi
>  	done
> +	exit $exit_status
> +	}
>  }

But here you use the simpler paradigm of setting exit_status?  Why that 
complicated and ugly "total" and "success" counting before?

Ciao,
Dscho

