From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 14:44:05 -0400
Message-ID: <20150828184405.GA17721@sigill.intra.peff.net>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
 <20150828183501.GA17222@sigill.intra.peff.net>
 <CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:44:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOdK-0000Dn-A4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbH1SoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:44:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:51654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752573AbbH1SoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:44:08 -0400
Received: (qmail 24869 invoked by uid 102); 28 Aug 2015 18:44:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 13:44:08 -0500
Received: (qmail 6809 invoked by uid 107); 28 Aug 2015 18:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 14:44:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2015 14:44:05 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276752>

On Fri, Aug 28, 2015 at 11:41:17AM -0700, Stefan Beller wrote:

> > So to an observer, it would look like a serial operation, but subsequent
> > operations after the first would magically go much faster (because
> > they'd been working and buffering in the background).
> >
> > And that doesn't require any additional IPC magic (though I am not sure
> > how we get progress in the first place if the child stderr is a
> > pipe...).
> 
> Moving the contents from the pipe to a strbuf buffer which we can grow
> indefinitely
> (way larger than pipe limits, but the output of a git fetch should be
> small enough for that).

Right, clearly we can't rely on pipe buffers to be large enough here
(though we _may_ want to rely on tempfiles if we aren't sure that the
stdout is bounded in a reasonable way).

But what I meant was: the child will only show progress if stderr is a
tty, but here it is not.

I wonder if we need to set GIT_STDERR_IS_TTY=1 in the parent process,
and then respect it in the children (this is similar to what
GIT_PAGER_IN_USE does for stdout).

-Peff
