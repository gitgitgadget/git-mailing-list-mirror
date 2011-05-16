From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] send-pack: avoid deadlock on git:// push with failed
 pack-objects
Date: Mon, 16 May 2011 02:52:57 -0400
Message-ID: <20110516065257.GC19078@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:53:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrfw-0003eA-05
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab1EPGxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:53:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40602
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1EPGxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:53:00 -0400
Received: (qmail 11362 invoked by uid 107); 16 May 2011 06:55:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 02:55:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 02:52:57 -0400
Content-Disposition: inline
In-Reply-To: <20110516063944.GB25731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173712>

Commit 09c9957c fixes a deadlock in which pack-objects
fails, the remote end is still waiting for pack data, and we
are still waiting for the remote end to say something (see
that commit for a much more in-depth explanation).

We solved the problem there by making sure the output pipe
is closed on error; thus the remote sees EOF, and proceeds
to complain and close its end of the connection.

However, in the special case of push over git://, we don't
have a pipe, but rather a full-duplex socket, with another
dup()-ed descriptor in place of the second half of the pipe.
In this case, closing the second descriptor signals nothing
to the remote end, and we still deadlock.

This patch calls shutdown() explicitly to signal EOF to the
other side.

Signed-off-by: Jeff King <peff@peff.net>
---
And if you wanted to drop the first two patches, this probably works OK
without the conditional, as the shutdown is just a no-op on a pipe
descriptor then.

 builtin-send-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 3e70795..682a3f9 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -520,6 +520,8 @@ int send_pack(struct send_pack_args *args,
 				ref->status = REF_STATUS_NONE;
 			if (args->stateless_rpc)
 				close(out);
+			if (git_connection_is_socket(conn))
+				shutdown(fd[0], SHUT_WR);
 			if (use_sideband)
 				finish_async(&demux);
 			return -1;
-- 
1.7.5.1.13.g0ca09.dirty
