From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 22:31:59 -0400
Message-ID: <20160601023159.GA5411@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 04:32:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7vx8-0005hR-A1
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 04:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbcFACcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 22:32:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:46911 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756726AbcFACcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 22:32:03 -0400
Received: (qmail 11619 invoked by uid 102); 1 Jun 2016 02:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 22:32:02 -0400
Received: (qmail 29344 invoked by uid 107); 1 Jun 2016 02:32:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 22:32:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 22:31:59 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296045>

On Tue, May 31, 2016 at 08:09:43PM -0400, Eric Sunshine wrote:

> >> -     GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic=
 &&
> >> +     (export GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc"; test_comm=
it exotic) &&
>=20
> Isn't "export FOO=3Dval" unportable?

Good catch. I was so busy looking for other cases I didn't even see
the problem here.

> > Thanks. This one is my fault. There's another use of the same name
> > elsewhere, but it's to call "git commit" directly, so it's OK.
>=20
> I was under the impression that the project was moving toward 'env' t=
o
> deal[1] with this sort of issue.
>=20
> [1]: 512477b (tests: use "env" to run commands with temporary env-var
> settings, 2014-03-18)

We can use it with test_must_fail, because it takes a command name:

  test_must_fail env FOO=3DBAR whatever-you-would-have-run

But I don't think it works in the general case, as test_commit does not
run its arguments. So you'd want something like:

  env FOO=3DBAR test_commit exotic

but of course that doesn't work because "env" can't find the shell
function. I think with bash you could do:

  export test_commit
  env FOO=3DBAR bash -c test_commit exotic

but we can't rely on that.

-Peff
