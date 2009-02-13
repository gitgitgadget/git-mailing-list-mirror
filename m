From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Fri, 13 Feb 2009 17:22:33 -0500
Message-ID: <20090213222233.GA7424@coredump.intra.peff.net>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu> <20090206161954.GA18956@coredump.intra.peff.net> <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY6SB-00033K-0P
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 23:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbZBMWWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 17:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZBMWWh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 17:22:37 -0500
Received: from peff.net ([208.65.91.99]:42527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761884AbZBMWWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 17:22:36 -0500
Received: (qmail 26475 invoked by uid 107); 13 Feb 2009 22:22:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 17:22:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 17:22:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109779>

On Mon, Feb 09, 2009 at 09:24:37AM -0800, Keith Cascio wrote:

> adding new vocab if possible.  If I'm missing something, I apologize
> ahead of time, but let me describe the problem I see.  Let's take the
> context size setting as an example, i.e. -U<n> or --unified=<n>.
> Default is 3.  Let's say someone defines diff.primer = -U6.  Now,
> without --no-primer, how does a program say "use the default value for
> context."  Aren't there options for which no inverse counterpart
> exists?  Is there command-line syntax to disable all whitespace ignore
> options, e.g. to disable -b?  If not then we need --no-primer.

Good point.  I think there are actually two separate problems you
describe:

  1. some default behaviors which can be changed via an option have no
     option that represents the default. This is your "-b" example (and
     there are others, like "-a", "--full-index", etc).

     Generally I think we try to allow boolean options to be specified
     in either positive or negative ways. Our parse-options library even
     automatically handles --no-$foo by default for any boolean option
     (as long as it has a corresponding long option).

     So I consider the lack of --no-ignore-space-change to be a failing
     of git, but one that we can correct. Either manually or by moving
     the diff code to parse-options.

  2. For options which take a value, there is no way to say "pretend I
     didn't specify a value at all".

     Actually, that is not entirely true. parse-options handles
     "--foo=bar --no-foo" as if "--foo" was never specified at all.

     But there are still two failure cases:

       - as above, the diff options are not handled by parse-options

       - not all value options are quite as straightforward. Some
         options run callbacks that do things which take specialized
         code to undo.

     Both are fixable. But I have to wonder if it is really all that
     useful to say "use the default for this option". Either you don't
     care what the value is, in which case you can take the default
     given by your primer value. Or you do care, in which case wouldn't
     you want to be setting the value yourself?

So I think doing it right is a bit more work in the long run, but the
extra work is generally improving git.

All that being said, though, I still think we can do the equivalent of
--no-primer. The trick to avoiding multiple passes is for the option to
exist outside of the set of primer'd options. I can think of two places:

  1. an environment variable, GIT_PRIMER. E.g., "GIT_PRIMER=0 git diff".
     This strikes me as hack-ish and unfriendly, but would work.

  2. in the git option list, but not the git command option list. IOW, we
     actually have two sets of options in any command:

        git [options] diff [options]

     So you could suppress primers (all of them, including diff.primer
     or primer.*) via:

       git --no-primer diff

Make sense?

-Peff
