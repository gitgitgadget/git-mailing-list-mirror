From: Jeff King <peff@peff.net>
Subject: Re: GIT_TRACE_PERFORMANCE and pager
Date: Mon, 29 Feb 2016 06:39:25 -0500
Message-ID: <20160229113924.GC29769@sigill.intra.peff.net>
References: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:39:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaMAn-0003gu-V1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbcB2Lja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 06:39:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:51330 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752372AbcB2Lj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:39:29 -0500
Received: (qmail 15012 invoked by uid 102); 29 Feb 2016 11:39:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:39:28 -0500
Received: (qmail 25246 invoked by uid 107); 29 Feb 2016 11:39:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:39:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:39:25 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287827>

On Mon, Feb 29, 2016 at 12:25:49PM +0100, Christian Couder wrote:

> Setting GIT_TRACE to 1 or 2 seems to work, but maybe it is because it
> outputs stuff at the beginning of the process and not at the end.

Yeah, I think so. Try this (on Linux):

  $ GIT_PAGER='sed s/^/paged:/' \
    GIT_TRACE_PERFORMANCE=1 \
    strace -f -e write -e 'signal=!sigchld' git -p rev-parse
  strace: Process 31155 attached
  strace: Process 31156 attached
  [pid 31156] +++ exited with 0 +++
  [pid 31155] +++ exited with 0 +++
  write(2, "06:32:30.486995 [pid=31154] trac"..., 114) = -1 EBADF (Bad file descriptor)
  write(2, "Could not trace into fd given by"..., 99) = -1 EBADF (Bad file descriptor)
  +++ exited with 0 +++

We redirect stderr to the pager (note that GIT_TRACE=1 still goes to
stderr; it never goes to stdout). We wait() on the pager process before
we exit the main git process, and we don't print the performance stats
until atexit(). So by the time we get there, the pager must be dead, and
the pipe descriptor is closed (I'm actually kind of surprised we don't
get EPIPE, but it looks like we close the descriptors in
wait_for_pager()).

One workaround is something like:

  GIT_TRACE_PERFORMANCE=3 3>&2 git ...

though I guess I'd question whether trace-performance is interesting at
all for a paged command, since it is also counting the length of time
you spend looking at the pager waiting to hit "q".

-Peff
