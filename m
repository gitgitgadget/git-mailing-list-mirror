From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Thu, 26 Jul 2012 14:37:35 -0400
Message-ID: <20120726183734.GA16037@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
 <1343232982-10540-5-git-send-email-rctay89@gmail.com>
 <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
 <CALUzUxp91zubHEkWMC1z2xp7kJCRYrtznQS_=pVSZoNkZMihig@mail.gmail.com>
 <20120726172630.GD13942@sigill.intra.peff.net>
 <7vy5m67694.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:37:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuSwQ-0008B3-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 20:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2GZShi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 14:37:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481Ab2GZShh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 14:37:37 -0400
Received: (qmail 12073 invoked by uid 107); 26 Jul 2012 18:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 14:37:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 14:37:35 -0400
Content-Disposition: inline
In-Reply-To: <7vy5m67694.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202290>

On Thu, Jul 26, 2012 at 10:59:51AM -0700, Junio C Hamano wrote:

> > The credential code uses git_terminal_prompt, which actually opens
> > /dev/tty directly. So it is probably sane to use for your new prompt,
> > but it does not (and should not) rely on isatty.
> 
> I think using git_terminal_prompt() after doing a looser "does the
> user sit at a terminal and is capable of answering interactive
> prompt" check with isatty(2) is OK, as long as we know that all
> implementations of git_terminal_prompt() never read from whatever
> happens to be connected to the standard input.

I don't think isatty(2) is correct, though. It would yield false
negatives when the user has redirected stderr but /dev/tty is still
available. I don't know if it possible for getpass to fallback to stdin
when stderr is a tty (it would mean that opening /dev/tty failed, which
would mean that we have no controlling terminal _but_ our stderr is
still connected to some terminal. That might be bizarre enough not to
care about).

I think the right answer would be a real is_prompt_available() that
checked /dev/tty when HAVE_DEV_TTY was set, and otherwise checked
isatty(2) (or whatever was appropriate for the platform).

> The function falls back to getpass() on platforms without DEV_TTY,
> and if getpass() on some platforms reads from the standard input,
> that would be a disaster.  I wasn't sure about that part.

Yeah, although it is already a disaster in those cases, as the main
caller of git_terminal_prompt is remote-curl, whose stdin is connected
to git via the remote-helper protocol. Which isn't to say this wouldn't
make things worse. It would, but the real solution is to implement a
sane git_terminal_prompt for those platforms. Erik had a patch for
Windows to use their magical CONIN$, but I think it is temporarily
stalled. I don't know if there are any other platforms that do not have
/dev/tty (I know we do not set HAVE_DEV_TTY by default, but that is only
because I was being conservative and waiting for people on particular
platforms to confirm that it works before tweaking our Makefile
defaults).

-Peff
