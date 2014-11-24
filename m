From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Mon, 24 Nov 2014 18:03:47 -0500
Message-ID: <20141124230346.GA10064@peff.net>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
 <20141124153609.GA25912@peff.net>
 <op.xpudh8c3nngjn5@freezie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:03:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2fj-0006bJ-HE
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbaKXXDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 18:03:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:44436 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751628AbaKXXDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:03:48 -0500
Received: (qmail 15289 invoked by uid 102); 24 Nov 2014 23:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 17:03:48 -0600
Received: (qmail 23310 invoked by uid 107); 24 Nov 2014 23:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 18:03:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 18:03:47 -0500
Content-Disposition: inline
In-Reply-To: <op.xpudh8c3nngjn5@freezie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260166>

On Mon, Nov 24, 2014 at 09:26:22PM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=
 =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:

> Yeah, I did realize that token is more restrictive than encoded-text,=
 but I
> didn't want to stray too far from the subject line of the patch. What=
 I'll
> probably do is split the patch into two, one for regex tweaking and o=
ne for
> multiple-word handling. And yeah, I'll try to make the two functions =
use the
> same regexes.

Thanks, I think that sounds like a good plan.

> >For your definition of encoded-text, RFC 2047 says:
> >
> >     encoded-text =3D 1*<Any printable ASCII character other than "?=
"
> >                          or SPACE>
> >
> >It looks like you pulled the definition of $et from is_rfc2047_quote=
d,
> >but I am not clear on where that original came from (it is from a3a8=
262,
> >but that commit message does not explain the regex).
>=20
> No, it's actually an independent discovery. :-) I don't think it need=
s
> explanation, though - it's just a character class with two ranges cov=
ering
> every printable character but the question mark.

And now it is my turn to hang my head in shame. I viewed that as a set
of characters, rather than ranges. The "-" just blended into the mass o=
f
punctuation, and I mistook the "!" for negation.

I wonder if it would be more readable as:

  [\x21-\x3e\x40-\x7e]

or something. I guess perl even has classes pre-made for "printable
ascii". I dunno. It may be OK as-is, too, and I just need to read more
carefully. :)

> >Also, I note that we handle 'q'-style encodings here, but not 'b'. I
> >wonder if it is worth adding that in while we are in the area (it is=
 not
> >a big deal if you always send-email git-generated patches, as we nev=
er
> >generate it).
>=20
> I could add "b" decoding, but since format-patch never generates "b"
> encodings, testing would be a problem. And I'd rather not do it witho=
ut any
> tests.

I think you could include some literal fixtures in the test suite (t510=
0
already does this for mailinfo). But I don't think handling 'b' is a
requirement here. It's really orthogonal to your patches, and nobody ha=
s
actually asked for it, so I don't mind leaving it for another day.

-Peff
