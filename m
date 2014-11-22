From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Sat, 22 Nov 2014 14:19:33 -0500
Message-ID: <20141122191932.GA13340@peff.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
 <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
 <20141121180105.GB26650@peff.net>
 <5470A4C0.3070501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 20:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsGDc-00075H-2r
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 20:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbaKVTTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2014 14:19:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:43526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752254AbaKVTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 14:19:35 -0500
Received: (qmail 13841 invoked by uid 102); 22 Nov 2014 19:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 13:19:34 -0600
Received: (qmail 1118 invoked by uid 107); 22 Nov 2014 19:19:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 22 Nov 2014 14:19:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Nov 2014 14:19:33 -0500
Content-Disposition: inline
In-Reply-To: <5470A4C0.3070501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260073>

On Sat, Nov 22, 2014 at 03:59:12PM +0100, Torsten B=C3=B6gershausen wro=
te:

> >> +test_expect_success 'error out when attempting to add ignored one=
s but add others' '
> >> +	touch a.if &&
> >> +	test_must_fail git add a.?? &&
> >> +	! (git ls-files | grep "\\.ig") &&
> >> +	(git ls-files | grep a.if)
> >> +'
> [...]
>=20
> 2 small comments:
> Why the escaped "\\.ig" and the unescaped "a.if"  ?

I agree that is inconsistent, and I don't see any reason for it.

> The other question, this is a more general one, strikes me every time=
 I see
> ! grep
>=20
> Should we avoid it by writing "test_must_fail" instead of "!" ?

No. The point of test_must_fail over "!" is to check that not only does
the command fail, but it fails with a clean exit rather than a signal
death.  The general philosophy is that this is useful for git (which we
are testing), and not for third-party tools that we are using to check
our outputs. In other words, we do not expect grep to segfault, and do
not need to bother checking it.

I do not think there is a real _downside_ to using test_must_fail for
grep, except that it is a bit more verbose.

And that describes the goal, of course; actual implementation has been
less consistent. Possibly because I do not know that those instructions
are written down anywhere. We usually catch such things in review these
days, but there are many inconsistent spots in the existing suite.

> The following came into my mind when working on another grepy thing,
> and it may be unnecessary clumsy:
>=20
> test_expect_success 'error out when attempting to add ignored ones bu=
t add others' '
> 	touch a.if &&
> 	test_must_fail git add a.?? &&
> 	git ls-files >files.txt &&
> 	test_must_fail grep a.ig files.txt >/dev/null &&
> 	grep a.if files.txt >/dev/null &&
> 	rm files.txt

Right, my "allergic to pipes" was basically advocating using a tempfile=
=2E
But as noted above, it should remain "! grep" here. And there is no nee=
d
to redirect the output of grep, as the test suite does it already (in
fact, it is preferable not to, because somebody debugging the test with
"-v" will get more output).

-Peff
