From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH] Remove terminal symbols from non-terminal console
Date: Thu, 8 Nov 2012 11:51:06 -0500
Message-ID: <20121108165106.GF15560@sigill.intra.peff.net>
References: <CABHRWd1T=a8Mze20G9koiTr0L2Nrq0g3vGLC9mEZ7rA45vgfSA@mail.gmail.com>
 <CABHRWd16k6B4Ybvc4k7z29_A9Q2wZVXA__Bov8Pst4cc2H0cmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Michael Naumov <mnaoumov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWVKE-0001Tn-4P
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab2KHQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 11:51:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36443 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395Ab2KHQvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:51:10 -0500
Received: (qmail 30672 invoked by uid 107); 8 Nov 2012 16:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 11:51:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 11:51:06 -0500
Content-Disposition: inline
In-Reply-To: <CABHRWd16k6B4Ybvc4k7z29_A9Q2wZVXA__Bov8Pst4cc2H0cmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209172>

On Tue, Nov 06, 2012 at 10:17:21AM +1100, Michael Naumov wrote:

> As per discussion on msysgit user group:
> https://groups.google.com/forum/?fromgroups=#!topic/msysgit/U_a982_a3rc/discussion
> we found the following patch is required to get rid of weird terminal
> characters for other tools such as GitExtensions for Windows
> 
> ---8<---

Please follow SubmittingPatches (missing signoff, weird use of scissors
marker that cuts out your commit message, and your commit message should
summarize the discussion).

> @@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int out)
> 
>   memcpy(buf, PREFIX, pf);
>   term = getenv("TERM");
> - if (term && strcmp(term, "dumb"))
> + if (isatty(out) && term && strcmp(term, "dumb"))
>   suffix = ANSI_SUFFIX;
>   else
>   suffix = DUMB_SUFFIX;

Is that right? The "out" fd is where we send sideband 1, and it is
almost always not going to be a tty. The suffix should be sent with
sideband 2, which goes to stderr. So I'd think you would want to check
isatty(2).

Also, most isatty checks also need to cover the case that a pager has
already been started.  That is probably not worth worrying about here,
though, as we shouldn't be using a pager for commands that do network
communications (and if we do, omitting the magic line-clearing signal is
probably a sane thing to do).

I think the overall goal is a step in the right direction, though.

-Peff
