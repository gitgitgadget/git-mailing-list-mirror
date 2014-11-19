From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] error: save and restore errno
Date: Tue, 18 Nov 2014 20:47:23 -0500
Message-ID: <20141119014722.GB2337@peff.net>
References: <20141119013532.GA861@peff.net>
 <20141119013710.GA2135@peff.net>
 <20141119014344.GP6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquMi-0004Nk-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbaKSBrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:47:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:42089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753850AbaKSBrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:47:25 -0500
Received: (qmail 10467 invoked by uid 102); 19 Nov 2014 01:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:47:24 -0600
Received: (qmail 25656 invoked by uid 107); 19 Nov 2014 01:47:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:47:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:47:23 -0500
Content-Disposition: inline
In-Reply-To: <20141119014344.GP6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 05:43:44PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > It's common to use error() to return from a function, like:
> >
> > 	if (open(...) < 0)
> > 		return error("open failed");
> >
> > Unfortunately this may clobber the errno from the open()
> > call. So we often end up with code like this:
> >
> >         if (open(...) < 0) {
> > 		int saved_errno = errno;
> > 		error("open failed");
> > 		errno = saved_errno;
> > 		return -1;
> > 	}
> >
> > which is less nice.
> 
> What the above doesn't explain is why the caller cares about errno.
> Are they going to print another message with strerror(errno)?  Or are
> they going to consider some errors non-errors (like ENOENT when trying
> to unlink a file), in which case why is printing a message to stderr
> okay?

I guess the unsaid bit is:

  Unfortunately this may clobber the errno from the open() call. Even
  though error() sees the correct errno, the caller to which we are
  returning may see a bogus errno value.

-Peff
