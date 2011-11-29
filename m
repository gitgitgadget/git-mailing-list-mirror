From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 15:59:05 -0500
Message-ID: <20111129205905.GA1793@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, spearce@spearce.org,
	torvalds@linux-foundation.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 21:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVUll-0000OR-R4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 21:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab1K2U7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 15:59:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab1K2U7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 15:59:07 -0500
Received: (qmail 2687 invoked by uid 107); 29 Nov 2011 21:05:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 16:05:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 15:59:05 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DboVU4kSbJSV=8NP08OyLYVgOKsm8tt=koZ0=JcGSE=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186082>

On Tue, Nov 29, 2011 at 09:04:06PM +0700, Nguyen Thai Ngoc Duy wrote:

> > You can fix this by including an extra header in the signed part of the
> > tag that says "also, the digest of the commit I point to is X". Then you
> > know you have the same commit that Linus had. But the commit points to a
> > tree by its sha1. So you have to add a similar header in the commit
> > object that says "also, the digest of the tree I point to is X". And
> > ditto for all of the parent pointers, if you want to care about signing
> > history. And then you have the same problem in the tree: each sub-tree
> > and blob is referenced by its sha1.
> >
> Can we just hash all objects in a pack from bottom up, (replacing
> sha-1 in trees/commits/tags with the new digest in memory before
> hashing), then attach the new top digest to tag's content? The sender
> is required by the receiver to send new digests for all objects in the
> pack together with the pack. The receiver can then go through the same
> process to produce the top digest and match it with one saved in tag.

I think that is conflating two different layers of git. The security for
tags happens at the conceptual object db layer: you sign a tag, and that
points to a commit, which points to a tree, and so on. The authenticity
comes from the tag signature, but the integrity of each link in the
chain is verifiable because of the has property. The pack layer, on the
other hand, is just an implementation detail about how those conceptual
objects are stored. More than just your tag will be in a pack, and the
contents of your tag may be spread across several packs (or even loose
objects).

So I don't think it's right to talk about packs at all in the signature
model.

If you wanted to say "make a digest of all of the sub-objects pointed to
by the tag", then yes, that does work (security-wise). But it's
expensive to calculate. Instead, you want to use a "digest of digests"
as much as possible. Which is what git already does, of course; you hash
the tree object, which contains hashes of the blob sha1s. Git's
conceptual model is fine. The only problem is that sha1 is potentially
going to lose its security properties, weakening the links in the chain.
So as much as possible, we want to insert additional links at the exact
same places, but using a stronger algorithm.

Does that make sense?

-Peff
