From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] usage: do not check die recursion outside main thread
Date: Mon, 15 Apr 2013 19:09:54 -0400
Message-ID: <20130415230954.GC11267@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 01:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsXJ-0006Sq-0V
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935157Ab3DOXKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:10:02 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933440Ab3DOXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:10:00 -0400
Received: (qmail 30496 invoked by uid 107); 15 Apr 2013 23:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:11:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:09:54 -0400
Content-Disposition: inline
In-Reply-To: <20130415230651.GA16670@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221328>

When we have started threads with the async subsystem, both
the thread and the main program may call die(). The async
subsystem sets up a special die routine to call pthread_exit
rather than regular exit, but the recursion check in die()
happens outside of this routine, and does not know that it's
OK for two dies to run.

As a result, we may print "recursion in die handler" when an
async thread dies, even though there is no recursion. This
can be triggered, for example, by upload-pack errors; the
receiving side will die both in the async sideband
demultiplexer and in the main program.

This patch teaches the recursion check to use the same
running_main_thread() check that the async code bases its
exit decision on. That means we detect only recursion within
the main program itself, and assume that async handlers
correctly die (which they do).

Signed-off-by: Jeff King <peff@peff.net>
---
This is the simplest solution. You could actually have a thread-local
dying counter, which would detect die recursion within an async thread.
But I did not want to get into designing a lowest-common-denominator of
thread-local storage that would work on all of our platforms.

 usage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/usage.c b/usage.c
index c6b7ac5..33405c8 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#include "run-command.h"
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
@@ -82,6 +83,9 @@ static void check_die_recursion(const char *fmt, va_list ap)
 {
 	static int dying;
 
+	if (!running_main_thread())
+		return;
+
 	if (!dying++)
 		return;
 
-- 
1.8.2.8.g44e4c28
