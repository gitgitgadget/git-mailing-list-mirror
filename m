From: Jeff King <peff@peff.net>
Subject: Re: Is there a reason the credential cache server cowardly refuses
 to delete/reuse the socket file?
Date: Sun, 15 Jun 2014 10:08:00 -0400
Message-ID: <20140615140800.GA6216@sigill.intra.peff.net>
References: <1EFC4B213D584B1EBAE78E6882705B6D@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jun 15 16:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwB6Q-0007n0-FD
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 16:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbaFOOIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 10:08:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:44650 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750900AbaFOOIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 10:08:05 -0400
Received: (qmail 22836 invoked by uid 102); 15 Jun 2014 14:08:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 15 Jun 2014 09:08:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2014 10:08:00 -0400
Content-Disposition: inline
In-Reply-To: <1EFC4B213D584B1EBAE78E6882705B6D@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251676>

On Sun, Jun 15, 2014 at 09:48:24AM -0400, Jason Pyeron wrote:

> Whenever my computer crashes, I am left with a socket file. On next git
> invocation it tries to conenct to the file, but the daemon is not running so it
> barfs until I delete the file.

It's supposed to transparently handle this situation. The server always
runs unlink() before binding to clear it out. The client will spawn the
server when it tries to connect and gets either ENOENT or ECONNREFUSED.

But:

> jpyeron@black /projects/dcarr/saar
> $ git push
> fatal: unable to connect to cache daemon: No error

Apparently your errno is 0 after returning an error from
credential-cache.c:send_request?

Could this be a cygwin weirdness? I'd be interested to see the output
of:

  echo url=https://example.com |
  strace -f git credential-cache get

in such a case.

-Peff
