From: Jeff King <peff@peff.net>
Subject: [RFC] upload-pack deadlock
Date: Mon, 4 Apr 2011 01:36:26 -0400
Message-ID: <20110404053626.GA26529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Aman Gupta <aman@github.com>,
	Ryan Tomayko <ryan@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 07:36:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6cT4-00051k-Aj
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 07:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab1DDFgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 01:36:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43334
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab1DDFgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 01:36:32 -0400
Received: (qmail 1848 invoked by uid 107); 4 Apr 2011 05:37:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Apr 2011 01:37:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2011 01:36:26 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170789>

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

Most of the time it doesn't happen, because the main thread manages to
call fflush(NULL) before the rev-list thread manages to block. But it's
easy to reproduce if you apply this patch:

diff --git a/upload-pack.c b/upload-pack.c
index bba053f..ceaef86 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -189,6 +189,7 @@ static void create_pack_file(void)
 	pack_objects.git_cmd = 1;
 	pack_objects.argv = argv;
 
+	sleep(1);
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
 

which slows the main thread just enough. With that applied, I can
reproduce reliably by running:

  git clone --depth 1 file://$GIT

where $GIT is some repo that is large enough that its rev-list output
will fill the OS's pipe buffer (I used git.git).

The end of the strace looks like this (27315 is the parent, 27316 is the
thread):

[pid 27316] write(4, "0ac7ec43918a5af59f1a305d47cd16ed"..., 4096) = 4096
[pid 27316] write(4, "entation/RelNotes/1.5.3.txt\nd4e4"..., 4096) = 4096
[pid 27316] write(4, "elNotes/1.6.5.3.txt\nd3a2a3e71243"..., 4096) = 4096
[pid 27316] write(4, "cumentation/docbook.xsl\nae413e52"..., 4096) = 4096
[pid 27316] write(4, "5d5c06cc37c7a203f758 Documentati"..., 4096 <unfinished ...>
[pid 27315] <... nanosleep resumed> 0x7fff053d81e0) = 0
[pid 27315] pipe([5, 6])                = 0
[pid 27315] pipe([7, 8])                = 0
[pid 27315] futex(0x82c930, FUTEX_WAIT_PRIVATE, 2, NULL

So you see the thread blocking on write, and the parent process stuck
trying to get the lock.

There are a few possible solutions:

  1. Flip the order of initialization, so that we don't start writing
     anything until the pack-objects reader is already in place. That
     works in this case, and the patch is at the end of this mail. The
     biggest problem is that it doesn't fix the general case.

  2. Rewrite the async rev-list into a separate rev-list invocation.
     There is no deadlock without threads (and this works fine if
     start_async uses fork() on your system). The problem is that I'm
     not sure what the thread is doing is possible via a rev-list
     invocation. And it's a lot more error-prone than (1), but still
     doesn't fix the general case.

  3. Make run-command fflush just stdout and stderr before calling fork.
     The reasons to flush before forking are:

       a. Avoid duplicated output when the forked process might be
          writing to the stream (and then both sides will end up
          outputting whatever cruft was in the buffer). But the point of
          run-command is to exec something, so the only stream we are
          likely to write to before exec'ing something (and losing those
          buffers anyway) is going to be stderr.

       b. Provide sane ordering of output. If you write something to
          a stream and then run a new command, you expect your output to
          come before the sub-command's.

     Doing (a) is easy; we really just need to flush stderr. Doing (b)
     is harder.  Most of the time the buffer you would want to flush is
     going to be stdout. But it's possible for it to be some other FILE
     stream pointing to a pipe.

     So the best we can do is to flush the common things that are
     probably safe, and then any callers who really care about the
     ordering of other output will have to fflush() their outputs
     manually.

     It would be nice to do the opposite: have everything flushed unless
     the caller says "no, this stream is being taken care of in a
     thread, so don't worry about it". But I don't think there is any
     way to do that. fflush(NULL) flushes everything, and there is no
     way to even get a list of what it _would_ flush so that we could do
     it ourselves.

     But of course that doesn't really fix the problem. It just
     restricts it to stdout and stderr. But once we have the actual list
     of things to flush, we can use ftrylockfile() to just try flushing
     each one (ftrylockfile is probably not available everywhere, but it
     is in POSIX.1-2001, which hopefully means it's available where we
     have pthreads).

I am tempted to go with (1), as it's simple and unlikely to introduce
new bugs. There are a few other start_async callsites with threads that
output to stdio: demuxers which call recv_sideband. They write to
stderr, but since they are just relaying stderr from the remote side, it
is unlikely that a well-behaved remote would send enough to actually
cause stderr to block. OTOH, I know Erik has mentioned some deadlock
problems on Windows when sideband-64k is enabled, so that might be
related (we start_async the demuxer and then spawn pack-objects).

Comments/ideas? Patch for approach (1) is below.

---
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
