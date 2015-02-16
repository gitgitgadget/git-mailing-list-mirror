From: Jeff King <peff@peff.net>
Subject: Re: Pack v4 again..
Date: Mon, 16 Feb 2015 01:45:38 -0500
Message-ID: <20150216064537.GF32381@peff.net>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
 <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:45:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNFRB-0001HH-CQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbbBPGpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:45:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:49424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbbBPGpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:45:40 -0500
Received: (qmail 10578 invoked by uid 102); 16 Feb 2015 06:45:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:45:40 -0600
Received: (qmail 12669 invoked by uid 107); 16 Feb 2015 06:45:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:45:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:45:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263883>

On Sun, Feb 15, 2015 at 11:59:02PM -0500, Nicolas Pitre wrote:

> Yet, I think the biggest problem with pack v4 at the moment is the 
> packing algorithm for tree objects.  We are piggy-backing on the pack v2 
> object delta compression sorting and that produces suboptimal results 
> due to deep recursions.  And it is the recursion that kills us. The pack 
> v4 requires a new packing algorithm for its tree objects.
> 
> What I imagined is something like this:
> 
> - Each canonical tree entry is made of a SHA1, mode and path.  Let's 
>   assume this is hashed into a 24-bit value.
> 
> - Each tree object can therefore be represented as a string of 24-bit 
>   "characters".
> 
> - Delta-compressing a tree object becomes a substring search where we 
>   try to replace a sequence of "characters" with the longest "string" 
>   possible from another object.  Repeat with the remaining sequences.

Somewhat related to this, I was playing this weekend with the idea of
generating fast tree diffs from our on-disk deltas. That is, given a
base tree and a binary delta against it, could I reliably reproduce a
diff (one way or the other) in O(size of diff), rather than O(size of
tree)?

I have two applications in mind:

  1. Tree diffs for "git log -- pathspec" do the same diff (between a
     tree and its corresponding version in the parent) over and over.
     A significant percentage of the time (at least in linux.git and
     git.git), we store deltas between these trees.  We could stop
     wasting time walking the common parts of the trees, and jump right
     to the differences.

  2. Calculating reachability for packing[1] spends a lot of time in
     lookup_object, as we have to go through each tree saying "have we
     seen object 1234abcd yet?". If we could instead just view the
     differences, we would not have to make those hash lookups for
     entries whose objects we know we have seen.

The conclusion I came to was "no, you cannot do it in the general case
of byte-wise binary diffs"[2].  Conceptually, it's not too difficult. For
example, if we know we have copied up to byte X from the source tree,
then we skip to byte Y, we know that bytes Y-X did not make it, and are
a deletion of entries. If those fall on whole-entry boundaries, it's
pretty simple. But of course we have no guarantee that they do in a
byte-wise diff. E.g., if entry "foo" changes its sha1, then we will
generally copy up to and including the "foo\0" from the source, and then
insert our own new sha1. Which means we need to walk backwards from
point "Y" to find the filename of the entry we are in. Or worse, the
sha1s might share one or more leading bytes, and that would be part of
the copy, too.

So in short, we may end up anywhere within a tree object and need to
walk backwards to the start of the entry. But we cannot walk backwards
looking for a NUL, because it may also be part of a sha1. You can only
reliably parse a git tree by starting at the beginning of the stream and
going forwards[3].

If we knew that our deltas were always produced on entry-boundaries (a
"character" in your description above), this would be much simpler.

Maybe this is all stuff you already thought through, but if not, food
for thought. :)

-Peff

[1] Of course there are other reachability checks besides packing, like
    git-prune. But all of those are even better sped up by using
    reachability bitmaps. Packing, as the place where we generate the
    bitmaps, and which is sensitive to things like traversal order,
    remains the place where we will always need to actually walk.

[2] One option, of course, is to generate byte-wise deltas, but with a
    promise to always align them on entry boundaries. I'm tempted by
    this, because the result would be readable by existing packv2
    readers. We'd have to set a flag somewhere that indicates the pack
    was written with this property, though.

[3] I suspect you could come up with some heuristic that finds tree
    entry boundaries with high probability, and in the low probability
    case does not produce a wrong answer, but instead has to walk all
    the way back to the beginning of the tree. That would be fine here.
    But frankly, this "walk backwards" thing was just the straw that
    broke the camel's back for me in working on this. Handling all the
    possible cases was ending up quite complicated.
