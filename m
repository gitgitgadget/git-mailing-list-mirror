From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 30 Sep 2005 10:01:22 -0700
Message-ID: <433D6F62.3030906@zytor.com>
References: <433B3B10.5050407@zytor.com> <7v4q826ffy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 19:01:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELOGU-0000da-Be
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 19:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVI3RBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVI3RBi
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 13:01:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36543 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030375AbVI3RBi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 13:01:38 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8UH1Maq020292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Sep 2005 10:01:27 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q826ffy.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9567>

Junio C Hamano wrote:
> 
> Could you do update-server-info there, please?
> 

Done...

> 
> Knowing nothing about Cygwin environment, here are some
> comments.
> 
>         +# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
> 
> This part probably is applicable outside Cygwin.  At some point,
> can we have it in the mainline please?
> 

Well, I would hope that all the changes could eventually be merged.

>          # The ones that do not have to link with lcrypto nor lz.
>          SIMPLE_PROGRAMS = \
>         -	git-get-tar-commit-id git-mailinfo git-mailsplit git-stripspace \
>         -	git-daemon git-var
>         +	git-get-tar-commit-id$(X) git-mailinfo$(X) git-mailsplit$(X) \
>         +	git-stripspace$(X) git-var$(X) git-daemon$(X)
>  
> I have seen these $(X) in other programs' ports and found them
> quite distasteful.  Since I not have immediate suggestions
> for improvements, I do not have rights to complain, though.
> 
> Spelling it $X is a bit less distracting but not that much
> better.  Maybe "SIMPLE_PROGRAM_NAMES = git-foo git-bar" and
> "SIMPLE_PROGRAMS = $(patsubst %,%$X,$(SIMPLE_PROGRAM_NAMES))"...
> but that would not help bits like this:
> 
>         -	PROGRAMS += git-http-fetch
>         +	PROGRAMS += git-http-fetch$(X)
> 
> or this: 
> 
>         -git-%: %.o $(LIB_FILE)
>         +git-%$(X): %.o $(LIB_FILE)
> 
> ... so I'd shut up about this part.

My first cut had PROGRAMS_X and SIMPLE_PROGRAMS_X being patsubst of the 
original versions, but in the end I decided it was even uglier, because 
these patterns were needed elsewhere.  I'll change them to $X except 
where the parens are needed.

>         diff --git a/daemon.c b/daemon.c
>         --- a/daemon.c
>         +++ b/daemon.c
>         @@ -1,9 +1,11 @@
>          #include "cache.h"
>          #include "pkt-line.h"
>         +#include <alloca.h>
> 
> Why?  I do not see any use of alloca in the added code...

I originally used alloca() before changing my mind and using calloc(); I 
think there might be platforms without alloca out there.

>         +#include <sys/poll.h>
> 
> Is poll preferrable over select in general?  Some may have only
> select available and others may have only poll available,
> perhaps?  In any case, this is probably relevant to wider
> audience than just Cygwin; please give it to mainline at some
> point, perhaps conditionally allowing either/both.

The main reason I switched to poll() is that I believe all platforms 
that are even remotely relevant have both these days, and forming a poll 
list is so much cleaner than forming a select set.  What makes forming a 
select set even remotely bearable is the invalid assumption that the 
number of file descriptors is bounded at compile time and therefore that 
fdset_t can be statically allocated.  We've had problems in the past 
with that assumption on Linux, and I've tried to avoid select since then.

>         +	*socklist_p = malloc(sizeof(int));
>         +	pfd = calloc(socknum, sizeof(struct pollfd));
> 
> Please use xmalloc and xcalloc just for consistency.

Check.

>                 test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
>         +
>         +	# In case we're running on Cygwin...
>         +	test -x $path/git-$cmd.exe && exec $path/git-$cmd.exe "$@" ;;
>          esac
>  
> Hmph, I think you forgot to drop double semicolon there.

D'oh!

> The git.sh script is munged by Makefile so presumably we could
> fix this part up there, like:
> 
>         git: git.sh Makefile
>                 rm -f $@+ $@
>                 sed -e '1s|#!.*/sh|#!$(SHELL_PATH)|' \
>                     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>                     -e 's/@@X@@/$X/g' <$@.sh >$@+
>                 chmod +x $@+
>                 mv $@+ $@
> 
> And then (a patch on top of your "master"):
> 
> diff --git a/git.sh b/git.sh
> --- a/git.sh
> +++ b/git.sh
> @@ -12,10 +12,14 @@ case "$#" in
>  		exit 0 ;;
>  	esac
>  
> -	test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
> +	test -x $path/git-$cmd && exec $path/git-$cmd "$@"
>  
> -	# In case we're running on Cygwin...
> -	test -x $path/git-$cmd.exe && exec $path/git-$cmd.exe "$@" ;;
> +	case '@@X@@' in
> +	'')
> +		;;
> +	*)
> +		test -x $path/git-$cmd@@X@@ && exec $path/git-$cmd@@X@@ "$@" ;;
> +	esac		
>  esac
>  
>  echo "Usage: git COMMAND [OPTIONS] [TARGET]"

That wouldn't work, because the shell scripts don't get the .exe 
extension.  However, I can figure out something equivalent.

	-hpa
