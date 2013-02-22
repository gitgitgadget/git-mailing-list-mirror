From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit
 with reviewed-by)
Date: Fri, 22 Feb 2013 13:34:19 -0500
Message-ID: <20130222183419.GB18934@sigill.intra.peff.net>
References: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:34:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8xSJ-00041a-0r
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528Ab3BVSeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:34:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57291 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab3BVSeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:34:21 -0500
Received: (qmail 7059 invoked by uid 107); 22 Feb 2013 18:35:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 13:35:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 13:34:19 -0500
Content-Disposition: inline
In-Reply-To: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216850>

On Fri, Feb 22, 2013 at 09:30:57AM -0800, Joshua Clayton wrote:

> Read and write each 1024 byte buffer, rather than trying to buffer
> the entire content of the file.

OK. Did you ever repeat your timing with a larger symmetric buffer? That
should probably be a separate patch on top, but it might be worth doing
while we are thinking about it.

> Previous code would crash on all files > 2 Gib, when the offset variable
> became negative (perhaps below the level of perl), resulting in a crash.

I'm still slightly dubious of this, just because it doesn't match my
knowledge of perl (which is admittedly imperfect). I'm curious how you
diagnosed it?

> On a 32 bit system, or a system with low memory it might crash before
> reaching 2 GiB due to memory exhaustion.
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Jeff King <peff@peff.net>

The commit message is a good place to mention any side effects, and why
they are not a problem. Something like:

  The previous code buffered the whole blob before writing, so any error
  reading from cat-file would result in zero bytes being written to the
  output stream.  After this change, the output may be left in a
  partially written state (or even fully written, if we fail when
  parsing the final newline from cat-file). However, it's not reasonable
  for callers to expect anything about the state of the output when we
  return an error (after all, even with full buffering, we might fail
  during the writing process).  So any caller which cares about this is
  broken already, and we do not have to worry about them.

> ---
>  perl/Git.pm |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

The patch itself looks fine to me.

-Peff
