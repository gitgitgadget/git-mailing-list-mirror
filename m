From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Sat, 14 May 2005 00:55:17 +0200
Message-ID: <20050513225516.GG32232@pasky.ji.cz>
References: <E1DWihi-0007DQ-SD@ash.dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 01:01:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWj91-0005Iz-Ox
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVEMW7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVEMW6E
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:58:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33673 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262615AbVEMWzW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:55:22 -0400
Received: (qmail 8016 invoked by uid 2001); 13 May 2005 22:55:17 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <E1DWihi-0007DQ-SD@ash.dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 12:32:22AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Updated
>     cg-add
>     cg-commit

I consider this Bad Thing (tm). Or could you please point a situation
where this would be actually useful? If you explicitly cg-add, you
likely know what are you doing, and same thing with cg-commit - if it's
already added, it should be watches, no matter what ignore patterns, I
think.
> --- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-commit  (mode:100755)
> +++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-commit  (mode:100755)
> @@ -65,6 +65,15 @@
>  	[ -s $_git/merging ] && merging=$(cat $_git/merging | sed 's/^/-p /')
>  fi
>  
> +# strip ignored files - *1 at a time* - any attempt to stream from 1
> +# while loop to another uses a subprocess and can't pass the variable
> +# back
> +# Also I don't know if this can be put in a shell function
> +for file in ${commitfiles[@]}
> +  do
> +  commitfiles[$i]=`echo $file | cg-Xignore`
> +  ((i++))
> +done
>  
>  LOGMSG=$(mktemp -t gitci.XXXXXX)
>  LOGMSG2=$(mktemp -t gitci.XXXXXX)

The variable? What variable?

> Index: cg-status
> ===================================================================
> --- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-status  (mode:100755)
> +++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-status  (mode:100755)
> @@ -15,21 +15,11 @@
>  
>  {
>  	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
> -} | sort -z -k 2 | xargs -0 sh -c '
> -while [ "$1" ]; do
> -	tag=${1% *};
> -	filename=${1#* };
> -	case "$filename" in
> -	*.[ao] | tags | ,,merge*) ;;
> -	*)   echo "$tag $filename";;
> -	esac
> -	shift
> -done
> -' padding
> +} | sort -z -k 2 | cg-Xignore -0 -t | tr "\000" "\n"

So you have two ignores now - exclude and Xignore.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
