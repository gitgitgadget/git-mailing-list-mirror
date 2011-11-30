From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Wed, 30 Nov 2011 01:25:12 -0500
Message-ID: <20111130062512.GA5317@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <20111129090733.GA22046@sigill.intra.peff.net>
 <1322603788.1728.190.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	spearce@spearce.org, torvalds@linux-foundation.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 07:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdbe-0007bW-00
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab1K3GZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:25:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55983
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab1K3GZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:25:15 -0500
Received: (qmail 7610 invoked by uid 107); 30 Nov 2011 06:31:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 01:31:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 01:25:12 -0500
Content-Disposition: inline
In-Reply-To: <1322603788.1728.190.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186105>

On Tue, Nov 29, 2011 at 01:56:28PM -0800, Bill Zaumen wrote:

> The additional CRC (easily changed to whatever message digest one might
> prefer) makes a malicious attack far more difficult: the modified file
> has to have both the same SHA-1 hash (including the Git header) and 
> the same CRC (not including the Git header).

Only if the attack actually involves creating a collision on both. But I
think the important attacks bypass your CRC anyway. Consider this attack
scenario:

  1. Linus signs a tag (or a commit) and pushes it to kernel.org.

  2. kernel.org gets hacked, and the attacker replaces an object with
     an evil colliding version[1].

  3. I clone from kernel.org, and run "git tag --verify". Git says it's
     OK, because the signature checks out, but I have a bogus object.

How does your CRC help? If I understand your scheme correctly,
kernel.org will have told me the CRC of all of the objects during the
clone. But that isn't part of what Linus signed, so the attacker in step
2 could just as easily have overwritten kernel.org's crc file, and the
signature will remain valid.

[1] This is an over-simplification, of course. Because the only even
    remotely feasible attacks on sha1 are birthday attacks, not pre-image
    attacks, there is a step 0 in which the attacker generates a
    colliding pair, convinces Linus to commit it, and then waits.

    Which is probably really hard, but for the purposes of this
    discussion, we assume the attacker is capable of inserting a
    colliding object maliciously into a repo you will fetch from.
    Otherwise, the integrity of sha1 isn't an issue at all.

> An efficient algorithm to do both simultaneously does not yet exist.
> So, if we could generate a SHA-1 collision in one second, it would
> presumably take billions of seconds (many decades of continuous
> computation) to generate a SHA-1 hash with the same CRC, and well
> before a year has elapsed, the original object should have been in all
> the repositories, preventing a forged object from being inserted. Of
> course, eventually you might need a real message digest.

This is wrong, for two reasons.

  1. The method for generating an object that collides in both sha-1 and
     CRC is not necessarily to generate a colliding sha-1 and then do a
     pre-image attack on the CRC. It is to do a birthday attack on the
     sha-1 and the CRC together. Which halves the bit-strength of the
     CRC to 16 bits (just as we can generally find collisions in 160-bit
     sha1s in 2^80). 16 bits isn't a lot to add when you are trying to
     fix a broken cryptosystem (it's not broken yet, obviously, but when
     it does get broken, will it be because computing reaches the 2^57
     or so that sha1 is broken at, or will it be because a new weakness
     is found that drops sha1's bit-strength to something much lower?).

     This assumes that you can combine the two in a birthday attack.
     Certainly this analysis works against brute-force 2^80 sha1
     collision attacks. But I haven't actually read the details of the
     sha1 attacks, so maybe some of the tweaking they do to get those
     results makes it harder. On the other hand, attacking CRC is far
     from hard, so I certainly wouldn't stake money that sha1 reseachers
     couldn't tweak their attacks in a way that also allows finding CRC
     collisions. You say that an algorithm to do both simultaneously
     does not yet exist. But is that because it's hard, or simply
     because nobody has bothered trying?

     Anyway, all of that is just reiterating that CRC should not be used
     as a security function. It can easily be replaced in your scheme by
     sha-256, which does have the desired properties.

  2. Your attack seems to be "find the sha-1 collision, publish one of
     your colliding objects (i.e., the innocent-looking half), then try
     to break the CRC". And then you claim that by the time you find the
     CRC, everybody will already have the object.

     But wouldn't a smarter attack be to first find the collision, including
     the CRC, and only _then_ start the attack? Then nobody will have
     the object.

     Moreover, it's not true that after a year everyone will have the
     object. People still run "git clone" against kernel.org. Those
     repos do not have the object.

> The weakness of a CRC as an integrity check is not an issue since it
> is never used alone: it's use is more analogous to the few extra bits
> added to a data stream when error-detecting codes are used.  I used a
> CRC in the initial implementation rather than a message digest because
> it is faster, and because the initial goal was to get things to work
> correctly.  In any case, the patch does not eliminate any code in
> which Git already does a byte-by-byte comparison.  In cases where Git
> currently assumes that two objects are the same because the SHA-1
> hashes are the same, the patch compares CRCs as an additional test.

Right. I don't claim that your scheme makes git any weaker. I just claim
that it fails to solve the problems people are actually concerned about,
and it adds a lot of complexity while doing so.

> Regarding your [Jeff's] second concern, "how does this alternative
> digest have any authority?" there are two things to keep in mind.
> First, it is a supplement to the existing digest.

Right, but we are assuming that sha1 is broken. That's the whole
security problem. So the existing digest is not worth much.

> Second, any value of the CRC that is stored permanently (baring bugs,
> in my implementation, of course) is computed locally - when a loose
> object is created or when a pack file's index is created.  At no point
> is a CRC that was obtained from another repository trusted. While the
> patch modifies Git so that it can send CRCs when using the git
> protocol, these CRCs are never stored, but are instead used only for
> cross checks.  If one side or the other "lies", you get an error.

But if I don't already have the object, then I have nothing to compare
against. So when I get it from kernel.org, I have to simply accept that
the object I'm getting is good, and write it into my object db.

> BTW, regarding your [Jeff's] discussion about putting an additional
> header in commit messages - I tried that.  The existing versions of
> Git didn't like it: barring a bug in my test code, it seems that Git
> expects headers in commit messages to be in a particular order and
> treats deviations from that to be an error.

Yes, the header has to go at the end of the existing headers. But I
don't see any reason that would be a problem for the scheme I described.

> I even tried appending blank lines at the end of a commit, with spaces
> and tabs encoding an additional CRC, and that didn't work either - at
> least it never got through all the test programs, failing in places
> like the tests involving notes.

Yes, git will helpfully trim whitespace in commit messages. With the
current code, you can hide arbitrary bytes in a commit message after a
NUL, but don't do that. It's not guaranteed to stay that way, and the
appropriate place to add new information is in a header.

> In any case, you'd have to phase in such a change gradually, first
> putting in the code to read the new header if it is there, and
> subsequently (after ample time so that everyone is running a
> sufficiently new version) enabling the code to create the new header.

Current git should ignore headers that it doesn't understand. I haven't
tested this, but Junio recently has been experimenting with
gpg-signature lines in commits, and I'm pretty sure he checked that
older gits properly ignore them.

-Peff
