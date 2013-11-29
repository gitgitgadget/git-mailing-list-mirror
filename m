From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] stash: handle specifying stashes with spaces
Date: Fri, 29 Nov 2013 20:54:11 +0100
Message-ID: <87k3frdlwc.fsf@thomasrast.ch>
References: <1385752979-28162-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 20:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmU96-00087B-2b
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 20:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab3K2Tya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Nov 2013 14:54:30 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:36065 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab3K2Ty1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Nov 2013 14:54:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E839A4D6574;
	Fri, 29 Nov 2013 20:54:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IvOwStJO6G0Y; Fri, 29 Nov 2013 20:54:14 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 659354D64DE;
	Fri, 29 Nov 2013 20:54:14 +0100 (CET)
In-Reply-To: <1385752979-28162-1-git-send-email-oystwa@gmail.com>
 (=?utf-8?Q?=22=C3=98ystein?=
	Walle"'s message of "Fri, 29 Nov 2013 20:22:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238536>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> When trying to pop/apply a stash specified with an argument containin=
g
> spaces the user will see an error:
>
>     $ git stash pop 'stash@{two hours ago}'
>     Too many revisions specified: stash@{two hours ago}
>
> This happens because word splitting is used to count non-option
> arguments. Instead shift the positional arguments as the options are
> processed; the number of arguments left is then the number we're afte=
r.
[...]
>  	for opt
>  	do
>  		case "$opt" in
>  			-q|--quiet)
>  				GIT_QUIET=3D-t
> +				shift
>  			;;
>  			--index)
>  				INDEX_OPTION=3D--index
> +				shift
>  			;;
>  			-*)
>  				FLAGS=3D"${FLAGS}${FLAGS:+ }$opt"
> +				shift
>  			;;
>  		esac
>  	done
> =20
> -	set -- $REV
> -

But this isn't correct any more, is it?  You unconditionally shift off
arguments when you see something of the form -*, even if what you shift
is not what you're currently looking at.

=46or example, without this patch:

  $ g stash apply stash@{0} --index
  On branch next
  Your branch is ahead of 'origin/next' by 41 commits.
    (use "git push" to publish your local commits)
  [blah blah]

but with this patch:

  $ g stash apply stash@{0} --index
  --index is not valid reference


Granted, git-stash is extremely inconsistent in its handling of options=
=2E
=46or example, 'git stash save foo -k' does _not_ treat -k as an option=
=2E
If you set out to unify this (not just randomly (un)break one
subroutine) I'd be all for it.

--=20
Thomas Rast
tr@thomasrast.ch
