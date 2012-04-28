From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Sat, 28 Apr 2012 08:25:33 -0400
Message-ID: <20120428122533.GA12098@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 14:26:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SO6jA-0005NX-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 14:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661Ab2D1MZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 08:25:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435Ab2D1MZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 08:25:37 -0400
Received: (qmail 6363 invoked by uid 107); 28 Apr 2012 12:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Apr 2012 08:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Apr 2012 08:25:33 -0400
Content-Disposition: inline
In-Reply-To: <vpqbomqqdxo.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196495>

On Tue, Apr 17, 2012 at 10:52:03PM +0200, Matthieu Moy wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > + 3. `git gc --aggressive`; this is often much slower than (2) because git
> > +    throws out all of the existing deltas and recomputes them from
> > +    scratch. It uses a higher window parameter meaning it will spend
> > +    more time computing, and it may end up with a smaller pack. However,
> > +    unless the repository is known to have initially been poorly packed,
> > +    this option is not needed and will just cause git to perform
> > +    extra work.
> 
> I like your patch.
> 
> Maybe you should elaborate on "unless the repository is known to have
> initially been poorly packed". My understanding is that --aggressive was
> implemented to be called after an import from another VCS that would
> have computed very poor deltas, but I'm not sure about the details.

Coincidentally, I came across a case last week that shows --aggressive
providing a large improvement. And it's a public repo, so I was able to
grab a snapshot of the pre-packed state to experiment on and share.

The current packfile is ~246M. It was produced over time by pushes into
the repository, which were then eventually grouped into a single pack by
"git gc" (I'm not sure of the exact history, but this may even have been
a set of "gc --auto" calls over time).

Here's a list of commands and the pack sizes they yield on the repo:

  1. `git repack -ad`: 246M
  2. `git repack -ad -f`: 376M
  3. `git repack -ad --window=250`: 246M
  4. `git repack -ad -f --window=250`: 145M

The most interesting thing is (4): repacking with a larger window size
yields a 100M (40%) space improvement. The other commands show that it
is not that the current pack is simply bad; command (2) repacks from
scratch and actually ends up with a worse pack. So the increased window
size really is important.

I haven't been able to figure out what it is about this dataset that
makes the bigger window so much better. Certainly doing the same
commands on git.git does not yield as impressive a speedup.

If anybody is interested in the repository as a packing test case, you
can download it from:

  https://gist.github.com/raw/2518074/d9c0244bf0ced690fee1edb2c88c522ecce102e4/phpmyadmin-network.tar

-Peff
