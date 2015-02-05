From: Jeff King <peff@peff.net>
Subject: Re: Git gc removes all packs
Date: Thu, 5 Feb 2015 15:03:32 -0500
Message-ID: <20150205200332.GD15326@peff.net>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry Neverov <dmitry.neverov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:03:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSeJ-0006JF-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbbBEUDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:03:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:45684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbbBEUDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:03:34 -0500
Received: (qmail 8726 invoked by uid 102); 5 Feb 2015 20:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 14:03:34 -0600
Received: (qmail 1912 invoked by uid 107); 5 Feb 2015 20:03:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 15:03:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 15:03:32 -0500
Content-Disposition: inline
In-Reply-To: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263396>

On Thu, Feb 05, 2015 at 04:13:03PM +0100, Dmitry Neverov wrote:

> I'm using git p4 for synchronization with perforce. Sometimes after 'git
> p4 rebase' git starts a garbage collection. When gc finishes a local
> repository contains no pack files only loose objects, so I have to
> re-import repository from perforce. It also doesn't contain a temporary
> pack git gc was creating.

It sounds like git didn't find any refs; it will pack only objects which
are reachable. Unreachable objects are either:

  1. Exploded into loose objects if the mtime on the pack they contain
     is less than 2 weeks old (and will eventually expire when they
     become 2 weeks old).

  2. Dropped completely if older than 2 weeks.

> One more thing about my setup: since git p4 promotes a use of a linear
> history I use a separate repository for another branch in perforce. In
> order to be able to cherry-pick between repositories I added this
> another repo objects dir as an alternate and also added a ref which is a
> symbolic link to a branch in another repo (so I don't have to do any
> fetches).

You can't symlink refs like this. The loose refs in the filesystem may
be migrated into the "packed-refs" file, at which point your symlink
will be broken. That is a likely reason why git would not find any refs.

So your setup will not ever work reliably.  But IMHO, it is a bug that
git does not notice the broken symlink and abort an operation which is
computing reachability in order to drop objects. As you noticed, it
means a misconfiguration or filesystem error results in data loss.

-Peff
