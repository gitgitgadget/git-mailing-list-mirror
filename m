From: Jeff King <peff@github.com>
Subject: Re: [RFC] upload-pack deadlock
Date: Wed, 6 Apr 2011 17:33:33 -0400
Message-ID: <20110406213333.GA18481@sigill.intra.peff.net>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aM9-0001uj-KU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab1DFVdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:33:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43531
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932330Ab1DFVdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:33:36 -0400
Received: (qmail 9469 invoked by uid 107); 6 Apr 2011 21:34:23 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 17:34:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 17:33:33 -0400
Content-Disposition: inline
In-Reply-To: <20110406175413.GA8205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171018>

On Wed, Apr 06, 2011 at 01:54:13PM -0400, Jeff King wrote:

> So I am wondering if we could simply drop the fflush(NULL) entirely in
> the start_command case. And in the start_async case, move it inside the
> NO_PTHREADS case.
> 
> I guess the fflush does do one other thing; it makes sure that output on
> a single descriptor is ordered sensibly. And we would be losing that.

After reading 13af8cb (start_command: flush buffers in the WIN32 code
path as well, 2011-02-04), I think dropping the fflush is a bad idea.
Let's do the simple and safe fix, and if this type of problem actually
comes up more than once, then I'll think about over-engineering an
abstraction to fix it. :)

Here it is with a nice commit message.

-- >8 --
Subject: [PATCH] upload-pack: start pack-objects before async rev-list

In a pthread-enabled version of upload-pack, there's a race condition
that can cause a deadlock on the fflush(NULL) we call from run-command.

What happens is this:

  1. Upload-pack is informed we are doing a shallow clone.

  2. We call start_async() to spawn a thread that will generate rev-list
     results to feed to pack-objects. It gets a file descriptor to a
     pipe which will eventually hook to pack-objects.

  3. The rev-list thread uses fdopen to create a new output stream
     around the fd we gave it, called pack_pipe.

  4. The thread writes results to pack_pipe. Outside of our control,
     libc is doing locking on the stream. We keep writing until the OS
     pipe buffer is full, and then we block in write(), still holding
     the lock.

  5. The main thread now uses start_command to spawn pack-objects.
     Before forking, it calls fflush(NULL) to flush every stdio output
     buffer. It blocks trying to get the lock on pack_pipe.

And we have a deadlock. The thread will block until somebody starts
reading from the pipe. But nobody will read from the pipe until we
finish flushing to the pipe.

To fix this, we swap the start order: we start the
pack-objects reader first, and then the rev-list writer
after. Thus the problematic fflush(NULL) happens before we
even open the new file descriptor (and even if it didn't,
flushing should no longer block, as the reader at the end of
the pipe is now active).

Signed-off-by: Jeff King <peff@peff.net>
---
And the result is one line shorter, so it _must_ be good.

 upload-pack.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bba053f..ce5cbbe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -157,15 +157,8 @@ static void create_pack_file(void)
 	const char *argv[10];
 	int arg = 0;
 
-	if (shallow_nr) {
-		memset(&rev_list, 0, sizeof(rev_list));
-		rev_list.proc = do_rev_list;
-		rev_list.out = -1;
-		if (start_async(&rev_list))
-			die("git upload-pack: unable to fork git-rev-list");
-		argv[arg++] = "pack-objects";
-	} else {
-		argv[arg++] = "pack-objects";
+	argv[arg++] = "pack-objects";
+	if (!shallow_nr) {
 		argv[arg++] = "--revs";
 		if (create_full_pack)
 			argv[arg++] = "--all";
@@ -183,7 +176,7 @@ static void create_pack_file(void)
 	argv[arg++] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in = shallow_nr ? rev_list.out : -1;
+	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
@@ -192,8 +185,14 @@ static void create_pack_file(void)
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
 
-	/* pass on revisions we (don't) want */
-	if (!shallow_nr) {
+	if (shallow_nr) {
+		memset(&rev_list, 0, sizeof(rev_list));
+		rev_list.proc = do_rev_list;
+		rev_list.out = pack_objects.in;
+		if (start_async(&rev_list))
+			die("git upload-pack: unable to fork git-rev-list");
+	}
+	else {
 		FILE *pipe_fd = xfdopen(pack_objects.in, "w");
 		if (!create_full_pack) {
 			int i;
-- 
1.7.4.3.13.g0b769.dirty
