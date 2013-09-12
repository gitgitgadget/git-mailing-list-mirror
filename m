From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 16:22:46 -0400
Message-ID: <20130912202246.GF32069@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
 <20130912101419.GY2582@serenity.lan>
 <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
 <20130912182057.GB32069@sigill.intra.peff.net>
 <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:23:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDPi-0004KX-5U
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab3ILUWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:22:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:57740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3ILUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:22:49 -0400
Received: (qmail 9052 invoked by uid 102); 12 Sep 2013 20:22:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 15:22:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 16:22:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234691>

On Thu, Sep 12, 2013 at 09:46:51PM +0200, Sebastian Schuberth wrote:

> > Right, option 3 seems perfectly reasonable to me, as we must be prepared
> > to cope with a decision not to inline the function, and there has to be
> > _some_ linked implementation. But shouldn't libc be providing an
> > external, linkable strcasecmp in this case?
> 
> MinGW / GCC is not linking against libc, but against MSVCRT, Visual
> Studio's C runtime. And in fact MSVCRT has a non-inline implementation
> of a "case-insensitive string comparison for up to the first n
> characters"; it just happens to be called "_strnicmp", not
> "strncasecmp". Which is why I still think just having a "#define
> strncasecmp _strnicmp" is the most elegant solution to the problem.
> And that's exactly what defining __NO_INLINE__ does. Granted, defining
> __NO_INLINE__ in the scope of string.h will also add a "#define
> strcasecmp _stricmp"; but despite it's name, defining __NO_INLINE__
> does not imply a performance hit due to functions not being inlined
> because it's just the "strncasecmp" wrapper around "_strnicmp" that's
> being inlined, not "_strnicmp" itself.

Ah, thanks, that explains what is going on. I do think the environment
is probably in violation of C99, but I dug in the mingw history, and it
looks like it has been this way for over 10 years.

So it is probably worth working around, but it would be nice if the
damage could be contained to just the affected platform.

I think there are basically three classes of solution:

  1. Declare __NO_INLINE__ everywhere. I'd worry this might affect other
     environments, who would then not inline and lose performance (but
     since it's a non-standard macro, we don't really know what it will
     do in other places; possibly nothing).

  2. Declare __NO_INLINE__ on mingw. Similar to above, but we know it
     only affects mingw, and we know the meaning of NO_INLINE there.

  3. Try to impact only the uses as a function pointer (e.g., by using
     a wrapper function as suggested in the thread).

Your patch does (1), I believe. Junio's patch does (3), but is a
maintenance burden in that any new callsites will need to remember to do
the same trick.

But your argument (and reading the mingw header, I agree) is that there
is no performance difference at all between (2) and (3). And (2) does
not have the maintenance burden. So it does seem like the right path to
me.

-Peff
