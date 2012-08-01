From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 17:27:20 -0400
Message-ID: <20120801212719.GA16233@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
 <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwgS5-000374-0s
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab2HAV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:27:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46764 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838Ab2HAV10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:27:26 -0400
Received: (qmail 10419 invoked by uid 107); 1 Aug 2012 21:27:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Aug 2012 17:27:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Aug 2012 17:27:20 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202725>

On Wed, Aug 01, 2012 at 11:36:00AM +0700, Nguyen Thai Ngoc Duy wrote:

> > That is orthogonal to the issue of what is being stored. I chose my
> > mmap'd disk implementation because it is very fast, which makes it nice
> > for a performance cache. But you could store the same thing in git-notes
> > (indexed by dst sha1, I guess, and then pointing to a blob of (src,
> > score) pairs.
> >
> > If you want to include path-based hints in a commit, I'd say that using
> > some micro-format in the commit message would be the simplest thing.
> 
> Rename correction is after the commit is created. I don't think we can
> recreate commits.

Yes, if you go with a commit-based approach, you can do either notes or
in-commit messages. In other words, I would break the solutions down as:

  1. Store sha1+sha1 -> score mapping (i.e., what I suggested). This is
     fundamentally a global store, not a per-commit store. For storage,
     you can do one (or a combination) of:

     a. Store the mapping in some local file. Fast, but can't be shared.

     b. Store the mapping in a note (probably indexed by the destination
        blob sha1). Less efficient, but easy to share.

  2. Store path -> path mapping. This is fundamentally a per-commit
     store, since it is valid only in the diff between two particular
     trees. For storage, you can do one (or a combination) of:

     a. Store the mapping inside the commit object. Simple to share, but
        hard to change later.

     b. Store it in a note indexed by the commit object. Slightly harder
        to share, but can change later.

I implemented (1a). Implementing (1b) would be easy, but for a full-on
cache (especially for "-C"), I think the resulting size might be
prohibitive.

All solutions under (2) suffer from the same problem: they are accurate
only for a single diff. For other diffs, you would either have to not
use the feature, or you would be stuck traversing the history and
assigning a temporary file identity (e.g., given commits A->B->C, and in
A->B we rename "foo" to "bar", the diff between A and C could discover
that A's "foo" corresponds to C's "bar").

That is slower than what we do now, but that is only one problem with
it. Another is that the history relationship between the commits might
be complex. In the example above, we had a direct-descendent
relationship. But what about one with branching, and one side does the
rename and the other does not? Or even cherry-picking from an unrelated
part of history entirely?

And I think all forms of (2) will suffer from this, no matter how you
store the data. The reason I mentioned specifically putting it in the
commit message (i.e., 2a) because that is what people suggested in the
very early days of git (e.g., saying that rename detection is OK, but
could we supplement it with hints at commit-time?). And all of the
arguments against it back then apply equally now. And apply equally to
storing it in notes, because it is just another form of the same thing.

> > But that has been discussed before; ultimately the problem is that
> > it only covers _one_ diff that we do with that commit (it is
> > probably the most common, of course, but it doesn't cover them all).
> 
> How about we generate sha1 mapping from commit hints? We try to take
> advantage of path hints when we can. Else we fall back to sha-1
> mapping. This way we can transfer commit hints as git-notes to another
> repo, then regenerate sha-1 mapping there. No need to transfer sha1
> maps.

Yes. You could definitely pre-seed the sha1 mapping from the per-commit
hints. However, if you are interested in overriding git's rename
detection, then per-commit hints will only let you do part of what you
want. For example, consider a linear history like this:

   A--B--C

And imagine that commit B renamed a file from "foo" to "bar", and that
commit C further modified "bar". Let's say that git did not detect the
rename in B, but you manually annotated it. As a result, we seed the
sha1 mapping to show that the sha1 of A:foo and the sha1 of B:bar has a
rename score of 100%.

Now I want to do a diff between A and C (e.g., for rename detection on
one side of a merge). But their sha1s are not in my mapping (because
C:bar is not the same as B:bar), and I don't find the rename. To find
it, I cannot seed a per-commit path mapping. I must seed the sha1
mapping itself.

So to adapt your per-commit mapping into a sha1 mapping, the seeding
process would have to actually walk the history, transitively creating
sha1 mapping entries (i.e., seeing that "bar" changed between B and C,
and therefore mapping A:foo to C:bar, as well).

For this reason, I'm not sure that stored overrides like this are
generally useful in the long run. I think storage is useful for
_caching_ the results, because it doesn't have to be perfect; it just
helps with some repetitive queries. Whereas for overriding, I think it
is much more interesting to override _particular_ diff. E.g., to say "I
am merging X and Y, and please pretend that Y renamed "foo" to "bar"
when you do rename detection.

And in that sense, your "git log" example can be considered a
special-case of this: you are saying that the diff from $commit to
$commit^ is done frequently, so rather than saying "please pretend..."
each time, you would like to store the information forever. And storing
it in the commit message or a note is one way of doing that.

I don't think there's anything fundamentally _wrong_ with that, but I
kind of question its usefulness. In other words, what is the point in
doing so? If it is inform the user that semantically the commit did a
rename, even though the content changed enough that rename detection
does not find it, then I would argue that you should simply state it in
the commit message (or in a human-readable git-note, if it was only
realized after the fact).

But there is not much point in making it machine-readable, since the
interesting machine-readable things we do with renames are:

  1. Show the diff against the rename src, which can often be easier to
     read. Except that if rename detection did not find it, it is
     probably _not_ going to be easier to read.

  2. Applying content to the destination of a merge. But you're almost
     never doing the diff between a commit and its parent, so the
     information would be useless.

-Peff
