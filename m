From: Jeff King <peff@peff.net>
Subject: Re: how to determine oldest supported version of git
Date: Wed, 15 Feb 2012 04:15:26 -0500
Message-ID: <20120215091526.GA22683@sigill.intra.peff.net>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
 <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
 <20120215053607.GC29902@sigill.intra.peff.net>
 <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 10:15:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxaxh-00015X-De
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 10:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066Ab2BOJPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 04:15:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37185
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab2BOJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 04:15:32 -0500
Received: (qmail 18611 invoked by uid 107); 15 Feb 2012 09:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 04:22:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 04:15:26 -0500
Content-Disposition: inline
In-Reply-To: <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190818>

On Tue, Feb 14, 2012 at 10:36:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you are running v1.7.8.1 now, even if v1.7.9 is out, it is less risky
> > to move to v1.7.8.2 than to move to v1.7.9.
> [...]
> But nobody in the development community rebuilds 'maint' every time it is
> updated and runs the result as his or her primary production version. Even
> I do not do that (remember, I run 'next'). I only build and run full test
> suite. Older maintenance tracks are worse. I do not think anybody runs
> them before they are tagged and released.

That's a good point. Maint releases are not well tested before release.
However, I think there are two things that help balance that:

  1. The commits that go onto them are "obviously" correct. I put
     obviously in quotes, because of course we can make a mistake. But
     just looking at the commits that end up in a typical maint release,
     they're usually quite conservative.

     So in deciding between v1.7.8.4 or v1.7.9, it is a question of
     whether you are more likely to be screwed by a conservative commit
     that has gotten less testing, or by one of the host of
     non-conservative commits that have gotten more testing.

     I don't think we have numbers on the historical balance (and going
     forward, it would really depend on qualitative factors like "how
     conservative" anyway).

  2. The commits on maint are often tested in isolation. That is, they
     are not generally cherry-picks, but were rather branched and
     developed from a maint-worthy version, and then forward ported into
     master (where forward porting for us is basically merging plus
     adding any required tweaks). So in an ideal world, the developer
     considers the fix looking at the maint code, and then the risky
     forward-porting happens in master (where we have time to cook and
     squash bugs).

     On the other hand, just because the developer comes up with the fix
     based on an old version doesn't mean that they don't make a
     mistake. And with nobody running it, those mistakes may slip
     through. Also, we do sometimes base bugfixes on the source of a
     bug, which is ancient, and then merge up not only to master but
     also to maint.  The right fix at the source of the bug may be
     different than what is needed at maint, which is different than
     what is needed at master.

Hmm. I really wish we had some numbers, because it's very unclear to me
which factor dominates. My gut says that the maint releases are still
safer, even with the problems you listed. I recall multiple bugs in
feature releases that caused quick bugfix releases. I don't recall
offhand having to quickly issue a fix for a maintenance release.

> > Which implies to me that in an ideal world, there would be maint
> > releases for the current series (i.e., v1.7.9.x now) and the previous
> > one (v1.7.8.x now). Somewhere around v1.7.9.3 (or after 3 months, or
> > whatever), stop bothering with v1.7.8.x releases.
> 
> Actually what I was thinking was to restructure the release schedule
> slightly so that
> 
>  * We do not merge to 'master' anything but bugfix patches to regressions
>    introduced by 1.7.10 or to new features introduced by 1.7.10, for two
>    weeks after it ships;
> 
>  * During that time, if an urgent fix is needed, 'maint' is directly
>    patched to produce 1.7.9.X, and it is merged upward to 'next';
> 
>  * After finishing applying the early fixes to 1.7.10 to 'master', we tag
>    the tip of 'master' as 1.7.10.1 and fork 'maint' from there;
> 
>  * At that point, old 'maint' and 1.7.9.X track cease to receive updates,
>    as there is no point maintaining them. It only encourages distros to
>    stay behind, adding unnecesary maintenance burden to us.

I think that is not so far from what I proposed (except that my "3
months or whatever" is your "2 weeks and one version").

> Yes, that's the crucial observation to make.  Cherry-picking or down
> merging fixes tested in a new context to older codebase that is not
> actively used by the person who is cherry-picking does not produce a
> stable end product. It only produces stale end product.  It makes it
> slightly scarier to imagine that the cherry-pick is done by people who
> may not be as familiar with the codebase as us, but on the other hand,
> they might be using that old codebase for their day-to-day work, and may
> have better luck hitting issues that did not manifest themselves in the
> context of 'master' and 'next.

Good point. I thought of them as less-qualified, but in many ways they
are more so.

Hmph. You've certainly given me something to think about. I joined this
thread thinking you were a little bit crazy, but now I think you are
starting to convince me. :)

-Peff
