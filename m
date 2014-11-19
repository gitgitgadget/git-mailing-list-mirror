From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] error: save and restore errno
Date: Wed, 19 Nov 2014 13:28:12 -0500
Message-ID: <20141119182812.GA9425@peff.net>
References: <20141119013532.GA861@peff.net>
 <20141119013710.GA2135@peff.net>
 <20141119014344.GP6527@google.com>
 <20141119014722.GB2337@peff.net>
 <xmqqvbmbrrba.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr9zT-0008Ek-9w
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaKSS21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:28:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:42352 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752315AbaKSS2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:28:14 -0500
Received: (qmail 24150 invoked by uid 102); 19 Nov 2014 18:28:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 12:28:14 -0600
Received: (qmail 5995 invoked by uid 107); 19 Nov 2014 18:28:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 13:28:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 13:28:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbmbrrba.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 10:14:17AM -0800, Junio C Hamano wrote:

> >> What the above doesn't explain is why the caller cares about errno.
> >> Are they going to print another message with strerror(errno)?  Or are
> >> they going to consider some errors non-errors (like ENOENT when trying
> >> to unlink a file), in which case why is printing a message to stderr
> >> okay?
> >
> > I guess the unsaid bit is:
> >
> >   Unfortunately this may clobber the errno from the open() call. Even
> >   though error() sees the correct errno, the caller to which we are
> >   returning may see a bogus errno value.
> >
> I am not sure if that answers the question asked.
> 
> If you have
> 
> 	int frotz(...) {
> 		int fd = open(...);
>         	if (fd < 0)
>                 	return error("open failed (%s)", strerror(errno));
> 		return fd;
> 	}
> 
> and the caller calls it and cares about the errno from this open,
> what does the caller do?  Jonathan's worried about a codepath that
> may be familiar to us as we recently saw a patch similar to it:
> 
> 	int fd = frotz(...);
>         if (fd < 0) {
>         	if (errno == ENOENT || errno == EISDIR)
>                 	; /* not quite an error */
> 		else
> 			exit(1);
> 	}
> 
> If ENOENT/EISDIR is expected and a non-error, it is not useful for
> frotz() to give an error message on its own.

Sure, but isn't that out-of-scope for this patch? We know that some
functions _are_ calling error() and taking care to keep errno valid, and
we would prefer to do that with less work.

If you are arguing "there are literally zero cases where that makes
sense; functions should either complain themselves, _or_ they should
pass on a valid errno so the caller can decide whether to complain, but
doing both is a recipe for pointless and unwanted error messages", then
this patch is counter-productive (and we should be fixing those call
sites of error() instead).

But I am not sure that there are zero legitimate cases. Just as a
hypothetical, imagine you wanted to complain to stderr _and_ propagate
the error value into a specific exit code. You'd want something like:

  fd = frotz(...);
  error("frotz failed (%s)", strerror(errno));
  exit(errno == ENOENT ? 1 : 2);

Granted, I do not think we do that particular pattern in git, but we do
take pains to save errno across some error() calls. I do not know which
of those are legitimate and which should be refactored. In the meantime,
I do not think this patch makes anything worse.

> I think a more appropriate answer to Jonathan's question is why is
> the callee (i.e. frotz()) calling error() in the first place if an
> unconditional error message is an issue.

Exactly. It is not error()'s business to know what the caller wants to
do, or whether or why it cares about retaining errno. But error(), since
it is designed to be called in error codepaths, should aim to be
minimally intrusive.

-Peff
