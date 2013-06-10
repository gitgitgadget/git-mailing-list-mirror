From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: remove ancient "ensure colon in
 COMP_WORDBREAKS" workaround
Date: Mon, 10 Jun 2013 11:14:19 +0200
Message-ID: <20130610091419.GF2091@goldbirke>
References: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
 <20130610000954.GA6464@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 11:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlyBr-0001XR-6B
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 11:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab3FJJOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 05:14:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:65477 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3FJJOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 05:14:22 -0400
Received: from localhost6.localdomain6 (g227025092.adsl.alicedsl.de [92.227.25.92])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LrbZ7-1UMMEw3ggn-013q8m; Mon, 10 Jun 2013 11:14:20 +0200
Content-Disposition: inline
In-Reply-To: <20130610000954.GA6464@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:yxafpkVo353jj8cdOR/gA+T6raFv8htlAu/Gjs/ci7h
 13FBuLtI72grhXfy/FEy4lgkQhY2VtNvIdc1GILOGwsLvXjoDf
 w+cR5PatJO0aEFmYkqFcjK7pSH3NeAq0z+zxHYByKJiPf1SYU4
 8b59wrk2Obezd1V83+CAIMHNSpW51wkT1y7O8OSs4S0YGb5+lp
 HBNjX68cuWf67tE1q+6JAB7iLNi4HlYph9QDd0NitYCwfVtwta
 7Tj/qeY+DBzNRRvEEQdeDK3qr1/a1l4JAN+qLiHK1yFKsLYm05
 INVVZS+3F7HS0nmJu2/JMokiqRbKmW05wWR+3KkThAcDtha2rD
 zyfD9++mCW0cQP7F0Duc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227267>


=46irst things first: Junio, please don't pick up this patch.

On Sun, Jun 09, 2013 at 05:09:54PM -0700, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
>=20
> > Fedore 9 shipped the gvfs package with a buggy Bash completion scri=
pt:
> > it removed the ':' character from COMP_WORDBREAKS, thereby breaking
> > certain features of git's completion script.  We worked this around=
 in
> > db8a9ff0 (bash completion: Resolve git show ref:path<tab> losing re=
f:
> > portion, 2008-07-15).
> >
> > The bug was fixed in Fedora 10 and Fedora 9 reached its EOL on
> > 2009-07-10, almost four years ago.  It's about time to remove our
> > workaround.
>=20
> Nice!  I had wondered what that workaround was about but never
> ended up digging into it.

Meh, not nice at all.

> Searching for COMP_WORDBREAKS in /etc/bash_completion.d/* finds
> similar breakage (removal of '=3D' and '@') in the npm completion
> script, but nothing involving colon.  So this looks like a good
> change.

And apparently I have a completion script called axi-cache (from
package apt-xapian-index) which removes ':' [1].  However, it doesn't
remove the ':' upon loading the script but the removal is done in the
completion function, i.e. it takes effect only when the user actually
attempts to complete its options.  I never use axi-cache, whatever the
hell it might be, so I didn't notice.

Unfortunately, with my above patch applied I get this in a new shell:

$ git show master:q<TAB>
$ git show master:quote.<TAB>
master:quote.c   master:quote.h  =20

$ axi-cache <TAB>
again     depends   help      madison   more      policy    rdepends
search    show      showpkg   showsrc  =20

$ git show master:q<TAB>
$ git show quote.<TAB>
quote.c  quote.h  quote.o

Not good.

I don't have the npm package, but manually removing '=3D' from
COMP_WORDBREAKS leads to similar breakage with e.g. 'git log
--pretty=3D'.

Neither this axi-cache not npm completion script comes from the
bash-completion project.  Apparently some developers providing
completion scripts for their projects lack the necessary expertise to
consider the effects their script might have on other completion
scripts.  Perhaps distributions should adopt a policy not to allow
completion scripts messing with COMP_WORDBREAKS, dunno.

Anyway.  Although the completion script in Fedora's gvfs package might
be fixed, there are other completion scripts making the same mistake,
so I'm afraid we should keep the workaround and drop this patch.
Moreover, we should even consider extending our workaround by adding
back '=3D' to COMP_WORDBREAKS, too.  Oh, well.


[1] - This might not be accurate nowadays, as my system is a bit
oldish...


Best,
G=E1bor
