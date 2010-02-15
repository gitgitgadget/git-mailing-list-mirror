From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] tests: Add tests for automatic use of pager
Date: Mon, 15 Feb 2010 00:10:16 -0500
Message-ID: <20100215051016.GF3336@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214121300.GF3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtDy-00038M-7j
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0BOFKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:10:14 -0500
Received: from peff.net ([208.65.91.99]:36309 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab0BOFKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:10:12 -0500
Received: (qmail 13352 invoked by uid 107); 15 Feb 2010 05:10:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:10:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:10:16 -0500
Content-Disposition: inline
In-Reply-To: <20100214121300.GF3499@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139976>

On Sun, Feb 14, 2010 at 06:13:00AM -0600, Jonathan Nieder wrote:

> They does not yet test:
> 
>  - use of pager by scripted commands (git svn and git am);
>  - effect of the pager.* configuration variables;
>  - setting of the LESS variable.
> 
> Some features require stdout to be a terminal to be testable without
> a (not written) shim using pseudo-terminals.  Thus about half of these
> tests are skipped unless $GIT_TEST_OPTS includes --verbose.

I am a little lukewarm on tests that require --verbose, since they will
not be caught by 99% of the runs of the test suite. Which means they
sneak through things like Junio's automated testing of maint, master,
and next.

Still, perhaps something is better than nothing. I wonder if we can do
better, though, with something like:

  int xisatty(int fd)
  {
    static int fake[3];

    if (fd > ARRAY_SIZE(pretend))
      return isatty(fd);

    if (fake[fd] == -1) {
      const char *x = getenv("GIT_PRETEND_TTY");
      if (x && strchr(x, '0' + fd))
        fake[fd] = 1;
      else
        fake[fd] = isatty(fd);
    }
    return fake[fd];
  }

-Peff
