From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Git commit path vs rebase path
Date: Thu, 10 May 2012 19:10:02 +0100
Message-ID: <4FAC047A.4010001@ramsay1.demon.co.uk>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>	<4FA8BBB0.1080406@viscovery.net>	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>	<4FA8C5DB.5060002@viscovery.net>	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>	<7v1umuwpo9.fsf@alter.siamese.dyndns.org> <CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSXq0-00064g-3e
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760349Ab2EJSLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 14:11:35 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:49958 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758939Ab2EJSLf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 14:11:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SSXps-0001jj-l4; Thu, 10 May 2012 18:11:33 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197610>

Steven Penny wrote:
> Junio C Hamano wrote:
>> Actually, the above is stated rather poorly.  The path that ends up =
in
>> $file must be usable by both Windows native and Cygwin programs, as =
the
>> user may be using "vi" from Cygwin, or "notepad" like your example.
>=20
> Excellent point.
>=20
> I ran some test and this is what I came up with
>=20
> # VI
> /cygdrive/c/test/hello.sh # works
> C:\test\hello.sh # works
> C:/test/hello/sh # works
>=20
> # NOTEPAD
> /cygdrive/c/test/hello.sh # does not work
> C:\test\hello.sh # works
> C:/test/hello.sh # works
>=20
> so the best compromise would be "C:/test/hello.sh" which can be creat=
ed with
>=20
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7b3ae75..ba198d2 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -260,6 +260,11 @@ case $(uname -s) in
>  		return 1
>  	}
>  	;;
> +*CYGWIN*)
> +    pwd () {
> +        builtin cygpath -m
> +    }
> +    ;;
>  *)
>  	is_absolute_path () {
>  		case "$1" in
>=20
> http://github.com/svnpenn/git/commit/692bc

I would rather define a script; it can then be used independently of gi=
t.

Personally, I don't have this specific problem because I use (the cygwi=
n
version of) vim. (does anybody actually use notepad?)

I mostly, but not exclusively, use cygwin tools on cygwin. For example =
I
use win32 versions of doxygen, ghostscript, tex (MikTex 2.7), graphviz =
etc.
However, the makefiles which drive those tools use relative paths ...

In fact the only problem I have encountered is with firefox, which I
resolved by hacking up a script. Indeed I have already posted to the
list on this issue before (back in January 2009) and, to save you the
effort of trawling the archives, I append that mail below.

HTH

ATB,
Ramsay Jones

-- >8 --
Date: Sat, 24 Jan 2009 18:51:23 +0000
=46rom: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =3D?ISO-8859-1?Q?Bj=3DF6rn_Steinbrink?=3D <B.Steinbrink@gmx.de>
CC: Junio C Hamano <gitster@pobox.com>,  jaeckel@stzedn.de,=20
 git@vger.kernel.org
Subject: Re: [PATCH] cygwin: Convert paths for html help from posix to =
windows

Bj=F6rn Steinbrink wrote:
> When using "git help --web" with cygwin, we used to pass the posix pa=
th
> to the browser, but a native windows browser will expect a windows pa=
th
> and is unable to make use of the given path.
>=20
> So the cygwin port gets its own open_html implementation that handles
> the path conversion.
>=20
> Reported-by: Steffen Jaeckel <jaeckel@stzedn.de>
> Tested-by: Steffen Jaeckel <jaeckel@stzedn.de>
>=20
> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
> OK, I don't really know if this is the right way to do it. Maybe when
> the browser was built for cygwin this breaks? I have no clue, it's
> admittedly just the result of a quick glance at the code and some
> googling to find the "right" cygwin function... :-/
>=20

Hi Bj=F6rn,

I had the same problem. However, rather than modifying git, I created a
firefox wrapper script (in ~/bin) which used the cygpath command line
tool to do the path conversion. Also, if you use "git instaweb", you
also need to filter out http URLs and pass them through un-molested
by cygpath (it turns http://localhost into http:\localhost).

My script is clearly a "quick hack" just to get something working for
me, but you may find it useful as a starting point for your own
("proper" ;-) script, so I've included it below.

HTH,
Ramsay Jones

-->8--
#!/bin/sh
#

while test $# !=3D 0
do
    case "$1" in
	-version)
	    echo "firefox 1.5.0.2"
	    exit 0
	    ;;
	-new-tab)
	    echo "-new-tab not supported"
	    exit 1
	    ;;
	--)
	    shift
	    break
	    ;;
	-*)
	    echo "option '$1' not supported"
	    exit 1
	    ;;
	*)
	    break
	    ;;
    esac
    shift
done

if test "$1" =3D ""
then
	p=3D
else
	case "$1" in
	    http*)
		p=3D"$1"
		;;
	    *)
		p=3D"$(cygpath -w "$1")"
		;;
	esac
fi


"/cygdrive/c/Program Files/Mozilla Firefox/firefox.exe" "$p"

exit 0



-- 8< --
