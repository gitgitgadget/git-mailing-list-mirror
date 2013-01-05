From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: encode signal death as a positive integer
Date: Sat, 5 Jan 2013 18:12:49 -0500
Message-ID: <20130105231248.GA4140@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
 <20130105140316.GA7272@sigill.intra.peff.net>
 <20130105144949.GA24479@sigill.intra.peff.net>
 <20130105221909.GA3247@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrcvO-0008Pv-8F
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930Ab3AEXMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:12:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44798 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898Ab3AEXMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:12:50 -0500
Received: (qmail 30307 invoked by uid 107); 5 Jan 2013 23:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 18:14:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 18:12:49 -0500
Content-Disposition: inline
In-Reply-To: <20130105221909.GA3247@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212738>

On Sat, Jan 05, 2013 at 02:19:09PM -0800, Jonathan Nieder wrote:

> >  Documentation/technical/api-run-command.txt | 6 ++----
> >  editor.c                                    | 2 +-
> >  run-command.c                               | 2 +-
> >  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> t/test-terminal.perl imitates the same logic.  It doesn't check for
> anything other than whether the exit status is 0, but maybe it would
> be worth squashing in the below as a futureproofing measure
> nonetheless.

Yeah, I think so. As you say, it does not matter, but it makes sense to
keep our conventions consistent.

> Aside from the launch_editor bugfix, the only observable effects of
> the above patch I can find are some changed error messages:
> 
> 	error: external filter cat failed -126
> 	-> error: external filter cat failed 130
> 
> 	warning: svnrdump, returned -126
> 	-> warning: svnrdump, returned 130
> 
> Those messages are equally senseless before and after the patch, so
> for what it's worth,

Thanks. I agree that change isn't a big deal (I would argue the positive
return is slightly more coherent as it matches what the shell would
report, but I really think user-facing errors should probably not even
mention the exact exit code, as it is just noise most of the time, and
we already complain about signals in wait_or_whine).

I did try auditing the callers of finish_command (and run_command) to
make sure I wasn't regressing anybody, but there are a lot of call
sites. In some cases we immediately say:

  if (finish_command(&child))
          die("failed...");

which is obviously unaffected. But in many cases we pass the exit code
up through several levels. It usually just ends up in exit() or being
collapsed to an error boolean, which is fine, but I may have missed a
spot where it matters. I'd expecting cooking this patch for a while
would flush out any I missed.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks (and to J6t) for the review.

-Peff
