From: Jeff King <peff@peff.net>
Subject: Re: rfe: git-config: lack of color reset option
Date: Mon, 20 Feb 2012 16:20:06 -0500
Message-ID: <20120220212006.GB6335@sigill.intra.peff.net>
References: <alpine.LNX.2.01.1202202142160.31585@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Feb 20 22:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzaeg-0001vU-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab2BTVUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 16:20:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44190
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab2BTVUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 16:20:10 -0500
Received: (qmail 7193 invoked by uid 107); 20 Feb 2012 21:20:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 16:20:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 16:20:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.01.1202202142160.31585@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191106>

On Mon, Feb 20, 2012 at 09:50:11PM +0100, Jan Engelhardt wrote:

> given the following config:
> 
> [color "diff"]
> 	commit = bold white blue
> [color "decorate"]
> 	branch = green
> 
> The attributes from color.diff.commit are inherited for color.decorate.

This is an artifact of the way the ANSI colorizing works. Git says "turn
on bold white and a blue background", then it outputs some content, then
it says "turn on green", and so forth. At the end we issue a "reset" to
turn everything back to normal. We should perhaps issue a reset before
outputting the decoration, as we are moving from one colorized bit to
the other, and we don't know what we are inheriting.

Of course that would break people who _want_ the blue background to
continue into the branch decoration. But they can easily fix it by
putting "green blue" in their config.

> 1. There seems to be no way to reset the attributes such that
> "color.decorate.branch = default green blue" wouuld have an effect.

I would have expected that perhaps setting color.decorate.branch to
"reset green" would work, but it seems that we don't allow arbitrary
sequences. Which would be another possible solution.

In your case, I think you just want turn off bold without resetting the
whole thing. That is its own attribute. It would be nice if we supported
"nobold", "noreverse", etc. But you wouldn't really need them if we
properly reset at the transition between two colorized bits.

> 2. It would be nice if there was an option to only paint the 
> commit hash, rather than the entire line including the decorate 
> parenthesis group.

Yeah, the parentheses are explicitly painted. I'm not sure how to easily
fix that short of adding lots of painfully small config options.

I have a long term dream that our --pretty=format specifiers would grow
featureful enough that all of the other --pretty formats could be
implemented in terms of them. And then you could tweak to your hearts
content, starting with the embedded definition of what "git log" shows
and putting colors wherever you like. I'm not sure how far we are off
from doing that now. You could try writing a format-specifier that looks
like git-log output and see if there is anything lacking.

-Peff
