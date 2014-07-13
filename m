From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Sun, 13 Jul 2014 13:33:56 -0400
Message-ID: <20140713173356.GA8406@sigill.intra.peff.net>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 19:34:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Nf3-0004Lr-O1
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 19:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaGMReA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 13:34:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:33168 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751103AbaGMRd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 13:33:58 -0400
Received: (qmail 28975 invoked by uid 102); 13 Jul 2014 17:33:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 12:33:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 13:33:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253453>

On Sun, Jul 13, 2014 at 10:10:27AM -0700, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> Made parse_sort_string take a "var" parameter, and if given will only warn
> >> about invalid parameter, instead of error.
> >
> > This seems unnecessarily ugly since it's hard-coding specialized
> > knowledge of the callers' error-reporting requirements into what
> > should be a generalized parsing function. If you instead make
> > parse_sort_string() responsible only for attempting to parse the
> > value, but leave error-reporting to the callers, then this ugliness
> > goes away. See below.
> 
> Yup, you are absolutely right.  Thanks for catching my silly.

I do not know if it is that silly. The reason we push the error
reporting down into reusable library functions, even though it is less
flexible or causes us to have "quiet" flags and such, is that the
library function knows more about the specific error.

In this case we are just saying "your sort specification is not valid",
so it is not adding much value, and returning "-1" provides enough
information for the caller to say that.  But would we eventually want to
diagnose errors more specifically? For example, in "foo:refname", we
could complain that "foo" is not a valid sort function. And in
"version:bar", we could complain that "bar" is not a valid sorting atom.

We can encode these error types into an enum, but it is often much
easier to report them at the time of discovery (e.g., because you have
the half-parsed string available that says "foo" or "bar"). This is a
general problem throughout a lot of our code.  In higher level languages
you might throw an exception with the error message and let the caller
decide how to report it. I wonder if it is too gross to do something
like:

  push_error_handler(collect_errors);

  /* all calls to error() in will push error text onto a stack */
  do_something();

  pop_error_handler();

  /* traverse the list, calling warning() on each, and clear the stack */
  print_errors_as_warnings();

One can imagine print_errors_as_errors, which would be useful when a
caller is not sure whether a full operation will succeed (e.g., you try
X, then Y, and only when both fail do you report an error). Or a caller
which does not call any print_error_* at all (i.e., replacing the
"quiet" flag that many library functions take).

I realize that I am reinventing the error-reporting wheel on a sleepy
Sunday afternoon without having thought about it much, so there is
probably some gotcha or case that makes this ugly, or perhaps it just
ends up verbose in practice. But one can dream.

-Peff
