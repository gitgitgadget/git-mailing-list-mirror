From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 19:16:42 -0500
Message-ID: <20151215001642.GA26409@sigill.intra.peff.net>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
 <1450121838-7069-4-git-send-email-sbeller@google.com>
 <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
 <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
 <20151214235736.GA26133@sigill.intra.peff.net>
 <CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:16:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8dIQ-0007lp-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 01:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbbLOAQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 19:16:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:41754 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932649AbbLOAQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 19:16:45 -0500
Received: (qmail 1350 invoked by uid 102); 15 Dec 2015 00:16:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 18:16:45 -0600
Received: (qmail 3650 invoked by uid 107); 15 Dec 2015 00:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 19:16:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 19:16:42 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282456>

On Mon, Dec 14, 2015 at 04:09:01PM -0800, Stefan Beller wrote:

> > Are we trying to protect ourselves against somebody _else_ giving us a
> > non-blocking descriptor? In that case we'll quietly spin and waste CPU.
> > Which isn't great, but perhaps better than returning an error.
> 
> Yes.
> This sounds like a good reasoning for 2/8 (add in the poll, so we are
> more polite), though.
> 
> This patch is a prerequisite for 4/8, which explicitly doesn't want to loop
> but a quick return. Maybe we could even drop this patch and just use
> `read` as is in 4/8. Looking from a higher level perspective, we don't care
> about strbuf_read_nonblocking to return after a signal without retry.

I was actually thinking about simply teaching xread() not to worry about
EAGAIN, but that would probably be a regression in the "whoops, somebody
gave us a non-blocking stdin!" case.

But yeah, I think simply using xread() as-is in strbuf_read_once (or
whatever it ends up being called) is OK.  I think all of the
_intentionally_ non-blocking descriptors are gone in this iteration,
right? So the caller of strbuf_read_once expects to have to call poll()
or to block. And that's what xread() does.

-Peff
