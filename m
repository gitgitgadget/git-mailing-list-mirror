From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 10 Dec 2014 14:14:34 -0500
Message-ID: <20141210191434.GA23273@peff.net>
References: <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141203210031.GA6631@peff.net>
 <20141203213858.GC6527@google.com>
 <20141204075920.GA27142@peff.net>
 <54887CB7.4000603@alum.mit.edu>
 <xmqqfvcngwjh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:14:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xymih-0001eZ-1n
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 20:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbaLJTOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 14:14:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:51196 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933022AbaLJTOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 14:14:37 -0500
Received: (qmail 19548 invoked by uid 102); 10 Dec 2014 19:14:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 13:14:37 -0600
Received: (qmail 11958 invoked by uid 107); 10 Dec 2014 19:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 14:14:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 14:14:34 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvcngwjh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261239>

On Wed, Dec 10, 2014 at 11:00:18AM -0800, Junio C Hamano wrote:

> Two potential issues are:
> 
>  - Callers that ignore errors need to actively ignore errors with
>    strbuf_release(&result.msg);

That was my first thought, too. If you want to do anything besides
report_error, you have to deal with the strbuf. But I'd guess that they
often fall into one of two cases:

  1. You are just propagating the error to your caller. In which case
      it is not _your_ result struct in the first place, and you do not
      need to care about deallocating it either way. I.e.:

        int some_func(..., struct result *err)
	{
		if (some_other_func(..., err))
			return -1;
		...
	}

  2. You want to ignore the error. I think anybody taking a result
     struct (or a strbuf, or whatever) should accept NULL as "do not
     bother giving me your message". And the convenience wrappers
     should handle that (I think the mkerror example I sent earlier
     did), so callees can just do:

       return mkerror(err, "whatever: %s", ...);

The remainder could strbuf_release manually, but there would hopefully
not be many of them.

I think I could live with something like that.

>  - Callers have to remember that once the report_errors() function
>    is called on a "struct result", the struct loses its information.
> 
> Neither is insurmountable, but the latter might turn out to be
> cumbersome to work around in some codepaths.

I suspect the message is not that interesting after calling
report_errors(). The "code" flag could remain, as it does not require
deallocation.

> Another alternative may be to have the reporting storage on the side
> of the callee, and have callers that are interested in errors to
> supply a place to store a pointer to it, i.e.
> 
> 	int some_func(..., struct result **errors) {
>         	static struct result mine;

This makes some_func not reentrant. Which is a hazard both for threaded
code, but also for functions which want to do:

  if (some_func(foo, &err_one)) {
          /* didn't work? Try an alternative. */
	  if (!some_func(bar, &err_two))
	          ....

and expect err_one to contain anything useful.
