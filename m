From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Thu, 1 Dec 2011 00:26:15 -0500
Message-ID: <20111201052615.GA22141@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <1322603788.1728.190.camel@yos>
 <20111130062512.GA5317@sigill.intra.peff.net>
 <1322700075.1710.157.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 06:26:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVzA9-0007bW-SK
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 06:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab1LAF0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 00:26:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58525
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1LAF0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 00:26:18 -0500
Received: (qmail 15306 invoked by uid 107); 1 Dec 2011 05:32:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 00:32:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 00:26:15 -0500
Content-Disposition: inline
In-Reply-To: <1322700075.1710.157.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186163>

On Wed, Nov 30, 2011 at 04:41:15PM -0800, Bill Zaumen wrote:

> Aside from that, suppose the attacker does what you suggests (providing
> a valid CRC so that git commands like verify-pack don't have an error
> to detect).  You can't tell that something is wrong, but Linus can - 
> the next time he does a fetch.  If he fetches, the server sends
> some SHA-1 hashes and the client responds with 'have' or 'want' in a
> reply.  If the client wants it, the client doesn't have a CRC, if the
> client sends 'have', the CRCs are available so those get sent.  The
> server then checks, notices a mismatch (probably in the CRC of the CRCs
> of all the blobs in the commit's tree), and generates an error.

OK. I thought your claim was that this would help detect
collision-related forgeries in the chain of hashes while verifying a
signed tag. But your claim is only that your scheme gives people who
already have the objects an additional chance to notice discrepencies in
what the server is serving and what they have. And then they can notify
other people of the problem in an out-of-band way (i.e., telling
kernel.org admins that the system is hacked, or telling users not to
fetch from there).

Cryptographically speaking, I think that claim is sound, and you can
certainly construct attack scenarios where this detection would help.
However, quantifying the effectiveness is difficult.  What is the
likelihood of a malicious collided-object replacement being detected
without your scheme? What is it with it?

There are many questions that factor into guessing the latter.

How often does Linus fetch from his own kernel.org repository? He would
usually push, I would think.  Even if he does fetch, he wouldn't be
getting the old objects that he already has. I guess this is the reason
for your digest-of-digests for each commit object sent? But what about
objects that are no longer in current commits, but are in older ones?
E.g., v1.0 of foo.c has sha1 X, and an attacker finds a collision and
replaces it. Meanwhile, the tip of development now has replaced foo.c
with X'. When Linus talks to the server, git will never care about X (it
is neither being transmitted, nor is part of a commit that is being
transmitted).  But people may still be cloning and using the v1.0 tag,
assuming it is valid.

What about the server being more clever about hiding the replacement
object? E.g., instead of just breaking into kernel.org and inserting a
replacement object, the attacker runs a malicious git-daemon that
returns the bogus object to cloners, but the real object to fetchers.
Thus there is nothing for Linus to detect, but new cloners get the
malicious object. Or you could give the bogus object to people who are
getting the object for the first time (since they presumably have no
crc for that object), but otherwise use the real object.

You could get around this deception by pretending to be a "victim";
i.e., cloning fresh and seeing what the server gives you, comparing it
to your known-good repository. Which is similar to what you suggest
here:

> It's also possible to write some additional commands to (for example)
> fetch the SHA-1 hashes and CRCs from all remote repositories you use
> and compare these to make sure they are all consistent, something that
> can be run ocassionally.

But we can already do that. Assume you have an existing repo "foo". To
verify the copy at git://example.com/foo.git, do a fresh clone to
"bar", and then compare the objects in "foo" to "bar", either byte-wise
or by digest.

> That result for birthday attack assumes the goal is to find two files
> that will have the same SHA-1 value (or SHA-1 + CRC).  The case I was
> talking about (apologies if I did not state this clearly) is that you
> have an existing object and an existing CRC and you want to generate
> a second object with the same SHA-1 and same CRC as the first.  A
> birthday attack doesn't work so well in that case - the number of tries
> is much higher than half the number of bits in the digest.

Yes. This is called a "pre-image" attack (to be more specific, it is a
"second pre-image attack", since you have the original object). And
AFAIK, it's not feasible against SHA-1, nor will it be in the near
future (even MD5, which is considered totally broken, does not have
feasible pre-image attacks).

> http://en.wikipedia.org/wiki/Birthday_attack#Digital_signature_susceptibility
> has a discussion regarding digital signatures.  The trick is for a
> person to create a large number of variations of a "fair" and "unfair"
> contract, and use a birthday attack to find a pair that have the same
> hash.  The variations are typically inconsequential changes (extra
> spacing, commas, etc.)

Right. This is the classic birthday attack. I don't keep up with the
state of the art in collision attacks these days, but I think in
practice they are usually executed by adding arbitrary binary garbage
into a "hidden" spot in a file. Which makes it much harder to execute
against text files like source code (as opposed to, say, a binary
firmware blob). IIRC, the practical MD5 attacks involved postscript
documents (with non-printing garbage sections that printers would
ignore).

> In the case I was discussing, a developer creates some code,  commits
> it and pushes it to a shared repository - the developer is not given
> code by the attacker.  The attacker can, however, see the code by
> fetching it.  An attack then consists of generating a collision,
> change the object in the attacker's local repository, and then push
> the original developer's commit (with the modified object) to another
> shared repository before someone else puts the correct objects into
> that repository.  A birthday attack does not work in this case.

Yeah, that is simply not feasible, and is not likely to become so
anytime soon.

> There one issue that this suggests however - it is not clear if the
> 2^57 number given for the best SHA-1 attacks were attempts to generate
> a new file with the same SHA-1 hash as an existing file or a pair of
> files that have the same SHA-1 hash.  If it is the latter, then an
> attack is significantly harder than I assumed as a worst case, but
> still possibly much, much better than brute force.

The 2^57 number is for a collision of two new objects, not for a
pre-image attack. AFAIK, there are currently no pre-image attacks on
SHA-1 at all.

I don't think there's a need to response individually to the points in
the rest of your email; they're all based on the assumption that the
attacker is replacing a known-good written-by-Linus commit with one
found in a pre-image attack.

-Peff
