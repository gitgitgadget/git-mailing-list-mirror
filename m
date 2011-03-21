From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Mon, 21 Mar 2011 11:51:08 -0400
Message-ID: <20110321155108.GA27662@sigill.intra.peff.net>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de>
 <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
 <1300701380.2583.13.camel@bee.lab.cmartin.tk>
 <20110321111414.GD16334@sigill.intra.peff.net>
 <1300721194.2583.22.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hO1-0005AY-Pb
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 16:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab1CUPvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 11:51:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47694
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab1CUPvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 11:51:12 -0400
Received: (qmail 14980 invoked by uid 107); 21 Mar 2011 15:51:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 11:51:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 11:51:08 -0400
Content-Disposition: inline
In-Reply-To: <1300721194.2583.22.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169603>

On Mon, Mar 21, 2011 at 04:26:29PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> > FWIW, we don't catch snprintf failures in 99% of the calls in git. =
Most
> > calls just ignore the return value, and some even directly use the
> > return value to add to a length. The one place that actually does c=
heck
> > for the error is strbuf_vaddf, which just says "your vsnprintf is
> > broken" and dies.
>=20
>  It's not actually likely we'll ever meet this error if the only one
> allowed to set the format string is the programmer (and to do otherwi=
se
> is a security risk).

Agreed.

>  Or we could overload (#define) snprintf and replace it with the
> paranoid. It'd go nicely with the vsnprintf that tries to work around
> the Windows implementation.
>=20
>  I don't feel that strongly we should have the extra check there, see=
ing
> how it's rare and not checked anywhere else.

Yeah, I am happy to just drop it. AFAICT, an error return from snprintf
is a bug in your program[1] or a bug in libc. In either case, it should
fail or produce bogus output on the first run, and we don't need to
worry about checking errors all the time. Noting the error helps a
little with detection, but since we already install our own vsnprintf o=
n
known-buggy platforms, I haven't seen a single complaint.

-Peff

[1] The only error I managed to get out of eglibc was trying to format
"%" (i.e., percent followed by NUL). Skimming the eglibc code (gaah, my
eyes!) it looks like under some conditions it can allocate small work
buffers, and return an error if malloc fails. So yeah, I guess it can
fail randomly, but it seems pretty unlikely.
