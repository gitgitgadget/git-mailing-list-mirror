From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 09 Jan 2008 09:59:09 +0100
Message-ID: <47848CDD.7050806@viscovery.net>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Imran M Yousuf <imran@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 09 09:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWmu-0005lX-5m
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYAII7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYAII7P
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:59:15 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19261 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYAII7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:59:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCWmD-00070R-Qz; Wed, 09 Jan 2008 09:59:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4B0C64E4; Wed,  9 Jan 2008 09:59:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69971>

imyousuf@gmail.com schrieb:
> @@ -16,6 +16,7 @@ update=
>  status=
>  quiet=
>  cached=
> +command=
>
>  #
>  # print stuff on stdout unless -q was specified
> @@ -293,20 +294,23 @@ modules_list()
>  	done
>  }
>
> +# command specifies the whole function name since
> +# one of theirs prefix is module not modules
>  while test $# != 0
>  do
>  	case "$1" in
>  	add)
>  		add=1
> +		command="module_$1"
>  		;;
>  	init)
> -		init=1
> +		command="modules_$1"
>  		;;
>  	update)
> -		update=1
> +		command="modules_$1"
>  		;;
>  	status)
> -		status=1
> +		command="modules_list"
>  		;;
>  	-q|--quiet)
>  		quiet=1
> @@ -320,7 +324,7 @@ do
>  		branch="$2"; shift
>  		;;
>  	--cached)
> -		cached=1
> +		command="modules_list"

Don't remove cached=1 because otherwise --cached is effectively ignored.

>  		;;
>  	--)
>  		break
> @@ -345,20 +349,8 @@ case "$add,$branch" in
>  	;;
>  esac
>
> -case "$add,$init,$update,$status,$cached" in
> -1,,,,)
> -	module_add "$@"
> -	;;
> -,1,,,)
> -	modules_init "$@"
> -	;;
> -,,1,,)
> -	modules_update "$@"
> -	;;
> -,,,*,*)
> -	modules_list "$@"
> -	;;
> -*)
> +if [ -z $command ]; then
>  	usage
> -	;;
> -esac
> +else
> +	"$command" "$@"
> +fi

- Previously 'git submodule' was equvalent to 'git submodule status', now
it is an error.

- Previously, passing --cached to add, init, or update was an error, now
it is not.

-- Hannes
