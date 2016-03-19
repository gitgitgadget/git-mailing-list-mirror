From: Jeff King <peff@peff.net>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 13:57:05 -0400
Message-ID: <20160319175705.GA6989@sigill.intra.peff.net>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 18:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahL9R-0007le-BR
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 18:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbcCSR5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 13:57:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:34644 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932439AbcCSR5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 13:57:10 -0400
Received: (qmail 21115 invoked by uid 102); 19 Mar 2016 17:57:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Mar 2016 13:57:08 -0400
Received: (qmail 21787 invoked by uid 107); 19 Mar 2016 17:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Mar 2016 13:57:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Mar 2016 13:57:05 -0400
Content-Disposition: inline
In-Reply-To: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289318>

On Sat, Mar 19, 2016 at 10:19:02PM +0530, Chirayu Desai wrote:

> > Yeah, I agree that showing the "-h" help is a bit much.
> > This is a side effect of looking up in the commit in the parse-options
> > callback. It has to signal an error to the option parser, and then the
> > option parser always shows the help on an error.
> > I think we'd need to do one of:
> > 1. call die() in the option-parsing callback (this is probably a bad
> > precedent, as the callbacks might be reused from a place that wants
> > to behave differently)
> I assume you mean parse-options-cb.c:parse_opt_commits() by the callback.
> I see that it is currently used only by commands which have a "--with"
> or "--contains" option,
> and all of them behave the same way, printing the full usage, so a one
> line change in that function would fix it for all of those.

Yes, that is the right callback.

> > 2. have the callback just store the argument string, and then resolve
> > the commit later (and die or whatever if it doesn't exist). This
> > pushes more work onto the caller, but in this case it's all done by
> > the ref-filter code, so it could presumably happen during another
> > part of the ref-filter setup.
> I'm not quire sure how exactly to do that.

You'd teach parse_opt_commits() to store the string _name_ of the
argument (e.g., using a string_list rather than a commit_list), and then
later resolve those names into commits.

> > 3. teach parse-options to accept some specific non-zero return code
> > that means "return an error, but don't show the usage"
> This sounds good, but also the most intrusive of 3.

Yeah. Reading the options again, I kind of like this one. The only trick
is that you would need to make sure no other callbacks are returning the
value you choose for the "don't show the usage" flag. That is probably
not too bad, though. There aren't that many callbacks, and they are not
likely to be using values besides "-1" and "0".

-Peff
