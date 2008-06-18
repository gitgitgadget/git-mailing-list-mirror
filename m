From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable)
Date: Wed, 18 Jun 2008 06:59:05 -0400
Message-ID: <20080618105905.GA23960@sigill.intra.peff.net>
References: <7vy77gapkl.fsf@gitster.siamese.dyndns.org> <7vmynqfeab.fsf@gitster.siamese.dyndns.org> <7vwsmjj0js.fsf@gitster.siamese.dyndns.org> <7vhcdchr80.fsf@gitster.siamese.dyndns.org> <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org> <7vod6wpjvr.fsf@gitster.siamese.dyndns.org> <7vod6nikuw.fsf@gitster.siamese.dyndns.org> <7viqws6zaz.fsf@gitster.siamese.dyndns.org> <7vfxrhwspw.fsf@gitster.siamese.dyndns.org> <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 13:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8vOV-0006AR-Ef
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 13:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYFRK7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 06:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYFRK7I
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 06:59:08 -0400
Received: from peff.net ([208.65.91.99]:4154 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbYFRK7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 06:59:07 -0400
Received: (qmail 4447 invoked by uid 111); 18 Jun 2008 10:59:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 18 Jun 2008 06:59:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2008 06:59:05 -0400
Content-Disposition: inline
In-Reply-To: <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85374>

On Wed, Jun 18, 2008 at 12:32:05AM -0700, Junio C Hamano wrote:

> I am sending this out just as the final minute preview before 1.5.6 final,
> hopefully tomorrow night.

I sent out a code cleanup for remote.c yesterday that fixes a segfault:

  http://mid.gmane.org/20080616161502.GA7219@sigill.intra.peff.net

I am OK if it doesn't make it in to 1.5.6, but if not, then we should at
least apply the very safe one-liner that prevents the segfault. That
patch is below.

-- >8 --
fix segfault with "git push bogus:bogus"

We try to guess the type of the dst half of the refspec
based on the src half. If the src half is bogus, we ended up
dereferencing NULL.
---
 remote.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 91e3b11..fd8c71a 100644
--- a/remote.c
+++ b/remote.c
@@ -920,7 +920,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if((dst_guess = guess_ref(dst_value, matched_src)))
+		else if(matched_src &&
+			(dst_guess = guess_ref(dst_value, matched_src)))
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 		else
 			error("unable to push to unqualified destination: %s\n"
-- 
1.5.6.rc3.160.g2a3c9
