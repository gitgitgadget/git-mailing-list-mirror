From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 20:44:57 -0500
Message-ID: <20151215014456.GA28768@sigill.intra.peff.net>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
 <1450121838-7069-4-git-send-email-sbeller@google.com>
 <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
 <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
 <20151214235736.GA26133@sigill.intra.peff.net>
 <CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
 <20151215001642.GA26409@sigill.intra.peff.net>
 <CAGZ79kbLHNtxcwhZz=tHpJB2XnxMeuEJBG=PmoAbcVF4Wzno2g@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 02:45:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8efw-00024Z-8r
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbbLOBpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:45:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:41828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753664AbbLOBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 20:45:00 -0500
Received: (qmail 8447 invoked by uid 102); 15 Dec 2015 01:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 19:44:59 -0600
Received: (qmail 4807 invoked by uid 107); 15 Dec 2015 01:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 20:45:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 20:44:57 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kbLHNtxcwhZz=tHpJB2XnxMeuEJBG=PmoAbcVF4Wzno2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282460>

On Mon, Dec 14, 2015 at 04:25:18PM -0800, Stefan Beller wrote:

> > But yeah, I think simply using xread() as-is in strbuf_read_once (or
> > whatever it ends up being called) is OK.
> 
> I was actually thinking about using {without-x}read, just the plain system call.
> Do we have any issues with that for wrapping purposes for Windows?
> There is no technical reason to prefer xread over read in strbuf_read_once as
> * we are not nonblocking (so the EAGAIN|| EWOULDBLOCK doesn't apply)
> * we don't care about EINTR and retrying upon that signal
> * we would not care about MAX_IO_SIZE most likely (that's actually one
> of the reasons I could technically think of to prefer xread)

I think you do still need to care about EINTR, or at least not barfing
if read() returns -1. If I understand correctly, you want to do
something like:

  while (1) {
	poll(some_fds);
	for (i = 0; i < nr_fds; i++) {
		if (some_fds[i].revents & POLLIN) {
			int r = strbuf_read_once(buf[i], some_fds[i]);
			/* ??? what do we do with r? */
		}
	}
  }

If we get EINTR from that read, it's OK for us to loop back to the
poll() and go again.

But if we get a true error in "r", we'd want to know, right? That means
we must distinguish between EINTR and "real" errors (like EIO or
something). We can do that here, but I think it's just as easy to do it
inside of strbuf_read_once (by calling xread() there). It's OK not to
jump back to the poll(), because we know the data that triggered the
POLLIN is still waiting for us to read it.

And we are fine with EAGAIN, too. We don't expect the sockets to be
non-blocking in the first place, but even if they were, we know we just
got POLLIN, so there should be data waiting.

-Peff
