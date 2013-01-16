From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 09:50:57 -0800
Message-ID: <20130116175057.GB27525@sigill.intra.peff.net>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvX92-0001i5-MT
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab3APRvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:51:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35397 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab3APRvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:51:02 -0500
Received: (qmail 13723 invoked by uid 107); 16 Jan 2013 17:52:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 12:52:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 09:50:57 -0800
Content-Disposition: inline
In-Reply-To: <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213781>

On Wed, Jan 16, 2013 at 06:26:35PM +0100, Max Horn wrote:

> > On Wed, Jan 16, 2013 at 06:12:57PM +0100, Antoine Pelisse wrote:
> >> FWIW, I also happen to have the warning:
> >> 
> >> advice.c:69:2: warning: expression result unused [-Wunused-value]
> >>        error("'%s' is not possible because you have unmerged files.", me);
> >>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> ./git-compat-util.h:314:55: note: expanded from:
> >> #define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
> >>                                                      ^~
> >> 
> >> with clang: Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final)
> >> (based on LLVM 3.0)
> > 
> > I have the same output with:
> > 
> > clang version 3.2 (tags/RELEASE_32/final)
> 
> Sorry for not being more specific in my message. I have this with 
> 
> Apple clang version 4.1 (tags/Apple/clang-421.11.66) (based on LLVM 3.1svn)

So it seems pretty common, and is just that clang is more concerned
about this than gcc. I think your patch is a reasonable workaround. It
seems a little weird to me that clang defines __GNUC__, but I assume
there are good reasons for it. The commit message should probably be
along the lines of:

  Commit a469a10 wraps some error calls in macros to give the compiler a
  chance to do more static analysis on their constant -1 return value.
  We limit the use of these macros to __GNUC__, since gcc is the primary
  beneficiary of the new information, and because we use GNU features
  for handling variadic macros.

  However, clang also defines __GNUC__, but generates warnings (due to
  throwing away the return value from the first half of the macro). We
  can squelch the warning by turning off these macros when clang is in
  use.

I'm confused, though, why your patch does not have a matching update to
the opterror macro in parse-options.h. It uses exactly the same
technique. Does it not generate a warning?

-Peff
