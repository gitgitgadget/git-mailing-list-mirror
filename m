From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper
	routine
Date: Wed, 18 Jun 2008 18:49:19 -0400
Message-ID: <20080618224919.GA22599@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96Tp-0001og-Jk
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYFRWtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYFRWtW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:49:22 -0400
Received: from peff.net ([208.65.91.99]:4403 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbYFRWtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 18:49:22 -0400
Received: (qmail 13665 invoked by uid 111); 18 Jun 2008 22:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 18 Jun 2008 18:49:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2008 18:49:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85420>

On Wed, Jun 18, 2008 at 03:30:35PM -0700, Linus Torvalds wrote:

> It makes the code a bit easier to read, and in theory a bit faster too
> (no need to compare all the different "core.*" strings against non-core
> config options).

Maybe it would be easier still to read (and unmeasurably more efficient)
to actually do it like:

        if (!prefixcmp(var, "core."))
                return git_default_core_config(var+5, value);
...
int git_default_core_config(const char *var, const char *value)
{
        if (!strcmp(var, "pager"))
                ...

> The config system really should get something of a complete overhaul,
> but in the absense of that, this at least improves on it a tiny bit.

I was curious a while ago and instrumented git_config to write the PID
to a tempfile each time it was called. Most git programs parse the
config files (.git/config, ~/.gitconfig, /etc/gitconfig) three times
each, with some doing it as many as five times.

Most of the config functions are simply "if this key, then set this
value". I wonder if it would be simpler to just load the whole thing at
once, using a table similar to parseopt.

Then we could do useful things like say "you specified core.foobar, but
there is no such variable." I know we can't know all values, since some
non-git programs put values in the config, but I don't think it's
unreasonable for us to claim all of core.*, especially if it helps us
catch simple configuration errors.

-Peff
