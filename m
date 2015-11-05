From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] run-parallel: rename set_nonblocking to
 set_nonblocking_or_die
Date: Thu, 5 Nov 2015 01:58:01 -0500
Message-ID: <20151105065801.GB4725@sigill.intra.peff.net>
References: <563A63BA.9020407@web.de>
 <1446677029-10745-1-git-send-email-sbeller@google.com>
 <1446677029-10745-2-git-send-email-sbeller@google.com>
 <563AF229.1060302@web.de>
 <xmqqfv0l7z2r.fsf@gitster.mtv.corp.google.com>
 <xmqq8u6d7ytc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>, j6t@kdbg.org,
	git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEWr-0005wo-2R
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbbKEG6G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2015 01:58:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:53186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161280AbbKEG6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:58:04 -0500
Received: (qmail 19580 invoked by uid 102); 5 Nov 2015 06:58:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 00:58:04 -0600
Received: (qmail 10698 invoked by uid 107); 5 Nov 2015 06:58:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 01:58:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 01:58:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8u6d7ytc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280909>

On Wed, Nov 04, 2015 at 10:19:43PM -0800, Junio C Hamano wrote:

> Having read your message, I notice these disturbing passages in my
> copy of manual pages.
>=20
> poll(2) has
>=20
>     BUGS
>            See the discussion of spurious readiness notifications und=
er
>            the BUGS section of select(2).
>=20
> and then select(2) has
>=20
>        Under Linux, select() may report a socket file descriptor as
>        "ready for read=E2=80=90 ing", while nevertheless a subsequent=
 read
>        blocks.  This could for example happen when data has arrived
>        but upon examination has wrong checksum and is discarded.
>        There may be other circumstances in which a file descriptor
>        is spuriously reported as ready.  Thus it may be safer to use
>        O_NONBLOCK on sock=E2=80=90 ets that should not block.
>=20
> The world is not all Linux, so there may be systems that we do not
> have to worry about the bug described here, but there still are some
> Linux systems in use in the world, so we cannot assume the bug
> described above will not matter, either.
>=20
> So I am not convinced that set_nonblocking() is unnecessary X-<.

Yes, I've heard of this bug, and I wouldn't be surprised if it is
present on many systems. But notice that it is talking about sockets,
whereas here I think we are dealing only with pipes. Pipes generally
have much simpler and more predictable behavior, and their behaviors ar=
e
more closely mandated by POSIX.

Of course that's all hearsay, and I can't quite you chapter and verse o=
f
POSIX (as if that would be enough, anyway) to prove it. But personally,
I would be comfortable dropping the non-blocking bits completely from
Stefan's series and adding them back in later if anybody can actually
find a real-world example that doesn't conform.

Of course, simply omitting the O_NONBLOCK bits on Windows would also
work if we can guarantee the Windows behavior. It means we're carrying
around extra code that may or may not be doing anything useful, but it'=
s
not _that_ much code.

-Peff
