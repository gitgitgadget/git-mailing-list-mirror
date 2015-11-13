From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 17:27:49 -0500
Message-ID: <20151113222748.GA14830@sigill.intra.peff.net>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
 <20151113062534.GE32157@sigill.intra.peff.net>
 <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Users <git@vger.kernel.org>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 23:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxMp2-0001rl-0n
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 23:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbKMW1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 17:27:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:57288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750907AbbKMW1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 17:27:51 -0500
Received: (qmail 12943 invoked by uid 102); 13 Nov 2015 22:27:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 16:27:51 -0600
Received: (qmail 29166 invoked by uid 107); 13 Nov 2015 22:28:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:28:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 17:27:49 -0500
Content-Disposition: inline
In-Reply-To: <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281266>

On Fri, Nov 13, 2015 at 04:25:18PM +0100, Fredrik Medley wrote:

> >> -             ${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
> >> +             "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
> >
> > I think this is the right thing to do (at least I could not think of a
> > case that would be harmed by it, and it certainly fixes your case). It
> > looks like filter-branch would need a similar fix?
> >
> > I think this still isn't resilient to weird meta-characters in the
> > @SHELL_PATH@, but as this is a build-time option, I think it's OK to let
> > people who do
> >
> >   make SHELL_PATH='}"; rm -rf /'
> >
> > hang themselves.
> >
> > -Peff
> 
> Okay, that's what @SHELL_PATH@ stands for. I just read the result
> in the Windows installation that is something like ${SHELL:-/bin/sh}.
> The shell script processor then replaces /bin/sh with
> C:\Program Files\...\bin\sh.

Hmm. Now I'm a bit puzzled. It sounds like the installed file does have
@SHELL_PATH@ set to /bin/sh, which is normal. And presumably the setting
containing space is coming from the $SHELL environment variable.

My original "I could not think of a case harmed by it" was because
@SHELL_PATH@ also gets used on the shebang line at the beginning of the
script. And that does not really handle command names with arguments
well (you get one argument, and it better not have spaces in it). Of
course, it _also_ does not handle command names with spaces in them,
either (and there's no room for quoting there).

So anything exotic pretty much has to be coming in from $SHELL, and my
mention of filter-branch is not interesting; it just uses @SHELL_PATH@.

So what are people putting in $SHELL? Obviously a shell path with a
space in it wants the quotes. Do people do more exotic things like:

  SHELL="my-shell --options"

(I think a plausible option might be "--posix" for some shells).  That
would break with your patch.

I dunno. We usually try to err on the side of the status quo, so as to
avoid breaking existing users. But I find the idea of $SHELL with
options reasonably unlikely, so I think your patch is the right
direction. I wish I understood better who was setting $SHELL and why,
though.

-Peff
