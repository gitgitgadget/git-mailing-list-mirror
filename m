From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Mon, 12 May 2014 14:56:45 -0400
Message-ID: <20140512185645.GA32569@sigill.intra.peff.net>
References: <20140505212938.GA16715@sigill.intra.peff.net>
 <20140506151441.GA25768@sigill.intra.peff.net>
 <20140512184426.GO9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvPA-0005LP-BU
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbaELS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 14:56:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:50093 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752721AbaELS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:56:48 -0400
Received: (qmail 17634 invoked by uid 102); 12 May 2014 18:56:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 13:56:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 14:56:45 -0400
Content-Disposition: inline
In-Reply-To: <20140512184426.GO9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248722>

On Mon, May 12, 2014 at 11:44:26AM -0700, Jonathan Nieder wrote:

> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -331,7 +331,11 @@ extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)))
> >   * using the function as usual.
> >   */
> >  #if defined(__GNUC__) && ! defined(__clang__)
> > -#define error(...) (error(__VA_ARGS__), -1)
> > +static inline int const_error(void)
> > +{
> > +	return -1;
> > +}
> > +#define error(...) (error(__VA_ARGS__), const_error())
> 
> I wish we could just make error() an inline function that calls some
> print_error() helper, but I don't believe all compilers used to build
> git are smart enough to inline uses of varargs.  So this looks like
> the right thing to do.

Not just "not all compilers", but "not even gcc". If you declare it
always_inline, gcc will even complain "you can't do that, it has
varargs".

For my curiosity, is there any compiler which _does_ inline varargs
calls? Clang would be the obvious guess.

> I kind of wish we weren't in so much of an arms race with static
> analyzers.  Is there some standard way to submit our code as "an idiom
> that should continue not to produce warnings" to be included in a
> testsuite and prevent problems in the future?

I agree the arms race is frustrating, but I think the compiler is being
completely reasonable in this case. It has flagged code where it knows
a variable may be uninitialized depending on the return value from
error(). The only reason I as a human know it's a false positive is that
I know error() will always return -1. So it's not an idiom here, so much
as letting the compiler know everything we know.

It would just be nice if there was an easier way to do it.

I do think giving the compiler that information is nicer than an
attribute saying "trust me, it's initialized". The constant return not
only silences the warnings, but it may actually let the compiler produce
better code (both in these cases, but in the hundreds of other spots
that call error()).

-Peff
