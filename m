From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 14:21:04 -0500
Message-ID: <20111216192104.GA19924@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:21:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdLF-0001Kp-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572Ab1LPTVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:21:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44257
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760557Ab1LPTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:21:07 -0500
Received: (qmail 6993 invoked by uid 107); 16 Dec 2011 19:27:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 14:27:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 14:21:04 -0500
Content-Disposition: inline
In-Reply-To: <4EEB4F13.2010402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187302>

On Fri, Dec 16, 2011 at 03:00:51PM +0100, Johannes Sixt wrote:

> Am 12/16/2011 12:00, schrieb Jeff King:
> >  static const char *builtin_attr[] = {
> ...
> > +	"*.c diff=cpp",
> > +	"*.cc diff=cpp",
> > +	"*.cxx diff=cpp",
> > +	"*.cpp diff=cpp",
> > +	"*.h diff=cpp",
> > +	"*.hpp diff=cpp",
> 
> Please don't do this. It would be a serious regression for C++ coders, and
> some C coders as well. The built-in hunk header patterns are severly
> broken and don't work well with C++ code. I know for sure that the
> following are not recognized:
> 
> - template declarations, e.g. template<class T> func(T x);
> - constructor definitionss, e.g. MyClass::MyClass()
> - functions that return references, e.g. const string& func()
> - function definitions along the GNU coding style, e.g.
> 
>      void
>      the_func ()

Hmm. I think it's a legitimate criticism to say "hunk-header detection
is a broken feature because our heuristics aren't good enough, and we
shouldn't start using it by default because people will complain because
it sucks too much".

At the same time, I think we have seen people complaining that the
regular dumb funcname detection is not good enough[1], and that using
language-specific funcnames, while not 100% perfect, produces better
results on the whole.

So I think rather than saying "this doesn't always work", it's important
to ask "on the whole, does this tend to produce better results than
without, and when we are wrong, how bad is it?"

I'm not clear from what you wrote on whether you were saying it is
simply sub-optimal, or whether on balance it is way worse than the
default funcname matching.

And if it is bad on balance, is the right solution to avoid exposing
people to it, or is it to make our patterns better? I.e., is it fixable,
or is it simply too hard a problem to get right in the general case, and
we shouldn't turn it on by default?

> I am currently using this pattern (but I'm sure it can be optimized) with
> an appropriate xcpp attribute:
> 
> [diff "xcpp"]
>         xfuncname = "!^[
> \\t]*[a-zA-Z_][a-zA-Z_0-9]*[^()]*:[[:space:]]*$\n^[a-zA-Z_][a-zA-Z_0-9]*.*"

So, I'm confused. If you are using this, surely you have "*.c diff=xcpp"
in your attributes file, and my patch has no effect for you, as it is
lower precedence than user-supplied gitattributes? Also, if you called
it diff.cpp.xfuncname, then wouldn't my patch still be useful, as your
complaint is not "my *.c files are not actually C language" but "the C
language driver sucks" (but you be remedying that by providing your own
config).

-Peff
