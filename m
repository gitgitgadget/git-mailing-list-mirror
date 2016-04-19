From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] send-pack: isolate sigpipe in demuxer thread
Date: Tue, 19 Apr 2016 18:50:17 -0400
Message-ID: <20160419225016.GC18255@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:50:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseTQ-0001NM-UA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbcDSWuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:50:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:52442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751642AbcDSWuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:50:20 -0400
Received: (qmail 27763 invoked by uid 102); 19 Apr 2016 22:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:50:19 -0400
Received: (qmail 20917 invoked by uid 107); 19 Apr 2016 22:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:50:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:50:17 -0400
Content-Disposition: inline
In-Reply-To: <20160419223945.GA18055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291944>

If we get an error from pack-objects, we may exit
send_pack() early, before reading the server's status
response. In such a case, we may racily see SIGPIPE from our
async demuxer (which is trying to write that status back to
us), and we'd prefer to continue pushing the error up the
call stack, rather than taking down the whole process with
signal death.

This is safe to do because our demuxer just calls
recv_sideband, whose data writes are all done with
write_or_die(), which will notice SIGPIPE.

We do also write sideband 2 to stderr, and we would no
longer die on SIGPIPE there (if it were piped in the first
place, and if the piped program went away). But that's
probably a good thing, as it likewise should not abort the
push process at all (neither immediately by signal, nor
eventually by reporting failure back to the main thread).

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/send-pack.c b/send-pack.c
index fc27db6..37ee04e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -518,6 +518,7 @@ int send_pack(struct send_pack_args *args,
 		demux.proc = sideband_demux;
 		demux.data = fd;
 		demux.out = -1;
+		demux.isolate_sigpipe = 1;
 		if (start_async(&demux))
 			die("send-pack: unable to fork off sideband demultiplexer");
 		in = demux.out;
-- 
2.8.1.512.g4e0a533
