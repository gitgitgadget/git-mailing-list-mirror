From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Thu, 15 Apr 2010 03:15:40 -0400
Message-ID: <20100415071540.GB27542@coredump.intra.peff.net>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com>
 <201004142110.36453.jnareb@gmail.com>
 <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 15 09:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2JJC-0007K6-3d
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab0DOHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 03:16:13 -0400
Received: from peff.net ([208.65.91.99]:55712 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab0DOHQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:16:12 -0400
Received: (qmail 13352 invoked by uid 107); 15 Apr 2010 07:16:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Apr 2010 03:16:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Apr 2010 03:15:40 -0400
Content-Disposition: inline
In-Reply-To: <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144955>

On Wed, Apr 14, 2010 at 09:57:27PM +0100, Julian Phillips wrote:

> > 'git blame' has --porcelain and --incremental output, which is
> [...]
> > JSON output would only add unnecessary chatter and different quoting
> > rules.
> 
> That depends really.  If you are writing something to parse the output,
> and you already have a JSON parser available then it's the current output
> that has different quoting rules. ;)

Every once in a while, I have some crazy idea for a short script that is
built around blame output (e.g., counting contributors by line count).
Something that I might do in a little one-off perl script. And my
experience has been that 90% of the script ends up parsing and managing
commit blocks, and not the computation of interest.

Not that it's a lot of lines, mind you, but having to write 20 lines of
parser to do a perl one-liner on the result is annoying. I would be very
happy to have some 1 or 2 line solution where one of the lines is "use
JSON;".

> Anyway, I have already converted blame to use the library for both
> --porcelain and --incremental output, so it'll be in the next version of
> the patch series.  So you can try before you buy ...

I'll be curious to see it. I hope you will (at least optionally) wrap
the _whole_ output and not just the commit blocks. It would be nice to
just suck it in all at once and walk the data structure. But it may be
tricky because the output suppresses the commit description for commits
that have already been output. You would probably want a list of lines
and a map of commits, like:

  {
    "lines": [
      { sha1 and line info }
      { sha1 and line info }
      ...
    ],
    "commits": {
      "$sha1": { commit info },
      ...
  }

which is close to what I would parse to in a script, except I would
actually drop the "commits" map and point directly to the commit info
from each line.

Is there a way in JSON to refer to the contents of a previous item
without just outputting the same data again? I assume not, and even if
there is, other output formats like XML wouldn't handle it.

-Peff
