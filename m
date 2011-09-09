From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 9 Sep 2011 01:30:09 +0000
Message-ID: <robbat2-20110909T004300-810527870Z@orbis-terrarum.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
 <20110908200343.GD16064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "	Robin H. Johnson" <robbat2@gentoo.org>,
	" Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 03:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pv9-0003GF-KR
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579Ab1IIBaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:30:13 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35353 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757512Ab1IIBaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:30:11 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 59FCC1B4027
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 01:30:10 +0000 (UTC)
Received: (qmail 7622 invoked by uid 10000); 9 Sep 2011 01:30:09 -0000
Content-Disposition: inline
In-Reply-To: <20110908200343.GD16064@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181018>

On Thu, Sep 08, 2011 at 04:03:43PM -0400,  Jeff King wrote:
> On Wed, Sep 07, 2011 at 11:55:44PM +0000, Robin H. Johnson wrote:
> > There's a couple of related things we've been considering on the Gentoo
> > side:
> > - detached signatures of blobs (either the SHA1 of the blob or the blob
> >   itself)
> There's not much point in signing the blob itself and not the sha1; the
> first thing any signature algorithm will do is make a fixed-size digest
> of the content anyway. So it is only useful if you don't trust sha1 as
> your digest algorithm (which maybe is a reasonable concern these
> days...).
To clarify here, there's two things gained by this over signing the
SHA1:
1. Ability to use a different digest algorithm right now, without
   having to trust SHA1.
2. Ability to use HMAC.

I agree that both of these are bandaids to the security of SHA*.

> > - The signature covering the message+blob details, but NOT the chain of
> >   history: this opens up the ability to cherry-pick and rebase iff there
> >   are no conflicts and the blobs are identical, all while preserving the
> >   signature.
> The problem is that many of the blobs won't be identical, because
> they'll have new content from the new commits you rebased on top of. So
> _some_ blobs will be the same, but you'll end up with a half-signed
> commit. I think you're better to just re-sign the new history.
Possibly, the rebase/cherry-pick isn't critical.

> But I'd have to see a longer description of your scheme to really
> critique it. I'm not 100% sure what your security goals are here.
The primary goal is that a developer can certify their commits when they
are ready to push them, regardless of the means of how they are going to
push them (I've had requests for some git-bundle usage help in pushes).

> > - concerns about a pre-image attack against Git. tl;dr version:
> >   1. Attacker prepares decoy file in advance, that hashes to the same as
> >      the malicious file.
> >   2. Attacker sends decoy in as an innocuous real commit.
> >   3. Months later, the attacker breaks into the system and alters the
> >      packfile to include the new malicious file.
> >   4. All new clones from that point forward get the malicious version.
> Nit: I think you mean "collision attack" here. Pre-image attacks are
> matching a malicious file to what is already in the tree, but are much
> harder to execute.
My bad, it was really late when I was writing the above.

> But yeah, it is a potential problem. I don't keep up very well with that
> sort of news anymore, but AFAIK, we still don't have any actual
> collisions in sha1. Wikipedia seems to seem to think the best attacks
> are in the 2^50-ish range, but nobody has successfully found one. So we
> may still be a few years away from a realistic attack. If the attacks
> are anything like the MD5 attacks, the decoy and malicious files will
> need to have a bunch of random garbage in them. Which may be hard to
> disguise, depending on your repo contents.
Joey Hess discussed this two years ago, and again last week:
http://kitenet.net/~joey/blog/entry/size_of_the_git_sha1_collision_attack_surface/
http://kitenet.net/~joey/blog/entry/sha-1/

This is easy in the kernel tree, it's got lots of eyeballs and only few
binary files. This isn't true for lots of other Git trees, a tree with a
JPEG image or a gzip file would be a great target.

It's 2^53 last I saw, which is only ~250 days of cputime on my i7
desktop. Also notably that is under the complexity of the 2^56 EFF DES
cracker was built do to (and the more recent COPACOBANA unit).

> I think, though, that the sane fix at that point is not to start trying
> to make per-blob signatures or anything like that, but to consider "git
> version 2" with SHA-256, or whatever ends up becoming SHA-3 next year.
> It would involve rewriting all of your history and dropping support for
> older git clients, of course, but it may be worth it at the point that
> sha1 is completely broken.
I think this is needed sooner rather than later.

> > Re your comment on always needing to resign commits above, we'd been
> > considering post-signing commits, not when they are initially made.
> > After your commit is clean and ready to ship, you can fire the commit
> > ids into the signature tool, which can generate a detached signature
> > note for each commit.
> Agreed. This is just an interface problem, not a cryptographic or
> technical one. However, I do think there's a subtle difference between
> the two ideas. Signing each commit individually just indicates some
> approval of particular commits. But signing a push certificate is about
> associating particular commits with particular refs (e.g., saying "move
> 'master' from commit X to commit Y). I think there may be uses for both
> forms.
Yes, there is use for both forms. The additional one is that you can
separate who pushes from who commits.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
