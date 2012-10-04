From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] peel_ref: check object type before loading
Date: Thu, 4 Oct 2012 15:41:50 -0400
Message-ID: <20121004194150.GA13955@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004080253.GC31325@sigill.intra.peff.net>
 <7vbogiys47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgU-00033L-8M
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2JDTlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:41:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40949 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756528Ab2JDTlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:41:52 -0400
Received: (qmail 24118 invoked by uid 107); 4 Oct 2012 19:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 15:42:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 15:41:50 -0400
Content-Disposition: inline
In-Reply-To: <7vbogiys47.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207026>

On Thu, Oct 04, 2012 at 12:06:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The point of peel_ref is to dereference tags; if the base
> > object is not a tag, then we can return early without even
> > loading the object into memory.
> >
> > This patch accomplishes that by checking sha1_object_info
> > for the type. For a packed object, we can get away with just
> > looking in the pack index. For a loose object, we only need
> > to inflate the first couple of header bytes.
> 
> We look at the pack index and have to follow its delta chain down to
> the base to find its type; if the object is deeply deltified, this
> certainly is an overall loss.

Yes. Although in practice I would expect most things pointed to by refs
to not be delta'd. And indeed, comparing "git index-pack -v" to "git
for-each-ref" in my git.git repository yields 950 non-delta tips and
only 42 delta (and those are mostly rebased commit objects). In my
linux-2.6 repo, I have 0 delta ref tips (probably because I do not
actually do kernel work, but keep it around for querying).

The numbers I mentioned in 926f1dd (which did this exact same
optimization for upload-pack) showed a slight improvement in practice.
Because keep in mind that the alternative to this multi-step delta
lookup for the type is to load the object. Which will do the _same_
lookup, but will also have to actually compute the delta.

So the only real loss is that you have to repeat the lookup (or in the
case of a loose object, re-open and re-inflate the first 32 bytes). The
best way to do this would be to have sha1_object_info return some kind
of handle to the object where we could get the meta info cheaply, and
then reuse the handle to get the actual object data later (so for a
packed object, cache the actual pack location; for a loose object, keep
the descriptor and zlib stream open).

Of course, the speed up in 926f1dd probably won't matter anymore because
the whole point of this series is to avoid touching the object at all.
So hitting sha1_object_info in peel_ref is already the slow path. On
most objects, an optimization like this will not be noticeable either
way. The interesting thing is that we can avoid touching a large or
expensive object at all.

> > This optimization is the one that gave me the most pause. While
> > upload-pack does call peel_ref on everything, the other callers all
> > constrain themselves to refs/tags/. So for many projects, we will be
> > calling it mostly on annotated tags, and it may be a very small net
> > loss. But in practice, it will not matter for most projects with a sane
> > number of normal tags, and saving even one accidental giant blob load
> > can have a huge impact.
> 
> I may be missing something, but the above description is not
> convincing to me.  When was the last time you pointed a blob
> directly with a ref, whether large or small, and whether within
> refs/tags or outside?

Not often (though you have such a ref in git.git). I started down this
road because just applying patch 4/4 produces a regression in the test
suite. t1050 tries to clone a tag pointing to a large object with
GIT_ALLOC_LIMIT set. Using peel_ref regresses this to actually load the
whole object into memory.

That particular regression is fixed by 1/1 (because it's an annotated
tag pointing to the large object). This would fix the same case if it
were an unannotated tag.

Now is that a real-world test? No, I'm not sure it is. But I consider it
a win for large-object git[1] every time we can avoid loading an object,
because it only takes one unnecessary load to ruin the user experience.
So even if it's unlikely, if it isn't hurting the regular code path, I
think it's worth doing (and I'm not sure it is hurting; my numbers
showed that it be helping, though I suspect it is doing nothing after my
4/4).

-Peff

[1] One thing I've been toying is with "external alternates"; dumping
    your large objects in some realtively slow data store (e.g., a
    RESTful HTTP service). You could cache and cheaply query a list of
    "sha1 / size / type" for each object from the store, but getting the
    actual objects would be much more expensive. But again, it would
    depend on whether you would actually have such a store directly
    accessible by a ref.
