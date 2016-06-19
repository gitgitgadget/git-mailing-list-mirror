Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4D31FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 09:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbcFSJen (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 05:34:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:56871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbcFSJem (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 05:34:42 -0400
Received: (qmail 29336 invoked by uid 102); 19 Jun 2016 09:34:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 05:34:42 -0400
Received: (qmail 6281 invoked by uid 107); 19 Jun 2016 09:34:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 05:34:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 05:34:39 -0400
Date:	Sun, 19 Jun 2016 05:34:39 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH] prune: keep files created after process start
Message-ID: <20160619093439.GB12221@sigill.intra.peff.net>
References: <20160619031338.GA5161@dcvr.yhbt.net>
 <xmqqa8ihygms.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8ihygms.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 08:58:03PM -0700, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > Avoid pruning files which were written after the prune process
> > starts, as it possible to concurrently create new objects while
> > "git prune" is running.
> >
> > Tested on git.git by starting "git prune" in one terminal,
> > creating a random loose object via "git hash-object --stdin -w"
> > in a different terminal, and ensuring the loose object remains
> > after "git prune" completes.
> >
> > Signed-off-by: Eric Wong <e@80x24.org>
> > ---
> >  I'm somewhat surprised this check didn't already exist;
> >  but maybe nobody else runs prune manually, anymore.
> 
> The only time an end user would run "git prune" in their
> repositories with working trees these days is "git repack" followed
> by "git prune", I would guess.
> 
> The current behaviour is totally expected and that is why you do not
> run "prune" without any grace period in an active repository.
> 
> Adding the proposed change however would not make anything worse, I
> would think.  Those who run "git prune" without grace period accept
> that the repository must be quiescent or otherwise the newly created
> objects will be lost.  So they are unlikely to be doing anything to
> create such objects, hence "things newer than 'start'" are unlikely
> to appear, and their expectation that "repack && prune" will remove
> all loose objects will not be broken.

I agree it does not making anything worse from a correctness standpoint,
but I am mildly negative in that it adds complexity without any real
safety. Even after this patch, running git prune without a grace period
isn't safe, as you are racing simultaneous processes that started before
prune, or started after prune but before it marks the "start" timestamp.

I know it isn't much code, but it makes things harder to reason about.
I think it also runs contrary to the logic in 3d27b9b (date.c: add
parse_expiry_date(), 2013-04-17)[1].

-Peff

[1] More context in http://mid.gmane.org/7vbo9ceqb3.fsf@alter.siamese.dyndns.org
    and the surrounding thread.
