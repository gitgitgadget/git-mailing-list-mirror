From: Jeff King <peff@peff.net>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 11:55:15 -0500
Message-ID: <20150217165514.GA12176@peff.net>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
 <20150205200332.GD15326@peff.net>
 <54E36EBF.2070600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Neverov <dmitry.neverov@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlQh-000156-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 17:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbbBQQzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 11:55:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:49945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751621AbbBQQzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 11:55:17 -0500
Received: (qmail 1414 invoked by uid 102); 17 Feb 2015 16:55:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 10:55:17 -0600
Received: (qmail 9229 invoked by uid 107); 17 Feb 2015 16:55:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 11:55:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 11:55:15 -0500
Content-Disposition: inline
In-Reply-To: <54E36EBF.2070600@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263953>

On Tue, Feb 17, 2015 at 05:39:27PM +0100, Michael Haggerty wrote:

> > You can't symlink refs like this. The loose refs in the filesystem may
> > be migrated into the "packed-refs" file, at which point your symlink
> > will be broken. That is a likely reason why git would not find any refs.
> > 
> > So your setup will not ever work reliably.  But IMHO, it is a bug that
> > git does not notice the broken symlink and abort an operation which is
> > computing reachability in order to drop objects. As you noticed, it
> > means a misconfiguration or filesystem error results in data loss.
> 
> There's a bunch of code in refs.c that is there explicitly for reading
> loose references that are symlinks. If the link contents literally start
> with "refs/", then they are read and treated as a symbolic ref.
> Otherwise, the symlink is just followed.

Right, but we should be able to notice that:

  1. We found a symlink.

  2. We couldn't read it its ref value (because it's a broken link).

I think we _do_ notice that at the lowest level, and set REF_ISBROKEN.
But the problem is that the reachability code in prune and in
pack-objects (triggered by "repack -ad") uses for_each_ref, and not
for_each_rawref. So they ignore "broken" refs rather than complaining,
even though failing to read a ref may mean we could drop objects which
were only mentioned by that ref.

> It is still possible to write symbolic refs that are represented as
> symlinks (see core.preferSymlinkRefs), but that backwards-compatibility
> code was added in 2006(!) Maybe it's time to deprecate it. And maybe we
> should start working towards a future where any symlinks under "refs"
> cause git to complain.

I wouldn't mind seeing all of the symlink code go away, but I think it
is orthogonal to the problem I mentioned.

-Peff
