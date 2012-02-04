From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 4/4] completion: simplify __gitcomp*
Date: Sat, 4 Feb 2012 14:54:04 +0100
Message-ID: <20120204135404.GF16099@goldbirke>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-5-git-send-email-felipe.contreras@gmail.com>
	<7vty37oedr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 14:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtg4D-0000MU-6q
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 14:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2BDNyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 08:54:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:60525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2BDNyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 08:54:07 -0500
Received: from localhost6.localdomain6 (p5B130ED9.dip0.t-ipconnect.de [91.19.14.217])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M1AGu-1SiTKb1NpQ-00tLzq; Sat, 04 Feb 2012 14:54:01 +0100
Content-Disposition: inline
In-Reply-To: <7vty37oedr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:bBkWAZlxOfHS8ZnozbWkQtyJ5y3VFupOcBXAnFC5iSW
 MF/NoLdIywg6dB2pEOzc2oHTbS4shViZCtngUcOC9NR2z+TIGr
 mXORJfLLT3YDKcIb2et3Dnw7nh12GDSYQMyAgZW7DROQ4lks7o
 Lnqmj0edXJ2rxnnq0L0vbsPdKuUtevkON7nsEhonQZzUFjsaTg
 P8eFAGaOv6GaPUSEL05/FmxGorN/Mz6UcdksttlCKQGxtQeyHr
 GYhO3inr0jQ532vRfBJDcjyny6ct+sz9ADfx1qBX96LM9DrEie
 0o2yH7h4o7jxqdut63xU8BlubY2AxD8FQXOLMXLGZ1gnV8wc5N
 lVtToUIBxtlrtT0OiwU/aCURmNkxtKN0iaJewcfVR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189869>

Hi,


On Fri, Feb 03, 2012 at 12:23:12PM -0800, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>=20
> > @@ -495,11 +495,7 @@ fi
> >  # 4: A suffix to be appended to each possible completion word (opt=
ional).
> >  __gitcomp ()
> >  {
> > -	local cur_=3D"$cur"
> > -
> > -	if [ $# -gt 2 ]; then
> > -		cur_=3D"$3"
> > -	fi
> > +	local cur_=3D"${3:-$cur}"
> >  	case "$cur_" in
> >  	--*=3D)
> >  		COMPREPLY=3D()
>=20
> I think this rewrite is wrong, even though it may not make a differen=
ce to
> the current callers (I didn't check).  Drop the colon from ${3:-...}.
>=20
> > @@ -524,18 +520,8 @@ __gitcomp ()
> >  #    appended.
> >  __gitcomp_nl ()
> >  {
> > -	local s=3D$'\n' IFS=3D' '$'\t'$'\n'
> > -	local cur_=3D"$cur" suffix=3D" "
> > -
> > -	if [ $# -gt 2 ]; then
> > -		cur_=3D"$3"
> > -		if [ $# -gt 3 ]; then
> > -			suffix=3D"$4"
> > -		fi
> > -	fi
> > -
> > -	IFS=3D$s
> > -	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"=
))
> > +	local IFS=3D$'\n'
> > +	COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3:-$c=
ur}"))
>=20
> So is this.
>=20
> Fixing the above two gives me what I've already sent in $gmane/189683=
,
> so...
>=20

Good point, I missed this when pointed out the similar issue with $4
earlier.

And it does make a difference, it breaks the completion of a single
word in multiple steps, e.g. git log --pretty=3D<TAB> master..<TAB>.  I=
n
such cases we pass "${cur##--pretty=3D}" and "${cur_#*..}" as third
argument to __gitcomp() and __gitcomp_nl(), which can be empty strings
when the user hits TAB right after the '=3D' and '..'.  Replacing that
empty string with $cur is bad, because none of the possible completion
words (i.e. $1) will match it, and bash will fall back to filename
completion.

Without the colon, i.e. using "${3-$cur}", it works as expected.


Best,
G=E1bor
