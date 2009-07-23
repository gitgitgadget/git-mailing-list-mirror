From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Thu, 23 Jul 2009 10:50:47 +0200
Message-ID: <20090723085046.GK4750@laphroaig.corp>
References: <20090723074104.GI4750@laphroaig.corp>
 <200907231041.32567.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 23 10:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTu0w-0001WQ-2a
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 10:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZGWIuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 04:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZGWIuu
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 04:50:50 -0400
Received: from pan.madism.org ([88.191.52.104]:40941 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbZGWIut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 04:50:49 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id 25FCD41DC4;
	Thu, 23 Jul 2009 10:50:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907231041.32567.trast@student.ethz.ch>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123860>

On Thu, Jul 23, 2009 at 10:41:31AM +0200, Thomas Rast wrote:
> Pierre Habouzit wrote:
> > One of my most frequent use case for git-add -p is when I had an in=
tense
> > debug session with quite a lot of debug() traces added. I then want=
 only
> > to select the hunks corresponding to the bugfixes and throw away th=
e debug
> > ones.
> >=20
> > With this new operation, instead of not staging hunks I don't want =
and
> > will eventually undo, I can just undo them.
>=20
> This is what 'git checkout --interactive -- $file' or 'git reset
> --interactive --hard' would accomplish, if they existed.  I wonder if
> there would be a way to avoid yet more command letters, and instead
> have "modes" that affect what happens with hunks you said 'y' to.  Fo=
r
> example:
>=20
>   add -p		apply --cached
>   undo -p		apply -R
>   unstage -p		apply -R --cached
>     [with hunks coming from diff --cached obviously]
>=20
> (I picked 'undo' and 'unstage' semi-randomly, but it's not, after all=
,
> an 'add' operation any more and the user doesn't need to know that th=
e
> program doing this is in fact git-add--interactive.)

The point is I want to do them at once, see my use case: I want to stag=
e
the hunks from my bugfix, and remove the debugging bits of it at the
same time, I don't want to run two commands.

I see git add -p as a triaging command, giving me the choice to do the
three things you can do with a hunk:
  - stage it now (y)
  - stage it later (n)
  - never stage it, it was intermediate code, debug, whatever (u).

> > +       u - do not stage this hunk and revert it
>=20
> you're overloading terminology a bit too much for my taste.  It has
> nothing to do with what git-revert does, and we shouldn't confuse
> people more about that.

Right, revert is probably too overloaded, let it be "forget" or "drop"
instead if you want, I don't care much.

> >  Documentation/git-add.txt |    1 +
> >  git-add--interactive.perl |   38 ++++++++++++++++++++++++++++++---=
-----
>=20
> Tests?

Riight, will do :)

> > @@ -693,6 +693,7 @@ sub split_hunk {
> >  			ADDDEL =3D> 0,
> >  			POSTCTX =3D> 0,
> >  			USE =3D> undef,
> > +			UNDO =3D> undef,
> >  		};
>=20
> Why not fold this into a single field?  It could, say, take values 0,
> 1, or '-R'.  It could probably be renamed to ACTION, but USE would be
> fine if you want to avoid the code churn.  Then you shouldn't need
> _completely_ separate handling during application.
>=20
> > @@ -1149,6 +1152,10 @@ sub patch_update_file {
> >  			elsif ($line =3D~ /^n/i) {
> >  				$hunk[$ix]{USE} =3D 0;
>=20
> +				$hunk[$ix]{UNDO} =3D 0;
>=20
> and similarly for [yad] too, on the grounds that the user can go back
> and change his choices with [KJ].  Of course that is not necessary if
> you go the ACTION way outlined above.

I hesitated to do so, but yes it makes perfect sense.

> > +	if (@undo) {
> > +		my $fh;
> > +
> > +		open $fh, '| git apply -R';
>=20
> This probably needs a --recount to cope with the case where the hunk
> headers became stale/invalid through user [e]diting.

Indeed.

--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
=46ax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie
