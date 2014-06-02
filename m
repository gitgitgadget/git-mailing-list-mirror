From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailinfo: use strcmp() for string comparison
Date: Mon, 2 Jun 2014 15:34:19 -0400
Message-ID: <20140602193419.GC2510@sigill.intra.peff.net>
References: <538AEBB8.9070505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrY01-0008Vx-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbaFBTeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2014 15:34:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36104 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbaFBTeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:34:21 -0400
Received: (qmail 4998 invoked by uid 102); 2 Jun 2014 19:34:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 14:34:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 15:34:19 -0400
Content-Disposition: inline
In-Reply-To: <538AEBB8.9070505@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250585>

On Sun, Jun 01, 2014 at 11:00:40AM +0200, Ren=C3=A9 Scharfe wrote:

> The array header is defined as:
>=20
> 	static const char *header[MAX_HDR_PARSED] =3D {
> 	     "From","Subject","Date",
> 	};
>=20
> When looking for the index of a specfic string in that array, simply
> use strcmp() instead of memcmp().  This avoids running over the end o=
f
> the string (e.g. with memcmp("Subject", "From", 7)) and gets rid of
> magic string length constants.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Looks correct to me.

> ---
> This is a minimal fix.  A good question, however, would be: Why do we
> keep on looking up constant strings in a (short) constant string arra=
y
> anyway?

Yeah, this code is quite confusing. I suspect it would be more readable
to unroll any loops over the header array into a series of function
calls or even just cascading if/else. Some of the sites (e.g.,
check_header) already have a mix, like:

  for (i =3D 0; header[i]; i++)
    if (cmp_header(line, header[i]))
      ... do something for this header ...

  if (cmp_header(line, "some-other-header"))
      ... do something special for this header type ...
  else if (cmp_header(line, "another"))
      ... and something else again ...

The looping is not really helping much there in the first place, since
it is not dealing with half of the headers. And then adding on top that
the loop has its own special cases found by comparing the string to
"Subject", I think it would be simpler to just unroll it.

That's just from a quick 5-minute read of the code, though. This isn't
an area I'm very familiar with, so maybe the refactor would get ugly.

-Peff
