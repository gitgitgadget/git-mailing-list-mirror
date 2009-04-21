From: Jeff King <peff@peff.net>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 15:11:26 -0400
Message-ID: <20090421191126.GA7632@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk> <20090421024433.GC14479@coredump.intra.peff.net> <7vskk2bt3x.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com> <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de> <20090421195434.3a01676d@gmail.com> <20090421180529.GA7583@coredump.intra.peff.net> <20090421204701.1e0115c0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 21:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwLPU-0005S8-2L
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbZDUTLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 15:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756597AbZDUTLb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 15:11:31 -0400
Received: from peff.net ([208.65.91.99]:45524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbZDUTLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 15:11:30 -0400
Received: (qmail 10969 invoked by uid 107); 21 Apr 2009 19:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 15:11:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 15:11:26 -0400
Content-Disposition: inline
In-Reply-To: <20090421204701.1e0115c0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117150>

On Tue, Apr 21, 2009 at 08:47:01PM +0200, Micha=C5=82 Kiedrowicz wrote:

> > I thought the point was about _empty_ renames. This is a small but
> > non-zero rename.
>=20
> Yes, you are right. But change these echos to touch and you'll see th=
at
> this bug happens if date and LICENSE are the same, not necessary empt=
y.

Right, because it is not exactly a bug, as I explained here:

  http://article.gmane.org/gmane.comp.version-control.git/117078

I say "not exactly a bug", because it is working as intended by the
software authors, but because the intended behavior is to make a
heuristic guess (some content moved from one filename to another, so we
guess that a patch against the original content should actually go
against the new location), the guess may not follow the user's
expectations.

It is easy to see how the heuristic can be fooled in a toy example. But
what we really care about is whether and how the heuristic is fooled in
the real world.  In the real world, there seems to be some non-trivial
probability of removing an empty file, adding a new one elsewhere, and
then merging with somebody who touched the empty file. So it may be
worth improving the heuristic for this special case, especially because
the harm done in a false negative is relatively small.

But what is the probability of doing the same thing to a file that has
non-trivial contents? I would guess it is much less likely, and by
special-casing it as a conflict, you have a much higher chance of
bothering users who were relying on actual rename detection for their
non-trivial case[1]. Of course, I don't have actual numbers, so I'm jus=
t
guessing.

So my point is that while both are perhaps a failing of the heuristic,
only one is going to be worth tweaking the heuristic for. So that is th=
e
one that should be included in the test case, since it is how somebody
implementing a proposed tweak can test their tweak.

-Peff

[1] On a side note, this got me thinking about how git handles rename
detection during merging. One of the things I like about git is that it
tries to be very stupid: if something is questionable during a merge, i=
t
calls attention to it and makes it _easy_ for the user to access the
versions and resolve (and I love mergetool for this). But renames are
not like this: either they happen during auto-conflict-resolution, or
they don't. I wonder if it might be a better strategy to barf on
conflicts due removed files that could be resolved by questionable
renames, but have a post-merge "renametool" that shows the user
potential renames and lets them interactively specify the resolution.
But maybe that would just be annoying, since 99% of the time, the renam=
e
detection gets it right.
