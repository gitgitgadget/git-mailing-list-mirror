From: Jeff King <peff@peff.net>
Subject: [PATCH] receive-pack: close sideband fd on early pack errors
Date: Fri, 19 Apr 2013 17:24:29 -0400
Message-ID: <20130419212429.GA20873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:24:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTInN-00054u-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab3DSVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:24:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:44343 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab3DSVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:24:32 -0400
Received: (qmail 21059 invoked by uid 102); 19 Apr 2013 21:24:37 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 16:24:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 17:24:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221822>

Since commit a22e6f8 (receive-pack: send pack-processing
stderr over sideband, 2012-09-21), receive-pack will start
an async sideband thread to copy the stderr from our
index-pack or unpack-objects child to the client. We hand
the thread's input descriptor to unpack(), which puts it in
the "err" member of the "struct child_process".

After unpack() returns, we use finish_async() to reap the
sideband thread. The thread is only ready to die when it
gets EOF on its pipe, which is connected to the err
descriptor. So we expect all of the write ends of that pipe
to be closed as part of unpack().

Normally, this works fine. After start_command forks, it
closes the parent copy of the descriptor. Then once the
child exits (whether it was successful or not), that closes
the only remaining writer.

However, there is one code-path in unpack() that does not
handle this. Before we decide which of unpack-objects or
index-pack to use, we read the pack header ourselves to see
how many objects it contains. If there is an error here, we
exit without running either sub-command, the pipe descriptor
remains open, and we are in a deadlock, waiting for the
sideband thread to die (which is in turn waiting for us to
close the pipe).

We can fix this by making sure that unpack() always closes
the pipe before returning.

Signed-off-by: Jeff King <peff@peff.net>
---
This was triggered in the real world by attempting to push a ref from
a corrupted repository. pack-objects dies on the local end, we get an
eof on the receive-pack end without any data, notice that it's a bogus
packfile, and hit the deadlock.

The bug was introduced by a22e6f8, which is in v1.7.12.3, so it should
be maint-worthy.

 builtin/receive-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ccebd74..e3eb5fc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -826,8 +826,11 @@ static const char *unpack(int err_fd)
 			    : 0);
 
 	hdr_err = parse_pack_header(&hdr);
-	if (hdr_err)
+	if (hdr_err) {
+		if (err_fd > 0)
+			close(err_fd);
 		return hdr_err;
+	}
 	snprintf(hdr_arg, sizeof(hdr_arg),
 			"--pack_header=%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
-- 
1.8.2.11.g379c3d8
