From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: resolve (merge) problems
Date: Thu, 1 Dec 2005 17:50:39 -0800 (PST)
Message-ID: <20051202015039.93047.qmail@web31811.mail.mud.yahoo.com>
References: <7vhd9sb9ie.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 02:52:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei04z-0005jj-2w
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 02:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVLBBvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 20:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVLBBvO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 20:51:14 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:11439 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964774AbVLBBvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 20:51:14 -0500
Received: (qmail 93049 invoked by uid 60001); 2 Dec 2005 01:50:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uWmFafBulYpA1RBKUL5ZU5Weopwn0tF4nThKiM++fM80nSWxKmMjA3//c+iFjXy+K6e6hqPJdSDwGXpvZkmRuCeEUP0rwTTDp9hUyMiLNtmCGNXE067nAbc6i4wgVwp1qE+qGOsWJRNIOSCc8wglMBcfG7Uig+2BEFUCVzbA6Us=  ;
Received: from [68.221.13.176] by web31811.mail.mud.yahoo.com via HTTP; Thu, 01 Dec 2005 17:50:39 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd9sb9ie.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13097>

--- Junio C Hamano <junkio@cox.net> wrote:
> However, there is a bug recently introduced in the
> merge-one-file script.  

Ok, if your patch below resolves the bug (please see my
other email just posted) please submit it.  (I'm hitting
this bug everytime there's a file deleted from the
kernel tree and I try to merge.)

Thanks,
   Luben


> 
> Although the conflict resolution procedure I described applies
> if you really had a real conflicting merge, I suspect your merge
> should not have failed in the first place.
> 
>         case "${1:-.}${2:-.}${3:-.}" in
>         #
>         # Deleted in both or deleted in one and unchanged in the other
>         #
>         "$1.." | "$1.$1" | "$1$1.")
>                 if [ "$2" ]; then
>                         echo "Removing $4"
>                 fi
>                 if test -f "$4"; then
>                         rm -f -- "$4" &&
>                         rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null
>                 fi &&
>                         exec git-update-index --remove -- "$4"
>                 ;;
> 
> The faliure code from "rmdir -p" leaks up and makes
> git-update-index to be skipped.  Here is a fix.
> 
> -- >8 --
> [PATCH] merge-one-file fix
> 
> 9ae2172aed289f2706a0e88288909fa47eddd7e7 used "rmdir -p"
> carelessly, causing the "git-update-index --remove" to be
> skipped.
> 
> ---
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 739a072..9a049f4 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -26,7 +26,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  	fi
>  	if test -f "$4"; then
>  		rm -f -- "$4" &&
> -		rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null
> +		rmdir -p "$(expr "$4" : '\(.*\)/')" 2>/dev/null || :
>  	fi &&
>  		exec git-update-index --remove -- "$4"
>  	;;
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
