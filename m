From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] cygwin: Convert paths for html help from posix to windows
Date: Sat, 24 Jan 2009 18:51:23 +0000
Message-ID: <497B632B.1060801@ramsay1.demon.co.uk>
References: <20090122171605.GA16684@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, jaeckel@stzedn.de,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQneM-0006gj-Fe
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbZAXSxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jan 2009 13:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbZAXSxJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:53:09 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:33647 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753678AbZAXSxI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 13:53:08 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1LQncv-00072u-iS; Sat, 24 Jan 2009 18:53:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20090122171605.GA16684@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106990>

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
