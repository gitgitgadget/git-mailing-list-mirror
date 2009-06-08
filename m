From: Jeff King <peff@peff.net>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Mon, 8 Jun 2009 08:24:30 -0400
Message-ID: <20090608122430.GD13775@coredump.intra.peff.net>
References: <20090602174229.GA14455@infidigm.net> <m3vdnda9f7.fsf@localhost.localdomain> <7vmy8p8947.fsf@alter.siamese.dyndns.org> <20090603191050.GB29564@coredump.intra.peff.net> <20090603191555.GL3355@spearce.org> <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com> <20090604160152.GA13984@sigill.intra.peff.net> <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com> <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 14:24:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDduC-0004TV-Tj
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 14:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbZFHMYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 08:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbZFHMYj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 08:24:39 -0400
Received: from peff.net ([208.65.91.99]:44028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755045AbZFHMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 08:24:38 -0400
Received: (qmail 21342 invoked by uid 107); 8 Jun 2009 12:24:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 08:24:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 08:24:30 -0400
Content-Disposition: inline
In-Reply-To: <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121067>

On Sun, Jun 07, 2009 at 07:21:13PM +0800, Tay Ray Chuan wrote:

> by the way, I have updated http-progress-indicators based on your suggestions.

Thanks, I just looked at it (though sadly it does not merge into what is
in 'next' right now).

> What I have now is:
> 
>  Fetching %d objects (got %d of %d, %d alt)[, and %s]: 100%
> (32077585/32077585), 30.59 MiB, done.

I tried to fetch linux-2.6, and it left me pretty confused.

My first complaint is that it is way too long. It wrapped in my
80-column terminal, causing all sorts of visual confusion.

> 1. %d objects = number of concurrent objects being fetched, usually
> around 4-5. Since objects are fetched alongside other files like packs
> and pack indices, I separated this from (4).

This did at times say '4' for me, but just as often it said '0' (even
when stuff was obviously downloading). I hadn't thought about the fact
that we have concurrent downloads. That really makes things harder.
Though it seems like we only do one pack file at a time (so maybe that
is the reason for the '0' -- we are downloading a pack).

In fact, while watching the progress go for the linux-2.6 download, it
is really hard to tell what is going on. The "% completed" number jumps
around between multiple values, even showing what appears to be
nonsense:

  Fetching 0 objects (got 2 of 320, 0 alt) and pack:   8%
  (241096602/302989431), 229.78 MiB | 668 KiB/s
  ...
  Fetching 0 objects (got 2 of 320, 0 alt) and pack:   4%
  (270741882/302989431), 257.93 MiB | 690 KiB/s

Those are two cut-and-pastes from the same fetch. You can see it
progressing in terms of absolute numbers, but the percentage values make
no sense. The "total downloaded" and throughput numbers look roughly
correct. I don't know if this is caused by multiple simultaenous
downloads.

> 2. got %d of %d = a count of loose objects. I haven't done counting of
> packs yet, but it shouldn't be very hard.

Fetching linux-2.6, I spent a very long time on "got 2 of 320" which
really wasn't all that helpful (because almost the whole thing is in
packs). Probably a pack count would be useful there. Though I wonder if
there is some shorter way to summarize what is going on to keep the line
smaller.

But somewhat worse is that we start at '320', spend a lot of time, and
then magically it ends up at 1182387 at the end. So it is not all that
useful as a progress counter, because we don't actually know the total.
So we can show that we are progressing, but the end keeps getting
farther away. :)

> 3. %d alt = number of alternate objects. The way I'm counting them now
> is very inaccurate; I may drop this if it's too complicated to do an
> accurate count. I added this because some people use forked repos, and
> they may wonder why after some time, the number of objects fetched
> doesn't increase. (The time was spent on waiting for the server, only
> for it to return a 404).

In the name of conserving space on the line, perhaps you should just
count this as a "fetched" object and increment the fetched count by one.
The user doesn't have to care which were alt and which were not, as long
as they see a counter progressing towards completion.

> How about pack file verification? Some pack files are monstrous, and
> can take some time to verify. Is it desirable to fit in pack file
> verification into the same "Fetching..." line? Verification is a
> per-file thing, so it should deserve the same treatment that "Getting
> pack ..." lines got.

It does take a while on big packs, so I think it makes sense to show
some eye candy. You can always use the "show only after 2 seconds"
feature of the progress meter if you are concerned about too much
information for quick verifications.

It probably makes sense to actually do a stop_progress() after the
fetching and before the verifying. Otherwise you get the cruft from the
fetch on the line, but it is not covered up by the verify. Like:

  Verifying pack file: 100% (1180771/1180771), done.   0%
  (302915802/302989431), 288.72 MiB | 752 KiB/s

I wonder if you should start a newline every time we get to a new
"phase". So you might see:

 Downloading %d loose objects: Z% (X/Y), x MiB | y KiB/s, done
 Fetching pack 1 of 2: Z% (X/Y), x MiB | y KiB/s, done
 Verifying pack 1 of 2: Z% (X/Y)
 Fetching pack 2 of 2: Z% (X/Y), x MiB | y KiB/s, done
 Verifying pack 2 of 2: Z% (X/Y)

That assumes we download packs one at a time (is that right?). It does take
a couple of lines to show what is going on, but I think most repos are
only going to have a couple of packs (though in theory, you could have
more "loose objects" lines interspersed with your packs).

-Peff
