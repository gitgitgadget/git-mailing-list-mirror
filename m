From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 15:16:20 -0400
Message-ID: <20130911191620.GB24251@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Karsten Blees <karsten.blees@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 21:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJptr-0008Ux-5K
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 21:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab3IKTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:16:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:47833 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab3IKTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:16:22 -0400
Received: (qmail 1189 invoked by uid 102); 11 Sep 2013 19:16:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Sep 2013 14:16:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Sep 2013 15:16:20 -0400
Content-Disposition: inline
In-Reply-To: <20130911182921.GE4326@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234601>

On Wed, Sep 11, 2013 at 11:29:21AM -0700, Jonathan Nieder wrote:

> Sebastian Schuberth wrote:
> 
> > This is necessary so that read_mailmap() can obtain a pointer to the
> > function.
> 
> Hm, what platform has strcasecmp() as an inline function?  Is this
> allowed by POSIX?  Even if it isn't, should we perhaps just work
> around it by providing our own thin static function wrapper in
> mailmap.c?

Environments can implement library functions as macros or even
intrinsics, but C99 requires that they still allow you to access a
function pointer.  And if my reading of C99 6.7.4 is correct, it should
apply to inlines, too, because you should always be able to take the
address of an inline function (though it is a little subtle).

But that does not mean there are not popular platforms that we do not
have to workaround (and the inline keyword is C99 anyway, so all bets
are off for pre-C99 inline implementations).

I would prefer the static wrapper solution you suggest, though. It
leaves the compiler free to optimize the common case of normal
strcasecmp calls, and only introduces an extra function indirection when
using it as a callback (and even then, if we can inline the strcasecmp,
it still ends up as a single function call). The downside is that it has
to be remembered at each site that uses strcasecmp, but we do not use
pointers to standard library functions very often.

-Peff
