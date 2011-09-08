From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Thu, 8 Sep 2011 16:03:43 -0400
Message-ID: <20110908200343.GD16064@sigill.intra.peff.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	" Shawn O. Pearce" <spearce@spearce.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 02:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1oZV-0006dZ-6O
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 02:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab1IIADr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 20:03:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58433
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511Ab1IIADq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 20:03:46 -0400
Received: (qmail 16497 invoked by uid 107); 8 Sep 2011 20:04:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 16:04:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 16:03:43 -0400
Content-Disposition: inline
In-Reply-To: <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181009>

On Wed, Sep 07, 2011 at 11:55:44PM +0000, Robin H. Johnson wrote:

> There's a couple of related things we've been considering on the Gentoo
> side:
> - detached signatures of blobs (either the SHA1 of the blob or the blob
>   itself)

There's not much point in signing the blob itself and not the sha1; the
first thing any signature algorithm will do is make a fixed-size digest
of the content anyway. So it is only useful if you don't trust sha1 as
your digest algorithm (which maybe is a reasonable concern these
days...).

> - The signature covering the message+blob details, but NOT the chain of
>   history: this opens up the ability to cherry-pick and rebase iff there
>   are no conflicts and the blobs are identical, all while preserving the
>   signature.

The problem is that many of the blobs won't be identical, because
they'll have new content from the new commits you rebased on top of. So
_some_ blobs will be the same, but you'll end up with a half-signed
commit. I think you're better to just re-sign the new history.

But I'd have to see a longer description of your scheme to really
critique it. I'm not 100% sure what your security goals are here.

> - concerns about a pre-image attack against Git. tl;dr version:
>   1. Attacker prepares decoy file in advance, that hashes to the same as
>      the malicious file.
>   2. Attacker sends decoy in as an innocuous real commit.
>   3. Months later, the attacker breaks into the system and alters the
>      packfile to include the new malicious file.
>   4. All new clones from that point forward get the malicious version.

Nit: I think you mean "collision attack" here. Pre-image attacks are
matching a malicious file to what is already in the tree, but are much
harder to execute.

But yeah, it is a potential problem. I don't keep up very well with that
sort of news anymore, but AFAIK, we still don't have any actual
collisions in sha1. Wikipedia seems to seem to think the best attacks
are in the 2^50-ish range, but nobody has successfully found one. So we
may still be a few years away from a realistic attack. If the attacks
are anything like the MD5 attacks, the decoy and malicious files will
need to have a bunch of random garbage in them. Which may be hard to
disguise, depending on your repo contents.

I think, though, that the sane fix at that point is not to start trying
to make per-blob signatures or anything like that, but to consider "git
version 2" with SHA-256, or whatever ends up becoming SHA-3 next year.
It would involve rewriting all of your history and dropping support for
older git clients, of course, but it may be worth it at the point that
sha1 is completely broken.

> Re your comment on always needing to resign commits above, we'd been
> considering post-signing commits, not when they are initially made.
> After your commit is clean and ready to ship, you can fire the commit
> ids into the signature tool, which can generate a detached signature
> note for each commit.

Agreed. This is just an interface problem, not a cryptographic or
technical one. However, I do think there's a subtle difference between
the two ideas. Signing each commit individually just indicates some
approval of particular commits. But signing a push certificate is about
associating particular commits with particular refs (e.g., saying "move
'master' from commit X to commit Y). I think there may be uses for both
forms.

-Peff
