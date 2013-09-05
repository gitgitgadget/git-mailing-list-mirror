From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu, 5 Sep 2013 19:23:22 -0400
Message-ID: <20130905232322.GB29351@sigill.intra.peff.net>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
 <vpqioyfukkw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHite-0004X2-Qa
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab3IEXX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:23:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:49867 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab3IEXX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:23:26 -0400
Received: (qmail 10709 invoked by uid 102); 5 Sep 2013 23:23:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Sep 2013 18:23:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Sep 2013 19:23:22 -0400
Content-Disposition: inline
In-Reply-To: <vpqioyfukkw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234003>

On Thu, Sep 05, 2013 at 09:36:47PM +0200, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > One caveat, though.  The name "oldStyle" will become problematic,
> > when we want to remove some wart in the output format long after
> > this "no comment prefix by default" series lands.  Some people may
> > expect setting oldStyle=true would give output from 1.8.4 era, while
> > some others would expect that it would give output from 1.8.5 era
> > that does not have comment prefix but still has that wart we will
> > remove down the line.
> 
> I'm fine with any name actually (since it is enabled by default, people
> don't need to know the name to benefit from the new output). Maybe
> status.displayCommentPrefix was the best name after all.

FWIW, I had the same thought as Junio. I much prefer something like
status.displayCommentPrefix for clarity and future-proofing.

As for the feature itself, I am still undecided whether I like it. I've
tried looking at the output of the series, and it feels weird to me.

Part of it is undoubtedly that my brain is simply used to the other way.
But it also seems to drop some of the vertical whitespace, which makes
things feel very crowded. E.g., before:

  # On branch private
  # Your branch and 'origin/next' have diverged,
  # and have 472 and 59 different commits each, respectively.
  #
  # Untracked files:
  #       t/foo
  #       test-obj-pool
  #       test-string-pool
  #       test-treap
  #       test-url-normalize
  nothing added to commit but untracked files present

after:

  On branch private
  Your branch and 'origin/next' have diverged,
  and have 472 and 59 different commits each, respectively.
  Untracked files:
          t/foo
          test-obj-pool
          test-string-pool
          test-treap
          test-url-normalize
  nothing added to commit but untracked files present

The blank before "Untracked files" was dropped (was this intentional? I
didn't see any note of it in the discussion), and the bottom "nothing
added" line butts against the untracked list more obviously, because
they now all have the same comment indentation.

I wonder if it would look a little nicer as:

  On branch private
  Your branch and 'origin/next' have diverged,
  and have 472 and 59 different commits each, respectively.

  Untracked files:
          t/foo
          test-obj-pool
          test-string-pool
          test-treap
          test-url-normalize

  nothing added to commit but untracked files present

As an orthogonal thing to your patch, I feel like the first two items
(branch and ahead/behind) are kind of squished and oddly formatted (in
both the original and yours). Could we do something like:

  Your branch 'private' and its upstream 'origin/next' have diverged,
  and have 472 and 59 different commits each, respectively.

when we are going to print both?  That's 69 characters, which might
overrun 80 if you have long branch names, but we could also line-break
it differently.

That doesn't need to be part of your topic, but while we are talking
about the format of the message, maybe it is worth thinking about.

-Peff
