From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname already
 be normalized
Date: Wed, 27 Apr 2016 18:19:06 -0400
Message-ID: <20160427221906.GA9707@sigill.intra.peff.net>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
 <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
 <1461787832.11504.1.camel@twopensource.com>
 <20160427201512.GA8073@sigill.intra.peff.net>
 <1461789293.11504.5.camel@twopensource.com>
 <20160427203728.GA8364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:19:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avXo7-0000YQ-Al
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbcD0WTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:19:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:57953 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750777AbcD0WTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:19:10 -0400
Received: (qmail 9428 invoked by uid 102); 27 Apr 2016 22:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 18:19:09 -0400
Received: (qmail 3218 invoked by uid 107); 27 Apr 2016 22:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 18:19:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 18:19:06 -0400
Content-Disposition: inline
In-Reply-To: <20160427203728.GA8364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292834>

On Wed, Apr 27, 2016 at 04:37:28PM -0400, Jeff King wrote:

> > > But anything writing a _new_ refname (whether the actual ref, or
> > > referencing it via a symref) should be using check_refname_format()
> > > before writing.
> > 
> > Unfortunately, neither check is lesser -- refname_is_safe allows
> > refs/heads//foo but not a/b while check_refname_format allows a/b but
> > not refs/heads//foo.  So sometimes we need both, while other times we
> > just need one :(
> 
> IMHO, that sounds like a bug. check_refname_format() should
> conceptually[1] be a superset of refname_is_safe(). Is there a case
> where we would want to _allow_ a refname that is not safe to look at on
> disk?

BTW, if there isn't a superset relationship here, then I suspect I may
have introduced some loosening or inconsistencies in 03afcbe
(read_packed_refs: avoid double-checking sane refs, 2015-04-16). So any
tightening now may simply be fixing that (which doesn't change anything
with respect to correctness, but may give people more confidence that
the tightening is not breaking something people have been depending on).

-Peff

PS Reading over that commit message, I think it mis-states
   "refname_is_safe() can only be true if check_refname_format() also
   failed". It should be "!refname_is_safe() ...". I.e., the condition can
   only trigger if...
