From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] send-email: extract_valid_address use qr//
 regexes and /o
Date: Fri, 1 Oct 2010 01:40:29 -0400
Message-ID: <20101001054029.GA18674@sigill.intra.peff.net>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
 <1285854189-10240-14-git-send-email-avarab@gmail.com>
 <20100930161912.GA8707@sigill.intra.peff.net>
 <AANLkTimSHxU8EhuOHn77kw+ASCCeg_Bjg2or7L=G_o=M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 07:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1YMH-0000TZ-Qx
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 07:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab0JAFkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 01:40:31 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52504 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836Ab0JAFkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 01:40:31 -0400
Received: (qmail 28558 invoked by uid 111); 1 Oct 2010 05:40:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 01 Oct 2010 05:40:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Oct 2010 01:40:29 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimSHxU8EhuOHn77kw+ASCCeg_Bjg2or7L=G_o=M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157732>

On Thu, Sep 30, 2010 at 04:33:59PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > But we are unnecessarily compiling the sub-regexes each time. Not t=
hat
> > this is probably a performance critical piece of code, but your "/o=
" is
> > doing very little, and this is exactly the sort perl wankery that I=
 find
> > interesting.
>=20
> IIRC different perl versions treat this differently. In more recent
> versions doing:
>=20
>     perl -Mre=3Ddebug -E 'sub x { my $x =3D qr/foo/; my $y =3D qr/bar=
/;
> /$x$y/ } x($_) for 1..2'

Ah, right. I am used to using qr// with variable input (since that is
the intended use), but of course perl is smart enough to just need to
compile qr/constant/ once.

> Will only compile all of those regexes once, since perl can see that
> they're constant. So the /o does nothing.

Nice. I didn't think it would be smart enough to handle the layer of
indirection, but obviously it does. Go perl.

> We might want to keep it for self-documentation purposes to indicate
> that the $local_part_regexp would never change, but it's probably bes=
t
> to drop that /o altogether.

Yeah, I would just drop the /o. It will in all probability never change=
,
but it it _did_, I think having the /o just makes it buggy.

> Perl has static variables like that, just not in the ancient version
> we're pinned to:
>=20
>     sub foo {
>         state $foo =3D qr/$_[0]/
>     }

Nice, I obviously have not kept up on my perl-changelog-reading. ;) But
yeah, it's not in 5.8. It's a moot point anyway, since as you
demonstrated above, perl is already doing the optimization.

-Peff
