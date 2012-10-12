From: Jeff King <peff@peff.net>
Subject: Re: How can I tell if anything was fetched?
Date: Fri, 12 Oct 2012 03:47:39 -0400
Message-ID: <20121012074739.GD17026@sigill.intra.peff.net>
References: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
 <m28vbdkley.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Lawrence <prlawrence@gmail.com>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:47:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMZyN-00036l-5L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059Ab2JLHrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:47:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50729 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482Ab2JLHrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 03:47:42 -0400
Received: (qmail 560 invoked by uid 107); 12 Oct 2012 07:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Oct 2012 03:48:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2012 03:47:39 -0400
Content-Disposition: inline
In-Reply-To: <m28vbdkley.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207538>

On Thu, Oct 11, 2012 at 06:45:09PM +0200, Andreas Schwab wrote:

> Phil Lawrence <prlawrence@gmail.com> writes:
> 
> > One approach might be to first generate a state-of-the-repo SHA1:
> >     # http://stackoverflow.com/a/7350019/834039
> >     # http://git-scm.com/book/ch9-2.html
> >     {
> >         git rev-list --objects --all
> >         git rev-list --objects -g --no-walk --all
> >         git rev-list --objects --no-walk \
> >             $(git fsck --unreachable |
> >               grep '^unreachable commit' |
> >               cut -d' ' -f3)
> >     } | sort | uniq | git hash-object -w --stdin
> 
> I think you'd only need to record the state of all refs (eg. the output
> of `git for-each-ref') to reliably detect any changes.

To clarify on the "only" in your sentence: it is not just that recording
the ref changes is more efficient. But recording the object state is
actively wrong. You might have fetched ref changes that do not introduce
new objects (e.g., a rewind of history, or a branch deletion). The
before-and-after ref state is both sufficient and necessary.  I suspect
you already realized that, Andreas, but I wanted to make sure it was
clear to readers, including the OP.

Checking ref state does suffer from potential race conditions with any
other simultaneous updates.  I don't think there is any reason we
couldn't have "git fetch" produce a machine-readable output detailing
what happened. We already have the same for "git push". I think it is
simply the case that nobody has really wanted it so far.

-Peff
