From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] run-command: allow aborting async code prematurely
Date: Thu, 31 Mar 2011 14:44:21 -0400
Message-ID: <20110331184421.GC16906@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:44:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Mr6-0001cR-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046Ab1CaSoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:44:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042Ab1CaSoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:44:23 -0400
Received: (qmail 1363 invoked by uid 107); 31 Mar 2011 18:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:45:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:44:21 -0400
Content-Disposition: inline
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170513>

We provide only two abstract promitives for async code:
start and finish. Where "finish" means to wait until the
async code tells us it is done. However, it may also be
useful for us to to tell the async code to abort right away,
because whatever it was doing is no longer useful.

For a separate process, we just kill() it. For Windows, we
need to do whatever the equivalent to pthread_cancel is.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |   10 ++++++++++
 run-command.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 258c880..f179d2a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -439,6 +439,16 @@ int finish_async(struct async *async)
 	return ret;
 }
 
+void abort_async(struct async *async)
+{
+#ifndef WIN32
+	kill(async->pid, 15);
+#else
+	/* no clue */
+#endif
+	finish_async(async);
+}
+
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
diff --git a/run-command.h b/run-command.h
index 65ccb1c..df2c736 100644
--- a/run-command.h
+++ b/run-command.h
@@ -83,5 +83,6 @@ struct async {
 
 int start_async(struct async *async);
 int finish_async(struct async *async);
+void abort_async(struct async *async);
 
 #endif
-- 
1.7.4.13.g8566c
