From: Jeff King <peff@peff.net>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 00:41:51 -0400
Message-ID: <20130702044151.GB7068@sigill.intra.peff.net>
References: <201307012102.31384.mfick@codeaurora.org>
 <20130702040758.GA7068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jul 02 06:41:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtsPU-0001bs-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 06:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3GBElo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 00:41:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:53879 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab3GBEln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 00:41:43 -0400
Received: (qmail 15811 invoked by uid 102); 2 Jul 2013 04:42:52 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Jul 2013 23:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 00:41:51 -0400
Content-Disposition: inline
In-Reply-To: <20130702040758.GA7068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229357>

On Tue, Jul 02, 2013 at 12:07:58AM -0400, Jeff King wrote:

> And yet another alternative would be to keep the list unsorted during
> the mark_complete calls, and then sort it at the end. Like this:

Amusingly, I seem to have posted the exact same patch last year:

  http://article.gmane.org/gmane.comp.version-control.git/194939

but never polished it up. It does cut a little time off of the initial
ref-loading that fetch-pack does (especially when we do not end up
transferring any objects at all). But it does not solve your problem.

I replicated your test setup, and the problem is that we have many
common objects on both sides during the ref negotiation. So we end up in
rev_list_push for each one, which has the same O(n^2) behavior.
Switching it to just sort at the end is not trivial; we first insert all
of the objects, but then we actually walk the parents, pushing onto the
list as we go. So I think we'd want a better data structure (like a
priority queue).

-Peff
