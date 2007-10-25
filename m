From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] Do linear-time/space rename logic for exact renames
Date: Thu, 25 Oct 2007 15:48:59 -0400
Message-ID: <20071025194859.GB27745@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org> <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:49:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il8hh-0001V3-2c
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 21:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbXJYTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 15:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbXJYTtD
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 15:49:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1123 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbXJYTtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 15:49:01 -0400
Received: (qmail 24182 invoked by uid 111); 25 Oct 2007 19:49:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 25 Oct 2007 15:49:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2007 15:48:59 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62361>

On Thu, Oct 25, 2007 at 03:43:46PM -0400, Daniel Barkalow wrote:

> Creating a list of the pointers doesn't work correctly with the grow 
> implementation, because growing the hash may turn a collision into a 
> non-collision, at which point items other than the first cannot be found 
> (since they're listed inside a bucket that's now wrong for them). AFAIK, 
> resizing a hash table requires being able to figure out what happened with 
> collisions.

I thought this at first, too, but there are two types of collisions in
this hash implementation: those that come from having the actual 32-bit
hash collide, and those that come from not having enough buckets.

The client code gets a pointer kicked back to it when there is a
collision on the actual hash value (i.e., two things had the exact same
hash value). The number of buckets grows when you simply have more
buckets filled than you like. Two different hashes that would be in the
same bucket don't actually occupy the same bucket -- the second one to
arrive gets shoved into the next available bucket.

-Peff
