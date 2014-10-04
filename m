From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] prune: factor out loose-object directory traversal
Date: Fri, 3 Oct 2014 20:24:07 -0400
Message-ID: <20141004002406.GD17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202943.GI16293@peff.net>
 <xmqqoatskd8u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaD98-00075g-8d
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbaJDAYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 20:24:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:54978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933546AbaJDAYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:24:09 -0400
Received: (qmail 12876 invoked by uid 102); 4 Oct 2014 00:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:24:09 -0500
Received: (qmail 16555 invoked by uid 107); 4 Oct 2014 00:24:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:24:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:24:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoatskd8u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257884>

On Fri, Oct 03, 2014 at 03:19:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Prune has to walk $GIT_DIR/objects/?? in order to find the
> > set of loose objects to prune. Other parts of the code
> > (e.g., count-objects) want to do the same. Let's factor it
> > out into a reusable for_each-style function.
> 
> Doesn't fsck also look at these as well?  I recall that we also have
> a "sort by inum" trick employed there.  Would it also be applicable
> to these two callers?

I didn't think to check fsck. It does have a similar function and could
be converted.

Fsck does store the inode and later visits the files in inode order. I
don't know if it matters as much here, because we are not opening most
of the files, just stat()ing them.

I'd also be kind of surprised if this optimization really matters in
practice these days. The inode-sorting comes from 7e8c174 (fsck-cache:
sort entries by inode number, 2005-05-02). That predates packfiles by
several months, I believe, and you are not likely to have a very large
number of loose objects anymore (and if you do, you will get _way_
better performance simply by packing).

-Peff
