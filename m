From: Jeff King <peff@peff.net>
Subject: Re: how to determine oldest supported version of git
Date: Wed, 15 Feb 2012 00:36:07 -0500
Message-ID: <20120215053607.GC29902@sigill.intra.peff.net>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
 <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Neal Kreitzinger <neal@rsss.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 06:36:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxXXK-0000E7-St
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 06:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab2BOFgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 00:36:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36205
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab2BOFgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 00:36:09 -0500
Received: (qmail 16531 invoked by uid 107); 15 Feb 2012 05:43:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 00:43:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 00:36:07 -0500
Content-Disposition: inline
In-Reply-To: <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190813>

On Fri, Feb 10, 2012 at 11:42:45AM -0800, Junio C Hamano wrote:

> Also our strict no regression policy means that it is not like an
> option --foo in one version of Git changes its meaning from X to Y
> across version boundaries, and even if on rare occasions we need to
> introduce incompatibilities to improve the system, we give enough
> advance warning and execute careful migration plans to ensure that
> third-parties can keep up, and the "fix at the oldest branch and merge
> upwards" policy means fixes to important bugs will be in all the
> maintenance tracks, including the 'master' version.

Just because we have a no-regression policy does not mean that we always
succeed. Bugs happen in new features. Hopefully the bugs only exist
for users of the new features, but occasionally they creep into
everybody's workflow.

If you are running v1.7.8.1 now, even if v1.7.9 is out, it is less risky
to move to v1.7.8.2 than to move to v1.7.9. Even though the risk of
moving to v1.7.9 is small, which I think is what you are arguing, it is
still greater than moving to a branch on which a release engineer (read:
you) has cherry-picked only ultra-safe bugfixes.

I think you are perhaps arguing that we are so safe that the difference
in risk is negligible. I do think we do better than many other projects,
but as a data storage project, I think it's nice to have a very
conservative branch (OTOH, data-loss bugs have historically been
extremely rare for git).

> So in practical terms, once 1.7.9 is out, there is *no* practical reason
> for anybody to use 1.7.8.x or anything older.

Wouldn't that also mean that v1.7.8.x has no reason to exist in the
first place? That is, if it is truly safe to move to v1.7.9, then why
did we bother making maintenance releases in the first place? Why not
just release the tip of master more frequently?

I think the answer is that v1.7.9 is _not_ as safe. But v1.7.9.4
probably _is_. That is, v1.7.9 will introduce new features, and
hopefully bugs will be shaken out while topics cook in master and next.
But once v1.7.9 is released, we get a much wider audience, and we will
probably find a few new bugs and some accidental regressions. Those will
slowly get fixed and we will get new minor v1.7.9.x releases, until at
some point the v1.7.9.x series gets just as solid as the v1.7.8.x series
was.

IOW, if you are on v1.7.8.2 and a we have a new bugfix, whether you want
a v1.7.8.3 or whether you jump to v1.7.9 should depend on where the
v1.7.9 series is in terms of maturity.

Which implies to me that in an ideal world, there would be maint
releases for the current series (i.e., v1.7.9.x now) and the previous
one (v1.7.8.x now). Somewhere around v1.7.9.3 (or after 3 months, or
whatever), stop bothering with v1.7.8.x releases.

Of course that takes time and effort (from you, mostly). If we dropped
maint releases entirely, then nobody would have to bother with the
release engineering task of deciding which topics were safe, and which
were not.

> If we only released the feature releases without _any_ maintenance
> releases, distros no longer have an excuse to stick to older maintenance
> tracks ("For the upcoming Zesty Zebra LTS, Git will stay at 1.7.7.x and
> never updated to any newer major version.")

I suspect that distros would not simply keep updating. Conservative
distros like Debian and RedHat (and probably Ubuntu LTSs, though I have
no experience with that) have policies in place about what can and
should go into updates. And they will end up doing the release
engineering themselves, staying on v1.7.7 + a bunch of cherry-picked
patches.

In some ways, that's a good thing; they can deal with the release
management work. OTOH, it's duplicated effort, and done by people who
are not as intimately familiar with git. A distro can probably pick up
your v1.7.8.x for an interim stable release without having to look
through all of the patches themselves.

Of course, the distros end up doing some of that release management
themselves, anyway. The git project's idea of "old" is 6-12 months, and
distros with long-term releases operate on much larger scales. So long
after we are tired of v1.7.8.x, they will probably still be
cherry-picking patches onto it. So maybe it is not worth caring about
distro's release management, as we are only helping them for a few
months, anyway.

-Peff
