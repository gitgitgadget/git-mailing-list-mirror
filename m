From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/4] git-prompt.sh: refactor colored prompt code
Date: Sun, 23 Jun 2013 16:51:57 +0200
Message-ID: <20130623145157.GN20052@goldbirke>
References: <cover.1371780085.git.erdavila@gmail.com>
 <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
 <CAOz-D1+LoAnoRLgnyRYtq5LQR32RyXp4RR2M5pPTaxaGcXM4yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=D8ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>
To: Eduardo D'Avila <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 16:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqleb-0003Cx-1I
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab3FWOwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 10:52:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51412 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3FWOwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:52:18 -0400
Received: from localhost6.localdomain6 (g227076062.adsl.alicedsl.de [92.227.76.62])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Ls7Op-1U9HJB0Z9r-013MU9; Sun, 23 Jun 2013 16:51:58 +0200
Content-Disposition: inline
In-Reply-To: <CAOz-D1+LoAnoRLgnyRYtq5LQR32RyXp4RR2M5pPTaxaGcXM4yg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Bl0TFeXH1kaF3PGmh11HUn6F75aYk4Hp2oLthFpKVBg
 JuXqib7H9BIoKoJz8jQl4o64k8EHy607BKI2cfIHti9F87u+Qh
 QVDNF1DO410cEeMOJA7p+xcaTwO1UUtm4APD27lc3yTSO1QfAC
 diCZ2H+dGYq6Wx4Nm8WUZfXl+/wySiSdC6dXg3nK/JcOgHu7qT
 AI2p7QPvdBAvWqO4XaFVPF63qo2FWccUb1Js0KvIIl7gW38xxh
 fBMoYrRzkwbrkg88hVqw948md9O0zQSesH4cvC+CKj1HBMacB5
 fx1dg8fiyK4LDPiobMjScuk+2l7I80r36g+fiaKkegnRDRjcL+
 rkIttAanRmxlItlaaTgH3t2C2gIg+27+lsyjFjFnN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228739>

On Sat, Jun 22, 2013 at 01:45:38PM -0300, Eduardo D'Avila wrote:
> 2013/6/22 =D8ystein Walle <oystwa@gmail.com>:
> > I've gotten the impression it's better to use tput to generate the =
escape
> > sequences instead of hardcoding them. So something like:
> >
> > local c_red=3D'\['"$(tput setaf 1)"'\]'
> > local c_green=3D'\['"$(tput setaf 2)"'\]'
> > local c_green=3D'\['"$(tput setaf 4)"'\]'
> > local c_clear=3D'\['"$(tput sgr0)"'\]'
> >
> > which is technically cleaner, if not visually.
> >
> > The problem with that approach is that tput will be run several tim=
es for
> > each prompt, so it would be best if the color variables were global=
=2E Another
> > thing is that you rely on tput being available.
>=20
> Are there any guidelines regarding global shell script variables?

There are a couple of global variables in the completion script, they
are all prefixed with "__git_", e.g. $__git_porcelain_commands.  In
the prompt script we don't have any global variables at the moment,
but if we were to create some, then they should be prefixed similarly.
Or perhaps with "__git_ps1_".  Anyway, in case of a global variable
I'd spell out "color" completely instead of abbreviating it as "c".

> I'm considering doing this:
>    __git_c_red=3D"\[$(tput setaf 1 || echo -e '\e[31m')\]"
> which handles the case where tput is not available.

To me 'tput setaf 1' is just a little bit less greek than '\e[31m'.

I'm wary of relying on tput's availability.  It's part of ncurses,
which is an essential package in many (most? all?) linux distros, but
I don't know how it is with other supported platforms.  So I think
we'd have to stick to the hard-coded escape sequences as a fallback
anyway.  And if we can't get rid of these escape sequences completely,
then I don't really see the point of using tput, especially
considering the additional delay that would be caused by fork()ing
four subshells and fork()+exec()ing four external commands on Windows.

However, I don't know much about the caveats of terminals, so I can't
judge the benefits of using tput instead of the escape sequences. =20


G=E1bor
