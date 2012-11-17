From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 6/7] completion: fix expansion issue in __gitcomp()
Date: Sat, 17 Nov 2012 15:09:25 +0100
Message-ID: <20121117140925.GF12052@goldbirke>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
 <1353150353-29874-7-git-send-email-szeder@ira.uka.de>
 <CAMP44s3J3e_bcyoQmcdQno59dPJuJ4=7ej=-eseE5j2tteD=dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZj5d-0004UQ-Ug
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab2KQOJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:09:32 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:49281 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2KQOJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:09:31 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LroEc-1T9pwv20GU-013UJG; Sat, 17 Nov 2012 15:09:28 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3J3e_bcyoQmcdQno59dPJuJ4=7ej=-eseE5j2tteD=dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:81z+3aA0Ozmv924R/Qmw0SfKOJoaNza3qUjrn1g+L5h
 BJplz3rLhCq/lcBS/4JkaNs1rW4N5HYqnvBduq8K7+uMFzSfCL
 Y/ViUusLT/NNX9ccpclPJqeLr2pGfXaJeOrcGDwav3pMCwd8XP
 I5YHmIIBEAm+SIlVDVC7IP22SMThXPlLvP2udbkus8Kq2VKcly
 KmyIbR/Zxy/Gd82Svgp0SNnxY33dvUMHuefTmBwurOM5zPo2HW
 c7nYVO4/j4XMPHSoNu6P2WIWjXrQ2jYFWjM7pUe5KX0Ean/Xfw
 gX3KY2pgT/fFiSf17mfwV97lH8CzGNCCdmrraEFwtAfF/vNPwV
 XSA6hj7TO9z8+NluORwQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209954>

On Sat, Nov 17, 2012 at 12:39:24PM +0100, Felipe Contreras wrote:
> On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
>=20
> > -# Generates completion reply with compgen, appending a space to po=
ssible
> > -# completion words, if necessary.
> > +# Generates completion reply for the word in $cur, appending a spa=
ce to
> > +# possible completion words, if necessary.
> >  # It accepts 1 to 4 arguments:
> >  # 1: List of possible completion words.
> >  # 2: A prefix to be added to each possible completion word (option=
al).
> > -# 3: Generate possible completion matches for this word (optional)=
=2E
> > +# 3: Generate possible completion matches for this word instead of=
 $cur
> > +#    (optional).
> >  # 4: A suffix to be appended to each possible completion word (opt=
ional).
> >  __gitcomp ()
> >  {
> > @@ -241,10 +242,22 @@ __gitcomp ()
> >                 COMPREPLY=3D()
> >                 ;;
> >         *)
> > -               local IFS=3D$'\n'
> > -               COMPREPLY=3D($(compgen -P "${2-}" \
> > -                       -W "$(__gitcomp_1 "${1-}" "${4-}")" \
> > -                       -- "$cur_"))
> > +               local i=3D0 c IFS=3D$' \t\n'
> > +               for c in $1; do
> > +                       case $c in
> > +                       "$cur_"*)
> > +                               c=3D"$c${4-}"
> > +                               case $c in
> > +                               --*=3D*|*.) ;;
> > +                               *) c=3D"$c " ;;
> > +                               esac
> > +                               COMPREPLY[$i]=3D"${2-}$c"
> > +                               i=3D$((++i))
> > +                               ;;
> > +                       *)
> > +                               ;;
> > +                       esac
> > +               done
>=20
> This is not quite the same as before, is it? Before the suffix would
> be taken into consideration for the comparison with $cur_, but not an=
y
> more.

That's a good catch, thanks.

I remember it puzzled me that the suffix is considered in the
comparison (and that a trailing space would be appended even after a
given suffix, too, so there seems to be no way to disable the trailing
space).  However, currently it doesn't make a difference for us,
because afaics we never specify a suffix for __gitcomp().  There were
two instances in _git_config() where we specified "." as suffix, but
those two were converted to __gitcomp_nl().  I changed those callsites
back to __gitcomp() and tried to provoke wrong behavior with the above
patch, but couldn't.

Anyway, it's better to err on the safe side, so here's the fixup.

-- >8 --
Subject: [PATCH] fixup! completion: fix expansion issue in __gitcomp()

---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index a1bf732f..29818fb5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -231,9 +231,9 @@ __gitcomp ()
 	*)
 		local i=3D0 c IFS=3D$' \t\n'
 		for c in $1; do
+			c=3D"$c${4-}"
 			case $c in
 			"$cur_"*)
-				c=3D"$c${4-}"
 				case $c in
 				--*=3D*|*.) ;;
 				*) c=3D"$c " ;;
--=20
1.8.0.220.g4d14ece
