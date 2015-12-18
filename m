From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Fri, 18 Dec 2015 13:12:33 -0500
Message-ID: <20151218181233.GA29057@sigill.intra.peff.net>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
 <56731715.9000509@web.de>
 <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
 <56731E19.7050504@web.de>
 <20151218031336.GA8467@sigill.intra.peff.net>
 <5673C8E6.8010001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 18 19:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9zWD-0004oI-QG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 19:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbbLRSMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2015 13:12:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:44320 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932091AbbLRSMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 13:12:37 -0500
Received: (qmail 13973 invoked by uid 102); 18 Dec 2015 18:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 12:12:36 -0600
Received: (qmail 31047 invoked by uid 107); 18 Dec 2015 18:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Dec 2015 13:12:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Dec 2015 13:12:33 -0500
Content-Disposition: inline
In-Reply-To: <5673C8E6.8010001@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282712>

On Fri, Dec 18, 2015 at 09:50:46AM +0100, Torsten B=C3=B6gershausen wro=
te:

> >> So the code would look like this:
> >>
> >>    if (!poll(&pfd, 1, -1))
> >>       return -1;
> >=20
> > That changes the semantics of the function. The poll() is just a
> > convenience to avoid spinning. If it fails, with Stefan's patch[1] =
the
> > worst case is that we would spin on read() and poll(), instead of
> > actually blocking in the poll().
> >=20
> > But if we return on poll() failure, now the caller will see errors =
from
> > poll() even though they don't know or care that we called poll() in=
 the
> > first place. Consider what would happen with your code if read got
> > EAGAIN and then poll got EINTR. We would report an error, even thou=
gh
> > the whole point of xread() is to loop on these conditions.
> [...]
>
> /* So the code v2 would look like this: */
>=20
>     if (!poll(&pfd, 1, -1)) {
>         if (errno =3D=3D EINTR)
>             continue;
>          return -1; /* poll() failed, this is serious. */
>     }

That solves the EINTR problem, but I still don't see why we want to
return -1. The caller asked us to read(). We know that read() did not
fail with an actual error. Yet we are going to return an error to the
user, with errno set to something related only to poll(). I think we ar=
e
better off to keep the same semantics from the caller's point of view:
we loop until read() returns forward progress or a real error, and
anything else we do is a behind-the-scenes optimization.

BTW, I am assuming you mean:

  if (poll(&pfd, 1, -1) < 0)
	...

in your examples. Returning "0" means that poll timed out, but of cours=
e
we are not providing a timeout.

-Peff
