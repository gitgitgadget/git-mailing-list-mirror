From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as
 "sideband"
Date: Tue, 1 Sep 2015 18:22:30 -0400
Message-ID: <20150901222230.GB7862@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
 <20150901202412.GA8020@sigill.intra.peff.net>
 <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:22:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtwr-00064k-CC
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbIAWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:22:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:53374 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbbIAWWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:22:32 -0400
Received: (qmail 30412 invoked by uid 102); 1 Sep 2015 22:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:22:32 -0500
Received: (qmail 6502 invoked by uid 107); 1 Sep 2015 22:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:22:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:22:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277056>

On Tue, Sep 01, 2015 at 03:13:25PM -0700, Junio C Hamano wrote:

> > So instead, let us just assume that any async process is
> > handling sideband data. That's always true now, and is
> > likely to remain so in the future.
> 
> Hmm, does Stefan's thread-pool thing interact with this decision in
> any way?

I don't think so. It is true that:

  start_async(...);
  finish_async(...);
  pthread_create(foo);

would incorrectly report in_async() inside the foo function (because we
know that async has been kicked off, and we know that we are in a thread
that is not the main one).

But I don't think it matters in the current code base, because we tend
to use async for I/O tasks like muxing/demuxing, and real threads in
CPU-heavy tasks like pack-objects.

Still, I admit it is a little gross, and may be a problem in the future.

An alternate approach would be to have the async system provide a
thread-local storage abstraction. With pthreads, we'd build on
pthread_setspecific(), and without, it becomes a simple global variable.

That's more work, but a lot less error-prone, and it may come in handy
in the future.

-Peff
