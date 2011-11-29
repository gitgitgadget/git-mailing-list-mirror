From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 09:08:27 -0800
Message-ID: <CAJo=hJtFT55Ucyij9esr3Hd9yJ6XCxatK7vjPOLMKow57HqBoQ@mail.gmail.com>
References: <1322546563.1719.22.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	peff@peff.net, torvalds@linux-foundation.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 18:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVRAs-0006Ha-Fw
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 18:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab1K2RIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 12:08:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59528 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1K2RIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 12:08:49 -0500
Received: by ggnr5 with SMTP id r5so6635766ggn.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 09:08:48 -0800 (PST)
Received: by 10.101.81.16 with SMTP id i16mr2010152anl.94.1322586528287; Tue,
 29 Nov 2011 09:08:48 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Tue, 29 Nov 2011 09:08:27 -0800 (PST)
In-Reply-To: <1322546563.1719.22.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186063>

On Mon, Nov 28, 2011 at 22:02, Bill Zaumen <bill.zaumen+git@gmail.com> wrote:
> Several years ago (in 2006) there was a discussion about the whether
> SHA-1 is adequate given the very small but non-zero probability of a
> hash collision, particularly given the possibility of a malicious
> attempt to generate a collision. At roughly the same time, Git was
> modified to support "thin packs" during data transfers. These allow
> one to send deltas based on objects that are not in the pack file
> being transferred. As a result a previously undetected hash collision
> could result in a corrupted repository when (for example) the same
> delta is applied to different objects that have the same SHA-1 hash.

I don't think you understand how these thin packs are processed.

If the pack contains <100 objects, it is inflated to loose objects. If
the receiving side (so client in fetch, server in push) already has an
object by that SHA-1, the new object is discarded. If the pack
contains >=100 objects, and the receiving side already has the object,
it is compared byte-for-byte to ensure the incoming copy exactly
matches the already existing copy.

Either way the first object to arrive always wins.


The recipient has to trust that the remote side is providing it
something reasonable. If the recipient has *ZERO* trust in the sender,
then s/he should read the content of all newly arrived objects before
compiling or executing them. This is one reason why Git does not run
hooks that are transported as part of the repository. If the recipient
thinks reading the content is too onerous or impossible, then they
have to make a trust assertion on the remote side.

This trust assertion should be derived from the community, and not so
much around the machine claiming the content is what it says it is. We
have yet to disprove the halting problem, so we have yet to construct
a machine that can verify those Linux kernel sources you downloaded
don't contain a local root exploit (for example). Instead we have to
trust the community of developers and users who work on and run that
code to have confidence that the code works as expected, etc. We base
our trust off reputable people making statements like "Linus kernel at
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git is
pretty good", and "kernel.org is where Linus pushes directly to, so
its reasonable to trust the kernel.org server".

The recipient should have some understanding of the remote server's
security policies, or pay attention to notices posted by others who
are also fetching and reviewing content from the same repository. At
some level, the community using a repository from a given site should
be policing that site and establishing trust that the host is not
providing garbage content. After an incident, it is possible to pick
up again by rebuilding the environment from an already known
repository that people trust. In the case of the recent kernel.org
environment rebuild, that is exactly what they did, the community
picked up again from Linus' personal repository.

DNS could be abused to send you the wrong IP for a site, but most
people don't use random DNS servers, they have some level of trust in
their DNS provider. DNSSEC is helping to improve the security of the
name->IP translation process, and using protocols like HTTPS with SSL
certificate verification can help to reduce the chances that a forged
DNS entry sends you to an evil source, rather than the community
trusted one. (Although SSL certificates seem to be getting forged left
and right these days, so again you can't really rely on strong
cryptography to magically solve security problems when the attacker
holds the private key you have decided to trust with no further
verification.)


But trust aside, consider an object C is sent as a delta to the remote
side. The delta base B is not included in the pack, and is referenced
by SHA-1. When the remote side processed delta C, it looks up a copy
of base B from its own repository. We assume this content of B is
correct, due to the "first to arrive wins" rule, and the community
review/trust/notification process.

The inflated length of B is checked against a size that is stored in
the front of the delta instruction stream that describes C. These
lengths must match exactly, if they do not match then the delta
application aborts, the pack is rejected, and any temporary data is
removed from the filesystem. As Peff pointed out elsewhere in this
thread, the odds of a SHA-1 collision in a project are low, on the
order of 1/(2^80). Although there are some attacks on message digest
functions like MD-5 or SHA-1 that might be possible to generate a
duplicate in 2^57 time, any that I have read require producing a
different length content than the original you are trying to replace.
Assuming the copy of B on the remote system actually inflates and
computes to the correct SHA-1 B, it probably does not also have the
correct length if it is an object with correct hash but wrong content.
So delta application should still be checking for collision with a
1/(2^80) probability.

Assuming the remote's copy of B passed the size check, the delta is
applied on top, and the SHA-1 of the result buffer is computed. The
attacker must craft the delta such that the SHA-1 of C is the result,
otherwise connectivity checks will fail.

Assuming the attacker successfully stores a C' that has the right
SHA-1, but wrong content... the community around that repository will
eventually notice this and message that the source site cannot be
trusted. I refer you back to the statement above about trusting the
site you pull from, or trusting the users that you authorize to push
into a repository.

But thin pack aside, this problem exists in any form of a packed
object. An attacker can try to send object P' (as a non-delta) in
place of P. SHA1(P') = SHA1(P), but the content differs. This is far
easier to construct than the thin pack delta case you think is a
problem, and is the most likely approach for an attacker to take. I
refer you back to the statement above about trusting the site you pull
from, or trusting the users that you authorize to push into a
repository, or reading every object you receive.


Even if you magically fix the hash function somehow to decrease the
odds of collision (e.g. by switching to a member of the SHA-2 or SHA-3
family), there is no way to prevent a bug or root exploit from
entering the project except by never adding new code, or by carefully
reviewing everything that is submitted, and building up a basis of
trust around that review method. It is far more likely for an attacker
to try and submit a plain text patch to the Linux kernel mailing list
that reads completely correct, hashes to the correct SHA-1s when
applied in Git, etc... but just "happens" to contain an off by one
pointer bug in some weird case that allows the attacker to overflow a
critical memory buffer and later inject some code that can later be
used to create an exploit. If they are ever "caught" they may just
claim "I AM A MORON I AM SORRY I MISSED THAT BUFFER CHECK AND SO DID
YOU DURING CODE REVIEW SO ITS NOT ALL MY FAULT LEAVE ME ALONE" and get
away with it.

Trust. Review. Verify.

I don't know about you, but I don't just pull random code from
arbitrary sites on the Internet. Nor do I compile or execute that code
on my workstation. I do trust some individuals based on their
reputation on the Internet, or my past experiences working with their
code. And I also trust some hosting environments like kernel.org, or
GitHub, or code.google.com, to provide reasonably secure hosting, and
to aggressively react to any event that might make it harder for me to
trust the content they supply. And I also read a lot of code that I
pull.

It really isn't the problem you try to claim it is.
