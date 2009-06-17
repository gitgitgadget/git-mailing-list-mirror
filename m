From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 06:23:33 -0400
Message-ID: <20090617102332.GA32353@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net> <4A38AD5D.6010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGsIx-000668-L6
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 12:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758850AbZFQKXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758672AbZFQKXd
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 06:23:33 -0400
Received: from peff.net ([208.65.91.99]:38058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758616AbZFQKXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 06:23:32 -0400
Received: (qmail 8742 invoked by uid 107); 17 Jun 2009 10:25:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Jun 2009 06:25:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2009 06:23:33 -0400
Content-Disposition: inline
In-Reply-To: <4A38AD5D.6010404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121733>

On Wed, Jun 17, 2009 at 10:46:21AM +0200, Paolo Bonzini wrote:

> 2) make sure that at least one space/tab is eaten on all but the last  
> occurrence of the repeated subexpression.  To this end the LHS of {2,} is 
> duplicated, once with [ \t]+ and once with [ \t]*.  The repetition itself 
> becomes a + since the last occurrence is now separately handled:
>
> ^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*
> [ \t]*\([^;]*)$

Thanks, I can confirm that this is _much_ faster. Here are some timings
from my Solaris 8 box for the "git diff v0.4.0" case using the system
and compat engines, and using three regexes: the original that git is
using now, an updated one with your regex above[1] replacing the second
line of the stock pattern, and a baseline regex of "." which should take
virtually no time at all.

  system,  orig: infinite
  system, paolo:   2.5s
  system,   ".":   0.6s
  compat,  orig: 288.0s
  compat, paolo:   1.5s
  compat,   ".":   0.6s

So it goes from infinite to 2.5s. Which still spends 3 times as long
matching funcname regexes as it does actually calculating the diff. The
compat library is a little better, but still chokes pretty badly on the
original regex.

Let's compare compat to the glibc implementation on my Debian box:

  system,  orig:   0.22s
  system, paolo:   0.22s
  system,   ".":   0.15s
  compat,  orig: 150.88s
  compat, paolo:   0.43s
  compat,   ".":   0.15s

Besides the exponential behavior on the original regex, it is still
about twice as slow as the system one.

So I think there are three possible optimizations worth considering:

  1. Replace the builtin diff.java.xfuncname pattern with what Paolo
     suggested (though I haven't verified its correctness beyond a
     cursory look at the results). This is easy to do, and will help
     people with crappy system regex libraries and people on
     compat/regex/ (right now just mingw) a _lot_. The downside is that
     it's a little harder to read the regex, but not terribly so.

  2. Recommend NO_REGEX for people with slow system regex libraries.
     This is also easy to do, and will help people even if we do (1) for
     two reasons:

       a. we process user-defined regexes through diff.*.xfuncname
          patterns, as well as through "git grep"; so we are protecting
          against poor performance when they give us a complex regex

       b. even on more reasonable regexps like Paolo's, we seem to get a
          2:1 speedup over the Solaris system library

  3. Replace compat/regex with something faster. It still produces
     exponential behavior in complex cases where glibc does not, and it
     seems to be about 1/3 as fast on Paolo's regex.

     I haven't looked at how large or how portable the glibc
     implementation is. Another alternative is that we could provide a
     simple compat/ as now, and have better support for linking against
     an external library like pcre, if it is available.

-Peff

[1] Note if you are cutting and pasting Paolo's regex into the C code,
    the "\(" needs to be "\\(", which I screwed up in my initial
    timings. :)
