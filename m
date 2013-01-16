From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 10:00:42 -0800
Message-ID: <20130116180041.GC27525@sigill.intra.peff.net>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXIU-0006Wx-3u
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab3APSAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:00:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35411 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3APSAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:00:46 -0500
Received: (qmail 13768 invoked by uid 107); 16 Jan 2013 18:02:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 13:02:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 10:00:42 -0800
Content-Disposition: inline
In-Reply-To: <20130116175057.GB27525@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213783>

On Wed, Jan 16, 2013 at 09:50:57AM -0800, Jeff King wrote:

> I'm confused, though, why your patch does not have a matching update to
> the opterror macro in parse-options.h. It uses exactly the same
> technique. Does it not generate a warning?

Ah, I think I see why not.

It is not about the macro itself, but rather the callsites that do not
return error, but call it for its printing side effect. It seems that
clang -Wunused-value is OK with unused values from functions being
discarded, but not with constants. So:

  int foo();
  void bar()
  {
    foo(); /* ok */
    1; /* not ok */
    (foo(), 1); /* not ok */
  }

The first one is OK (I think it would fall under -Wunused-result under
either compiler). The middle one is an obvious error, and caught by both
compilers. The last one is OK by gcc, but clang complains.

So opterror does not happen to generate any warnings, because we do not
ever use it in a void context. It should probably be marked the same
way, though, as future-proofing.

> The commit message should probably be along the lines of:
> [...]
>   However, clang also defines __GNUC__, but generates warnings (due to
>   throwing away the return value from the first half of the macro). We
>   can squelch the warning by turning off these macros when clang is in
>   use.

So a more accurate description would be:

  However, clang also defines __GNUC__, but generates warnings with
  -Wunused-value when these macros are used in a void context, because
  the constant "-1" ends up being useless. Gcc does not complain about
  this case (though it is unclear if it is because it is smart enough to
  see what we are doing, or too dumb to realize that the -1 is unused).
  We can squelch the warning by just disabling these macros when clang
  is in use.

-Peff
