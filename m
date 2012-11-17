From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 4/5] completion: get rid of compgen
Date: Sat, 17 Nov 2012 15:12:15 +0100
Message-ID: <20121117141215.GG12052@goldbirke>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
 <1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
 <20121117110031.GE12052@goldbirke>
 <CAMP44s21CUb3_KhHBfJXW+Eqd45kz1hcbx3GCbs+f0HNRDEAzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:12:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZj8Z-0007Ka-CB
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789Ab2KQOMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:12:33 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:54905 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2KQOMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:12:33 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MMaaI-1TeeYI1E3q-008TjI; Sat, 17 Nov 2012 15:12:16 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s21CUb3_KhHBfJXW+Eqd45kz1hcbx3GCbs+f0HNRDEAzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:TRw2Dxnbkwurnp+oP1tTrqBDGVDLaFup4M52N3vSqmV
 W+/Eoy3ACg8XJN+7zfhU1d59Rs+tzY9gfULsYRlZQf35frq5TA
 wh6mWR7uGdZwZk+Zz/vejmofR2e6+XUN5+PATErmUcqo5AoNuP
 OG8A22pCCP+Bd6GtHirrzZsMFa0hNM/EhQ/QTzmGxVCYsVOW+u
 MqQMcT+rCOi/nM29qE3w/6/iBg+c3wrH9lpAV9yg57phHPYx16
 He/9VpVdidW841KgEbIPd6f1MvvuRDbsLTPVpRdyPXwjs64ral
 ljXhpP7R0KDaS6ViyK4jcL+Q7EknXqaFNXCFeYAoy2rInsny1V
 LYYeQ1trzgyyEuAj4O8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209955>

On Sat, Nov 17, 2012 at 12:42:38PM +0100, Felipe Contreras wrote:
> On Sat, Nov 17, 2012 at 12:00 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
> > On Sat, Nov 17, 2012 at 02:38:17AM +0100, Felipe Contreras wrote:
> >> The functionality we use is very simple, plus, this fixes a known
> >> breakage 'complete tree filename with metacharacters'.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  contrib/completion/git-completion.bash | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/comp=
letion/git-completion.bash
> >> index 975ae13..ad3e1fe 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -227,7 +227,11 @@ fi
> >>
> >>  __gitcompadd ()
> >>  {
> >> -     COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
> >> +     for x in $1; do
> >> +             if [[ "$x" =3D "$3"* ]]; then
> >> +                     COMPREPLY+=3D("$2$x$4")
> >> +             fi
> >> +     done
> >
> > The whole point of creating __gitcomp_nl() back then was to fill
> > COMPREPLY without iterating through all words in the wordlist, maki=
ng
> > completion faster for large number of words, e.g. a lot of refs, or
> > later a lot of symbols for 'git grep' in a larger project.
> >
> > The loop here kills that optimization.
>=20
> So your solution is to move the loop to awk? I fail to see how that
> could bring more optimization, specially since it includes an extra
> fork now.

This patch didn't aim for more optimization, but it was definitely a
goal not to waste what we gained by creating __gitcomp_nl() in
a31e6262 (completion: optimize refs completion, 2011-10-15).  However,
as it turns out the new version with awk is actually faster than
current master with compgen:

  Before:

    $ refs=3D"$(for i in {0..9999} ; do echo branch$i ; done)"
    $ time __gitcomp_nl "$refs"

    real    0m0.242s
    user    0m0.220s
    sys     0m0.028s

  After:

    $ time __gitcomp_nl "$refs"

    real    0m0.109s
    user    0m0.096s
    sys     0m0.012s
