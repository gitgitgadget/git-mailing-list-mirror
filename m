From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] transport-helper: initialize debug flag before starting
 threads
Date: Mon, 8 Dec 2014 03:22:06 -0500
Message-ID: <20141208082206.GA28302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 09:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxta9-00029D-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 09:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbaLHIWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 03:22:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:49835 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753901AbaLHIWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 03:22:07 -0500
Received: (qmail 3380 invoked by uid 102); 8 Dec 2014 08:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 02:22:07 -0600
Received: (qmail 21371 invoked by uid 107); 8 Dec 2014 08:22:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 03:22:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 03:22:06 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261003>

The transport_debug() function uses a static variable to
lazily cache the boolean value of $TRANSPORT_DEBUG. If a
program uses transport-helper's bidirectional_transfer_loop
(as remote-ext and remote-fd do), then two threads may both
try to write the variable at the same time.

We can fix this by initializing the variable right before
starting the threads.

Noticed by "-fsanitize=thread". This probably isn't a
problem in practice, as both threads will write the same
value, and we are unlikely to see a torn write on an "int"
(i.e., on sane platforms a write to an int is atomic).

Signed-off-by: Jeff King <peff@peff.net>
---
I'm playing around with -fsanitize=thread and found this. The fix isn't
_too_ bad, but it's not the only case.

For example, "grep" may spawn many threads, each of which calls
want_color(), which does the same static cache-the-env trick. Should
grep call want_color() preemptively before staring threads? That's also
not too bad, but we're starting to cross a lot of module boundaries here
(i.e., it's a bit gross that grep needs to know how want_color() is
implemented).

As noted above, I think these cases are pretty benign. But it looks like
-fsanitize=thread would be a good way to find cases that are not (e.g.,
places in index-pack where we need to take the global lock but don't),
and it would be nice to keep things clean. The options for doing so (and
hence the RFC) are:

  1. Fixes like this (or grep calling want_color preemptively0. I'm not
     sure yet how many would be necessary, but probably a handful.

  2. Annotate sites like this (a single int read/write where all threads
     should get the same value) with "it's OK to race here" markers.

  3. Introduce locking into each site. This has performance
     implications, which makes me hesitate if this isn't a problem in
     practice. There's probably a simple lockless solution, though.

I think I'd favor (2) if we don't mind polluting our code with such
annotations. I haven't investigated exactly what they would look like,
though (there is a "dynamic annotation" that is pretty gross, as it
requires linking with extra code; but I think there may also be a
valgrind-suppression-like scheme that can live outside the code
completely).

 transport-helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0224687..fc3756c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1058,17 +1058,23 @@ int transport_helper_init(struct transport *transport, const char *name)
 /* This should be enough to hold debugging message. */
 #define PBUFFERSIZE 8192
 
+static int transport_debug_enabled(void)
+{
+	static int debug_enabled = -1;
+
+	if (debug_enabled < 0)
+		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
+	return debug_enabled;
+}
+
 /* Print bidirectional transfer loop debug message. */
 __attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
 	va_list args;
 	char msgbuf[PBUFFERSIZE];
-	static int debug_enabled = -1;
 
-	if (debug_enabled < 0)
-		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
-	if (!debug_enabled)
+	if (!transport_debug_enabled)
 		return;
 
 	va_start(args, fmt);
@@ -1237,6 +1243,10 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	pthread_t ptg_thread;
 	int err;
 	int ret = 0;
+
+	/* initialize static global debug flag as a side effect */
+	transport_debug_enabled();
+
 	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-- 
2.2.0.390.gf60752d
