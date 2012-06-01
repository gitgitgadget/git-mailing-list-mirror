From: Jeff King <peff@peff.net>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Fri, 1 Jun 2012 05:53:33 -0400
Message-ID: <20120601095333.GF32340@sigill.intra.peff.net>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
 <20120531012908.GD5488@sigill.intra.peff.net>
 <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
 <1338471582.12573.140661083191693.32060E78@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Travis P <git@castle.fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaOYJ-0004yZ-BA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab2FAJxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:53:39 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39714
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807Ab2FAJxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:53:38 -0400
Received: (qmail 31624 invoked by uid 107); 1 Jun 2012 09:53:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 05:53:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 05:53:33 -0400
Content-Disposition: inline
In-Reply-To: <1338471582.12573.140661083191693.32060E78@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198971>

On Thu, May 31, 2012 at 08:39:42AM -0500, Travis P wrote:

> Here's what I learned this morning: it appears to work when I don't
> close STDIN.
> 
>     #close $_ for *STDIN, *STDOUT, *STDERR; # What I was doing. Fails.
>     close $_ for *STDOUT, *STDERR;  # Tried this, it works.
>     *STDOUT = $log_fh;
>     *STDERR = $log_fh;

Yeah, don't do that.  This can cause subtle bugs in subprocesses. For
example:

  1. You don't have a descriptor 0, because it is closed.

  2. Some part of the program opens a new descriptor (e.g., to read a
     file, making a pipe, etc). This becomes descriptor 0, because it is
     the lowest unused descriptor.

  3. The program wants to redirect its stdin (e.g., because it is
     forking and exec'ing a child). So it calls dup2(fd, 0), closing
     what was at stdin previously, which might have been valuable.

The right thing to do is to redirect stdin from /dev/null, not close it
entirely.

> >  2. We check isatty(1) for starting a pager, auto-selecting color,
> >  and in recent versions of git, for column support. But none of
> >  those things should be in use by git-pull anyway.
> 
> Ahh, this could be it:  when the pull does receive an output and I'm
> running the command in the shell, I get output with a "+-" where the
> plus is green and the minus red.  So, I think that git may be trying
> to check whether color (and columns?) is supported to output.
> However, it appears that this check is sensitive to stdin being
> connected (based on test mentioned earlier here), which is surprising.
>
> Is the code that calls isatty, calling it on all 3 descriptors, even
> when STDIN is not relevant?

No, the color code just checks isatty(1). And even if it checked some
random descriptor, the worst case should be that it affects the color
flag. So I think the terminal thing is a red herring, and it is more
likely you are seeing some subtle issue like the one I described above.

-Peff
