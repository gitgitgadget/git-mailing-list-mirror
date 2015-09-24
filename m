From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5561: get rid of racy appending to logfile
Date: Thu, 24 Sep 2015 14:23:06 -0400
Message-ID: <20150924182306.GA15647@sigill.intra.peff.net>
References: <20150924014541.GB6442@sigill.intra.peff.net>
 <1443118342-3856-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 20:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfBAo-0003iE-B0
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 20:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832AbbIXSXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 14:23:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:35816 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755331AbbIXSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 14:23:08 -0400
Received: (qmail 1306 invoked by uid 102); 24 Sep 2015 18:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 13:23:08 -0500
Received: (qmail 27828 invoked by uid 107); 24 Sep 2015 18:23:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 14:23:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 14:23:06 -0400
Content-Disposition: inline
In-Reply-To: <1443118342-3856-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278553>

On Thu, Sep 24, 2015 at 08:12:22PM +0200, Stephan Beyer wrote:

> The definition of log_div() appended information to the web server's
> logfile to make the test more readable. However, log_div() was called
> right after a request is served (which is done by git-http-backend);
> the web server waits for the git-http-backend process to exit before
> it writes to the log file. When the duration between serving a request
> and exiting was long, the log_div() output was written before the last
> request's log, and the test failed. (This duration could become
> especially long for PROFILE=GEN builds.)
> 
> To get rid of this behavior, we should not change the logfile at all.
> This commit removes log_div() and its calls. The additional information
> is kept in the test (for readability reasons) but filtered out before
> comparing it to the actual logfile.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  Okay Peff, I added the information to the commit message (in my own
>  words). Past tense for the situation before the patch, present tense
>  for the situation after (hope that's right but should not be too
>  important).
> 
>  I also used your proposed grep line because it is probably more robust.

This all looks good to me. Thanks so much for working on this.

> -cat >exp <<EOF
> +grep '^[^#]' >exp <<EOF

One quick note for others who are reviewing: this violates our usual
advice to use "<<-\EOF" for here-docs, but I think it's best as-is.

We can't use "\" here because we _do_ want interpolation. The reason to
use "<<-" is to match indentation with the rest of the test block. This
particular content is outside a test block, which is something we
typically avoid. But in this case, the expected content is essentially
the whole of the script, and I think it reads a little more easily
outside.

So I don't think there is anything to change, but I wanted to point out
my thought process so other reviewers don't end up repeating it.

-Peff
