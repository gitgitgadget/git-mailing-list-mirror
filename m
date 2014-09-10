From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Wed, 10 Sep 2014 15:11:59 -0400
Message-ID: <20140910191159.GA23655@peff.net>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
 <20140910081358.GB16413@peff.net>
 <CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>
 <20140910103014.GA15461@peff.net>
 <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:12:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRnJI-0005z7-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 21:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaIJTME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 15:12:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:46641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbaIJTMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 15:12:03 -0400
Received: (qmail 8778 invoked by uid 102); 10 Sep 2014 19:12:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 14:12:02 -0500
Received: (qmail 19127 invoked by uid 107); 10 Sep 2014 19:12:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 15:12:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 15:11:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256760>

On Wed, Sep 10, 2014 at 09:51:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, we don't let normal fetchers see these repos. They're only for
> > holding shared objects and the ref tips to keep them reachable.
> 
> Are these individual refs have relations to the real world after
> they are created?  To ask it another way, let's say that a branch in
> a repository, which is using this as a shared object store, caused
> one of these refs to be created; now the origin repository rewinds
> or deletes that branch---do you do anything to the ref in the shared
> object store at that point?

Yes, we fetch from them before doing any maintenance in the shared
repository (like running repack). That's how objects migrate into the
shared repository, as well.

> I am wondering if it makes sense to maintain a single ref that
> reaches all the commits in this shared object store repository,
> instead of keeping these millions of refs.  When you need to make
> more objects kept and reachable, create an octopus with the current
> tip and tips of all these refs that causes you to wish making these
> "more objects kept and reachable".  Obviously that won't work well
> if the reason why your current scheme uses refs is because you
> adjust individual refs to prune some objects---hence the first
> question in this message.

Exactly. You could do this if you threw away and re-made the octopus
after each fetch (and then threw away the individual branches that went
into it). For that matter, if all you really want are the tips for
reachability, you can basically run "for-each-ref | sort -u"; most of
these refs are tags that are duplicated between each fork.

However, having the individual tips does make some things easier. If I
only keep unique tips and I drop a tip from fork A, I would then need to
check every other fork to see if any other fork has the same tip. OTOH,
that means visiting N packed-refs files, each with (let's say) 3000
refs. As opposed to dealing with a packed-refs file with N*3000 refs. So
it's really not that different.

We also use the individual ref tips for packing. They factor into the
bitmap selection, and we have some patches (which I've been meaning to
upstream for a while now) to make delta selections in the shared-object
repository that will have a high chance of reuse in clones of individual
forks. And it's useful to query them for various reasons (e.g., "who is
referencing this object?").

There a lot of different ways to do it, and the giant refs file is a
pain (not to mention writing objects to disk in the forks, and then
migrating them separately to the shared storage). But doing it this way
means that the forks and the shared-object repository are all real
first-class git repositories. We follow the usual object reachability
guarantees, and it's safe to run any stock git command on them.

I am leaning towards a system where the shared-object repository is a
pseudo-repository, forks actually write directly into the shared object
store (probably with a symlinked objects/ directory), and implementing a
ref backend that generates a virtual mapping on the fly (e.g., all refs in
"../foo.git" appear as "refs/remotes/foo/*" in the pseudo-repository.
I'm watching the refs-backend work anxiously. :)

-Peff
