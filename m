From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] avoid double close of descriptors handed to run_command
Date: Tue, 24 Jun 2014 05:45:46 -0400
Message-ID: <20140624094545.GB14514@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNIY-0008Ru-8a
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaFXJpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 05:45:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:50134 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbaFXJpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 05:45:49 -0400
Received: (qmail 16486 invoked by uid 102); 24 Jun 2014 09:45:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 04:45:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 05:45:46 -0400
Content-Disposition: inline
In-Reply-To: <20140624094217.GA14216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252392>

When a file descriptor is given to run_command via the
"in", "out", or "err" parameters, run_command takes
ownership. The descriptor will be closed in the parent
process whether the process is spawned successfully or not,
and closing it again is wrong.

In practice this has not caused problems, because we usually
close() right after start_command returns, meaning no other
code has opened a descriptor in the meantime. So we just get
EBADF and ignore it (rather than accidentally closing
somebody else's descriptor!).

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed the one in replace, and grepped around for other instances. I
think this is all of them. The only possible cases I didn't investigate
carefully were in send-pack/receive-pack. The logic there is quite
complicated, and I remember looking at and fixing close() issues there
not too long ago (e.g., 49ecfa1), so I assumed it was OK.

 builtin/replace.c | 2 --
 daemon.c          | 1 -
 2 files changed, 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 8507835..eb1d2ec 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -207,8 +207,6 @@ static void export_object(const unsigned char *sha1, const char *filename)
 
 	if (run_command(&cmd))
 		die("cat-file reported failure");
-
-	close(fd);
 }
 
 /*
diff --git a/daemon.c b/daemon.c
index f9c63e9..e1e424d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -775,7 +775,6 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		logerror("unable to fork");
 	else
 		add_child(&cld, addr, addrlen);
-	close(incoming);
 }
 
 static void child_handler(int signo)
-- 
2.0.0.566.gfe3e6b2
