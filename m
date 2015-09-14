From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 14:07:59 -0400
Message-ID: <20150914180759.GA11920@sigill.intra.peff.net>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
 <1442012994-20374-3-git-send-email-sbeller@google.com>
 <xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
 <20150914171736.GA1548@sigill.intra.peff.net>
 <20150914175509.GJ8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 20:08:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbYAj-0004CB-4n
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbbINSIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:08:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:58917 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751127AbbINSID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:08:03 -0400
Received: (qmail 1856 invoked by uid 102); 14 Sep 2015 18:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 13:08:02 -0500
Received: (qmail 31451 invoked by uid 107); 14 Sep 2015 18:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 14:08:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2015 14:07:59 -0400
Content-Disposition: inline
In-Reply-To: <20150914175509.GJ8165@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277856>

On Mon, Sep 14, 2015 at 10:55:09AM -0700, Jonathan Nieder wrote:

> > I don't think you need exact timing information.  This is no different
> > than running the commands themselves, with stdout and stderr writing to
> > a pty that your terminal emulator will then read() from. If the program
> > produces intermingled stdout/stderr that clogs up the terminal, that is
> > its problem.
> 
> The difference is that when stdout and stderr write to a pty, they write
> to the same pty.  That is, suppose a child process does
> 
> 	write(1, "A\n", 2);
> 	write(2, "B\n", 1);
> 	write(1, "C\n", 2);

Ah, right. The pty is where things get mixed, not the read() from the
terminal. So it depends on the write() order. Thanks for the
explanation.

> One can imagine a "git grep --recurse-submodules" that wants to run a
> grep in each submodule and combine their output in some appropriate
> way.  It's not clear what order is best for that use case: stderr
> (errors, plus progress in some imaginary future) at the beginning to
> show the story of how output was generated before the output?  stderr
> at the end so errors are not hidden way up on the screen?  Some kind
> of interleaving that pays attention to the format of stdout?

I'd suggest a "best effort" interleaving, where we select and preserve
the read() order. That makes the easy cases work (you get things in the
original order), and the hard cases at least do something reasonable
(we may reorder two items which come in the same atomic "tick" of our
select, but at least they are nearby).

That's just my gut feeling, though.

> That is more complicated than the "fetch --recurse-submodules" case
> that Stefan is currently tackling, so it seems wise to me to punt for
> now.

I can live with that.

-Peff
