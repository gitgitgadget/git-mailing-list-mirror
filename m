From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Wed, 7 Dec 2011 01:42:31 -0500
Message-ID: <20111207064231.GA499@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBDC-0001Df-Jm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab1LGGme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:42:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41647
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1LGGmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:42:33 -0500
Received: (qmail 13325 invoked by uid 107); 7 Dec 2011 06:49:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 01:49:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 01:42:31 -0500
Content-Disposition: inline
In-Reply-To: <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186431>

On Tue, Dec 06, 2011 at 01:40:17PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >     ... You can now
> >     do: "git credential-store erase </dev/null" to erase everything
> >     (since you have provided no restrictions, it matches everything).
> 
> That "justification" does not sound so true to me but perhaps that is
> because it is unclear what "erase" means and what it means to give the
> operation parameters.

It's not meant to be a justification, but rather an explanation. I think
the behavior is probably too dangerous to leave.

> When I see "erase $foo", I would find it natural if $foo meant "if there
> is something that matches $foo, then please remove it, but keep everything
> else intact", and not the other way around "Match the existing entries
> against a pattern (or a set of matching patterns) I am giving you, and
> drop all the rest". So if I happen to give you an empty set, I would
> expect nothing is removed.

It does do the first thing you mentioned (you provide one pattern $foo,
and we match the pattern you have given). It's just that the pattern you
have specified is "everything". The problem is not in the matching, but
in the pattern specification language.

This pattern:

  protocol=https
  host=github.com

means "match everything that uses https _and_ has a host of github.com".
The username and path fields are not present, which implicitly means
"don't care about them".

Similarly, this pattern:

  protocol=https

means "match everything that uses https". Everything else is not
specified, and therefore we allow anything.

Then what does the empty pattern do? It cares about nothing, and
therefore matches everything.

By itself, I don't think that is a problem. It's something you might
want to specify, and it's logically consistent with the way the patterns
are matched.  What is dangerous, though, is that failing to provide
input is byte-wise identical to the empty pattern. And that's why I say
it's a pattern specification problem.

A rough BNF for the pattern format is something like:

  pattern = *line
  line = key "=" value
  key = *<any byte except NUL, "=", or "\n">
  value = *<any byte except NUL or "\n">

Because the pattern takes 0 or more lines and no terminator, we can't
distinguish between empty or truncated input and the empty pattern. So
one solution would be:

  pattern = *line "\n"

i.e., require a blank line terminator.

Does that explain the issue better?

-Peff
