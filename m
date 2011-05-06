From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Fri, 6 May 2011 18:38:47 -0400
Message-ID: <20110506223847.GC17848@sigill.intra.peff.net>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITfk-0004Ph-6i
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1EFWiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:38:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39311
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058Ab1EFWiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:38:51 -0400
Received: (qmail 14366 invoked by uid 107); 6 May 2011 22:40:45 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 18:40:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 18:38:47 -0400
Content-Disposition: inline
In-Reply-To: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173024>

On Fri, May 06, 2011 at 01:35:37PM -0700, Junio C Hamano wrote:

> When switching away from a detached HEAD with "git checkout", we give a
> final warning to tell how to resurrect the commits being left behind since
> 8e2dc6a (commit: give final warning when reattaching HEAD to leave commits
> behind, 2011-02-18) rather loudly.
> 
> This is a good safety measure for people who are not comfortable with the
> detached HEAD state, but the warning was given even to those who set the
> advice.detachedHead to false to decline the warning given when detaching,
> resulting in an asymmetric experience.  Silent when going detached, and
> very loud when coming back.

I'm somewhat negative on this. I think there are actually 5 distinct
pieces of information that git currently gives in going to and from a
detached HEAD, and the motivations for suppressing them may be
different:

  1. On detaching, we indicate briefly that the HEAD has been detached
     by saying "HEAD is now at ..." instead of "Switched to branch ...".

  2. On detaching, we give a large warning on what the detached HEAD
     state means, and advise on how to get out of it.

  3. On leaving, if there are no orphaned commits, we indicate briefly
     where the previous HEAD position was with "Previous HEAD position
     was...".

  4. On leaving, if there are orphaned commits, we list them.

  5. On leaving, if there are orphaned commits, we give advice on how to
     make branches out of them.

Right now, advice.detachedhead suppresses (2); that is, we leave the
short indicator that provides distinct per-use information to the user
(1), but suppress the lengthy advice that is not helpful to advanced
user.

So if you wanted symmetry, I think that would mean suppressing (5), but
leaving (4), which contains per-use information, intact.

I can also see somebody wanting to suppress (4), either because it takes
too much time to compute, or because even though there is distinct
information in the message, it is lengthy. But I think that should be a
separate knob.

Personally, I want to see (1) and (4). Since the introduction of the
orphaned-commit check, I can think of at least 2 or 3 times when I have
been happy it reminded me, and immediately cherry-picked or performed
some other action on commits in the list it showed.

I tend to think (3) is now just useless. Before the orphaned-commit
check, it was perhaps a reminder that you might have orphaned something.
But now it is only useful as a reminder of some point you were at that
you might want to go back to (which is slightly more useful than when
you leave a ref, since there are a much smaller number of refs than
there are arbitrary commits that could appear in a detached HEAD). But
for going back to an arbitrary point, I think the reflog is a much more
useful tool.

>  * Admittedly, going into the detached HEAD state is much less warn-worthy
>    event than coming out of it, especially if you made any commit that
>    will become unreachable, so there is an inherent asymmetry and some
>    people may want to have a silent entry and loud exit (i.e. the current
>    behaviour).  I do not mind a separate "advice.abouttolosecommit", but
>    with this weatherbaloon I am trying to see if we can get away without
>    adding yet another knob that the user has to tweak.

Hopefully the above made sense, but to be clear, what I think we should
do is:

  1. Suppress the "If you want to keep it..." advice on exit with the
     existing advice.detachedhead.

  2. Optionally, if anybody cares (and I don't), introduce
     advice.detachedOrphanCheck to suppress the check entirely.

  3. Optionally remove "Previous HEAD position" in the non-orphan case.
     I think it's superfluous, but it's so short that I don't really
     care either way.

-Peff
