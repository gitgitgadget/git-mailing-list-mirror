From: Jeff King <peff@peff.net>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Wed, 27 Aug 2014 15:28:48 -0400
Message-ID: <20140827192848.GC7561@peff.net>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMitq-0000P2-PL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbaH0T2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:28:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:60284 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935462AbaH0T2t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:28:49 -0400
Received: (qmail 18564 invoked by uid 102); 27 Aug 2014 19:28:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 14:28:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 15:28:48 -0400
Content-Disposition: inline
In-Reply-To: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256028>

On Wed, Aug 27, 2014 at 03:15:05PM -0400, dev wrote:

> This causes a problem on things like Solaris :
> 
>  * new build flags
>     CC credential-store.o
> "git-compat-util.h", line 516: error: identifier redeclared: inet_ntop
>         current : function(int, pointer to const void, pointer to char,
> unsigned long) returning pointer to const char
>         previous: function(int, pointer to const void, pointer to char,
> unsigned int) returning pointer to const char :
> "/usr/include/arpa/inet.h", line 68
> cc: acomp failed for credential-store.c
> gmake: *** [credential-store.o] Error 2

That declaration should only be used if you have NO_INET_NTOP defined by
the Makefile. That is not defined by default for Solaris. Have you
specified it yourself, or are you using the autoconf script? If the
latter, I suspect its test for inet_ntop needs to be fixed.

> However ran into a problem, again, with compat/inet_ntop.c which seems
> to be not needed at all since inet_ntop() handles both IPv6 and IPv4
> just fine.   Really I don't see why this file gets carted around so much
> as it is even in the Apache svn codebase as well.

Again, that should not be compiled at all unless you have NO_INET_NTOP
set. Fixing that should solve both of your problems.

> Also the Makefile's generated are all borked full of GCCism "CFLAGS = -g
> -O2 -Wall"  which means very little on some OS wherein the gcc compiler
> is not the default.

Yes, this is a potential portability problem we've discussed before, but
literally nobody has ever complained. I suspect it's a combination of
many compilers accepting those arguments (e.g., clang is fine with it)
and people on exotic compilers accepting that "make CFLAGS=" is a
reasonable starting point (you can also put "CFLAGS = " into your
config.mak if you do not want to remember to include it on each make
invocation).

> is Solaris and am using ORacle Studio 12.3 compilers and therefore the
> CFLAGS in the Makefiles are just silly.  Lastly, the linkage to libintl
> should look in /usr/local/lib if the LD_LIBRARY_PATH and other env vars
> are setup correctly. However the Makefile's seem to miss this fact and
> -lintl needs to be manually hacked into place.

I do not usually see Makefiles peeking at LD_LIBRARY_PATH, which is for
runtime resolution. Do you need to set LDFLAGS in your environment (or
in config.mak)?

-Peff
