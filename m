From: Jeff King <peff@github.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Wed, 6 Apr 2011 13:54:13 -0400
Message-ID: <20110406175413.GA8205@sigill.intra.peff.net>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Wvy-0002C0-Af
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab1DFRyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 13:54:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39542
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab1DFRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:54:18 -0400
Received: (qmail 7140 invoked by uid 107); 6 Apr 2011 17:55:04 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 13:55:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 13:54:13 -0400
Content-Disposition: inline
In-Reply-To: <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170995>

On Wed, Apr 06, 2011 at 10:20:55AM -0700, Junio C Hamano wrote:

> > There are a few possible solutions:
> >
> >   1. Flip the order of initialization, so that we don't start writing
> >      anything until the pack-objects reader is already in place. That
> >      works in this case, and the patch is at the end of this mail. The
> >      biggest problem is that it doesn't fix the general case.
> 
> In what sense are you not fixing "the general case", though?
> 
> If a program runs two threads, both of which access the FILE streams, it
> should be the responsibility of the program to get these threads
> coordinated to avoid such races and deadlocks, no?

Yes, but the problem is that looking at the code of the two threads, you
would never realize there is a deadlock. They never intentionally try to
touch the same stream. The real problem is buried in the run-command
code which calls fflush(NULL). This is inherently thread-unsafe, because
it wants to touch global data. It does do proper locking, at least, but
there is a deadlock issue, as demonstrated here.

We could do something like this:

diff --git a/run-command.c b/run-command.c
index 8619c76..ec8a2e6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,6 +2,21 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
+static void flush_one(FILE *fh) {
+	/* if we can't get the lock, some thread
+	 * is already writing/flushing it */
+	if (ftrylockfile(fh))
+		return;
+
+	fflush(fh);
+	funlockfile(fh);
+}
+
+static void flush_all() {
+	flush_one(stdout);
+	flush_one(stderr);
+}
+
 static inline void close_pair(int fd[2])
 {
 	close(fd[0]);
@@ -199,7 +214,7 @@ fail_pipe:
 	}
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
-	fflush(NULL);
+	flush_all();
 
 #ifndef WIN32
 {
@@ -530,7 +545,7 @@ int start_async(struct async *async)
 
 #ifdef NO_PTHREADS
 	/* Flush stdio before fork() to avoid cloning buffers */
-	fflush(NULL);
+	flush_all();
 
 	async->pid = fork();
 	if (async->pid < 0) {

but I'm not all that happy with it. It does remove the deadlock, though
it makes the race condition for duplicate output slightly worse.  The
comment in this hunk:

+static void flush_one(FILE *fh) {
+	/* if we can't get the lock, some thread
+	 * is already writing/flushing it */
+	if (ftrylockfile(fh))
+		return;

is a little optimistic. Somebody may be writing to the stream, but not
enough to flush. We fail to flush, and then the forked process has the
duplicated buffer. To be fair, this race condition already exists. If a
thread is writing and not flushing a buffer, it may do a write after the
fflush(NULL) but before the fork, anyway.

Of slightly more concern is this hunk:

+static void flush_all() {
+	flush_one(stdout);
+	flush_one(stderr);
+}

which obviously is not really "all" but just a fixed set of descriptors.
But AFAIK, there is no portable way to get the list of all streams (even
though it clearly must exist to implement fflush(NULL) properly).

I wonder if that matters, though. Consider why we fflush(NULL); it is to
avoid duplicate output across a fork. But we fork in only two cases:

  1. To start an async process when we don't have pthreads. But for this
     to be a problem, we must be using pthreads already.

  2. To immediately exec a command. In that case, we control the whole
     code path up to the point of exec (at which point we no longer care
     about duplicated buffers), so we know which streams will be written
     to. I assumed it was just stderr, but actually I think it may be
     none at all. We replace the die routine with one that writes
     straight to the stderr descriptor.

So I am wondering if we could simply drop the fflush(NULL) entirely in
the start_command case. And in the start_async case, move it inside the
NO_PTHREADS case.

I guess the fflush does do one other thing; it makes sure that output on
a single descriptor is ordered sensibly. And we would be losing that.

Bleh. I hate parallel programming. Maybe my original fix is the right
thing to do. It's simple and obviously correct. It does mean we might
run into this problem again, but we really don't use threads very much,
so it's probably not worth spending too much up-front effort to prevent
a later coding error that is not very likely to occur.

I do still wonder about the win32 deadlock that Erik mentioned. Does my
patch help at all, or is there another bug hiding somewhere? This
particular deadlock only occurs with shallow clones.

-Peff
