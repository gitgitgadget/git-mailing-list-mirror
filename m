From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Mon, 24 Nov 2014 10:36:09 -0500
Message-ID: <20141124153609.GA25912@peff.net>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsvgX-0003Ef-5K
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 16:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbaKXPgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 10:36:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:44061 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752589AbaKXPgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 10:36:12 -0500
Received: (qmail 28262 invoked by uid 102); 24 Nov 2014 15:36:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 09:36:11 -0600
Received: (qmail 17207 invoked by uid 107); 24 Nov 2014 15:36:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 10:36:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 10:36:09 -0500
Content-Disposition: inline
In-Reply-To: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260128>

On Mon, Nov 24, 2014 at 02:50:04AM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=
 =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:

> The RFC says that they are to be concatenated after decoding (i.e. th=
e
> intervening whitespace is ignored).
>=20
> I change the sender's name to an all-Cyrillic string in the tests so =
that
> its encoded form goes over the 76 characters in a line limit, forcing
> format-patch to split it into multiple encoded words.
>=20
> Since I have to modify the regular expression for an encoded word any=
way,
> I take the opportunity to bring it closer to the spec, most notably
> disallowing embedded spaces and making it case-insensitive (thus allo=
wing
> the encoding to be specified as both "q" and "Q").

The overall goal makes sense to me. Thanks for working on this. I have =
a
few questions/comments, though.

>  sub unquote_rfc2047 {
>  	local ($_) =3D @_;
> +
> +	my $et =3D qr/[!->@-~]+/; # encoded-text from RFC 2047
> +	my $sep =3D qr/[ \t]+/;
> +	my $encoded_word =3D qr/=3D\?($et)\?q\?($et)\?=3D/i;

The first $et in $encoded_word is actually the charset, which is define=
d
by RFC 2047 as:

     charset =3D token    ; see section 3

     token =3D 1*<Any CHAR except SPACE, CTLs, and especials>

     especials =3D "(" / ")" / "<" / ">" / "@" / "," / ";" / ":" / "
	               <"> / "/" / "[" / "]" / "?" / "." / "=3D"

Your regex is a little more liberal. I doubt that it is a big deal in
practice (actually, in practice, I suspect [a-zA-Z0-9-] would be fine).
But if we are tightening things up in general, it may make sense to do
so here (and I notice that is_rfc2047_quoted does a more thorough $toke=
n
definition, and it probably makes sense for the two functions to be
consistent).

=46or your definition of encoded-text, RFC 2047 says:

     encoded-text =3D 1*<Any printable ASCII character other than "?"
                          or SPACE>

It looks like you pulled the definition of $et from is_rfc2047_quoted,
but I am not clear on where that original came from (it is from a3a8262=
,
but that commit message does not explain the regex).

Also, I note that we handle 'q'-style encodings here, but not 'b'. I
wonder if it is worth adding that in while we are in the area (it is no=
t
a big deal if you always send-email git-generated patches, as we never
generate it).

> +	s{$encoded_word(?:$sep$encoded_word)+}{

If I am reading this right, it requires at least two $encoded_words.
Should this "+" be a "*"?

> +		my @words =3D split $sep, $&;
> +		foreach (@words) {
> +			m/$encoded_word/;
> +			$encoding =3D $1;
> +			$_ =3D $2;
> +			s/_/ /g;
> +			s/=3D([0-9A-F]{2})/chr(hex($1))/eg;

In the spirit of your earlier change, should this final regex be
case-insensitive? RFC 2047 says only "Upper case should be used for
hexadecimal digits "A" through "F." but that does not seem like a "MUST=
"
to me.

-Peff
