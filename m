From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 16:00:31 -0500
Message-ID: <20141203210031.GA6631@peff.net>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:00:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwH2M-0000or-Do
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaLCVAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:00:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:47950 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbaLCVAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:00:34 -0500
Received: (qmail 25096 invoked by uid 102); 3 Dec 2014 21:00:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 15:00:33 -0600
Received: (qmail 32034 invoked by uid 107); 3 Dec 2014 21:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 16:00:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 16:00:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260691>

On Wed, Dec 03, 2014 at 11:01:08AM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > -extern int copy_fd(int ifd, int ofd);
> > +extern int copy_fd(int ifd, int ofd, struct strbuf *err);
> 
> It is not limited to this single function, but what contract do we
> envision this "error messages are given back to the caller via
> strbuf" convention should give between the callers and the callee?
> 
> For example, is it a bug in the callee to touch "err" when there is
> no error to report?  Another example is if we should allow the
> callers to pass NULL there when they do not care about the nature of
> the error (e.g. "git cmd -q").
> 
> There may be other rules we want to enforce consistently across
> functions that adopt this convention.

It seems like we are really re-designing the error-handling chain here.
Maybe it is worth taking a step back and thinking about our overall
strategy.

Why do we dislike errno? Because it is global state, and it is easy for
it to get stomped by unrelated operations.  Another reason is that it
carries no parameters. You see "ENOENT", but you do not have any context
(e.g., which file).

What's good about errno? It is machine-readable (i.e., callers can check
for ENOENT, as opposed to text in a strbuf). It does not require any
allocation. Besides making it slightly more robust, it removes any
responsibility for resource cleanup from the caller.  It's globalness is
also convenient; you do not need to add an extra parameter to each
function to handle errors.

So what are some alternatives?

Passing back "-errno" instead of "-1" helps with the stomping issue (and
without adding extra parameters). It also retains machine-readability
(which I'll call just readability from now on).  But it doesn't help
with context, or better messaging.

Your solution adds a strbuf. That helps with context and stomping, but
loses readability and adds allocation.

If we changed the strbuf to a fixed-size buffer, that would help the
allocation issue. Some messages might be truncated, but it seems
unlikely in practice. It still loses readability, though.

What about a struct that has an errno-like value _and_ a fixed-size
buffer? I'm thinking something like:

  struct error {
	int code;
	char msg[1024];
  };

  /* caller who wants to print the message; no need to free message */
  struct error err;
  if (copy_fd(from, to, &err))
	return error("%s", err.msg);

  /* caller who does not; they can pass NULL */
  if (copy_fd(from, to, NULL))
	return -1;

  /* or they can use it to grab the errno value */
  struct error err;
  if (copy_fd(from, to, &err)) {
	if (err.code == EPIPE)
		exit(141);
	return -1;
  }

  /* function which generates error */
  void read_foo(const char *fn, struct error *err)
  {
	if (open(fn, O_RDONLY))
		return mkerror(err, errno, "unable to open %s", fn);
	... do other stuff ...
	return 0;
  }

  /* helper function for generating errors */
  int mkerror(struct error *err, int code, const char *fmt, ...)
  {
	va_list ap;
	int len;

	if (!err)
		return;

	err->code = code;
	va_start(ap, fmt);
	len = vsnprintf(err->msg, sizeof(err->msg), fmt, ap);
	va_end(ap);

	if (code)
		snprintf(err->msg + len, sizeof(err->msg) - len,
			 ": %s", strerror(code));

	return -1;
  }

You can also take the machine-readable thing a step further, like:

  struct error {
	int code;
	char param1[1024];
	char param2[1024];
	/* 2 parameters should be big enough for anyone, right? */
  }

and then generate the message on the fly when printing. This gives the
callers more information. But it also means defining a constant for
"code" for every error message, which is annoying. Libraries often do
this, but I do not think we need to go that far here.

-Peff
