From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Mon, 20 Oct 2014 02:19:17 -0700
Message-ID: <20141020091916.GA12913@peff.net>
References: <54390DC0.8060302@web.de>
 <20141012015321.GA15272@peff.net>
 <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
 <20141014091628.GB16686@peff.net>
 <54439CDA.9070804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:19:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg97d-0004pc-WB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 11:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbaJTJTW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2014 05:19:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:60153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752850AbaJTJTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 05:19:21 -0400
Received: (qmail 4973 invoked by uid 102); 20 Oct 2014 09:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 04:19:21 -0500
Received: (qmail 10416 invoked by uid 107); 20 Oct 2014 09:19:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Oct 2014 05:19:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2014 02:19:17 -0700
Content-Disposition: inline
In-Reply-To: <54439CDA.9070804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 19, 2014 at 01:13:30PM +0200, Ren=C3=A9 Scharfe wrote:

> >We could flip it to give the managed version the short name (and cal=
ling
> >the unmanaged version "env_ptr" or something). That would require
> >munging the existing callers, but the tweak would be simple.
>=20
> Perhaps, but I'm a but skeptical of big renames.  Let's start small a=
nd add
> env_array, and see how far we get with that.

Yeah, having basically implemented patches similar to yours, I think
that is a good first step. Both of your patches looked good to me.

> Trickiness makes me nervous, especially in daemon.c.  And 5% CPU usag=
e just
> for waiting sounds awful.  Using waitpid(0, ...) is not supported by =
the
> current implementation in compat/mingw.c, however.

I guess you could use wait() and a counter that you increment whenever
you get SIGCLD, but that feels a bit hacky. I wonder how bad a real
waitpid would be for mingw.

> By the way, does getaddrinfo(3) show up in your profiles much?  Recen=
tly I
> looked into calling it only on demand instead of for all incoming
> connections because doing that unconditional with a user-supplied
> ("tainted") hostname just felt wrong.  The resulting patch series tur=
ned out
> to be not very pretty and I didn't see any performance improvements i=
n my
> very limited tests, however; not sure if it's worth it.

It shows up in the child, not the parent, so it wasn't part of the
profiling I did recently. I did look at it just now, and it does
introduce some latency into each request (though not a lot of CPU;
mainly it's the DNS request). Like you, I'm nervous about convincing
git-daemon to do lookups on random hosts. By itself it's not horrible
(except for tying up git-daemon with absurdly long chains of glueless
references), but I worry that it could exacerbate other problems
(overflows or other bugs in DNS resolvers, as part of a cache-poisoning
scheme, orbeing used for DoS amplification).

I think doing it on demand would be a lot more sensible. We do not need
to do a lookup at all unless the %H, %CH, or %IP interpolated path
features are used. And we do not need to do hostname canonicalization
unless %CH is used.

-Peff
