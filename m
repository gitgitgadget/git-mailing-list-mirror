From: Jeff King <peff@peff.net>
Subject: Re: Why does "git config" output nothing instead of the default
 value for unset variables?
Date: Sun, 14 Apr 2013 14:56:19 -0400
Message-ID: <20130414185619.GB1621@sigill.intra.peff.net>
References: <kke7o1$oo$1@ger.gmane.org>
 <CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 20:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URS6M-0000qC-QQ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab3DNS4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 14:56:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45506 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3DNS4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 14:56:24 -0400
Received: (qmail 15787 invoked by uid 107); 14 Apr 2013 18:58:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 14:58:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 14:56:19 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221150>

On Sun, Apr 14, 2013 at 10:47:31PM +1000, Andrew Ardill wrote:

> More to the point, I can easily imagine many scripts relying on git
> config returning a value to indicate that a config item has been set.
> Your proposed change would break all those. For that reason, it might
> be nicer to introduce a flag that returns the config if it is set or
> the default otherwise. Something like git config --value perhaps.

The expected output is certainly a problem, but the issue is more
fundamental than that: git-config does not even _know_ what the default
is for any given option.

It is assumed that the caller knows what to do with an unset value. And
this is nothing to do with git-config; the internal C code works the
same way. The actual defaults are not even necessarily expressible
through the config. E.g., I know that http.receivepack considers "unset"
to be distinct either "true" or "false", but setting it can yield only
one of those latter two values. I'm sure there are others, too (I just
happened to notice that one this week).

I could certainly see an argument that the world would be a better place
if the code had a big table of options and their descriptions, possible
values, and defaults, and if we used that to generate documentation as
well as validate input. But nobody has gone to the trouble to construct
that table and convert all of the callers. And as Jakub mentioned, such
a central table can do nothing for external programs that store their
config alongside git's.

So I think the desire that is expressed in this thread is reasonable,
but I don't see it happening anytime soon. I'd love to be proved wrong
by somebody converting the whole system, of course. :)

I'd also be fine with a "git config --get-$TYPE $OPTION $DEFAULT" mode;
the "--get-color" option already works like this. But the caller has
to provide the "$DEFAULT", since git-config does not know it. So I
suspect it defeats the purpose of the original request.

-Peff
