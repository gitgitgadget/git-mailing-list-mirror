From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 22:13:36 -0500
Message-ID: <20151218031336.GA8467@sigill.intra.peff.net>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
 <56731715.9000509@web.de>
 <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
 <56731E19.7050504@web.de>
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
X-From: git-owner@vger.kernel.org Fri Dec 18 04:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9lUF-0002Qh-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 04:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbbLRDNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 22:13:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:44072 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752125AbbLRDNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 22:13:38 -0500
Received: (qmail 10534 invoked by uid 102); 18 Dec 2015 03:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 21:13:38 -0600
Received: (qmail 20683 invoked by uid 107); 18 Dec 2015 03:13:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:13:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 22:13:36 -0500
Content-Disposition: inline
In-Reply-To: <56731E19.7050504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282694>

On Thu, Dec 17, 2015 at 09:42:01PM +0100, Torsten B=C3=B6gershausen wro=
te:

> > Or do you mean to insert another continue in here?
> I was thinking that we run into similar loop as before:
> read() returns -1; errno =3D EAGAIN  /* No data to read */
> poll() returns -1; errno =3D EAGAIN /* poll failed. If the fd was OK,=
 the failure may be temporaly,
>                                     as much as poll() can see.
>                                     But most probably we run out ouf =
memory */
>=20
> So the code would look like this:
>=20
>    if (!poll(&pfd, 1, -1))
>       return -1;

That changes the semantics of the function. The poll() is just a
convenience to avoid spinning. If it fails, with Stefan's patch[1] the
worst case is that we would spin on read() and poll(), instead of
actually blocking in the poll().

But if we return on poll() failure, now the caller will see errors from
poll() even though they don't know or care that we called poll() in the
first place. Consider what would happen with your code if read got
EAGAIN and then poll got EINTR. We would report an error, even though
the whole point of xread() is to loop on these conditions.

-Peff

[1] Stefan's patch does have a bug. It forgets to "continue" after
    calling poll, which means we will block with poll and _then_ exit
    with -1, instead of restarting the loop.
