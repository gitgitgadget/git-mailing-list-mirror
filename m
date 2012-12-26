From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Wed, 26 Dec 2012 13:51:20 +0100
Message-ID: <20121226125120.GA16990@xs4all.nl>
References: <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
 <50B66F41.1030305@xs4all.nl>
 <7vlidltpyj.fsf@alter.siamese.dyndns.org>
 <50C7B811.7030006@xs4all.nl>
 <7v7goo6vi3.fsf@alter.siamese.dyndns.org>
 <7vy5h45e7b.fsf@alter.siamese.dyndns.org>
 <20121212085507.GA32187@xs4all.nl>
 <7vlid35fe4.fsf@alter.siamese.dyndns.org>
 <50C8E857.5080000@xs4all.nl>
 <7vvcbpp846.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 13:52:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnqT7-0004Vh-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 13:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab2LZMv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 07:51:58 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:2078 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2LZMv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 07:51:57 -0500
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBQCpNR9017513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Dec 2012 13:51:23 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qBQCpLe1022905;
	Wed, 26 Dec 2012 13:51:21 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qBQCpKaK022882;
	Wed, 26 Dec 2012 13:51:20 +0100
Content-Disposition: inline
In-Reply-To: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212135>

* Junio C Hamano <gitster@pobox.com> [2012-12-25 23:47:53 -0800]:
 
> Can we make it take an optional third parameter so that we could say
> 
> 	PROMPT_COMMAND='__git_ps1 ": \h \W" "; " "/%s"'
> 
> to do the same as what the command substitution mode would have
> given for
> 
> 	PS1=': \h \W$(__git_ps1 "/%s"); '
> 
> perhaps?
> 
> Totally untested, but perhaps along this line.
> 

I tried your patch and (to my surprise, after the first reading) it worked.

I've further modified git-prompt.sh to include more usage text and I changed
the name of ps1 to gitstring, as it might be confused with PS1 upon casual
reading.

I'll be sending a format-patch patchmail ASAP...


>  contrib/completion/git-prompt.sh | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 9b074e1..b2579f4 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -236,9 +236,10 @@ __git_ps1 ()
>  	local printf_format=' (%s)'
>  
>  	case "$#" in
> -		2)	pcmode=yes
> +		2|3)	pcmode=yes
>  			ps1pc_start="$1"
>  			ps1pc_end="$2"
> +			printf_format="${3:-$printf_format}"
>  		;;
>  		0|1)	printf_format="${1:-$printf_format}"
>  		;;
> @@ -339,6 +340,7 @@ __git_ps1 ()
>  
>  		local f="$w$i$s$u"
>  		if [ $pcmode = yes ]; then
> +			local ps1=
>  			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
>  				local c_red='\e[31m'
>  				local c_green='\e[32m'
> @@ -356,29 +358,31 @@ __git_ps1 ()
>  					branch_color="$bad_color"
>  				fi
>  
> -				# Setting PS1 directly with \[ and \] around colors
> +				# Setting ps1 directly with \[ and \] around colors
>  				# is necessary to prevent wrapping issues!
> -				PS1="$ps1pc_start (\[$branch_color\]$branchstring\[$c_clear\]"
> +				ps1="\[$branch_color\]$branchstring\[$c_clear\]"
>  
>  				if [ -n "$w$i$s$u$r$p" ]; then
> -					PS1="$PS1 "
> +					ps1="$ps1 "					
>  				fi
>  				if [ "$w" = "*" ]; then
> -					PS1="$PS1\[$bad_color\]$w"
> +					ps1="$ps1\[$bad_color\]$w"
>  				fi
>  				if [ -n "$i" ]; then
> -					PS1="$PS1\[$ok_color\]$i"
> +					ps1="$ps1\[$ok_color\]$i"
>  				fi
>  				if [ -n "$s" ]; then
> -					PS1="$PS1\[$flags_color\]$s"
> +					ps1="$ps1\[$flags_color\]$s"
>  				fi
>  				if [ -n "$u" ]; then
> -					PS1="$PS1\[$bad_color\]$u"
> +					ps1="$ps1\[$bad_color\]$u"
>  				fi
> -				PS1="$PS1\[$c_clear\]$r$p)$ps1pc_end"
> +				ps1="$ps1\[$c_clear\]$r$p"
>  			else
> -				PS1="$ps1pc_start ($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
> +				ps1="$c${b##refs/heads/}${f:+ $f}$r$p"
>  			fi
> +			ps1=$(printf -- "$printf_format" "$ps1")
> +			PS1="$ps1pc_start$ps1$ps1pc_end"
>  		else
>  			# NO color option unless in PROMPT_COMMAND mode
>  			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"

/Simon
