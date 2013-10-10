From: Jeff King <peff@peff.net>
Subject: Re: A workflow for local patch maintenance
Date: Thu, 10 Oct 2013 13:36:28 -0400
Message-ID: <20131010173628.GB24782@sigill.intra.peff.net>
References: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk>
 <20131010013343.GB14429@sigill.intra.peff.net>
 <alpine.LSU.2.00.1310100927270.3100@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Oct 10 19:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUKA8-000663-6A
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 19:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727Ab3JJRgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 13:36:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:47045 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753647Ab3JJRgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 13:36:31 -0400
Received: (qmail 6114 invoked by uid 102); 10 Oct 2013 17:36:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Oct 2013 12:36:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Oct 2013 13:36:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.1310100927270.3100@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235871>

On Thu, Oct 10, 2013 at 05:53:57PM +0100, Tony Finch wrote:

> Our aim is to get as many patches into the upstream version as we can,
> which is why my starting point is a clean rebased patch series. I am also
> thinking that this will help me to know when a patch can be dropped from
> the series because upstream have incorporated something like it. If
> upstream works like git upstream (incorporating patches verbatim after
> they pass review) then git can handle this automatically, but if the patch
> gets re-worked it might be easier for me to drop it when rebasing rather
> than resolve conflicts. I'm also thinking that for packages which we
> update relatively infrequently, having a clean patch series makes it
> easier to review whether they are all still necessary when updating. But
> perhaps I am too wedded to manual patch management...

I am in a similar situation to you. At GitHub, we run more-or-less stock
git on our backend, but often make bug-fixes or enhancements that are
intended for upstream, but which we want to start using before the next
release.

We used to keep the patches as series, and rebase them on newer versions
of git from time to time. These days we use the workflow I described
earlier. The specific things we wanted to fix were:

  1. It was a giant pain to work on or modify a patch series.

  2. It did not scale well beyond one person handling the patches
     and rebasing. Now people more or less work on our forked repository
     as they would normally, and don't have to care; merging from
     upstream is just another feature (that happens to bring in a ton of
     commits :) ).

  3. The pain in doing the big rebase-test-deploy cycle meant that we
     often delayed it, keeping us several versions behind upstream.
     This is bad not only for the end product (you aren't getting other
     bugfixes from upstream as quickly), but also because the longer you
     wait to rebase or merge, the more painful it generally is.

That being said, there are some new downsides, as you noted:

  1. Resolving conflicts between your version and the reworked upstream
     version can be a pain.

  2. If your local development does not happen in a clean series, it can
     be hard to create a clean series for upstream, and/or revert in
     favor of upstream when necessary.

I don't have silver bullets for either, unfortunately. To mitigate
problem 1, I will sometimes revert a local topic before doing the
upstream merge, if I know it has been reworked. You can do this right
before merging. Or, as soon as you see that upstream is taking a
reworked version, you can revert what you have locally and apply the
upstream fix. This latter has the advantage of doing it much closer to
the actual development time, so handling any irregularities is easier.
But it is not always a possibility if upstream's reworking involved
building on other changes that you do not want to grab. :)

For problem 2, it helps if you can do development with topic branches as
git.git does, with aggressive rebasing while a topic is in development,
and then merging to master once it is mature.  Then at least your "git
log --first-parent" view of "master" shows you which topics you made,
and the topics themselves are relatively clean. Sometimes you end up
needing to make changes to a topic after it is mature, and the ordering
is not exactly what you would send upstream (e.g., for a pure patch
series going to upstream, you would not fix the bug on top, you would
squash the fix into an earlier commit). I mostly just handle this
manually, and it doesn't come up too often (and in many cases, by the
time you have the "bugfix on top" locally, upstream has also already
applied the original patches, and they want it as a bugfix on top, too).

We can no longer easily say "this is stock git, with patches X-Y-Z on
top" (we can get the set of commits we have that git does not have, of
course, but there's no easy way to say "these ones aren't relevant
anymore"). But we've found it's not all _that_ important. With a
rebasing strategy, you really want to know so that you don't
accidentally drop a patch that is necessary. But with a merge strategy,
you cannot accidentally drop a patch (you might botch the conflict
resolution, of course, but that is a bit harder).

-Peff
