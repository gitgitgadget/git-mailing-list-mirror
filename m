From: Jeff King <peff@peff.net>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 03:10:19 -0500
Message-ID: <20111212081019.GA17725@sigill.intra.peff.net>
References: <4EE4F97B.9000202@alum.mit.edu>
 <20111212064305.GA16511@sigill.intra.peff.net>
 <4EE5B123.2030708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0xu-0005KL-H0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1LLIKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:10:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1LLIKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:10:21 -0500
Received: (qmail 30460 invoked by uid 107); 12 Dec 2011 08:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 03:17:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 03:10:19 -0500
Content-Disposition: inline
In-Reply-To: <4EE5B123.2030708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186885>

On Mon, Dec 12, 2011 at 08:45:39AM +0100, Johannes Sixt wrote:

> Am 12/12/2011 7:43, schrieb Jeff King:
> > I'll leave the issue of "-std=c89" triggering SNPRINTF_RETURNS_BOGUS to
> > people who know and care about autoconf. My gut is to say "don't do
> > that".
> 
> Right. But Michael's problem was actually that SNPRINTF_RETURNS_BOGUS was
> set incorrectly; his system has a working snprintf (or so I assume). The
> reason for the failure is that ./configure's test program produced a
> warning, and that warning was turned into an error due to -Werror. Without
> -Werror, the test program would have compiled successfully, and the
> working snprintf would have been detected.

Right, I understand that. But he has given a set of options that
shouldn't compile git at all (he tells the compiler not to use snprintf
via -std=c89, but we require that it exists, because even our
git_vsnprintf wrapper uses the underlying system vsnprintf).

So yes, the configure script is broken to detect the situation as
SNPRINTF_RETURNS_BOGUS and not "this platform doesn't have snprintf at
all"[1]. But I'm saying that the "we do not have snprintf at all" case
is not all that interesting: git needs it. So I'm not sure compiling
with -std=c89 really makes sense[2].

If somebody wants to make the configure script more accurate, I
certainly don't want to stop them. I'm just not sure it is worth
anybody's time in this case.

-Peff

[1] Yes, obviously we do actually have it, but it is somewhat a fluke
    that it works. We tell the compiler during the compile phase that we
    don't have it, but then during the link phase it is magically
    available in libc.

[2] I can convince git to compile on recent Linux with gcc using
    CFLAGS='-std=c89 -Dinline='.  Turning on "-Wall -Werror" doesn't
    work because all of the inline functions appear to be unused
    statics.  But if I understand Michael's problem correctly, wouldn't
    we be missing the prototype for snprintf, which could cause subtle
    errors?
