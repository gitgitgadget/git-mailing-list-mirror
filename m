From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] run-command: factor out running_main_thread function
Date: Mon, 15 Apr 2013 19:08:16 -0400
Message-ID: <20130415230816.GB11267@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 01:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URsVg-0004Qz-0R
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934966Ab3DOXIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:08:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47201 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933440Ab3DOXIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:08:23 -0400
Received: (qmail 30476 invoked by uid 107); 15 Apr 2013 23:10:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:10:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:08:16 -0400
Content-Disposition: inline
In-Reply-To: <20130415230651.GA16670@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221327>

When the async subsystem is used, we may spawn off
sub-threads (if the platform supports it), and consider the
original thread to be the "main" thread of execution. We use
this information in a custom die_routine to decide whether
to call pthread_exit or a regular full-process exit.

Let's pull this decision out into its own function so that
other parts of the system can use it to make decisions.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 15 ++++++++++++++-
 run-command.h | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 765c2ce..69ca052 100644
--- a/run-command.c
+++ b/run-command.c
@@ -603,7 +603,7 @@ static NORETURN void die_async(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
 
-	if (!pthread_equal(main_thread, pthread_self())) {
+	if (!running_main_thread()) {
 		struct async *async = pthread_getspecific(async_key);
 		if (async->proc_in >= 0)
 			close(async->proc_in);
@@ -614,6 +614,19 @@ static NORETURN void die_async(const char *err, va_list params)
 
 	exit(128);
 }
+
+int running_main_thread(void)
+{
+	return pthread_equal(main_thread, pthread_self());
+}
+
+#else /* NO_PTHREADS defined */
+
+int running_main_thread(void)
+{
+	return 1;
+}
+
 #endif
 
 int start_async(struct async *async)
diff --git a/run-command.h b/run-command.h
index 221ce33..981dd10 100644
--- a/run-command.h
+++ b/run-command.h
@@ -92,4 +92,14 @@ int finish_async(struct async *async);
 int start_async(struct async *async);
 int finish_async(struct async *async);
 
+/*
+ * If the platform supports threads, returns 1 if we are running the "main"
+ * thread that spawned other async threads, and zero if we are executing one
+ * of the async threads.
+ *
+ * If the platform does not support threads, returns 1 (we are always in the
+ * main thread then).
+ */
+int running_main_thread(void);
+
 #endif
-- 
1.8.2.8.g44e4c28
