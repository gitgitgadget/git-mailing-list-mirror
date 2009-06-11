From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Thu, 11 Jun 2009 07:11:41 -0400
Message-ID: <20090611111141.GB4409@coredump.intra.peff.net>
References: <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com> <20090604160152.GA13984@sigill.intra.peff.net> <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com> <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com> <20090608122430.GD13775@coredump.intra.peff.net> <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 13:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEiCn-0007ap-EI
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 13:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762262AbZFKLLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 07:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758142AbZFKLLs
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 07:11:48 -0400
Received: from peff.net ([208.65.91.99]:37176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757925AbZFKLLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 07:11:47 -0400
Received: (qmail 9143 invoked by uid 107); 11 Jun 2009 11:11:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Jun 2009 07:11:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jun 2009 07:11:41 -0400
Content-Disposition: inline
In-Reply-To: <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121336>

On Wed, Jun 10, 2009 at 10:03:10PM +0800, Tay Ray Chuan wrote:

> > My first complaint is that it is way too long. It wrapped in my
> > 80-column terminal, causing all sorts of visual confusion.
>=20
> The byte counts can really take up alot of space. Perhaps we should
> just show the size (MiB) and completed percentage, sans byte counts?

I think that makes sense. Especially because the (X/Y) in git's progres=
s
output usually refers to the number of _objects_, and there is nothing
in the output to indicate that it is actually a byte count here.

I think it will need some tweaking of the progress code to show the
percentage but not the actual byte counts, but it should be a relativel=
y
simple change.

> Fetching of objects and packs take place separately; it doesn't mean
> that when '0' objects are being fetched, we're definitely fetching
> something else (eg. packs). Perhaps we should "hide" the "Fetching 0
> objects" part when the number of simultaneous object fetches is 0?

Yes, though I really wonder if the "fetching" number is all that useful
even when it is not zero. The _most_ important thing is to show the use=
r
that something is happening, and we are waiting on the network. And I
think we largely show that through the "total bytes sent" and throughpu=
t
counters.

Second to that is trying to give a sense of when the task may finish.
But as we've discussed, we don't have a sense of the total number of
objects until we actually fetch them. Showing progress within packs, an=
d
the total number of packs is somewhat useful there (though it can be
misleading -- most of the time will probably be spent on one or two of
the packs).

> The total number of objects (320) increases as we "walk" the commits;
> sometimes we need to fetch the "walked" objects, sometimes we don't
> (eg. in packs we've fetched already). There's no way to know in
> advance the total; hence, the continually updating of the total. I
> don't think there's it's a problem; the idea is to let the user be
> sure that git is active.

Right. But I think we are better off showing simple increasing numbers
(like bytes or objects transferred) than misleading or inaccurate
guesses of totals. The latter creates more frustration, I think.

> > I wonder if you should start a newline every time we get to a new
> > "phase". So you might see:
> >
> > =C2=A0Downloading %d loose objects: Z% (X/Y), x MiB | y KiB/s, done
> > =C2=A0Fetching pack 1 of 2: Z% (X/Y), x MiB | y KiB/s, done
> > =C2=A0Verifying pack 1 of 2: Z% (X/Y)
> > =C2=A0Fetching pack 2 of 2: Z% (X/Y), x MiB | y KiB/s, done
> > =C2=A0Verifying pack 2 of 2: Z% (X/Y)
> >
> > That assumes we download packs one at a time (is that right?). It d=
oes take
> > a couple of lines to show what is going on, but I think most repos =
are
> > only going to have a couple of packs (though in theory, you could h=
ave
> > more "loose objects" lines interspersed with your packs).
>=20
> Yeah, we do download packs one at a time (as I said above).

But from what you wrote elsewhere in the message, it sounds like we may
be downloading a pack _and_ a loose object at the same time. So my
suggestion doesn't quite work in that case.

> the linux-2.6 repo has only 1 pack (and no http-alternates), so this
> is weird.

Maybe we are fetching from different places:

  $ wget 2>/dev/null -O - \
  http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git=
/objects/info/packs
  P pack-ab6a95cfd1919f6e820a8b2670403292838cfc17.pack
  P pack-ff5d2e76c6b3d4c0a5a11efd36af43934c3744df.pack
  P pack-588543ec42616a86eef47bb53dd04cd8a864d9b5.pack
  P pack-93b35ef7e596e6839c020e36edfaf8206b0f78c4.pack
  P pack-c89a5bf3b095d812bf1068cd1c84f8a07c3403c5.pack
  P pack-2cc5038b758e40a40a4590b37a8019d1ba5a65a9.pack
  P pack-9f36ce46120d8d9ee32e6394bb5857d7e548826b.pack
  P pack-8bebad1b754473489d516549632e904c0b3178a2.pack
  P pack-6554949d36a94e012da6ca6134ef62ce347b2efa.pack

-Peff
