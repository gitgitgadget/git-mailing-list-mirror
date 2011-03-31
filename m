From: Jeff King <peff@peff.net>
Subject: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Thu, 31 Mar 2011 14:45:46 -0400
Message-ID: <20110331184546.GA16981@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MsT-0002RW-L8
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759058Ab1CaSpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:45:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759054Ab1CaSps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:45:48 -0400
Received: (qmail 1444 invoked by uid 107); 31 Mar 2011 18:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:46:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:45:46 -0400
Content-Disposition: inline
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170515>

We just need to cancel the thread, instead of sending it a
signal as we do for fork()'d async sections.

Signed-off-by: Jeff King <peff@peff.net>
---
This could also just be part of the merge resolution, but I thought it
would be easier to see what is going on if I put it here.

 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index e31c073..46ea07d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -607,7 +607,7 @@ void abort_async(struct async *async)
 #ifdef NO_PTHREADS
 	kill(async->pid, 15);
 #else
-	/* no clue */
+	pthread_cancel(async->tid);
 #endif
 	finish_async(async);
 }
-- 
1.7.4.13.g8566c
