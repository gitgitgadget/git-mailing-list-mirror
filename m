From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] pager: factor out a helper to prepare a child
 process to run the pager
Date: Tue, 16 Feb 2016 19:32:15 -0500
Message-ID: <20160217003215.GC1187@sigill.intra.peff.net>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455664017-27588-3-git-send-email-gitster@pobox.com>
 <20160216232657.GB18634@sigill.intra.peff.net>
 <xmqqk2m4kyfw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:32:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVq2X-0005Lz-VC
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933488AbcBQAcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 19:32:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:43767 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933422AbcBQAcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 19:32:17 -0500
Received: (qmail 11687 invoked by uid 102); 17 Feb 2016 00:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 19:32:17 -0500
Received: (qmail 1031 invoked by uid 107); 17 Feb 2016 00:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 19:32:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 19:32:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2m4kyfw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286467>

On Tue, Feb 16, 2016 at 03:49:55PM -0800, Junio C Hamano wrote:

> > And if you put the git_pager() call inside prepare_pager_args (which I
> > agree would be cleaner), we just have:
> >
> >   void prepare_pager_args(struct child_process *pager_process);
> >
> > which is pretty self-explanatory (though it might need a new name; I'd
> > be tempted to call it init_pager_process() or something, and actually
> > have it do the child_process_init() to make sure it is working with a
> > sane clean slate).
> 
> Conceptually I am on the same page, but I am not sure how well that
> interacts with what "git am -i" codepath wants to do, though.
> 
> One big difference between the "we'll feed our output to pager"
> codepath and "we'll spawn a pager to let a file on the filesystem be
> read" codepath is that the former needs to call git_pager() and
> check the NULL-ness of the return value to decide that it does not
> want to spawn a pager and let the standard output just go straight
> to the outside world.  The latter, on the other hand, does want to
> spawn something to cause the file to be presented to the end user
> even git_pager() returns NULL.
> 
> And that is why I didn't make this helper call git_pager() itself.

That makes sense. I didn't dig into it carefully. I saw the "pager=cat"
thing in the context of your diff to git-am, and assumed it was weird
fallback that should be done by the regular pager infrastructure. But
it's the exact thing you're talking about here.

So of all of the things I suggested, I think the non-varargs one that
takes "pager" as a string makes the most sense.

-Peff
