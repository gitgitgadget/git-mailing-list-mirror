From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] run-command: provide in_async query function
Date: Tue, 1 Sep 2015 16:22:43 -0400
Message-ID: <20150901202243.GA6931@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 22:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWs4w-0000yp-1h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 22:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbbIAUWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 16:22:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:53290 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbbIAUWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 16:22:45 -0400
Received: (qmail 21559 invoked by uid 102); 1 Sep 2015 20:22:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 15:22:45 -0500
Received: (qmail 5415 invoked by uid 107); 1 Sep 2015 20:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 16:22:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 16:22:43 -0400
Content-Disposition: inline
In-Reply-To: <20150901202215.GA17370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277037>

It's not easy for arbitrary code to find out whether it is
running in an async process or not. A top-level function
which is fed to start_async() can know (you just pass down
an argument saying "you are async"). But that function may
call other global functions, and we would not want to have
to pass the information all the way through the call stack.

Nor can we simply set a global variable, as those may be
shared between async threads and the main thread (if the
platform supports pthreads). We need pthread tricks _or_ a
global variable, depending on how start_async is
implemented.

The callers don't have enough information to do this right,
so let's provide a simple query function that does.
Fortunately we can reuse the existing infrastructure to make
the pthread case simple (and even simplify die_async() by
using our new function).

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 16 +++++++++++++++-
 run-command.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 3277cf7..c8029f2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -595,7 +595,7 @@ static NORETURN void die_async(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
 
-	if (!pthread_equal(main_thread, pthread_self())) {
+	if (in_async()) {
 		struct async *async = pthread_getspecific(async_key);
 		if (async->proc_in >= 0)
 			close(async->proc_in);
@@ -614,6 +614,13 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
+int in_async(void)
+{
+	if (!main_thread_set)
+		return 0; /* no asyncs started yet */
+	return !pthread_equal(main_thread, pthread_self());
+}
+
 #else
 
 static struct {
@@ -653,6 +660,12 @@ int git_atexit(void (*handler)(void))
 }
 #define atexit git_atexit
 
+static int process_is_async;
+int in_async(void)
+{
+	return process_is_async;
+}
+
 #endif
 
 int start_async(struct async *async)
@@ -712,6 +725,7 @@ int start_async(struct async *async)
 		if (need_out)
 			close(fdout[0]);
 		git_atexit_clear();
+		process_is_async = 1;
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
 
diff --git a/run-command.h b/run-command.h
index 5b4425a..629fab7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -118,5 +118,6 @@ struct async {
 
 int start_async(struct async *async);
 int finish_async(struct async *async);
+int in_async(void);
 
 #endif
-- 
2.5.1.739.g7891f6b
