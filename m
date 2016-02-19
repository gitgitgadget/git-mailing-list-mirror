From: Jeff King <peff@peff.net>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 06:59:29 -0500
Message-ID: <20160219115928.GA10204@sigill.intra.peff.net>
References: <20160207162540.GK29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:59:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjik-0005ym-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948540AbcBSL7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:59:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:45353 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1948535AbcBSL7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:59:32 -0500
Received: (qmail 22858 invoked by uid 102); 19 Feb 2016 11:59:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:59:31 -0500
Received: (qmail 27262 invoked by uid 107); 19 Feb 2016 11:59:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:59:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:59:29 -0500
Content-Disposition: inline
In-Reply-To: <20160207162540.GK29880@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286709>

On Sun, Feb 07, 2016 at 04:25:40PM +0000, John Keeping wrote:

> It seems that binary file detection has changed in GNU grep 2.23 as a
> result of commit 40ed879 (grep: fix bug with with invalid unibyte
> sequence).

I read this bug report a while ago when you posted it, but happily
ignored it until today, when my debian unstable system pulled in the new
version of grep. :)

> This causes a couple of test failures in t8005 and t9200 (the t9200 case
> is less obvious so I'm only including t8005 here):
> 
> -- >8 --
> $ ./t8005-blame-i18n.sh -v -i
> [snip]
> expecting success: 
>         git blame --incremental file | \
>                 egrep "^(author|summary) " > actual &&
>         test_cmp actual expected

Just a side note while we are touching these tests:

 - we probably should not pipe, so we check the exist code from
   git-blame

 - we usually flip the test_cmp file order, to show the difference from
   expectation when there is a failure

 - no space after ">" redirection :)

> The following patch fixes the tests for me, but I wonder if "-a" is
> supported on all target platforms (it's not in POSIX, which specifies
> that the "input files shall be text files") or whether we should do
> something more comprehensive to provide sane_{e,f,}grep which guarantee
> to treat input as text.
> 
> I also tried setting POSIXLY_CORRECT but that doesn't affect the
> text/binary decision.

Yeah, I'd worry that "-a" is not portable. OTOH, BSD grep seems to have
it, so between that and GNU, I think most systems are covered. We could
do:

  test_lazy_prereq GREP_A '
	echo foo | grep -a foo
  '

and mark these tests with it. I'd also be happy to skip that step and
just do it if and when somebody actually complains about a system
without it (I wouldn't be surprised if most people on antique systems
end up installing GNU grep anyway).

Another option might be using "sed -ne '/^author/p'" or similar. But
that may very well just be trading one portability problem for another.

I also wondered whether we could get away without grepping at all here.
But the blame output has a bunch of cruft we don't care about; I think
the readability of the tests would suffer if we tried to match the whole
thing in a test_cmp.

-Peff
