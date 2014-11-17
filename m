From: Jeff King <peff@peff.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Mon, 17 Nov 2014 16:26:57 -0500
Message-ID: <20141117212657.GC15880@peff.net>
References: <5468C33E.2080108@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Patrick Schleizer <patrick-mailinglists@whonix.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:27:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqTpA-00088U-8L
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 22:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaKQV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 16:27:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:41285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752025AbaKQV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 16:26:59 -0500
Received: (qmail 2727 invoked by uid 102); 17 Nov 2014 21:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 15:26:59 -0600
Received: (qmail 2084 invoked by uid 107); 17 Nov 2014 21:27:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 16:27:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Nov 2014 16:26:57 -0500
Content-Disposition: inline
In-Reply-To: <5468C33E.2080108@whonix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 16, 2014 at 03:31:10PM +0000, Patrick Schleizer wrote:

> How safe are signed git tags? Especially because git uses SHA-1. There
> is contradictory information around.
> 
> So if one verifies a git tag (`git tag -v tagname`), then `checksout`s
> the tag, and checks that `git status` reports no untracked/modified
> files, without further manually auditing the code, how secure is this
> actually? Is it only as safe as SHA-1?

Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
only a SHA-1 hash. If somebody can find a collision with a hash you have
signed, they can substitute the colliding data for the data you signed.

Of course, "safe as SHA-1" and "find a collision" are vague. If
pre-image attacks are feasible (i.e., given already-published SHA-1, I
can find a different input with the same SHA-1), then attacks are
trivial. But when people talk about attacks on SHA-1, they are usually
referring to finding a collision between two new pieces of data. You can
also use that in an attack, but it's much less straightforward
(basically, you need to get somebody to sign one of the colliding pieces
of data and then replace it with the other).

And of course there is the question of getting the colliding data to the
victim. Git does collision checks whenever a remote (e.g., from a "git
fetch") gives us data that we already have. So you could poison new
cloners with bad data, but you could not convince a repository with the
existing "good" half of the collision to fetch the "evil" half.

> > Git uses SHA-1 not for security
> 
> And goes on.
> 
> > The security parts are elsewhere
> 
> Could you please elaborate on this? Where are the security parts? Can
> you please briefly explain how these work? Where can I read more about this?

I cannot speak for Linus, but I would not agree that SHA-1 is not part
of Git's security model. If we consider the GPG signature as a black box
(and we largely do in Git), then we _never_ sign the tree contents
itself. We always sign the SHA-1 of the tree, along with some metadata
(whether you are signing a tag or a commit). If an attacker can create
SHA-1 collisions (either by pre-image, or if you agree to sign a tree
containing a potential collision from an attacker), then you are
vulnerable to having the tree contents swapped out after the fact (and
the signature still checking out).

I am not sure that is what Linus is saying, though. In the paragraph you
quote:

> > "The source control management system Git uses SHA-1 not for security
> but for ensuring that the data has not changed due to accidental
> corruption. Linus Torvalds has said, "If you have disk corruption, if
> you have DRAM corruption, if you have any kind of problems at all, Git
> will notice them. It's not a question of if, it's a guarantee. You can
> have people who try to be malicious. They won't succeed. [...] Nobody
> has been able to break SHA-1, but the point is the SHA-1, as far as Git
> is concerned, isn't even a security feature. It's purely a consistency
> check. The security parts are elsewhere, so a lot of people assume that
> since Git uses SHA-1 and SHA-1 is used for cryptographically secure
> stuff, they think that, OK, it's a huge security feature. It has nothing
> at all to do with security, it's just the best hash you can get. [...] I
> guarantee you, if you put your data in Git, you can trust the fact that
> five years later, after it was converted from your hard disk to DVD to
> whatever new technology and you copied it along, five years later you
> can verify that the data you get back out is the exact same data you put
> in. [...] One of the reasons I care is for the kernel, we had a break in
> on one of the BitKeeper sites where people tried to corrupt the kernel
> source code repositories." [6]

I think he is saying more "SHA-1 is about data integrity, not about
authenticity; if you want authenticity, that's elsewhere [handled by
gpg]". Unsaid there is that you can't really have authenticity without
the integrity, and that I think he was assuming that SHA-1 works (he
says "Nobody has been able to break SHA-1..").

> If (!) I understand Mike Gerwitz ([...] GNU [...]) 's opinion, his
> opinion is, that for best security each and every commit should be
> signed for best possible git verification security.

I think it would depend on your threat model. You haven't defined "best
security".

Even without a break in SHA-1, there is value to signing every commit
versus signing just tags. If Linus signs a tag, all it says is "I think
this tree state and the history leading up to it is called v3.16". But
Linus can lie all he likes about who made each commit, and what happened
in each one. Signing commits is more about authenticating individual
commits: who made them, what was the state they were based on, and what
was the end state (and between the two, you can calculate the introduced
changes).

Of course, that comes with its own headaches, too. E.g., in mailing-list
development, the patch is picked up and applied by a maintainer, who
does not necessarily commit it on the same state you used to create it.
And even if they did, the committer information is different than what
you would create locally.  You inherently _can't_ sign that ahead of
time.

-Peff
