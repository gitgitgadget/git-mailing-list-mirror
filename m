From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] fetch-pack: ignore SIGPIPE in sideband demuxer
Date: Wed, 24 Feb 2016 02:44:58 -0500
Message-ID: <20160224074457.GB9481@sigill.intra.peff.net>
References: <20160224073603.GA9163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:45:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYU8A-0000VE-Sf
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbcBXHpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:45:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:48075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755752AbcBXHpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:45:00 -0500
Received: (qmail 20626 invoked by uid 102); 24 Feb 2016 07:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:45:00 -0500
Received: (qmail 5237 invoked by uid 107); 24 Feb 2016 07:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:44:58 -0500
Content-Disposition: inline
In-Reply-To: <20160224073603.GA9163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287178>

If the other side feeds us a bogus pack, index-pack (or
unpack-objects) may die early, before consuming all of its
input. As a result, the sideband demuxer may get SIGPIPE
(racily, depending on whether our data made it into the pipe
buffer or not). If this happens and we are compiled with
pthread support, it will take down the main thread, too.

This isn't the end of the world, as the main process will
just die() anyway when it sees index-pack failed. But it
does mean we don't get a chance to say "fatal: index-pack
failed" or similar. And it also means that we racily fail
t5504, as we sometimes die() and sometimes are killed by
SIGPIPE.

So let's ignore SIGPIPE while demuxing the sideband. We are
already careful to check the return value of write(), so we
won't waste time writing to a broken pipe. The caller will
notice the error return from the async thread, though in
practice we don't even get that far, as we die() as soon as
we see that index-pack failed.

The non-sideband case is already fine; we let index-pack
read straight from the socket, so there is no SIGPIPE at
all. Technically the non-threaded async case is also OK
without this (the forked async process gets SIGPIPE), but
it's not worth distinguishing from the threaded case here.

Signed-off-by: Jeff King <peff@peff.net>
---
It's tempting to just ignore SIGPIPE in all async processes,
as other sites may have similar problems (and we cannot
depend on SIGPIPE taking down the main thread anyway, as
async code may be implemented via fork()).

But that errs in the opposite direction. If an async process
does not check the return value of write(), it may
wastefully keep writing.

It would also mean implementing a pthread_sigmask() wrapper
on Windows. I have no idea how feasible that would be.

 fetch-pack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 01e34b6..f96f6df 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "prio-queue.h"
 #include "sha1-array.h"
+#include "sigchain.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -671,9 +672,12 @@ static int everything_local(struct fetch_pack_args *args,
 static int sideband_demux(int in, int out, void *data)
 {
 	int *xd = data;
+	int ret;
 
-	int ret = recv_sideband("fetch-pack", xd[0], out);
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = recv_sideband("fetch-pack", xd[0], out);
 	close(out);
+	sigchain_pop(SIGPIPE);
 	return ret;
 }
 
-- 
2.7.2.645.g4e1306c
