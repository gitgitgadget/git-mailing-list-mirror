From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Thu, 2 Aug 2012 18:41:55 -0400
Message-ID: <20120802224155.GB28217@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
 <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
 <20120801212719.GA16233@sigill.intra.peff.net>
 <CACsJy8CndopS7fg4mevFD5T0KJ85ba6jjhamrKDdKvKsWa_fQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx45r-0007ao-0m
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab2HBWmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:42:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49193 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2HBWmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:42:03 -0400
Received: (qmail 19422 invoked by uid 107); 2 Aug 2012 22:42:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Aug 2012 18:42:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2012 18:41:55 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CndopS7fg4mevFD5T0KJ85ba6jjhamrKDdKvKsWa_fQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202809>

On Thu, Aug 02, 2012 at 07:08:25PM +0700, Nguyen Thai Ngoc Duy wrote:

> > I implemented (1a). Implementing (1b) would be easy, but for a full-on
> > cache (especially for "-C"), I think the resulting size might be
> > prohibitive.
> 
> (1a) is good regardless rename overrides. Why don't you polish and
> submit it? We can set some criteria to limit the cache size while
> keeping computation reasonably low. Caching rename scores for file
> pairs that has file size larger than a limit is one. Rename matrix
> size could also be a candidate. We could even cache just rename scores
> for recent commits (i.e. close to heads) only with the assumption that
> people diff/apply recent commits more often.

I'll polish and share it. I'm still not 100% sure it's a good idea,
because introducing an on-disk cache means we need to _manage_ that
cache. How big will it be? Who will prune it when it gets too big? By
what criteria? And so on.

But if it's all hidden behind a config option, then it won't hurt people
who don't use it. And people who do use it can gather data on how the
caches grow.

> > All solutions under (2) suffer from the same problem: they are accurate
> > only for a single diff. For other diffs, you would either have to not
> > use the feature, or you would be stuck traversing the history and
> > assigning a temporary file identity (e.g., given commits A->B->C, and in
> > A->B we rename "foo" to "bar", the diff between A and C could discover
> > that A's "foo" corresponds to C's "bar").
> 
> Yeah. If we go with manual overrides, I expect users to deal with
> these manually too. IOW they'll need to create a mapping for A->C
> themselves. We can help detect that there are manual overrides in some
> cases, like merge, and let users know that manual overrides are
> ignored. For merge, I think we can just check for all commits while
> traversing looking for bases.

Yeah, merges are a special case, in that we know the diff we perform
will always have a direct-ancestor relationship (since it is always
between a tip and the merge base).

> > But there is not much point in making it machine-readable, since the
> > interesting machine-readable things we do with renames are:
> >
> >   1. Show the diff against the rename src, which can often be easier to
> >      read. Except that if rename detection did not find it, it is
> >      probably _not_ going to be easier to read.
> 
> Probably. Still it helps "git log --follow" to follow the correct
> track in the 1% case that rename detection does go wrong.

Thanks. I didn't think of --follow, but that is a good counterpoint to
my argument.

> >   2. Applying content to the destination of a merge. But you're almost
> >      never doing the diff between a commit and its parent, so the
> >      information would be useless.
> 
> Having a way to interfere rename detection, even manually, could be
> good in this case if it reduces conflicts. We could feed rename
> overrides using command line.

Yeah. I think I'd start with letting you feed pairs to diff_options,
give it a command-line option to see how useful it is, and then later on
consider a mechanism for extracting those pairs automatically from
commits or notes.

-Peff
