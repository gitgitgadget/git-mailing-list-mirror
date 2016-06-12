From: Jeff King <peff@peff.net>
Subject: Re: Repacking a repository uses up all available disk space
Date: Sun, 12 Jun 2016 18:13:09 -0400
Message-ID: <20160612221309.GC5428@sigill.intra.peff.net>
References: <20160612212514.GA4584@gmail.com>
 <20160612213804.GA5428@sigill.intra.peff.net>
 <20160612215436.GB4584@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 00:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCDdB-0001m5-8o
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 00:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933311AbcFLWNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 18:13:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53533 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932891AbcFLWNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 18:13:12 -0400
Received: (qmail 6358 invoked by uid 102); 12 Jun 2016 22:13:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 18:13:12 -0400
Received: (qmail 8664 invoked by uid 107); 12 Jun 2016 22:13:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 18:13:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jun 2016 18:13:09 -0400
Content-Disposition: inline
In-Reply-To: <20160612215436.GB4584@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297144>

On Sun, Jun 12, 2016 at 05:54:36PM -0400, Konstantin Ryabitsev wrote:

> >   git gc --prune=now
> 
> You are correct, this solves the problem, however I'm curious. The usual
> maintenance for these repositories is a regular run of:
> 
> - git fsck --full
> - git repack -Adl -b --pack-kept-objects
> - git pack-refs --all
> - git prune
> 
> The reason it's split into repack + prune instead of just gc is because
> we use alternates to save on disk space and try not to prune repos that
> are used as alternates by other repos in order to avoid potential
> corruption.
> 
> Am I not doing something that needs to be doing in order to avoid the
> same problem?

Your approach makes sense; we do the same thing at GitHub for the same
reasons[1]. The main thing you are missing that gc will do is that it
knows the prune-time it is going to feed to git-prune[2], and passes
that along to repack. That's what enables the "don't bother ejecting
these, because I'm about to delete them" optimization.

That option is not documented, because it was always assumed to be an
internal thing to git-gc, but it is:

  git repack ... --unpack-unreachable=5.minutes.ago

or whatever.

-Peff

[1] We don't run the fsck at the front, though, because it's really
    expensive.  I'm not sure it buys you much, either. The repack
    will do a full walk of the graph, so it gets you a connectivity
    check, as well as a full content check of the commits and trees. The
    blobs are copied as-is from the old pack, but there is a checksum on
    the pack data (to catch any bit flips by the disk storage). So the
    only thing the fsck is getting you is that it fully reconstructs the
    deltas for each blob and checks their sha1. That's more robust than
    a checksum, but it's a lot more expensive.

[2] It's unclear to me if you're passing any options to git-prune, but
    you may want to pass "--expire" with a short grace period. Without
    any options it prunes every unreachable thing, which can lead to
    races if the repository is actively being used.

    At GitHub we actually have a patch to `repack` that keeps all
    objects, reachable or not, in the pack, and use it for all of our
    automated maintenance. Since we don't drop objects at all, we can't
    ever have such a race. Aside from some pathological cases, it wastes
    much less space than you'd expect. We turn the flag off for special
    cases (e.g., somebody has rewound history and wants to expunge a
    sensitive object).

    I'm happy to share the "keep everything" patch if you're interested.
