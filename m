From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Wed, 10 Feb 2010 00:39:37 -0500
Message-ID: <20100210053937.GF28526@coredump.intra.peff.net>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:43:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf5Md-00019S-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab0BJFji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:39:38 -0500
Received: from peff.net ([208.65.91.99]:51740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab0BJFjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:39:37 -0500
Received: (qmail 31280 invoked by uid 107); 10 Feb 2010 05:39:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:39:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:39:37 -0500
Content-Disposition: inline
In-Reply-To: <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139490>

On Mon, Feb 08, 2010 at 02:21:26PM -0800, Junio C Hamano wrote:

> I think the purpose of the patches that started this thread was to admit
> that 1965ff7 (add --porcelain option to git-push, 2009-06-22) was not well
> thought out, and to break compatibility to fix it.

I thought it was simply to remove stdout cruft that had crept in, and at
the same time to remove some stderr cruft that was simply noise on the
terminal. That being said, I am in favor of fixing it even if it means a
slight compatibility breakage.

> Having said that, I would say that what 1965ff7 specified was only these
> two:
> 
>     = TAB refs/heads/master:refs/heads/master TAB [up to date]
>     - TAB :refs/heads/foobar TAB [deleted]
> 
> so everything else that do not match this pattern is a fair game, most
> importantly, the line that begins with "To" would not be mistaken with
> this pattern, I think.

It depends on the parser. If the parser was something like:

  switch (line[0]) {
    case '=': ...; break;
    case '-': ...; break;
    default: die("wtf: %s", line);
  }

then we are not introducing any ambiguity, but we are causing a
breakage. The problem is that we did not specify the format anywhere, so
it is hard to say whether we are breaking any promises we made.

> > This one, on the other hand, seems to me to be just noise. What does a
> > --porcelain caller learn by seeing "Everything up-to-date" that it did
> > not already know from seeing the list of refs?
> 
> I do not care too much about this hunk either way.  We could leave it as
> is, as we will be giving some other stuff to the standard error stream
> without squelching anyway, even with the three-patch series.  We could
> squelch only this message, but it is dubious what it is buying us.  If you
> forced me to decide, I would probably say "let's just drop this hunk and
> keep the code as-is".

I have not actually been running these patches, just reading them, but
my impression was the goal _was_ to squelch all of the stderr cruft. But
if we are not even close, then probably we should just give up and
callers should "2>/dev/null".

> As to the exit status, do you have any thoughts, by the way?
> 
> I am not convinced that it would be necessary nor even a good idea to make
> it behave inconsistently between the normal case and Porcelain case, only
> to make it easier to special case the "remote side would reject due to
> non-fast-forward" failure mode (iow, even if the calling script knows that
> it would fail due to non-fast-forward but otherwise everything else would
> be fine, what good would it do?)

I had initially endorsed it, but now I am having second thoughts.
Especially if the "usual" calling convention is to redirect stderr as
above, then we are probably missing out on any useful error messages
that accompany a failure return, anyway.  So maybe the sane thing to do
is to leave the exit code alone, and include a --porcelain output line
that either says "Everything was OK, see individual ref status" or "We
couldn't even talk to the other side". Then the status code is
irrelevant, and stdout contains all of the useful information (and if
you don't get an error or OK message, you know there was some
serious error like a broken git installation).

-Peff
