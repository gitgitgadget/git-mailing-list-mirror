From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 08:22:09 -0500
Message-ID: <20080209132209.GA20443@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com> <20080209024636.GE2572@coredump.intra.peff.net> <20080209025431.GF2572@coredump.intra.peff.net> <alpine.LSU.1.00.0802091302550.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpfN-0004vo-3t
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbYBINWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbYBINWN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:22:13 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3293 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597AbYBINWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:22:13 -0500
Received: (qmail 13006 invoked by uid 111); 9 Feb 2008 13:22:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 09 Feb 2008 08:22:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Feb 2008 08:22:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802091302550.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73223>

On Sat, Feb 09, 2008 at 01:04:10PM +0000, Johannes Schindelin wrote:

> I was already trying to make a patch on top of yours which says "[stale]" 
> instead of "[rejected]" for those cases, but then I realised that 2 tests 
> in t5400 fail.

I think the problem is that tests 7/8 in t5400 actually try to create
a non-ff situation by doing a rewind. So it is not a bug in the new code
so much as the test relied on the very behavior we changed.

> > -			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
> > +			if (ref_newer(ref->old_sha1, new_sha1))
> > +				ref->status = REF_STATUS_REJECT_REWIND;
> > +			else
> > +				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
> 
> Indeed.  I did not think it was that easy, but apparently it is.

It's also slower than it needs to be, since we also do a ref_newer in
the other direction, and because non-ff cases traverse all the way to
the root.  I think you could do better to write a function (similar to
limit_list) which returned one of { A is an ancestor of B, B is an
ancestor of A, A and B are equal, A and B are not directly related },
and you would have to traverse down only to the nearest merge base.

-Peff
