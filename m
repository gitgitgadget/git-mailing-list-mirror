From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Thu, 12 Jun 2008 00:49:33 -0400
Message-ID: <20080612044932.GA25992@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806092319.23906.johan@herland.net> <20080610110553.GA13655@sigill.intra.peff.net> <200806111102.31481.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 12 06:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6elZ-0002MG-Ag
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 06:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYFLEtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 00:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYFLEtf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 00:49:35 -0400
Received: from peff.net ([208.65.91.99]:1163 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYFLEtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 00:49:35 -0400
Received: (qmail 3945 invoked by uid 111); 12 Jun 2008 04:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 00:49:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 00:49:33 -0400
Content-Disposition: inline
In-Reply-To: <200806111102.31481.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84698>

On Wed, Jun 11, 2008 at 11:02:29AM +0200, Thomas Rast wrote:

> However, as in the earlier versions, the hunk is placed in the editing
> loop again.  In this version, I made it so it will be marked for use
> as if you had entered 'y', so if it was the last (or only) hunk, the
> files will be patched immediately.  But if you Ctrl-C out in the
> middle, nothing has been changed yet.

OK, I really think this is the most sane behavior. It naturally follows
what the user wants (if they edit, they then want to apply), but it
still waits until the end of the loop, so they can back out if they
want.

> By the way, current 'add -p' recounts the headers to account for all
> hunks that the user answered 'n'.  I haven't given it enough thought
> to put it in the code yet, but it may be possible to rip that out as
> well and unconditionally --recount.  Only the preimage line numbers
> matter, and those never change.

Ah, I hadn't thought about that, but of course it makes sense that it
would need to recount (I guess I should have looked a little more
closely at the other code). I think replacing that with --recount would
be great, but it should be a separate patch, and we should wait for
--recount to stabilize (all of this should be post 1.5.6, anyway).

> +# If the patch applies cleanly, the hunk will immediately be marked
> +# for staging as if you had answered 'y'.  (However, if you remove
> +# everything, nothing happens.)  Otherwise, you will be asked to edit
> +# again.

This "however" confused me the first time I read it. I assume you mean
that "if the diff is empty, then staging it will do nothing"? I wonder
if that is even worth mentioning, since it seems obvious.

Although I guess you do special-case "no lines" later on.

> +# Do not add @ lines unless you know what you are doing.  The original
> +# @ line will be reinserted if you remove it.

This can probably be moved from the "every time" instructions to the
manual, if we want to keep the size of the instructions a bit smaller.

> +		if (diff_applies($head,
> +				 @{$hunk}[0..$ix-1],
> +				 $newhunk,
> +				 @{$hunk}[$ix+1..$#{$hunk}])) {

I'm confused here...we are feeding _all_ of the hunks to git-apply. In
my patch, I simply fed the hunk of interest. Since we are recounting,
shouldn't the single hunk be enough? And if it isn't, then shouldn't we
be feeding only the hunks that are to be applied?

> +			my @display = color_diff(@{$text});
> +			$newhunk->{DISPLAY} = \@display;

Perl nit: you can create an arrayref with brackets:

  $newhunk->{DISPLAY} = [color_diff(@$text)];

> +		open $fh, '| git apply --cached'
> +			. ($need_recount ? ' --recount' : '');

Nice. I think this is much cleaner.

-Peff
