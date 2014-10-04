From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Fri, 3 Oct 2014 20:30:36 -0400
Message-ID: <20141004003036.GE17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003203931.GM16293@peff.net>
 <xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaDFK-00017G-3w
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805AbaJDAan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 20:30:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:54982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759790AbaJDAal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:30:41 -0400
Received: (qmail 13137 invoked by uid 102); 4 Oct 2014 00:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:30:41 -0500
Received: (qmail 16592 invoked by uid 107); 4 Oct 2014 00:30:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:30:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:30:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257885>

On Fri, Oct 03, 2014 at 02:47:57PM -0700, Junio C Hamano wrote:

> With this patch applied, the system will not prune unreachable old
> objects that are reachable from a recent object (the recent object
> itself may or may not be reachable but that does not make any
> difference).  And that is sufficient to ensure the integrity of the
> repository even if you allow new objects to be created reusing any
> of these unreachable objects that are left behind by prune, because
> the reachability check done during prune (with this patch applied)
> makes sure any object left in the repository can safely be used as a
> starting point of connectivity traversal.

Your use of "safely" in the last sentence here made me think.

In a repository that has had this patch from the beginning, it should be
safe to traverse the unreachable but unpruned objects, because the
property of the repository we are trying to guarantee means that we will
have all of the referents.

But in a repository created by current git (or one where you have been
fooling around with hash-object), we might not. Our secondary traversal
for recent objects may fail because we are already missing some of the
referents, and prepare_revision_walk (or traverse_commit_list) will
barf. That's a bad thing.

I think we need to tell that second traversal that it's OK to skip
missing objects that are reachable from recent objects. It's not ideal,
but there's nothing better we can do.  Eventually those objects will
fall off the back of the expiration window, but we should not be holding
up prunes (which, after all, are the thing that expires them :) ) in the
meantime.

I think it would be enough to just set revs->ignore_missing_links for
the secondary traversal.

-Peff
