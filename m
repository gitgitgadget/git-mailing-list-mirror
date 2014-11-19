From: Jeff King <peff@peff.net>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Wed, 19 Nov 2014 14:15:02 -0500
Message-ID: <20141119191502.GC9908@peff.net>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 20:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrAij-0000yg-CL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 20:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbaKSTPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 14:15:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:42391 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756513AbaKSTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 14:15:04 -0500
Received: (qmail 26138 invoked by uid 102); 19 Nov 2014 19:15:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 13:15:03 -0600
Received: (qmail 6404 invoked by uid 107); 19 Nov 2014 19:15:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 14:15:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 14:15:02 -0500
Content-Disposition: inline
In-Reply-To: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 03:52:33PM +0100, Michael J Gruber wrote:

> "git add foo bar" adds neither foo nor bar when bar is ignored, but dies
> to let the user recheck their command invocation. This becomes less
> helpful when "git add foo.*" is subject to shell expansion and some of
> the expanded files are ignored.
> 
> "git add --ignore-errors" is supposed to ignore errors when indexing
> some files and adds the others. It does ignore errors from actual
> indexing attempts, but does not ignore the error "file is ignored" as
> outlined above.
> 
> Change "git add --ignore-errors foo bar" to add foo when bar is ignored,
> i.e. to ignore the ignore error.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

FWIW, your complaint and this new behavior makes sense to me.

Typically I keep a very neat .gitignore file and just use "git add .",
which _does_ ignore those files. The real problem here is that git
cannot tell the difference between "the user explicitly asked for
foo.aux, so we should complain" and "oops, foo.aux got caught in a shell
expansion".

I almost wonder if skipping ignored files should _always_ be a warning,
not a hard error. I guess that has unpleasant side effects for scripts
which call "git add XXX" and check the exit code, who may be
unpleasantly surprised that they missed out on some content.

Perhaps we could do a hybrid: add the files that were not ignored, but
then still exit non-zero. Careful scripts need to check the exit status
of "git add" anyway, and sloppy humans with over-broad wildcards
typically do not care about the exit status.

-Peff
