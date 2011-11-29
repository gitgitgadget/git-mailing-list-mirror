From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 04:07:33 -0500
Message-ID: <20111129090733.GA22046@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 10:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVJfG-0002cR-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 10:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab1K2JHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 04:07:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55556
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab1K2JHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 04:07:35 -0500
Received: (qmail 29532 invoked by uid 107); 29 Nov 2011 09:14:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 04:14:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 04:07:33 -0500
Content-Disposition: inline
In-Reply-To: <1322546563.1719.22.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186046>

[Your original message was almost certainly bounced by git@vger because
 it surpassed the 100K limit; I'll try to quote liberally for those who
 missed the original. You may want to split your content and repost.]

On Mon, Nov 28, 2011 at 10:02:43PM -0800, Bill Zaumen wrote:

> Maintains a database of CRCs of Git objects to allow SHA-1 hash
> collisions to be detected with high probability (1 - 1/2^32) and with
> little computational overhead.  The CRCs cover the content of Git
> objects, but not the header.  For loose objects, these are stored in
> subdirectories of GIT_DIRECTORY/objects/crcs, with each subdirectory's
> name consisting of the first two hexadecimal digits of the
> corresponding object's SHA-1 hash.  For each pack file, FILE.pack, the
> CRCs are stored in a FILE.mds, in the same order as the SHA-1 hashes
> that appear in FILE.idx.  Checks for hash collisions are made whenever
> a new loose object is created.

I'm confused. Is this about avoiding accidental collisions, or about
avoiding malicious collision attacks?

Let's assume the former for a minute. The usual way of considering
collision likelihood is not by probabilities, but by the number of items
that must be selected to achieve a >50% probability that there is a
collision. Which is the square root of the number of total items, or
half the bit-space.

So we expect to see a collision in 160-bit SHA-1 after writing about
2^80 objects. The linux-2.6 repository has about 2.2 million objects
after 6.5 years of development. If development continues at this pace,
we would expect a collision in a mere 10^18 years.

Assuming your 32-bit CRC is statistically independent of the SHA-1
value, it adds 32 bits to the hash, or 16 bits to the number of objects
we expect to generate (i.e., 2^96). That bumps us up to 10^23 years.

However, it may be of interest that the Sun is expected to burn out in a
mere 10^10 years[1].

So I'm not sure there is really any point in adding a few bits to the
hash length to detect an accidental collision. It's already
fantastically unlikely. Adding another probability on top does make it
less likely, but in the same ballpark of fantastic.

You can argue about whether linux-2.6 is a representative sample, or
whether the pace of object creation might increase. But the simple
answer is that we're many orders of magnitude away from having to care.

However, in your patch you write:

