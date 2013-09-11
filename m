From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 17:41:16 -0400
Message-ID: <20130911214116.GA12235@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 23:41:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJsA7-0003LZ-DE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab3IKVlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 17:41:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:48771 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab3IKVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 17:41:19 -0400
Received: (qmail 8170 invoked by uid 102); 11 Sep 2013 21:41:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Sep 2013 16:41:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Sep 2013 17:41:16 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234610>

On Wed, Sep 11, 2013 at 09:59:53PM +0200, Sebastian Schuberth wrote:

> On Wed, Sep 11, 2013 at 8:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> This is necessary so that read_mailmap() can obtain a pointer to the
> >> function.
> >
> > Hm, what platform has strcasecmp() as an inline function?  Is this
> > allowed by POSIX?  Even if it isn't, should we perhaps just work
> > around it by providing our own thin static function wrapper in
> > mailmap.c?
> 
> I'm on Windows using MSYS / MinGW. Since MinGW runtime version 4.0,
> string.h contains the following code (see [1]):
> 
> #ifndef __NO_INLINE__
> __CRT_INLINE int __cdecl __MINGW_NOTHROW
> strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
> {return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}
> #else
> #define strncasecmp _strnicmp
> #endif

What is the error the compiler reports? Can it take the address of other
inline functions? For example, can it compile:

    inline int foo(void) { return 5; }
    extern int bar(int (*cb)(void));
    int call(void) { return bar(foo); }

Just wondering if that is the root of the problem, or if maybe there is
something else subtle going on. Also, does __CRT_INLINE just turn into
"inline", or is there perhaps some other pre-processor magic going on?

-Peff
