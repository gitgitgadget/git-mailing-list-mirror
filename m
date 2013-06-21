From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Fri, 21 Jun 2013 01:31:12 -0400
Message-ID: <20130621053112.GA9634@sigill.intra.peff.net>
References: <1371586006-16289-1-git-send-email-artagnon@gmail.com>
 <7vip1b40zb.fsf@alter.siamese.dyndns.org>
 <CALkWK0=6ot9ZXEyMmO1ZtEXPi5H1JXXvG5j6yvBeE56H9zQBwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 07:31:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UptwQ-000391-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 07:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935571Ab3FUFbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 01:31:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:35208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935551Ab3FUFbR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 01:31:17 -0400
Received: (qmail 15882 invoked by uid 102); 21 Jun 2013 05:32:16 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 00:32:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 01:31:12 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=6ot9ZXEyMmO1ZtEXPi5H1JXXvG5j6yvBeE56H9zQBwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228574>

On Wed, Jun 19, 2013 at 02:05:06AM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:
> > Sounds like making "make test" build it is a more correct approach,
> > at least to me.  What am I missing?
> 
> How exactly?  I'm not exactly competent in make, but this is what I
> understood from what you said (and it's obviously wrong):
> 
> diff --git a/Makefile b/Makefile
> index 03524d0..da91937 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -580,6 +580,7 @@ TEST_PROGRAMS_NEED_X += test-svn-fe
>  TEST_PROGRAMS_NEED_X += test-wildmatch
> 
>  TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
> +TEST_PROGRAMS += git-remote-testpy

I'm confused. git-remote-testpy is already mentioned in SCRIPT_PYTHON,
which means it should be built by "make" or "make all", as well as "make
test" (which depends on "all"). I just double checked that this is the
case with a fresh clone of master. NO_INSTALL should not have an impact.

But upon looking at the Makefile more, I am doubly confused. We build
$(ALL_PROGRAMS), which contains $(SCRIPTS), which contains
$(SCRIPT_PYTHON_INS), the set of _installed_ python scripts. Which
doesn't make sense; we would want to build all of the generated scripts,
and only care about the installed ones for the "install" target.

Ah, I see. We later add back in $(NO_INSTALL) as dependencies of "all".
That is perhaps not the most direct way of doing it, but I suspect it
was done to keep the meaning of "$(ALL_PROGRAMS)" the same before and
after.

So I do not see any problem with the current Makefile. Running "make" or
"make test" should let t5800 pass. Can you describe how you are
triggering the issue in more detail?

-Peff
