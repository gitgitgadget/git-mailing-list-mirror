From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/25] t0020: use modern test_* helpers
Date: Tue, 24 Mar 2015 22:56:35 -0400
Message-ID: <20150325025635.GC15051@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320101308.GQ12543@peff.net>
 <20150325012323.Horde.zCWvV1mF8OBE1PxYPuuEFg8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YabUo-0003k8-SZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 03:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbCYC4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 22:56:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38127 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752018AbbCYC4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 22:56:37 -0400
Received: (qmail 10978 invoked by uid 102); 25 Mar 2015 02:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 21:56:37 -0500
Received: (qmail 10822 invoked by uid 107); 25 Mar 2015 02:56:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 22:56:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2015 22:56:35 -0400
Content-Disposition: inline
In-Reply-To: <20150325012323.Horde.zCWvV1mF8OBE1PxYPuuEFg8@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266251>

On Wed, Mar 25, 2015 at 01:23:23AM +0100, SZEDER G=C3=A1bor wrote:

> >  	for f in one dir/two
> >  	do
> >  		append_cr <$f >tmp && mv -f tmp $f &&
> >-		git update-index -- $f || {
> >-			echo Oops
> >-			false
> >-			break
> >-		}
> >+		git update-index -- $f ||
> >+		break
> >  	done &&
>=20
> Ah, these tests are evil, I remember them from the time when I was fi=
ddling
> with Jonathan's patch.  They can fail silently without testing what t=
hey
> were supposed to test.
>=20
> If something in the loop fails, the break will leave the loop but it =
will do
> so with zero return value and, consequently, the test will continue a=
s if
> everything were OK.
> And unless it was 'git update-index' that failed in a way that left a=
 borked
> index behind, the 'git diff-index --cached' below will not error out =
or
> produce some output that would cause the test to fail.  i.e. I tried =
e.g.
>=20
>   append_cr <$f >tmp && mv -f tmp $f && false &&
>=20
> in the loop and the test succeeded.

Ugh, you're right. I remembered that for loops were tricky in &&-chains=
,
but for some reason was thinking that "break" would give you the last
exit code, But I just re-tested, and of course it does not work.

> I think the best fix would be to unroll the loop: after this patch th=
e loop
> body consists of only two significant lines and we iterate through th=
e loop
> only twice, so the test would be even shorter.

Yeah, unrolling may be the best thing here, given the size of the loops=
=2E
As a general rule, I think it has to be a subshell with an exit, like:

  (
	for i in one two three; do
		echo $i &&
		test $i =3D one ||
		exit 1
	done
  )
  echo exit=3D$?

which should yield one, two, and exit=3D1. 7b1732c (t7510: use consiste=
nt
&&-chains in loop, 2014-06-16) deals with this in another test.

-Peff
