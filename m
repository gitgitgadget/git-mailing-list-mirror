From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch-pack: Finish negotation if remote replies "ACK
 %s ready"
Date: Thu, 17 Mar 2011 03:15:12 -0400
Message-ID: <20110317071512.GF11931@sigill.intra.peff.net>
References: <1300146519-26508-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:15:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07Qd-0002Lf-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab1CQHPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:15:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48435
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab1CQHPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:15:15 -0400
Received: (qmail 21095 invoked by uid 107); 17 Mar 2011 07:15:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 03:15:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 03:15:12 -0400
Content-Disposition: inline
In-Reply-To: <1300146519-26508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169215>

On Mon, Mar 14, 2011 at 04:48:38PM -0700, Shawn O. Pearce wrote:

> Upon receiving "ACK %s ready" there is no point in looking at
> the remaining commits inside of rev_list.  Sending additional
> "have %s" lines to the remote will not construct a smaller pack.
> It is unlikely a commit older than the current cut point will have
> a better delta base than the cut point itself has.
> [...]
> Assuming the client is only following the remote (and does not make
> its own local commits), the client needs 11 rounds to spin through
> the entire list of tags (32 commits per round, ceil(339/32) == 11).
> Unfortunately the server knows on the first "have %s" line that
> it can produce a good pack, and does not need to see the remaining
> 320 tags in the other 10 rounds.

Does this optimization help in that case? From looking at the code, it
seems that we offer "ACK %s ready" only in the case that the client
has something we do not. I.e., they _are_ building local commits on top.

> Over smart HTTP, the client must do an additional 10 HTTP POST
> requests, each of which incurs round-trip latency, and must upload
> the entire state vector of all known common objects.  On the final
> POST request, this is 16 KiB worth of data.

This optimization aside, I wonder if it is worth bumping up the number
of haves we send in a chunk from 32 to something higher.

-Peff
