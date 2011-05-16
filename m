From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/9] send-pack: Attempt to retrieve remote status even
 if pack-objects fails
Date: Mon, 16 May 2011 00:07:45 -0400
Message-ID: <20110516040745.GA23583@sigill.intra.peff.net>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 06:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLp65-0001n5-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 06:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab1EPEHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 00:07:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab1EPEHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 00:07:48 -0400
Received: (qmail 9820 invoked by uid 107); 16 May 2011 04:09:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 00:09:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 00:07:45 -0400
Content-Disposition: inline
In-Reply-To: <1305495440-30836-3-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173700>

On Sun, May 15, 2011 at 11:37:13PM +0200, Johan Herland wrote:

> I first wrote this patch on a base where e07fd15 (Peff's "send-pack:
> unbreak push over stateless rpc") was not present, and then resolved
> a conflict when rebasing this patch onto current master. I hope Peff
> or Johannes (Sixt) can verify that my patch does not reintroduce the
> deadlock they fixed.

I don't think it reintroduces the deadlock we fixed, but I am worried
that it produces a new, similar one. That is, imagine pack-objects fails
horribly, maybe or maybe not producing any output. We close its pipe
outgoing pipe at the end of run_command, and per Johannes' 09c9957, we
are sure that the sideband demuxer does not hold a pipe end open,
either.

So the remote side sees us close our end of the pipe, knows there is no
more pack data, and then closes their end. So our receive_status should
either get some error message, or EOF, either of which is fine. So no
deadlock there. Essentially, we have done a half-duplex shutdown of the
connection to the remote, and that is enough for everybody to keep
going.

But what if we are not using pipes, but have an actual TCP socket? In
that case, I'm not sure what happens. We don't seem to do a half-duplex
shutdown() anywhere. So I'm concerned that we are still open for sending
from the remote's perspective, and we may deadlock.

However, that would not necessarily be something introduced by your
patch; you would deadlock in receive_status, but prior to that it would
deadlock in the sideband demuxer.

AFAICT, the only way to have an actual TCP connection instead of pipes
is for the push to go over git://, which is enabled almost nowhere. But
we should perhaps check for deadlock on failed pack-objects in that
case, both with and without your patch.

-Peff
