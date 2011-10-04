From: Jeff King <peff@peff.net>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 14:08:29 -0400
Message-ID: <20111004180829.GB31671@sigill.intra.peff.net>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
 <CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
 <CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
 <7v62k5g988.fsf@alter.siamese.dyndns.org>
 <CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
 <20111004110702.GA18599@sigill.intra.peff.net>
 <CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
 <20111004124502.GB30162@sigill.intra.peff.net>
 <CAA01Csp2rouKk4jvCH0Wu+0gc3+cvyH__d-yw8EHEkeZhRpX1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 20:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB9Px-0000X2-LJ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 20:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039Ab1JDSId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 14:08:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52273
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab1JDSIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 14:08:32 -0400
Received: (qmail 10403 invoked by uid 107); 4 Oct 2011 18:13:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 14:13:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 14:08:29 -0400
Content-Disposition: inline
In-Reply-To: <CAA01Csp2rouKk4jvCH0Wu+0gc3+cvyH__d-yw8EHEkeZhRpX1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182785>

On Tue, Oct 04, 2011 at 03:21:24PM +0200, Piotr Krukowiecki wrote:

> I have 4GB ram + 4GB swap. Is it possible the RAM is the problem if I
> always have free RAM left and my swap is almost not used?
> For example at the moment repack finished counting objects ("Counting
> objects: 1742200, done."):
> 
> $ free -m
>              total       used       free     shared    buffers     cached
> Mem:          3960       3814        146          0        441        215
> -/+ buffers/cache:       3157        803
> Swap:         6143        694       5449

I am not the best person to comment on Linux's disk caching strategies,
but in general, it should prefer dropping disk cache over pushing
program memory into swap. So no, you're not swapping, but you are
working with only 800M or so to do your disk caching.

So depending how big pack-object's working set of objects is, we might
be overflowing that, and constantly evicting and re-reading objects. I
don't recall offhand what kind of locality there is to pack-object's
accesses.

One thing you could try to reduce the working set is to incrementally
pack some smaller chunks, and then combine them all at the end. That
ends up being more work overall, but at any given time, your working set
of objects will be smaller.

You'd have to do something like this (this is very untested):

  # find out how many revisions we have. Let's pretend it's about
  # 25,000.
  git rev-list HEAD | wc -l

  # now split them into chunks of whatever size you feel like trying.
  # 1000, maybe, or a few thousand. Bearing in mind that this is a gross
  # approximation, since the history is not linear.
  #
  # Start with HEAD~24K (25K total, minus 1K we want to pack)
  echo HEAD~24000 | git pack-objects --revs .git/objects/pack/pack
  # And then prune the loose objects that we just packed.
  git prune-packed
  # And repeat for the next chunk
  echo HEAD~24000..HEAD~23000 | git pack-objects --revs .git/objects/pack/pack
  git prune-packed
  # And so forth...

And then at the end, probably do a "git repack -ad" to put it all in
one big pack. Which should hopefully be less disk-intensive, because now
you'll have a much smaller disk footprint, since most of your objects
are at least delta'd against the others in their own pack.

I have no idea if this will actually go faster for you. But it might be
worth trying, instead of just redoing the svn import with auto-gc turned
on.

-Peff
