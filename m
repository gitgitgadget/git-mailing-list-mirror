From: Jeff King <peff@peff.net>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 6 Feb 2015 14:33:13 -0500
Message-ID: <20150206193313.GA4220@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJoeW-0002W3-Rm
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 20:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbbBFTdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 14:33:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:46051 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbbBFTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 14:33:16 -0500
Received: (qmail 3536 invoked by uid 102); 6 Feb 2015 19:33:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 13:33:15 -0600
Received: (qmail 11068 invoked by uid 107); 6 Feb 2015 19:33:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 14:33:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2015 14:33:13 -0500
Content-Disposition: inline
In-Reply-To: <20150206124528.GA18859@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263418>

On Fri, Feb 06, 2015 at 01:45:28PM +0100, Andreas Krey wrote:

> there seems to be a regression in the behaviour of 'git show_ref'
> (note the underscore). In v2.0.3-711-g586f414 it starts to say:
> 
>   $ ./git show_ref
>   error: invalid key: pager.show_ref
>   git: 'show_ref' is not a git command. See 'git --help'.
> 
> and somewhere (probably two commits, judging the diffs)
> later that changes again to:
> 
>   $ git show_ref
>   error: invalid key: pager.show_ref
>   error: invalid key: alias.show_ref
>   git: 'show_ref' is not a git command. See 'git --help'.
> 
> Apparently we need to squelch this message from
> within git_config_get_* in this case?

This is highlighting the problem with "pager.*" that Junio mentioned
recently, which is that the keyname has arbitrary data, but
syntactically is limited to alnum and "-". This should have been:

  pager.show_ref.enabled

from the beginning. But of course it was not. Even if we transition, we
would want to support pager.* for a while.

I don't think squelching the messages is quite the right approach. They
come from git_config_parse_key, which barfs on parsing the syntactically
invalid keyname. So not only are we complaining, but we are not actually
looking up the value. I don't think that's technically a regression in
586f414, though. The reader started to complain, but AFAICT git would
not agree to parse a file containing:

  [pager]
  show_ref = true

in the first place. So it is not a new problem, but it is a bug that you
cannot set pager config for such a command or alias.

I can think of a few possible paths forward:

  1. Squelch the messages, and declare "show_ref" and friends
     out-of-luck for pager config or aliases.

  2. Relax the syntactic rules for config keys to allow more characters.
     We cannot make this perfect (e.g., we cannot allow "." for reasons
     of ambiguity), but I imagine we could cover most practical cases.

     Note that we would need the matching loosening on the file-parsing
     side.

  3. Start phasing in pager.*.enabled (and I guess pager.*.command). We
     would still do the lookup of pager.* for backwards compatibility,
     but we would be careful to do so only when it is syntactically
     valid. IOW, this looks like (1), except the path forward for
     "show_ref" is to use the new, more robust, syntax.

-Peff
