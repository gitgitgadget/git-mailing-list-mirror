From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] fetch-pack: isolate sigpipe in demuxer thread
Date: Tue, 19 Apr 2016 18:50:29 -0400
Message-ID: <20160419225029.GD18255@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:50:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseTd-0001W6-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcDSWud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:50:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:52445 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751692AbcDSWuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:50:32 -0400
Received: (qmail 27769 invoked by uid 102); 19 Apr 2016 22:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:50:32 -0400
Received: (qmail 20933 invoked by uid 107); 19 Apr 2016 22:50:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:50:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:50:29 -0400
Content-Disposition: inline
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291945>

In commit 9ff18fa (fetch-pack: ignore SIGPIPE in sideband
demuxer, 2016-02-24), we started using sigchain_push() to
ignore SIGPIPE in the async demuxer thread. However, this is
rather clumsy, as it ignores SIGPIPE for the entire process,
including the main thread. At the time we didn't have any
per-thread signal support, but we now we do. Let's use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f96f6df..b501d5c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,7 +15,6 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
-#include "sigchain.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -674,10 +673,8 @@ static int sideband_demux(int in, int out, void *data)
 	int *xd = data;
 	int ret;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
 	ret = recv_sideband("fetch-pack", xd[0], out);
 	close(out);
-	sigchain_pop(SIGPIPE);
 	return ret;
 }
 
@@ -701,6 +698,7 @@ static int get_pack(struct fetch_pack_args *args,
 		demux.proc = sideband_demux;
 		demux.data = xd;
 		demux.out = -1;
+		demux.isolate_sigpipe = 1;
 		if (start_async(&demux))
 			die("fetch-pack: unable to fork off sideband"
 			    " demultiplexer");
-- 
2.8.1.512.g4e0a533
