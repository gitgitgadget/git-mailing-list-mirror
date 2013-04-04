From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 4 Apr 2013 17:03:04 -0400
Message-ID: <20130404210304.GA25811@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrJs-0007on-S7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763092Ab3DDVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:03:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56371 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762620Ab3DDVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:03:11 -0400
Received: (qmail 7068 invoked by uid 107); 4 Apr 2013 21:05:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 17:05:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 17:03:04 -0400
Content-Disposition: inline
In-Reply-To: <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220102>

On Thu, Apr 04, 2013 at 01:31:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> If you do this:
> >> 
> >> 	rm -fr d e
> >>         mkdir e
> >>         >e/f
> >>         ln -s e d
> >>         git add d/f
> >> 
> >> we do complain that d/f is beyond a symlink (meaning that all you
> >> can add is the symlink d that may happen to point at something).
> >
> > Right, but that is because you are adding a bogus entry to the index; we
> > cannot have both 'd' as a symlink and 'd/f' as a path in our git tree.
> > But in the removal case, the index manipulation is perfectly reasonable.
> 
> I think you misread me.  I am not adding 'd' as a symlink at all.
> IIRC, ancient versions of Git got this case wrong and added d/f to
> the index, which we later fixed.

I think I just spoke sloppily. What is bogus about "d/f" is not that "d"
is necessarily in the index right now, but that adding "d/f" implies
that "d" is a tree, which it clearly is not. Git maps filesystem
symlinks into the index and into its trees without dereferencing them.
So whether we have "d" in the index right now or not, "d/f" is wrong
conceptually.

But I do not think the "we are mis-representing the filesystem" problem
applies to this "rm" case. We are not adding anything bogus into the
index; on the contrary, we are deleting something that no longer matches
the filesystem representation (and is actually the same bogosity that we
avoid adding under the rule above).

I do agree that it violates git's general behavior with symlinks (i.e.,
that they are not dereferenced).

> I have been hinting that we should do the same safety not to touch
> (even compare the contents of) e/f, because the only reason we even
> look at it is because it appears beyond a symbolic link 'd'.

I can certainly see the safety argument that crossing a symlink at "d"
means the resulting "d/f" is not necessarily related to the original
"d/f" that is in the index. As I said, I do not mind having the extra
protection; my argument was only that the content-check already protects
us, so the extra protection is not necessary. And the implication is
that I do not feel like working on it. :) I do not mind at all if you
drop my third patch (and that is part of the reason I split it out from
patch 2, which I do think is a no-brainer), and I am happy to review
patches to do the symlink check if you want to work on it.

Having made the argument that the content-check is enough, though, I
think there is an interesting corner case where it might not be. I don't
mind "git rm d/f" deleting "e/f" inside the repository when "d" is a
symlink to "e". But what would happen with:

  rm -rf d
  ln -s /path/outside/repo d
  git rm d/f

Deleting across symlinks inside the repo can be brushed aside with "eh,
well, it is just another way to mention the same name in the
filesystem". But deleting anything outside of the repo seems actively
wrong.

And more on that "brushed aside". I think it is easy in the cases we
have been talking about, namely where "d/f" still exists in the index,
to think that "git rm d/f" is useful and the question is one of safety:
should we delete e/f if it is pointed to? But let us imagine that d/f is
_not_ in the index, but "d" is a symlink pointing to some/long/path".
The user wants to be lazy and say "git rm d/f", because typing
"some/long/path" is too much work. But what happens to the index? We
should probably not be removing "some/long/path".

Hmm. I think you have convinced me (or perhaps I have convinced myself)
that we should generally not be crossing symlink boundaries in
translating names between the filesystem and index. I still don't want
to work on it, though. :)

-Peff
