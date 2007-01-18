From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Thu, 18 Jan 2007 08:17:23 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070118071723.GB3245@informatik.uni-freiburg.de>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116200847.GB29100@spearce.org> <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070117164410.GA5950@cepheus> <7vps9dsgn0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 18 08:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7RWd-0004mD-Vu
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 08:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARHR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 Jan 2007 02:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXARHR3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 02:17:29 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:56564 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990AbXARHR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jan 2007 02:17:28 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H7RWZ-0001AE-Eb; Thu, 18 Jan 2007 08:17:27 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0I7HOEk003969;
	Thu, 18 Jan 2007 08:17:24 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0I7HN1j003968;
	Thu, 18 Jan 2007 08:17:23 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7vps9dsgn0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37061>

Hello Junio,

Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <zeisberg@informatik.uni-freiburg.de> writes:
>=20
> > I tried to do the symmetric part for fetch, but that shell script i=
s too
> > complicated for me and so I let this part to s.o. being more famili=
ar
> > with git-fetch.sh.
>=20
> I do not know what s.o. is but something like this untested
> patch would do.
s.o. =3D someone, I thought it's a usual abbreviation.
=20
> I do not have strong objection to the configuration on the push
> side, but I am not sure if we want to call it pushexec -- it is
> naming receive-pack so remote.*.receivepack might be more
> appropriate, just in case we update the fetch/push protocol
> someday to run more than one program on the other end.
I wondered about that, too.  In the docs we currently have:

	git-send-pack ... [--exec=3D<git-receive-pack>]
	git-fetch-pack ... [--exec=3D<git-upload-pack>]
	git-push ... [--exec=3D<receive-pack>]
	git-pull ... [--upload-pack <upload-pack>]
	git-fetch ... [--upload-pack <upload-pack>]

I have choosen 'pushexec' because that's the name of the option to push=
=2E
remote.*.receivepack is cleaner, as is

	git-push ...  [--receive-pack=3D...]

=2E  If we choose remote.*.receivepack, we should consider deprecating
--exec and introduce --receive-pack (--upload-pack resp.)
=20
> diff --git a/git-fetch.sh b/git-fetch.sh
> index 87b940b..7372c5f 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -82,6 +82,13 @@ case "$#" in
>  	set x $origin ; shift ;;
>  esac
> =20
> +if test -z "$exec" && exec=3D$(git-repo-config "remote.$1.uploadpack=
")
> +then
> +	# No command line override and we have configuration for the remote=
=2E
> +	upload_pack=3D"-u $exec"
> +	exec=3D"--exec=3D$exec"
> +fi
> +
>  remote_nick=3D"$1"
>  remote=3D$(get_remote_url "$@")
>  refs=3D

I thought that it would be cleaner to add this code to
git-parse-remote.sh and only do it if $(get_data_source) =3D=3D 'config=
'.
But it's OK for me this way, too.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

If a lawyer and an IRS agent were both drowning, and you could only sav=
e
one of them, would you go to lunch or read the paper?
