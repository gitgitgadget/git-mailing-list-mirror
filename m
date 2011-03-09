From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: fix --max-count when used together with -S or -G
Date: Wed, 9 Mar 2011 16:38:27 -0500
Message-ID: <20110309213824.GA4400@sigill.intra.peff.net>
References: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
 <1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:38:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxR5T-0002lL-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab1CIViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:38:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58808
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1CIViV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:38:21 -0500
Received: (qmail 2565 invoked by uid 107); 9 Mar 2011 21:38:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Mar 2011 16:38:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Mar 2011 16:38:27 -0500
Content-Disposition: inline
In-Reply-To: <1299703935-639-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168765>

On Wed, Mar 09, 2011 at 09:52:15PM +0100, Matthieu Moy wrote:

> --max-count is implemented by counting revisions in get_revision(), but
> the -S and -G take effect later (after running diff), hence,
> --max-count=10 -Sfoo meant "examine the 10 first revisions, and out of
> them, show only those changing the occurences of foo", not "show 10
> revisions changing the occurences of foo".
> 
> In case the commit isn't actually shown, cancel the decrement of
> max_count.

Hmm. Is this papering over a bigger problem, which is that we are
throwing out commits at the time of diff rather than finding out early
whether they are TREESAME?

That is, you fixed this:

  git log -100 -Sfoo

but this is still broken:

  git log --parents -Sfoo

in that parent rewriting doesn't happen. You can see the results with
"gitk -Sfoo" (compare to "gitk -- path", which properly shows a
simplified history).

This is also a problem with --follow. Maybe others.

One solution is to hoist the diffcore_std stuff up to rev_compare_tree,
so we get pickaxe and rename-detection at that level. But there may be
some performance implications, especially with respect to saving the
intermediate result to be used by the actual diff generation later on.

So it's definitely a much deeper topic than your small patch. Which
maybe means we should apply your patch now as a band-aid and hope for a
better solution in the long term. I dunno.

-Peff
