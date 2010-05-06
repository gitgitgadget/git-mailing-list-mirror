From: Jeff King <peff@peff.net>
Subject: Re: Multiblobs
Date: Thu, 6 May 2010 02:26:44 -0400
Message-ID: <20100506062644.GB16151@coredump.intra.peff.net>
References: <loom.20100428T164432-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:26:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uXx-00068a-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0EFG0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:26:48 -0400
Received: from peff.net ([208.65.91.99]:48143 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab0EFG0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:26:47 -0400
Received: (qmail 2797 invoked by uid 107); 6 May 2010 06:27:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 02:27:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 02:26:44 -0400
Content-Disposition: inline
In-Reply-To: <loom.20100428T164432-954@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146443>

On Wed, Apr 28, 2010 at 03:12:07PM +0000, Sergio Callegari wrote:

> it happened to me to read an older post by Jeff King about "multiblobs"
> (http://kerneltrap.org/mailarchive/git/2008/4/6/1360014) and I was wandering
> whether the idea has been abandoned for some reason or just put on hold.

I am a little late getting to this thread, and I agree with a lot of
what Avery said elsewhere, so I won't repeat what's been said. But after
reading my own message that you linked and the rest of this thread, I
wanted to note a few things.

One is that many of the applications for these multiblobs are extremely
varied, and many of them are vague and hand-waving. I think you really
have to look at each application individually to see how a solution
would fit. In my original email, I mentioned linear chunking of large
blobs for:

  1. faster inexact rename detection

  2. better diffs of binary files

I think (2) is now obsolete. Since that message, we now have textconv
filters, which allow simple and fast diffs of large objects (in my
example, I talked about exif tags on images. I now textconv the images
into a text representation of the exif tags and diff those). And with
textconv caching, we can do it on the fly without impacting how we
represent the object in git (we don't even have to pull the original
large blob out of storage at all, as the cache provide a look-aside
table keyed by the object name).

I also mentioned in that email that in theory we could diff individual
chunks even if we don't understand their semantic meaning. In practice,
I don't think this works. Most binary formats are going to involve not
just linear chunking, but decoding the binary chunks into some
human-readable form. So smart chunking isn't enough; you need a decoder,
which is what a textconv filter does.

For item (1), this is closely related to faster (and possibly better)
delta compression. I say only possibly better, because in theory our
delta algorithm should be finding something as simple as my example
already.

And for both of those cases, the upside is a speed increase, but the
downside is a breakage of the user-visible git model (i.e., blobs get
different sha1's depending on how they've been split). But being two
years wiser than when I wrote the original message, I don't think that
breakage is justified. Instead, you should retain the simple git object
model, and consider on-the-fly content-specific splits. In other words,
at rename (or delta) time notice that blob 123abc is a PDF, and that it
can be intelligently split into several chunks, and then look for other
files which share chunks with it. As a bonus, this sort of scheme is
very easy to cache, just as textconv is. You cache the smart-split of
the blob, which is immutable for some blob/split-scheme combination. And
then you can even do rename detection on large blob 123abc without even
retrieving it from storage.

Another benefit is that you still _store_ the original (you just don't
look at it as often). Which means there is no annoyance with perfectly
reconstructing a file. I had originally envisioned straight splitting,
with concatenation as the reverse operation. But I have seen things like
zip and tar files mentioned in this thread. They are quite challenging,
because it is difficult to reproduce them byte-for-byte. But if you take
the splitting out of the git data model, then that problem just goes
away.

The other application I saw in this thread is structured files where you
actually _want_ to see all of the innards as individual files (e.g.,
being able to do "git show HEAD:foo.zip/file.txt"). And for those, I
don't think any sort of automated chunking is really desirable. If you
want git to store and process those files individually, then you should
provide them to git individually. In other words, there is no need for
git to know or care at all that "foo.zip" exists, but you should simply
feed it a directory containing the files. The right place to do that
conversion is either totally outside of git, or at the edges of git
(i.e., git-add and when git places the file in the repository). Our
current hooks may not be sufficient, but that means those hooks should
be improved, which to me is much more favorable than a scheme that
alters the core of the git data model.

So no, reading my original message, I don't think it was a good idea. :)
The things people want to accomplish are reasonable goals, but there are
better ways to go about it.

-Peff
