From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] utf8: NO_ICONV: silence uninitialized variable warning
Date: Fri, 5 Jun 2015 05:23:09 -0400
Message-ID: <20150605092309.GA11855@peff.net>
References: <1433486536-23447-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 11:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0nqS-0006zU-1u
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 11:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbbFEJXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 05:23:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:41530 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753518AbbFEJXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 05:23:13 -0400
Received: (qmail 23188 invoked by uid 102); 5 Jun 2015 09:23:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 04:23:13 -0500
Received: (qmail 7416 invoked by uid 107); 5 Jun 2015 09:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 05:23:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jun 2015 05:23:09 -0400
Content-Disposition: inline
In-Reply-To: <1433486536-23447-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270819>

On Fri, Jun 05, 2015 at 02:42:16AM -0400, Eric Sunshine wrote:

> The last argument of reencode_string_len() is an 'int *' which is
> assigned the length of the converted string. When NO_ICONV is defined,
> however, reencode_string_len() is stubbed out by the macro:
> 
>     #define reencode_string_len(a,b,c,d,e) NULL
> 
> which never assigns a value to the final argument. When called like
> this:
> 
>     int n;
>     char *s = reencode_string_len(..., &n);
>     if (s)
>         do_something(s, n);
> 
> some compilers complain that 'n' is used uninitialized within the
> conditional.

Hmm, this sounded familiar to me. And indeed:

  http://article.gmane.org/gmane.comp.version-control.git/264095

but I guess we never pushed that topic forward.

> -#define reencode_string_len(a,b,c,d,e) NULL
> +static inline char *reencode_string_len(const char *a, int b,
> +					const char *c, const char *d, int *e)
> +{ if (e) *e = 0; return NULL; }
>  #endif

In the non-NO_ICONV code path we do not set "e" when returning NULL, so
this actually behaves differently than the real function. I'm not
puzzled that the compiler behaves differently (after all, it must assume
that the out-parameter is filled in when it is passed to an extern
function, but with the noop here it can easily see that it is not).

But I am puzzled that the compiler, when given the full code, does not
realize that "s" in your example is always NULL, and the conditional is
dead code.

In the patch linked above, I just initialized the variables in the
callers. Your patch here just unconditionally sets the outsz parameter.
That is certainly fine when NO_ICONV is set (and nicer, because it
contains the fix to one spot), but I wonder if it means we are papering
over a problem in the normal code path. I.e., now that we give the
compiler the extra information about the implementation of
reencode_string_len, it knows to complain.

But I just cannot see any way for it to be a problem. The simple code
example you gave above is quite accurate.

So I think your patch is the best option, but it might be good to give
one more look at the callers to be sure we are not missing something.

-Peff
