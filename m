From: Jeff King <peff@peff.net>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 18:16:57 -0400
Message-ID: <20160329221657.GA31811@sigill.intra.peff.net>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net>
 <20160329205208.GF1578@serenity.lan>
 <20160329212143.GA30116@sigill.intra.peff.net>
 <20160329220003.GG1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elliott Cable <me@ell.io>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:17:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al1wg-0007py-D3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcC2WRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:17:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:40328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752307AbcC2WRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:17:00 -0400
Received: (qmail 13972 invoked by uid 102); 29 Mar 2016 22:17:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 18:17:00 -0400
Received: (qmail 28627 invoked by uid 107); 29 Mar 2016 22:16:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 18:16:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 18:16:57 -0400
Content-Disposition: inline
In-Reply-To: <20160329220003.GG1578@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290203>

On Tue, Mar 29, 2016 at 11:00:03PM +0100, John Keeping wrote:

> > We seem to get that wrong. I'm also not sure if it would make sense if
> > you explicitly set the two to be equal, like:
> > 
> >   # checking in your own refs?
> >   GIT_WORK_TREE=$(pwd) GIT_DIR=$(pwd) git add refs packed-refs
> > 
> > So the current behavior may just be weird-but-true.
> 
> This case definitely feels wrong:
> 
> 	$ GIT_WORK_TREE=$(cd ..; pwd) GIT_DIR=$(pwd) git rev-parse --is-inside-git-dir
> 	false

Yeah, and not just the is-inside-git-dir test:

  $ echo content >../file
  $ GIT_WORK_TREE=$(cd ..; pwd) GIT_DIR=$(pwd) git add file
  fatal: pathspec 'file' did not match any files

I'd expect that to work, and it doesn't, because we pass ".git/" as the
"prefix" to cmd_add(). Which I guess is true, but it feels kind of weird
(I think most people who set both variables like that would generally
point to some other directory entirely, and we would have a NULL
prefix).

The --is-inside-git-dir thing is related, but a different problem. I
just got your follow-up mentioning that it doesn't take the prefix into
account, which I agree it probably should.

-Peff
