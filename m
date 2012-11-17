From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 5/7] completion: fix expansion issues in __gitcomp_nl()
Date: Sat, 17 Nov 2012 15:14:22 +0100
Message-ID: <20121117141422.GI12052@goldbirke>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-6-git-send-email-szeder@ira.uka.de>
 <CAMP44s1ZgNM1WXPu_-q9aFkz8Ui3czwcUqHWvs7Yspi_p9kuNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZjAM-0000Tk-G9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2KQOOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:14:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53867 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2KQOOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:14:24 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MP3YZ-1TcBb61ZyB-006Y3Y; Sat, 17 Nov 2012 15:14:23 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s1ZgNM1WXPu_-q9aFkz8Ui3czwcUqHWvs7Yspi_p9kuNQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:C7cXMbJ1yXqn4ErU0kEu+lkAeNLwTU4vUb77govuoT8
 R4fYMOdtho2Gr+DsCiArhUSB+cof01PIaVAZnsU3J1xktoolFW
 jZ42MvVKfei68JwRZpaWIkoAvaaj/8fy0wKBs19vcqW9KrxPNF
 2uhyhJbpm2Rqzy4x0NQZY70GLSSOlcCy4gkzj4CnR5RQd8R+YK
 eERoyhylbwNQdTnpc6bM1FQHEu1xQrgY90ZxTNvnaPcwo3IXII
 TuRd9gPDRdqVaYMqIS7SWLOCJfbBhM+R8dnhGlavdpOxp+7eB8
 1UZXWx3sVpwYlKrvvgvhVAQgA1Icrf5HEGHIdcs3P+skHNDf7I
 XwF2EfRQSzp1tATD5A2o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209957>

On Sat, Nov 17, 2012 at 12:50:39PM +0100, Felipe Contreras wrote:
> On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
>=20
> >  __gitcomp_nl ()
> >  {
> >         local IFS=3D$'\n'
> > -       COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "$=
{3-$cur}"))
> > +       COMPREPLY=3D($(awk -v pfx=3D"${2-}" -v sfx=3D"${4- }" -v cu=
r=3D"${3-$cur}" '
> > +               BEGIN {
> > +                       FS=3D"\n";
> > +                       len=3Dlength(cur);
> > +               }
> > +               {
> > +                       if (cur =3D=3D substr($1, 1, len))
> > +                               print pfx$1sfx;
> > +               }' <<< "$1" ))
> >  }
>=20
> Does this really perform better than my alternative?
>=20
> +       for x in $1; do
> +               if [[ "$x" =3D "$3"* ]]; then
> +                       COMPREPLY+=3D("$2$x$4")
> +               fi
> +       done

It does:

  My version:

    $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
    $ time __gitcomp_nl "$refs"

    real    0m0.109s
    user    0m0.096s
    sys     0m0.012s

  Yours:

    $ time __gitcomp_nl "$refs"

    real    0m0.321s
    user    0m0.312s
    sys     0m0.008s
