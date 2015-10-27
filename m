From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Tue, 27 Oct 2015 14:41:51 -0400
Message-ID: <20151027184151.GA12717@sigill.intra.peff.net>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
 <CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
 <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
 <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
 <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
 <20151026215016.GA17419@sigill.intra.peff.net>
 <CAM-tV--80xt_Ro_vQdgRmRxfy+2k2Ca13gVsjDHK+1pdsB_hqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:42:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr9C3-0006Hn-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbbJ0Slz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:41:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:48666 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754398AbbJ0Sly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:41:54 -0400
Received: (qmail 18319 invoked by uid 102); 27 Oct 2015 18:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 13:41:54 -0500
Received: (qmail 26851 invoked by uid 107); 27 Oct 2015 18:42:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 14:42:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 14:41:51 -0400
Content-Disposition: inline
In-Reply-To: <CAM-tV--80xt_Ro_vQdgRmRxfy+2k2Ca13gVsjDHK+1pdsB_hqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280287>

On Mon, Oct 26, 2015 at 08:50:10PM -0400, Noam Postavsky wrote:

> On Mon, Oct 26, 2015 at 5:50 PM, Jeff King wrote:
> > But these days, people often have several simultaneous sessions open.
> > They may have multiple ssh sessions to a single machine, or they may
> > have a bunch of terminal windows open, each of which has a login shell
> > and will send HUP to its children when it exits.
> 
> Yes, except that as far as I can tell the shell never sends HUP.

Ah, OK, I thought your original problem was too many HUPs. But reading
more, it is really "too many HUPs from Emacs".

I certainly do not get SIGHUPs when I close a terminal window. But I
would not be surprised if that behavior is dependent on shell version,
shell options, and terminal version.

> > I don't know what shell Noam is using, but I wonder if tweaking
> > that option (or a similar one if not bash) might be helpful to signal
> > "let this stuff keep running even after I exit".
> 
> My normal login shell is zsh, but I've been testing with bash and I
> see the same behaviour with both. But the original reason for this
> whole thread is that when running from Emacs (not via shell), the
> daemon *always* get a SIGHUP as soon as "git push" finishes, which
> makes the caching thing not so useful. We do have a workaround for
> this by now though (start the daemon independently before calling "git
> push").

That makes sense. According to the emacs docs[1], "killing a buffer
sends a SIGHUP signal to all its associated processes". I don't know if
that is configurable or not, but even if it were, it might not do the
right thing (you probably _do_ want to send a signal to most processes,
just not the credential daemon).

Certainly the daemon could do more to "daemonize" itself. Besides
ignoring SIGHUP, it could detach from the controlling tty, close more
descriptors, etc. But along the lines that Junio mentioned, I'm not sure
if that's what people want. In general, it _is_ kind of associated with
your terminal session and should not live on past it.

I wonder if it would work in your case to simply nohup the credential
helper. I.e., put this in your git config:

  [credential]
  helper = "!nohup git credential-cache"

There are probably some weird things with how nohup works, though (e.g.,
it redirects stderr to stdout, which is not what you want). Ignored
signals are inherited by children, so you could probably just do:

  [credential]
  helper = "!trap '' HUP; git credential-cache"

That _almost_ works. Unfortunately, credential-cache installs its own
SIGHUP handler to clean up its socket. So it cleans up the socket, and
then chains to the original handler, which was to ignore the signal.
Meaning we keep running, but nobody can contact us. Whoops.

So I dunno. I think it would be reasonable to provide a config option to
tell the cache-daemon to just ignore SIGHUP (or alternatively, a general
option to try harder to dissociate itself from the caller). But I'm not
sure I'd agree with making it the default. I'd want to know if anybody
is actually _using_ the SIGHUP-exits-daemon feature. Clearly neither of
us is, but I wouldn't be surprised if other setups are.

-Peff

[1] http://www.gnu.org/s/emacs/manual/html_node/elisp/Signals-to-Processes.html
