From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] match_push_refs(): nobody sets src->peer_ref anymore
Date: Tue, 5 Mar 2013 00:45:06 -0500
Message-ID: <20130305054456.GA12446@sigill.intra.peff.net>
References: <7vlia2x05q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 06:45:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCkgz-0001Ux-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 06:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab3CEFpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 00:45:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35095 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab3CEFpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 00:45:08 -0500
Received: (qmail 10634 invoked by uid 107); 5 Mar 2013 05:46:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 00:46:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 00:45:06 -0500
Content-Disposition: inline
In-Reply-To: <7vlia2x05q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217431>

On Mon, Mar 04, 2013 at 02:36:33PM -0800, Junio C Hamano wrote:

> In ancient times, we used to disallow the same source ref to be
> pushed to more than one places, e.g. "git push there master:master
> master:naster" was disallowed.  We later lifted this restriction
> with db27ee63929f (send-pack: allow the same source to be pushed
> more than once., 2005-08-06) and there no longer is anybody that
> sets peer_ref for the source side of the ref list in the push
> codepath since then.
> 
> Remove one leftover no-op in a loop that iterates over the source
> side of ref list (i.e. our local ref) to see if it can/should be
> sent to a matching destination ref while skipping ones that is
> marked with peer_ref (which will never exist, so we do not skip
> anything).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This looks good to me. I was curious how difficult it would be to verify
the "no longer is anybody that sets peer_ref" claim. It's actually quite
easy. All of the call-sites just feed the result of get_local_heads(),
which is easy to verify does not ever set peer_ref. Looking at the
current code, I think you could even drop the "src" parameter and just
have match_push_refs call get_local_heads() itself, though that does
feel like a step backwards in terms of function generality.

As an aside, I have always found the embedded "next" and "peer_ref"
pointers in "struct ref" to be hacky. They are not properties of the ref
at all, and the "refs to fetch" list would be more logically represented
as a list of pairs of refs (and then I would not have to ever remember
whether the peer is the local or remote ref in a given case). Probably
not worth worrying about at this point, though, as the code fallout
would be significant for little gain.

-Peff
