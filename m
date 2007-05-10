From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 18:04:55 +0100
Message-ID: <464350B7.3030601@shadowen.org>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>	<20070509.150256.59469756.davem@davemloft.net>	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>	<20070509.162301.48802460.davem@davemloft.net>	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net> <7vd519r10c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 19:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmC4s-0006M7-Fe
	for gcvg-git@gmane.org; Thu, 10 May 2007 19:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbXEJREx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 13:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbXEJREx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 13:04:53 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4208 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbXEJREw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 13:04:52 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1HmCBE-0006JW-Vj; Thu, 10 May 2007 18:11:53 +0100
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <7vd519r10c.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46879>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
>> David Miller <davem@davemloft.net> writes:
>>
>>> From: Junio C Hamano <junkio@cox.net>
>>> Date: Wed, 09 May 2007 15:59:23 -0700
>>>
>>>> The above sequence is called before we create the new directory
>>>> and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
>>>> we need to explicitly say /bin/pwd or somesuch...
>>> Indeed:
>>>
>>> [davem@hera ~]$ pwd
>>> /home/davem
>>> [davem@hera ~]$ cd git
>>> [davem@hera git]$ pwd
>>> /home/davem/git
>>> [davem@hera git]$ /bin/pwd
>>> /home/ftp/pub/scm/linux/kernel/git/davem
>>> [davem@hera git]$ 
>> Thanks.
> 
> This would fix it, but I find this kind of ugly.
> 
> -- >8 --
> git-clone: don't get fooled by $PWD
> 
> If you have /home/me/git symlink pointing at /pub/git/mine,
> trying to clone from /pub/git/his/ using relative path would not
> work as expected:
> 
> 	$ cd /home/me
>         $ cd git
>         $ ls ../
>         his    mine
>         $ git clone -l -s -n ../his/stuff.git
> 
> This is because "cd ../his/stuff.git" done inside git-clone to
> check if the repository is local is confused by $PWD, which is
> set to /home/me, and tries to go to /home/his/stuff.git which is
> different from /pub/git/his/stuff.git.
> 
> We could probably say "set -P" (or "cd -P") instead, if we know
> the shell is POSIX, but the way the patch is coded is probably
> more portable.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
> diff --git a/git-clone.sh b/git-clone.sh
> index cad5c0c..c5852a2 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -18,7 +18,14 @@ usage() {
>  }
>  
>  get_repo_base() {
> -	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
> +	(
> +		cd "`/bin/pwd`" &&
> +		cd "$1" &&
> +		(
> +			cd .git
> +			pwd
> +		)
> +	) 2>/dev/null
>  }
>  
>  if [ -n "$GIT_SSL_NO_VERIFY" ]; then

That is pretty much how I have seen this solved in the past.  One thing
while you are playing with this code.  There seems to be an extra
sub-shell in there unnecesarily and the error redirection seems a little
aggressive?

This seems to be semantically equivalent:

get_repo_base() {
	(
		cd "`/bin/pwd`" &&
		cd "$1" &&
		{
			cd .git 2>/dev/null
			pwd
		}
	)
}

-apw
