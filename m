From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 21:36:32 -0400
Message-ID: <20160413013632.GA10656@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
 <20160412234251.GB2210@sigill.intra.peff.net>
 <xmqqlh4imibd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:36:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9jT-0007mN-R0
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbcDMBgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:36:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:48413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756565AbcDMBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:36:35 -0400
Received: (qmail 22454 invoked by uid 102); 13 Apr 2016 01:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 21:36:35 -0400
Received: (qmail 13288 invoked by uid 107); 13 Apr 2016 01:36:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 21:36:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 21:36:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh4imibd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291360>

On Tue, Apr 12, 2016 at 06:03:02PM -0700, Junio C Hamano wrote:

> > So we'd probably need a "treev2" object type that gives room for an
> > algorithm byte (or we'd have to try to shove it into the mode, but since
> > old versions won't know the new algorithm anyway, I don't think it
> > solves that much...). Or you can just define for the whole tree object
> > (either implicit in its type, or in a header) that it always uses
> > algorithm X.
> 
> This will hurt the performance a lot during the transition period as
> it no longer will be possible to rely on "most of the time a fine
> grained commit changes only a small part of the tree, and we can
> cheaply avoid descending into trees that haven't changed because we
> can tell that the corresponding tree objects in the pre- and post-
> trees have the same object name" optimization.  But we cannot avoid
> it.

Yeah. I'd hope in general that there would be a single commit that does
the transition, and we'd only pay it when doing diffs across the
boundary. And even then, I think a local-only cache of aliases could
mitigate the worst of it.

> >   7. After a while, flip the config option on. Hopefully the readers
> >      from steps 1-5 have percolated to the masses by then, and it's not
> >      a horrible flag day.
> >
> > We're basically on step 0 right now. I'm sure I'm missing some
> > subtleties in there, too.
> 
> One subtlety is that 7. "not a flag day" may not be a good thing.
> 
> There has to be a section of a history that spans the transition,
> set of commits and trees that have pointers to both kinds of object
> names.  The narrower such a section of the history, the more
> pleasant to use the result of the transition would be.
> 
> Different projects that can have their own flag days at their own
> pace is a good thing, so the above observation does not invalidate
> your transition plan, though.

Good point. I do think projects would do well to have a moment where
they switch to the new format, and don't freely intermingle. We could
possibly do some magic there to help things out. For example, if we are
building on a commit that is sha-2, we automatically use more sha-2
objects to point to them. And then the "flag day" for a project is
simply that somebody pushes to "master" using sha-2, and everybody
else's git (which learned long ago to speak the new algorithm) just
picks it up.

Of course that's not exactly a flag day for projects that branch from
old history for bugfixes. But it might be close enough.

-Peff
