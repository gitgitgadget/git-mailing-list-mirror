From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Thu, 4 Dec 2014 02:59:20 -0500
Message-ID: <20141204075920.GA27142@peff.net>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141203210031.GA6631@peff.net>
 <20141203213858.GC6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 08:59:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRJz-0000CH-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 08:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbaLDH7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 02:59:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:48192 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753153AbaLDH7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 02:59:23 -0500
Received: (qmail 19887 invoked by uid 102); 4 Dec 2014 07:59:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 01:59:23 -0600
Received: (qmail 4329 invoked by uid 107); 4 Dec 2014 07:59:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 02:59:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 02:59:20 -0500
Content-Disposition: inline
In-Reply-To: <20141203213858.GC6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260730>

On Wed, Dec 03, 2014 at 01:38:58PM -0800, Jonathan Nieder wrote:

> > What about a struct that has an errno-like value _and_ a fixed-size
> > buffer? I'm thinking something like:
> >
> >   struct error {
> > 	int code;
> > 	char msg[1024];
> >   };
> 
> My experience with errno is that it is very hard to anticipate what
> granularity to use with error codes, especially if the error code is
> going to (in some contexts) determine the message printed to the user.
> In practice, it is easier to come up with a message at the error
> detection site and use a generic "something happened" error code
> except in those places where the caller is going to act on specific
> error types that need to be distinguished.

Yeah, I agree. I think error.msg there would be the main use, and
error.code is just gravy. I agree it could simply come back through the
integer return value, too.

> The "< 0 means error" convention gives room to use different exit
> codes for the errors that need to be programmatically distinguished.
> For example, the ref transaction API uses this to distinguish D/F
> conflicts from other errors, while still returning an error message
> through a strbuf output parameter.

Yup. One nice thing about stuffing it into the error struct is that it
saves the caller from declaring a separate variable (assuming they need
"err" anyway to collect the message). I.e.:

  struct error err;

  if (some_func(fd, &err))
	react_to(err.code);

as opposed to:

  struct error err;
  int ret;

  ret = some_func(fd, &err);
  if (ret)
	react_to(ret);

But I think it's a minority of cases where we care about the specific
value anyway, so it's probably not a big deal either way.

> > If we changed the strbuf to a fixed-size buffer, that would help the
> > allocation issue. Some messages might be truncated, but it seems
> > unlikely in practice. It still loses readability, though.
> 
> I don't like the idea of having to choose a size in advance and not
> being able to fit more detailed (perhaps language-specific, and
> including user-specified input) messages lest the buffer overflow.

Is that really a problem in practice? Is a message larger than 1024
characters actually readable? It would have to be broken across many
lines, and then I think we are no longer dealing with an error message,
but some advice (which probably shouldn't go through this mechanism
anyway).

> The allocation of a variable-sized buffer is a small overhead that I
> don't mind incurring on error.  In the non-error case, the caller
> doesn't actually have to free the buffer, and if they choose to, the
> overhead incurred is that of free(NULL)'.

I don't care at all about overhead. I care about extra work on the part
of the caller to avoid a leak. It turns:

  if (some_func(fd, &err))
	return error("%s", err.msg);

into:

  if (some_func(fd, &err)) {
	error("%s", err.buf);
	strbuf_release(&err);
	return -1;
  }

It may make things a little easier when an intermediate function has
to further munge the message. For example, your 04/14 uses
strbuf_prefixf. But that can also be expressed in a buffer world as:

  /* "parent_err" is passed to us from caller, "err" is a local buffer */
  if (copy_fd(orig, fd, &err))
	return mkerror(&parent_err, "cannot copy '%s': %s", path, err.msg);

Strbufs make more complicated munging possible, but I'd expect prefixing
to be the most common case (except for not munging at all, which I think
is even more common).

I dunno. I just hate to see a system where it's very easy for callers to
introduce memory leaks by forgetting a strbuf_release, or that bogs
callers down with error-handling boilerplate.

-Peff
