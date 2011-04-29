From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/2] merge-one-file: fix broken merges with alternate
 work trees
Date: Fri, 29 Apr 2011 18:46:46 -0400
Message-ID: <20110429224646.GA4095@sigill.intra.peff.net>
References: <20110429185228.GA27268@sigill.intra.peff.net>
 <20110429222432.GB3347@sigill.intra.peff.net>
 <7vtydgvfx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Aman Gupta <themastermind1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:46:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwSc-0006JF-Ji
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab1D2Wqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:46:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1D2Wqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:46:49 -0400
Received: (qmail 17169 invoked by uid 107); 29 Apr 2011 22:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:48:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:46:46 -0400
Content-Disposition: inline
In-Reply-To: <7vtydgvfx4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172504>

On Fri, Apr 29, 2011 at 03:41:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This patch makes merge-one-file chdir to the toplevel of the working
> > tree (and exit if we don't have one). This most closely matches the
> > assumption made by the original script (before separate work trees were
> > invented), and matches what happens when the script is called as part of
> > a merge strategy.
> >
> > While we're at it, we'll also error-check the call to cat.
> > Merging a file in a subdirectory could in fact fail, as the
> > redirection relies on the "checkout-index" call just prior
> > to create leading directories. But we never noticed, since
> > we ignored the error return from running cat.
> 
> This part is probably incorrect as we have && before cat that checks
> an error from checkout-index that fails to create such a subdirectory, no?

Sort of. In the original code, checkout-index wrote to one spot, and cat
wrote to another, so they could fail independently, masking the bug.

Now that the code correctly respects GIT_WORK_TREE, that should never
happen, and the only reason for cat to fail is something like ENOSPC
(checkout-index wrote the original version, but we are writing the merge
result, which could be larger).

> And then "exec git update-index -- $4" at the last step would have failed.

No. In the old code, it succeeded because it respected GIT_WORK_TREE, so
it marked the original stage-2 version as the merge result (hence the
bogus merge results).

In the new code, if we got ENOSPC, then it would mark the truncated
merge result as good (except that we probably would also fail to write a
new index due to the same error...).

It's unlikely, I'll grant, but I don't see a reason not to check the
error.

-Peff
