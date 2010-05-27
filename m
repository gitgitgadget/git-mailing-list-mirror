From: Jeff King <peff@peff.net>
Subject: Re: (Mosty harmless) protocol error when pushing
Date: Thu, 27 May 2010 11:12:23 -0400
Message-ID: <20100527151222.GA18590@coredump.intra.peff.net>
References: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
 <20100525072824.GA19612@coredump.intra.peff.net>
 <AANLkTilc9-B79EhmmO2t-VsHFZdupQn8zX9LFYRrn5of@mail.gmail.com>
 <20100527113305.GB7865@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu May 27 17:12:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHel5-0002mu-La
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0E0PMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 11:12:25 -0400
Received: from peff.net ([208.65.91.99]:47456 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab0E0PMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:12:25 -0400
Received: (qmail 22725 invoked by uid 107); 27 May 2010 15:12:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 May 2010 11:12:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 May 2010 11:12:23 -0400
Content-Disposition: inline
In-Reply-To: <20100527113305.GB7865@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147870>

On Thu, May 27, 2010 at 02:33:05PM +0300, Ilari Liusvaara wrote:

> I can't reproduce it either.
>=20
> I tried testing using git:// over TLS. I could trigger the auto-gc,
> but got no messages about it (hmm... other sideband messages do
> work...) and no protocol error.

Same here. But look at Bj=C3=B6rn's original error, which contained:

  fatal: protocol error: bad line length character: Remo

So I think it may not just be an auto-gc, but an auto-gc which provokes
prune-packed to say:

  Removing duplicate objects: 100% (256/256), done.

which happens only when it takes more than 2 seconds to remove all of
the objects. But I was still not able to reproduce it, even after
removing the delay:

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..da1ab20 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -48,7 +48,7 @@ void prune_packed_objects(int opts)
=20
 	if (opts =3D=3D VERBOSE)
 		progress =3D start_progress_delay("Removing duplicate objects",
-			256, 95, 2);
+			256, 95, 0);
=20
 	if (len > PATH_MAX - 42)
 		die("impossible object directory");

I notice that the original problem was seen when pushing to github. I
wonder if they are running an older version, or even a custom version
that behaves differently (perhaps with stdout and stderr file
descriptors set up differently for the gc or something like that).

-Peff
