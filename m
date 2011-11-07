From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum
 member
Date: Mon, 7 Nov 2011 11:38:23 -0500
Message-ID: <20111107163823.GB27055@sigill.intra.peff.net>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-4-git-send-email-avarab@gmail.com>
 <m2pqh5nvic.fsf@igel.home>
 <CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
 <m3pqh4krer.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSDO-0000II-JB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab1KGQiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 11:38:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35801
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab1KGQiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:38:25 -0500
Received: (qmail 27416 invoked by uid 107); 7 Nov 2011 16:38:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 11:38:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 11:38:23 -0500
Content-Disposition: inline
In-Reply-To: <m3pqh4krer.fsf@hase.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184993>

On Mon, Nov 07, 2011 at 02:12:28PM +0100, Andreas Schwab wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > I.e. we'll always have GREP_HEADER_AUTHOR =3D 0 and
> > GREP_HEADER_COMMITTER =3D 1, we'll never have GREP_HEADER_AUTHOR =3D=
 and
> > GREP_HEADER_COMMITTER =3D <some int>.
>=20
> That is irrelevant.  You can always assign -1 to an object of enumera=
ted
> type and the implicit conversion to the underlying type is fully
> defined, no matter what type the compiler choses.

Yes, but now you are getting into implementation-defined behavior, whic=
h
is also something to avoid. IOW, I don't think it's wrong for a static
analyzer to complain about:

  if (enum_with_only_positive_values < 0)

just because you could say:

  enum_with_only_positive_values =3D -1;

and it would work on _some_ platforms. That same static analyzer should
be complaining about the second line, which is where the real potential
bug is. If you want "-1" as an enumerated value, then add it to your
enum definition and the compiler will do the right thing.

It is perfectly fine to do:

     enum foo { a =3D -1, b, c };
     ...
     if (foo < 0)
        ...

and the static analyzer should not complain about the conditional there=
=2E

-Peff