> +Security-Issue Details
> +----------------------
> +
> +Without hash-collision detection, Git has a higher risk of data
> +corruption due to the obvious hash-collision vulnerability, so the
> +issue is really whether a usable vulnerability exists. Recent research
> +has shown that SHA-1 collisions can be found in 2^63 operations or
> +less.  While one result claimed 2^53 operations, the paper claiming
> +that value was withdrawn from publication due to an error in the
> +estimate. Another result claimed a complexity of between 2^51 and 2^57
> +operations, and still another claimed a complexity of 2^57.5 SHA-1
> +computations. A summary is available at
> +<http://hackipedia.org/Checksums/SHA/html/SHA-1.htm#SHA-1>. Given the
> +number of recent attacks, possibly by governments or large-scale
> +criminal enterprises
> +(<http://www.csmonitor.com/World/terrorism-security/2011/0906/Iranian-government-may-be-behind-hack-of-Dutch-security-firm>,
> +<http://en.wikipedia.org/wiki/Operation_Aurora>,
> +<http://en.wikipedia.org/wiki/Botnet#Historical_list_of_botnets>),
> +which include botnets with an estimated 30 million computers, there is
> +reason for some concern: while generating a SHA-1 collision for
> +purposes of damaging a Git repository is extremely expensive
> +computationally, it is possibly within reach of very well funded
> +organizations. 2^32 operations, even if the operations are as
> +expensive as computing a SHA-1 hash of a modest source-code file, can
> +be performed in a reasonably short period of time on the type of
> +hardware widely used in desktop or laptop computers at present. With
> +sufficient parallelism, 30 million personal computers sufficient for
> +playing the latest video games could perform 2^56 operations in a
> +reasonable time.

...which makes me think that you do care about malicious collisions. All
of what you wrote above seems fairly accurate. Let's leave aside that
those numbers are for a collision attack as opposed to a pre-image
attack (collision attacks are hard to execute, as they require you to
generate two "matched" objects, one good and one evil, and then convince
somebody to first accept your good object, only to later replace it with
the evil one).

I have two concerns with this as a security mechanism:

First, let us assume that the implementation details of your scheme
work, and that git users will effectively be checking not just a SHA-1,
but now a SHA-1 plus your additional digest.

In that case, why use crc32 as the digest? It seems like a terrible
choice. Assuming it's cryptographically secure, then it's adding a mere
16 bits to the numbers you mentioned above. IOW, it's at best a band-aid
that pushes attacks off for a few years. But more importantly, it's
_not_ secure, and can be trivially forged.

But that's a relatively simple problem. crc32 could be replaced in your
scheme with any of the SHA-2 family, or the upcoming SHA-3, or whatever.

That brings me to my second concern: how does this alternative message
digest have any authority?

For example, your patch teaches the git protocol a new extension to pass
these digests along with the object sha1s. But how do we know the server
isn't feeding us a bad digest along with the bad object?

The "usual" security model discussed in git is that of verifying a
signed tag. Linus signs a tag and pushes it to a server. I fetch the
tag, and can verify the signature on the tag. I want to know that I have
the exact same objects that Linus had. But I can't assume the server is
trustworthy; it may have fed me a bad object with a collided sha1.

But what's in the signed part of the tag object? Only the sha1 of the
commit the tag points to, but not the new digest. So an attacker can
replace the commit with one that collides, and it can in turn point to
arbitrary trees and blobs.

You can fix this by including an extra header in the signed part of the
tag that says "also, the digest of the commit I point to is X". Then you
know you have the same commit that Linus had. But the commit points to a
tree by its sha1. So you have to add a similar header in the commit
object that says "also, the digest of the tree I point to is X". And
ditto for all of the parent pointers, if you want to care about signing
history. And then you have the same problem in the tree: each sub-tree
and blob is referenced by its sha1.

In other words, authority flows from the gpg-signed tag portion, and
links in the chain to each object are made by referencing sha1s. Every
time such a link is made, you need to also include the digest of the
object, or you are giving the attacker a place to insert a collided
object.

For tag and commit objects, this actually isn't that hard; they have a
relatively small number of links, and they have room for arbitrary
headers. I.e., add a "tree-md-sha256" header that gives the expected
sha-256 of the tree object referenced by sha-1 in the "tree" header.
Older versions of git will skip over this header (though obviously they
won't be smart enough to do the more-secure verification).

However, it's harder for trees. Each entry needs to have the new digest
added, but there simply isn't room in the format. So we would have to
change the tree format, breaking interoperability with older versions of
git. And all of your tree sha1's would change as soon as you wrote them
with the new format. That's only slightly better than just swapping
sha1 out for a better algorithm.

One trick you could do is to include the digest of each blob in the
commit object itself. This really bloats the size of commit objects,
though. You can store a digest of their digests instead (which your
patch actually calculates, but AFAICT does not actually insert into the
commit object). That is small and relatively cheap (it turns commit from
an O(1) operation into an O(number of files) operation, but the per-file
constant is pretty inexpensive). But it comes at the expense of not being
able to tell which of the constituent blobs was actually attacked.

So I think all of that would work for verification starting at a signed
tag that points to a commit or a blob. For a tag pointing straight to a
tree, it could include the same "digest of digests" that the commit
would.

But it can never handle direct sha1 references outside of git. For
example, a bug tracker or CI system that references a commit in git will
do so by sha1. But that's an insecure link in the chain; you really need
it to refer to both the sha1 _and_ the digest, and then you can verify
that the object you have under that sha1 matches the digest. So you'd
have to teach a whole generation of tools that they can't trust git sha1
ids, and that you need an "extended" id that includes the digest.

At that point, I really wonder if a flag day to switch to a new
repository format is all that bad. You'd have to either rewrite existing
history (which means re-signing tags if you care about them!), or just
decide to leave the new and old histories disconnected.  Whereas a
scheme based around an added-on digest could keep the old history
connected. But at the same time, the old history will have zero value
from a security perspective. If sha1 is broken, then those old
signatures are worthless, anyway. And just switching to a new algorithm
means the implementation remains very simple.

-Peff

[1] Fun fact of the day: if linux development continues at the same
    rate until the Sun burns out, there is a 1/2^60 chance of a
    collision!
