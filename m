From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects error
Date: Thu, 31 Mar 2011 14:44:43 -0400
Message-ID: <20110331184443.GD16906@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MrW-0001qe-L9
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759052Ab1CaSot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:44:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759048Ab1CaSot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:44:49 -0400
Received: (qmail 1394 invoked by uid 107); 31 Mar 2011 18:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:45:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:44:43 -0400
Content-Disposition: inline
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170514>

If pack-objects dies prematurely (for example, because there
is some repo corruption), we are careful to clean up the
sideband demuxer (if it is being used) with finish_async.
However, for an async implementation which forks (i.e., not
Windows), that means we will waitpid() for the async
process.

Meanwhile, the async sideband demuxer will continue trying
to stream data from the remote repo until it gets EOF.
Depending on what data pack-objects actually sent, the
remote repo may not actually send anything (e.g., if we sent
nothing and it is simply waiting for the pack). This leads
to deadlock cycle in which send-pack waits on the demuxer,
the demuxer waits on the remote receive-pack, and the remote
receive-pack waits on send-pack to send the pack data.

To break this, let's have send-pack abort the demuxer when
it knows that it has failed to properly send the pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2478e18..cc068ff 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -516,7 +516,7 @@ int send_pack(struct send_pack_args *args,
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
 			if (use_sideband)
-				finish_async(&demux);
+				abort_async(&demux);
 			return -1;
 		}
 	}
-- 
1.7.4.13.g8566c
