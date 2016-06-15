From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] hooks--pre-commit.sample: check for chars, that are not
 allowed for a windows file name
Date: Wed, 15 Jun 2016 13:15:36 +0200
Message-ID: <5c02cc24-f68d-6eb3-9759-ffff328a0c2f@virtuell-zuhause.de>
References: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: dexteritas <dexteritas1@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 13:15:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD8nT-0005Iu-4R
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 13:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbcFOLPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 07:15:43 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:56746 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbcFOLPm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 07:15:42 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1bD8nM-0002C9-FJ; Wed, 15 Jun 2016 13:15:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465989342;b698a78f;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297365>

Am 15.06.2016 um 10:02 schrieb dexteritas:
> After the ASCII-check, test the windows compatibility of file names.
> Can be disabled by:
> git config hooks.allownonwindowschars true
> ---
>  templates/hooks--pre-commit.sample | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 68d62d5..120daf1 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -17,6 +17,7 @@ fi
>  
>  # If you want to allow non-ASCII filenames set this variable to true.
>  allownonascii=$(git config --bool hooks.allownonascii)
> +allownonwindowschars=$(git config --bool hooks.allownonwindowschars)
>  
>  # Redirect output to stderr.
>  exec 1>&2
> @@ -43,6 +44,27 @@ If you know what you are doing you can disable this check using:
>    git config hooks.allownonascii true
>  EOF
>  	exit 1
> +elif [ "$allownonwindowschars" != "true" ] &&
> +	# If you work with linux and windows, there is a problem, if you use
> +	# chars like \ / : * ? " < > |
> +	# Check if there are used only windows compatible chars
> +	test $(git diff --cached --name-only --diff-filter=A -z $against |
> +	  LC_ALL=C tr -d '[0-9A-Za-z\[\]\{\}_ -)+-.]\0' | wc -c) != 0
> +then
> +	cat <<\EOF
> +Error: Attempt to add a chars that are not allowed for a windows file name.
> +
> +This can cause problems if you want to work with people on other platforms.
> +
> +To be portable it is advisable to rename the file.
> +
> +Check your filenames for: \ / : * ? " < > |
> +
> +If you know what you are doing you can disable this check using:
> +
> +  git config hooks.allownonwindowschars true
> +EOF
> +	exit 2
>  fi
>  
>  # If there are whitespace errors, print the offending file names and fail.

There are some cases of illegal file names missing. E.g. reserved names,
trailing period and space. My trial with a precommit hook for avoiding
illegal filenames on windows can be found at [1]. Feel free to loot my
version for a reroll.

[1]:
https://github.com/t-b/git-pre-commit-hook-windows-filenames/blob/master/pre-commit
