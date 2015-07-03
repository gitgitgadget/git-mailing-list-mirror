From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: do not leak "GIT_PAGER_IN_USE" to the pager
Date: Fri, 3 Jul 2015 13:56:27 -0400
Message-ID: <20150703175627.GA9223@peff.net>
References: <xmqqk2uh5fd6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5Cc-00023x-84
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbbGCR4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:56:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:55414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755258AbbGCR4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:56:31 -0400
Received: (qmail 17018 invoked by uid 102); 3 Jul 2015 17:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 12:56:30 -0500
Received: (qmail 14602 invoked by uid 107); 3 Jul 2015 17:56:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 13:56:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jul 2015 13:56:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2uh5fd6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273305>

On Fri, Jul 03, 2015 at 10:18:45AM -0700, Junio C Hamano wrote:

> Since 2e6c01e2, we export GIT_PAGER_IN_USE so that a process that

I imagine you mean 2e6c012e here.

> becomes the upstream of the spawned pager can still tell that we
> have spawned the pager and decide to do colored output even when
> its output no longer goes to a terminal (i.e. isatty(1)).
> 
> But we forgot to clear it from the enviornment of the spawned pager.
> This is not a problem in a sane world, but if you have a handful of
> thousands Git users in your organization, somebody is bound to do
> strange things, e.g. typing "!<ENTER>" instead of 'q' to get control
> back from $LESS.  GIT_PAGER_IN_USE is still set in that subshell
> spawned by "less", and all sorts of interesting things starts
> happening, e.g. "git diff | cat" starts coloring its output.
> 
> We can clear the environment variable in the half of the fork that
> runs the pager to avoid the confusion.

I think this is a reasonable fix. I guess it would be possible that some
pager would want to react differently depending on the variable, but I
could not think of a useful case. And certainly your pager, being the
pager itself, can assume that the pager is in use. ;) At the very worst,
somebody can set GIT_PAGER="GIT_PAGER_IN_USE=1 my-pager" if they truly
want to do something bizarre.

So,

Acked-by: Jeff King <peff@peff.net>

-Peff
