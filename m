From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 1 Feb 2012 18:20:27 -0500
Message-ID: <20120201232027.GA32119@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
 <20120201082005.GA32348@sigill.intra.peff.net>
 <20120201091009.GA20984@sigill.intra.peff.net>
 <CAOTq_ptj06aNGsQRjV0fVRxnQFBHmU2FFSXwWDUUk9MM77k2LQ@mail.gmail.com>
 <20120201221437.GA19044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsjTf-0001uS-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab2BAXUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 18:20:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab2BAXUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 18:20:30 -0500
Received: (qmail 14390 invoked by uid 107); 1 Feb 2012 23:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 18:27:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 18:20:27 -0500
Content-Disposition: inline
In-Reply-To: <20120201221437.GA19044@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189552>

On Wed, Feb 01, 2012 at 05:14:37PM -0500, Jeff King wrote:

> > The first time I introduced this behaviour[1], I made it conditiona=
l
> > on a preference =E2=80=94 those who wanted "good" grep could set th=
e
> > preference, while those who wanted "fast" grep could not. I think
> > that's not a good idea, though if the performance issues are
> > show-stoppers, I'd suggest the opposite preference (so speed-freaks
> > can disable the checks).
>=20
> I've been able to get somewhat better performance by hoisting the
> attribute lookup into the parent thread. That means it happens in ord=
er
> (which lets the attr code's stack optimizations work), and there's no
> lock contention.
>=20
> I'll post finished patches with numbers in a few minutes.

OK, here they are. After playing with some options, I'm satisfied this
is a sane way to do it. I don't think it's worth having a config option=
=2E
There is a measurable slowdown, but it's simply not that big.

  [1/2]: grep: let grep_buffer callers specify a binary flag
  [2/2]: grep: respect diff attributes for binary-ness

There are a few optimizations I didn't do that you could put on top:

  1. When "-a" is given, we can avoid the attribute lookup altogether.

  2. When "-I" is given, we can actually check attributes _before_
     loading the file or blob into memory. This can help with very larg=
e
     binaries.

  3. When "-I" is given but we have no attribute, we can stream the
     beginning of the file or blob to check for binary-ness, and then
     avoid loading the whole thing if it turns out to be binary.

I think (1) and (2) should be easy. Doing (3) is a little messier,
because binary detection happens inside grep_buffer, but we can hoist i=
t
out. However, for large files, it might be nice to have a streaming gre=
p
interface anyway, and (3) could be part of that.

-Peff
