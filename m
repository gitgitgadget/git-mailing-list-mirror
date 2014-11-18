From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Mon, 17 Nov 2014 19:21:30 -0500
Message-ID: <20141118002130.GA3031@peff.net>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
 <xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
 <20141117213442.GD15880@peff.net>
 <CADoxLGMFzujP6kKNpExsCSzQrUrpsgPOcgLmFA_yU7S=NhQorQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	Git Mailing List <git@vger.kernel.org>,
	Bryan Turner <bturner@atlassian.com>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 01:21:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqWY5-00051W-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 01:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbaKRAVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 19:21:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:41406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbaKRAVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 19:21:33 -0500
Received: (qmail 10011 invoked by uid 102); 18 Nov 2014 00:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 18:21:32 -0600
Received: (qmail 5077 invoked by uid 107); 18 Nov 2014 00:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 19:21:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Nov 2014 19:21:30 -0500
Content-Disposition: inline
In-Reply-To: <CADoxLGMFzujP6kKNpExsCSzQrUrpsgPOcgLmFA_yU7S=NhQorQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 10:59:14AM +1100, Stefan Saasen wrote:

> >> I am not sure if this much of code churn is warranted to work arou=
nd
> >> issues that only happen on repositories on NFS servers that do not
> >> keep open-but-deleted files available.  Is it an option to instead
> >> have a copy of repository locally off NFS?
> >
> > I think it is also not sufficient. This patch seems to cover only
> > objects. But we assume that we can atomically rename() new versions=
 of
> > files into place whenever we like without disrupting existing reade=
rs.
> > This is the case for ref updates (and packed-refs), as well as the =
index
> > file.  The destination end of the rename is an unlink() in disguise=
, and
> > would be susceptible to the same problems.
>=20
> I=E2=80=99m going out on a limb here as my NFS knowledge is rather sh=
allow but a
> rename should be atomic even on NFS.
>=20
> "The RENAME operation must be atomic to the client.=E2=80=9D
> (https://www.ietf.org/rfc/rfc1813.txt: 3.3.14)
>=20
> Does git do something differently here for that not to be the case?

I don't mean the atomicity of the rename itself. But rather what happen=
s
to an existing file at the destination of the rename, and processes tha=
t
have it open. E.g., consider this sequence of events:

  1. Process A calls open("index", O_RDONLY). Possibly it also mmap()s
     the result.

  2. Process B calls open("index.lock", O_WRONLY|O_CREAT|O_EXCL),
     write()s some data to it, and close()s it.

  3. Process B calls rename("index.lock", "index");

Normally, process A's descriptor continues to point to the old "index",
and it does not see the new version unless it calls open() again. But o=
n
NFS, what happens to process A when it tries to read?  I could imagine
one of:

  a. It acts like the "unlink" call under discussion. The old file has
     gone away, and anybody who had it mmap'd is going to SIGBUS.

  b. We silently read data from the replacement file. This is bad,
     because we may be in the middle of reading a data structure. We
     expect to get an atomic view of the file once we've opened it.

I don't know which happens, or if it all just works. But it seems like
another potential problem point of the same type.

-Peff
