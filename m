From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] write_or_die: handle EPIPE in async threads
Date: Wed, 24 Feb 2016 02:40:16 -0500
Message-ID: <20160224074016.GA9481@sigill.intra.peff.net>
References: <20160224073603.GA9163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:40:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYU3d-0005Xh-8R
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbcBXHkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:40:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:48072 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755067AbcBXHkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:40:19 -0500
Received: (qmail 20409 invoked by uid 102); 24 Feb 2016 07:40:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:40:19 -0500
Received: (qmail 5204 invoked by uid 107); 24 Feb 2016 07:40:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:40:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:40:16 -0500
Content-Disposition: inline
In-Reply-To: <20160224073603.GA9163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287177>

When write_or_die() sees EPIPE, it treats it specially by
converting it into a SIGPIPE death. We obviously cannot
ignore it, as the write has failed and the caller expects us
to die. But likewise, we cannot just call die(), because
printing any message at all would be a nuisance during
normal operations.

However, this is a problem if write_or_die() is called from
a thread. Our raised signal ends up killing the whole
process, when logically we just need to kill the thread
(after all, if we are ignoring SIGPIPE, there is good reason
to think that the main thread is expecting to handle it).

Inside an async thread, the die() code already does the
right thing, because we use our custom die_async() routine,
which calls pthread_join(). So ideally we would piggy-back
on that, and simply call:

  die_quietly_with_code(141);

or similar. But refactoring the die code to do this is
surprisingly non-trivial. The die_routines themselves handle
both printing and the decision of the exit code. Every one
of them would have to be modified to take new parameters for
the code, and to tell us to be quiet.

Instead, we can just teach write_or_die() to check for the
async case and handle it specially. We do have to build an
interface to abstract the async exit, but it's simple and
self-contained. If we had many call-sites that wanted to do
this die_quietly_with_code(), this approach wouldn't scale
as well, but we don't. This is the only place where do this
weird exit trick.

Signed-off-by: Jeff King <peff@peff.net>
---
This is needed for patch 2, wherein we (surprise!) call write_or_die()
in a thread and want to ignore SIGPIPE.

Obviously another solution is "don't call write_or_die() in a thread",
and that would work for patch 2 here. But it can be hard to know whether
or not write_or_die() is called deep in the call stack. So even though
this solution is slightly more complex, I like that it behaves correctly
in all cases.

 run-command.c  | 10 ++++++++++
 run-command.h  |  1 +
 write_or_die.c |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/run-command.c b/run-command.c
index cdf0184..426387b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -635,6 +635,11 @@ int in_async(void)
 	return !pthread_equal(main_thread, pthread_self());
 }
 
+void async_exit(int code)
+{
+	pthread_exit((void *)(intptr_t)code);
+}
+
 #else
 
 static struct {
@@ -680,6 +685,11 @@ int in_async(void)
 	return process_is_async;
 }
 
+int async_exit(int code)
+{
+	exit(code);
+}
+
 #endif
 
 int start_async(struct async *async)
diff --git a/run-command.h b/run-command.h
index d5a57f9..42917e8 100644
--- a/run-command.h
+++ b/run-command.h
@@ -121,6 +121,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
+void NORETURN async_exit(int code);
 
 /**
  * This callback should initialize the child process and preload the
diff --git a/write_or_die.c b/write_or_die.c
index e7afe7a..49e80aa 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,8 +1,12 @@
 #include "cache.h"
+#include "run-command.h"
 
 static void check_pipe(int err)
 {
 	if (err == EPIPE) {
+		if (in_async())
+			async_exit(141);
+
 		signal(SIGPIPE, SIG_DFL);
 		raise(SIGPIPE);
 		/* Should never happen, but just in case... */
-- 
2.7.2.645.g4e1306c
