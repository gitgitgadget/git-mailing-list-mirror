From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded
 words properly
Date: Sun, 7 Dec 2014 04:18:59 -0500
Message-ID: <20141207091859.GA21311@peff.net>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
 <1417894583-2352-2-git-send-email-dpb@corrigendum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:19:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxXzg-0005Kp-3X
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 10:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaLGJTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 04:19:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:49563 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752659AbaLGJTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 04:19:01 -0500
Received: (qmail 9751 invoked by uid 102); 7 Dec 2014 09:19:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 03:19:01 -0600
Received: (qmail 15790 invoked by uid 107); 7 Dec 2014 09:19:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 04:19:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2014 04:18:59 -0500
Content-Disposition: inline
In-Reply-To: <1417894583-2352-2-git-send-email-dpb@corrigendum.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260977>

On Sat, Dec 06, 2014 at 10:36:23PM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=
 =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:

> The RFC says that they are to be concatenated after decoding (i.e. th=
e
> intervening whitespace is ignored).

Thanks. Both patches look good to me, and I'd be happy to have them
applied as-is. I wrote a few comments below, but in all cases I think I
convinced myself that what you wrote is best.

> +	my $sep =3D qr/[ \t]+/;
> +	s{$re_encoded_word(?:$sep$re_encoded_word)*}{
> +		my @words =3D split $sep, $&;
> +		foreach (@words) {
> +			m/$re_encoded_word/;
> +			$charset =3D $1;
> +			my $encoding =3D $2;
> +			my $text =3D $3;

It feels a little weird to have to split and rematch $re_encoded_word i=
n
the loop, but I don't think there is a way around it. ($1, $2, $3) will
have our first word, and ($4, $5, $6) will have the final (if any), but
I don't think we can get access to what is in between.

So I think what you have here is the best we can do.

> +			if ($encoding eq 'q' || $encoding eq 'Q') {
> +				$_ =3D $text;
> +				s/_/ /g;
> +				s/=3D([0-9A-F]{2})/chr(hex($1))/egi;

It took me a minute to figure out why this works. $_ is a reference to
the iterator for @words, so it is re-assigning that element of the arra=
y
first to the encoded text, and then modifying it in place.

I wonder if it would be more obvious like this:

  join '',
  map {
          m/$re_encoded_word/;
	  $charset =3D $1;
	  my $encoding =3D $2;
	  my $text =3D $3;
          if ($encoding eq 'q' || $encoding eq 'Q') {
	    $text =3D~ s/_/ /g;
	    $text =3D~ s=3D([0-9A-F]{2}/chr(hex($1))/egi;
	  } else {
	    # other encoding not supported yet
	  }
  } split($sep, $&);


I dunno. I kind of like your version better now that I understand it,
but it did take me a minute.

One final note on this bit of code: if there are multiple encoded words=
,
we grab the $charset from the final encoded word, and never report the
earlier charsets. Technically they do not all have to be the same
(rfc2047 even has an example where they are not). I think we can dismis=
s
this, though, as:

  1. It was like this before your patches (we might have seen multiple
     non-adjacent encoded words; you're just handling adjacent ones),
     and nobody has complained.

  2. Using two separate encodings in the same header is sufficiently
     ridiculous that I can live with us not handling it properly.

> +# This name is long enough to force format-patch to split it into mu=
ltiple
> +# encoded-words, assuming it uses UTF-8 with the "Q" encoding.
> +test_expect_success $PREREQ 'long non-ascii self name is suppressed'=
 "
> +	test_suppress_self_quoted '=C6=91=C3=BC=C3=B1n=C3=AD=C4=99=C5=99 =E2=
=82=AC. N=C3=A2=E1=B9=81=C3=A9' 'odd_?=3Dmail@example.com' \
> +		'long_non_ascii_self_suppressed'
> +"

Cute. :)

-Peff
