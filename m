From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Wed, 20 Nov 2013 12:30:54 -0500
Message-ID: <20131120173054.GA15339@sigill.intra.peff.net>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
 <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
 <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr>
 <201309030227.r832RmBd013888@freeze.ariadne.com>
 <20130903074150.GE3608@sigill.intra.peff.net>
 <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:31:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBcC-0002nj-SV
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3KTRa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:30:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:42691 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751885Ab3KTRa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:30:56 -0500
Received: (qmail 23258 invoked by uid 102); 20 Nov 2013 17:30:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Nov 2013 11:30:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Nov 2013 12:30:54 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238085>

On Wed, Nov 20, 2013 at 06:24:45PM +0100, Erik Faye-Lund wrote:

> > diff --git a/pager.c b/pager.c
> > index c1ecf65..fa19765 100644
> > --- a/pager.c
> > +++ b/pager.c
> > @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
> >                 pager = getenv("PAGER");
> >         if (!pager)
> >                 pager = DEFAULT_PAGER;
> > -       else if (!*pager || !strcmp(pager, "cat"))
> > +       if (!*pager || !strcmp(pager, "cat"))
> 
> Hmmpf. It's sometimes useful to actually pipe through cat rather than
> disabling the pager, as this changes the return-code from isatty. I
> sometimes use this for debugging-purposes. Does this patch break that?

My patch should not change the behavior of PAGER=cat, GIT_PAGER=cat,
core.pager, etc. It should _only_ impact the case where DEFAULT_PAGER is
set to "cat" (or NULL), and bring it in line with the other cases.

I am not clear on how you are using "cat", so I can't say whether it is
broken. But if you are doing:

  PAGER=cat git log

that already is a no-op, and that is not changed by my patch. If you
want to make stdout not a tty, I'd think:

  git log | cat

is the right way to do it (and anyway, when the pager is in effect git
will pretend that stdout is a tty, since you would still want things
like auto-color to go to the pager).

-Peff
