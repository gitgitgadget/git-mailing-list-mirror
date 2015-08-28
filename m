From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 14:35:02 -0400
Message-ID: <20150828183501.GA17222@sigill.intra.peff.net>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:35:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOUa-0007VP-65
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbbH1SfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:35:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:51627 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753120AbbH1SfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:35:04 -0400
Received: (qmail 23931 invoked by uid 102); 28 Aug 2015 18:35:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 13:35:04 -0500
Received: (qmail 6494 invoked by uid 107); 28 Aug 2015 18:35:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 14:35:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2015 14:35:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276746>

On Fri, Aug 28, 2015 at 11:27:04AM -0700, Junio C Hamano wrote:

> > But for commands that show progress like "git clone", "git checkout",
> > and "git fetch", it does not work well at all.  They provide output
> > that updates itself by putting a carriage return at the end of each
> > chunk of output, like this:
> >
> >  remote: Finding sources:  11% (18/155)           \r
> >  remote: Finding sources:  12% (19/155)           \r
> >
> > With multiple commands producing such output, they will overwrite each
> > other's lines, producing a mixture that is confusing and unuseful.
> 
> That example also illustrates why it is not a useful to buffer all
> of these lines and showing them once.

I think Jonathan's point is that you could pick _one_ active child to
show without buffering, while simultaneously buffering everybody else's
output. When that finishes, pick a new active child, show its buffer,
and then start showing its output in realtime. And so on.

So to an observer, it would look like a serial operation, but subsequent
operations after the first would magically go much faster (because
they'd been working and buffering in the background).

And that doesn't require any additional IPC magic (though I am not sure
how we get progress in the first place if the child stderr is a
pipe...).

-Peff
