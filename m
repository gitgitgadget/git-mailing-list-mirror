From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 22:01:24 -0400
Message-ID: <20120801020124.GA18071@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 04:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwOFi-0006Do-9t
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 04:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab2HACB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 22:01:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43987 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab2HACB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 22:01:28 -0400
Received: (qmail 2143 invoked by uid 107); 1 Aug 2012 02:01:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jul 2012 22:01:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2012 22:01:24 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202700>

On Wed, Aug 01, 2012 at 08:10:12AM +0700, Nguyen Thai Ngoc Duy wrote:

> > I do not think that is the right direction. Let's imagine that I have a
> > commit "A" and I annotate it (via notes or whatever) to say "between
> > A^^{tree} and A^{tree}, foo.c became bar.c". That will help me when
> > doing "git show" or "git log". But it will not help me when I later try
> > to merge "A" (or its descendent). In that case, I will compute the diff
> > between "A" and the merge-base (or worse, some descendent of "A" and the
> > merge-base), and I will miss this hint entirely.
> >
> > A much better hint is to annotate pairs of sha1s, to say "do not bother
> > doing inexact rename correlation on this pair; I promise that they have
> > value N".
> 
> I haven't had time to think it through yet but I throw my thoughts in
> any way. I actually went with your approach first. But it's more
> difficult to control the renaming. Assume we want to tell git to
> rename SHA-1 "A" to SHA-1 "B". What happens if we have two As in the
> source tree and two Bs in the target tree? What happens if two As and
> one B, or one A and two Bs? What if a user defines A -> B and A -> C,
> and we happen to have two As in source tree and B and C in target
> tree?

Yes, it disregards path totally. But if you had the exact same movement
of content from one path to another in one instance, and it is
considered a rename, wouldn't it also be a rename in a second instance?

> There's also the problem with transferring this information. With
> git-notes I think I can transfer it (though not automatically). How do
> we transfer sha1 map (that you mentioned in the commit generation mail
> in this thread)?

That is orthogonal to the issue of what is being stored. I chose my
mmap'd disk implementation because it is very fast, which makes it nice
for a performance cache. But you could store the same thing in git-notes
(indexed by dst sha1, I guess, and then pointing to a blob of (src,
score) pairs.

If you want to include path-based hints in a commit, I'd say that using
some micro-format in the commit message would be the simplest thing. But
that has been discussed before; ultimately the problem is that it only
covers _one_ diff that we do with that commit (it is probably the most
common, of course, but it doesn't cover them all).

> > Then it will find that pair no matter which trees or commits
> > are being diffed, and it will do so relatively inexpensively[1].
> 
> But does that happen often in practice? I mean diff-ing two arbitrary
> trees and expect rename correction. I disregarded it as "git log" is
> my main case, but I'm just a single user..

It happens every time merge-recursive does rename detection, which
includes "git merge" but also things like "cherry-pick".

-Peff
