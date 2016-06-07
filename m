From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:55:37 -0400
Message-ID: <20160607215536.GA20768@sigill.intra.peff.net>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: santiago@nyu.edu, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:56:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOyO-0002kP-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933308AbcFGVzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:55:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:50845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933273AbcFGVzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:55:40 -0400
Received: (qmail 10272 invoked by uid 102); 7 Jun 2016 21:55:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:55:39 -0400
Received: (qmail 2149 invoked by uid 107); 7 Jun 2016 21:55:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 17:55:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 17:55:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296731>

On Tue, Jun 07, 2016 at 02:50:23PM -0700, Junio C Hamano wrote:

> >> Or it could even do this:
> >> 
> >> 	tag="$1"
> >> 	if ! git tag -v "$tag"
> >> 	if ! git tag -v "$tag"
> >>         then
> >> 		echo >&2 "Bad tag."
> >>                 exit 1
> >> 	fi
> >> +	tag=$(git tag --show-tagname $tag)
> >> 	make dest=/usr/local/$package/$tag install
> >
> > It is racy. That probably doesn't matter for most callers, but it would
> > be nice to be able to get a custom format out of the "-v" invocation.
> 
> Heh, you can do
> 
> -	tag="$1"
> +	tag=$(git rev-parse --verify "$1")
> 
> upfront and it no longer is racy, no?

Yes, though that doesn't quite work today. The formatted output comes
from "tag -l", which wants a refname. You can almost use "git show", but
its format specifiers don't do tag parsing (they probably should).
Likewise you can't use cat-file, as it doesn't do any intra-object
parsing at all (which arguably it should).

I'm still not sure I like the direction, simply because it requires 3
invocations of git to accomplish this task (which is inefficient in
terms of processes, but also just means the interface is a bit tedious
to work with; we could be making this easier for the caller).

-Peff
