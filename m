From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 18:31:13 -0400
Message-ID: <20120806223113.GA16298@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
 <20120806213404.GA14320@sigill.intra.peff.net>
 <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:31:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyVpb-0001Ub-7T
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 00:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307Ab2HFWbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 18:31:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53814 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032Ab2HFWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 18:31:17 -0400
Received: (qmail 20619 invoked by uid 107); 6 Aug 2012 22:31:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 18:31:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 18:31:13 -0400
Content-Disposition: inline
In-Reply-To: <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202995>

On Mon, Aug 06, 2012 at 06:09:08PM -0400, Ben Walton wrote:

> > I'm currently in pkgutil hell trying to remember how to get a working
> > gcc on Solaris. Bleh. What kind of OS doesn't ship with a compiler by
> > default? :)
> 
> One that's losing mindshare and isn't gaining traction? *g*  Feel free
> to message me offline if you need a hand with that.

Thanks, I figured it out (I installed opencsw's gcc, but I had no
standard include files. Turns out that I needed the system/header
package from upstream).

The stdio behavior on Solaris is weird. If I run this sample program:

  #include <stdio.h>
  int main(void)
  {
    FILE *fh = fopen("/dev/tty", "w+");
    char buf[32] = {0};
    fgets(buf, sizeof(buf), fh);
    fprintf(fh, "got %s\n", buf);
    return 0;
  }

on Linux, I get:

  $ ./a.out
  foo        <-- me typing
  got foo    <-- program output

On Solaris, I get:

  $ ./a.out
  foo        <-- me typing
  foo        <-- ???
  got foo    <-- program output

If you step it through the debugger, the mystery output comes as part of
the fprintf, as if it is in the buffer waiting to be flushed. And
indeed, if you dump the FILE handle via gdb, there is only a single
buffer, and it contains "foo\n". Whereas with glibc, there are separate
read/write buffers.

I suspect the single buffer is enough to handle normal files, but not
bidirectional pipes where the input and output content are unrelated. I
don't think Solaris is _buggy_ per se, as we have probably stepped
outside the realm of what the standard promises, but it's certainly a
quality-of-implementation issue.

So I think it could be solved by opening /dev/tty twice (or fdopen()ing
the same descriptor twice). Or by just doing away with stdio entirely.

Looking over the code, I recall now why I used stdio: strbuf_getline
requires it. These days we have strbuf_getwholeline_fd. It's slightly
less efficient (it has to read() a character at a time), but since we
are talking about a few characters of keyboard input, it should be OK.

-Peff
