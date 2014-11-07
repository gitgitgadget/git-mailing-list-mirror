From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 03:38:05 -0500
Message-ID: <20141107083805.GA26365@peff.net>
References: <20141107081324.GA19845@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 09:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmf3d-0003i0-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 09:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaKGIiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 03:38:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:37477 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751088AbaKGIiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 03:38:08 -0500
Received: (qmail 1489 invoked by uid 102); 7 Nov 2014 08:38:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 02:38:08 -0600
Received: (qmail 16879 invoked by uid 107); 7 Nov 2014 08:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 03:38:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2014 03:38:05 -0500
Content-Disposition: inline
In-Reply-To: <20141107081324.GA19845@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 03:13:24AM -0500, Jeff King wrote:

> I noticed that "git checkout $tree -- $path" will _always_ unlink and
> write a new copy of each matching path, even if they are up-to-date with
> the index and the content in $tree is the same.

By the way, one other thing I wondered while looking at this code: when
we checkout a working tree file, we unlink the old one and write the new
one in-place. Is there a particular reason we do this versus writing to
a temporary file and renaming it into place?  That would give
simultaneous readers a more atomic view.

I suspect the answer is something like: you cannot always do a rename,
because you might have a typechange, directory becoming a file, or vice
versa; so anyone relying on an atomic view during a checkout operation
is already Doing It Wrong.  Handling a content-change of an existing
path would complicate the code, so we do not bother.

But I would be curious to hear confirmation of that.

-Peff
