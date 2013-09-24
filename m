From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Tue, 24 Sep 2013 22:36:51 +0200
Message-ID: <20130924203651.GH14259@raven.wolf.lan>
References: <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
 <20130912194453.GD32069@sigill.intra.peff.net>
 <20130913100934.GE14259@raven.wolf.lan>
 <20130916215536.GB5477@sigill.intra.peff.net>
 <20130920092715.GG14259@raven.wolf.lan>
 <20130924073613.GC7257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 22:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOZP9-0006uo-2G
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 22:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab3IXUkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 16:40:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:51857 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005Ab3IXUkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 16:40:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VOZOz-00019Z-3K; Tue, 24 Sep 2013 22:40:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 0B475761BF; Tue, 24 Sep 2013 22:36:51 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130924073613.GC7257@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235316>

On Tue, Sep 24, 2013 at 03:36:13AM -0400, Jeff King wrote:
> On Fri, Sep 20, 2013 at 11:27:15AM +0200, Josef Wolf wrote:

> > Even without asking, we can assume with great probability that
> > origin/somebranch is available at origin.
> Bear in mind that the transfer process does not know about
> cherry-picking at all.

It dosn't need to know.

> It only sees the other side's tips and traverses.

The sender side knows with high probability that origin/somebranch is avalable
at the receivig side (unless it was deleted). And since the file in question
is part of the tree at the tip of origin/somebranch, we can deduce that the
file is available on the other side (unless it was deleted).

> > And the file in question happens to reside in the tree at the very tip
> > of origin/somebranch, not in some of its ancestors. In this case,
> > there's no need to search the history at all. And even in this pretty
> > simple case, the algorithm seems to fail for some reason.
> 
> Correct. And in the current code, we should be looking at the tip tree
> for your case.  However, the usual reason to do so is to mark those
> objects as a "preferred base" in pack-objects for doing deltas. I wonder
> if we are not correctly noticing the case that an object is both
> requested to be sent and marked as a preferred base (in which case we
> should drop it from our sending list).

Further, it seems that the marking as preferred base had no effect, since the
delta should have been zero in this case. Or is this mechanism deactivated for
binary data (/dev/zero in this case)?

> If that's the problem, it should be easy to fix cheaply. It would not
> work in the general case, but it would for your specific example. But
> since it costs nothing, there's no reason not to.
> 
> I'll see if I can investigate using the example script you posted.

Thanks!

> I meant "we do the optimization during history traversal that avoids
> going into sub-trees we have already seen". We do _not_ do the full
> history traversal for a partial push.

OK. I see. Maybe a config option to request a full traversal would be a
reasonable compromise? That way CPU could be traded against bandwidth for
repositories that happen to have slow/unreliable/expensive connections.

> Yes, that would be nice. However, in the common cases it would make
> things much worse. A clone of linux.git has ~3.5M objects.

Of course, if there's nothing you can drop, any attempt to drop objects will
add to overhead. That's similar to compressing compressed files. This will
enlarge the original file. Would that be a reasonable argument to get rid of
all attempts to compress files?

-- 
Josef Wolf
jw@raven.inka.de
