From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as
 "sideband"
Date: Tue, 1 Sep 2015 18:38:08 -0400
Message-ID: <20150901223807.GF7862@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
 <20150901202412.GA8020@sigill.intra.peff.net>
 <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKJF2epU=2gb7jFWni2tBu03dYGgttvZeW40ra=r2iiA@mail.gmail.com>
 <20150901222639.GD7862@sigill.intra.peff.net>
 <CAGZ79kYoWWc34GOxyAi5WvYf=UQvt--qwEr_m+bZwKO-uVqkiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuBz-0007zu-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbIAWiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:38:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:53410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbbIAWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:38:10 -0400
Received: (qmail 31771 invoked by uid 102); 1 Sep 2015 22:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:38:10 -0500
Received: (qmail 6813 invoked by uid 107); 1 Sep 2015 22:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:38:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:38:08 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYoWWc34GOxyAi5WvYf=UQvt--qwEr_m+bZwKO-uVqkiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277064>

On Tue, Sep 01, 2015 at 03:31:41PM -0700, Stefan Beller wrote:

> > Ah, right, I think I misunderstood Junio's question. Yes, if we start
> > calling cmd_fetch() from inside the threads, things may get confusing.
> >
> > I'll see how painful the thread storage approach would be.
> 
> I think that may be part of the thread pool API eventually.
> 
> I don't plan on relying on thread local storage, which is why I did
> not add it there,
> though I guess it can be added in there quite conveniently.

I think the task_queue and the async code are two separate things,
though. The task_queue, when we do not have threads, falls back to doing
things serially in a single process. Changing "thread local" variables
there is OK, but tasks need to be aware that they might affect
subsequent tasks.

Whereas for async code, we fall back to doing things in a forked
sub-process. And there "thread local" really is local to the async
process, no cleanup required.

-Peff
