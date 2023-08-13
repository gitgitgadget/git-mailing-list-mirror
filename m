Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD0C001B0
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 16:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjHMQcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjHMQc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 12:32:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DE199E
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 09:32:06 -0700 (PDT)
Received: (qmail 27454 invoked by uid 109); 13 Aug 2023 16:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 13 Aug 2023 16:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17260 invoked by uid 111); 13 Aug 2023 16:24:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Aug 2023 12:24:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Aug 2023 12:24:40 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4053: avoid writing to unopened pipe
Message-ID: <20230813162440.GA1688763@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an occasional hang I see when running t4053 with
--verbose-log using dash.

Commit 1e3f26542a (diff --no-index: support reading from named pipes,
2023-07-05) added a test that "diff --no-index" will complain when
comparing a named pipe and a directory. The minimum we need to test this
is to mkfifo the pipe, and then run "git diff --no-index pipe some_dir".
But the test does one thing more: it spawns a background shell process
that opens the pipe for writing, like this:

        {
                (>pipe) &
        } &&

This extra writer _could_ be useful if Git misbehaves and tries to open
the pipe for reading. Without the writer, Git would block indefinitely
and the test would never end. But since we do not have such a bug, Git
does not open the pipe and it is the writing process which will block
indefinitely, since there are no readers. The test addresses this by
running "kill $!" in a test_when_finished block. Since the writer should
be blocking forever, this kill command will reliably find it waiting.

However, this seems to be somewhat racy, in that the writing process
sometimes hangs around even after the "kill". In a normal run of the
test script without options, this doesn't have any effect; the
main test script completes anyway. But with --verbose-log, we spawn a
"tee" process that reads the script output, and it won't end until all
descriptors pointing to its input pipe are closed. And the background
process that is hanging around still has its stderr, etc, pointed into
that pipe.

You can reproduce the situation like this:

  cd t
  ./t4053-diff-no-index.sh --verbose-log --stress

Let that run for a few minutes, and then you'll find that some of the
runs have hung. For example, at 11:53, I ran:

  $ ps xk start o pid,start,command | grep tee | head
   713459 11:48:06 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-9.out
   713527 11:48:06 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-15.out
   719434 11:48:07 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-1.out
   728117 11:48:08 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-5.out
   738738 11:48:09 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-31.out
   739457 11:48:09 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-27.out
   744432 11:48:10 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-21.out
   744471 11:48:10 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-29.out
   761961 11:48:12 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-0.out
   812299 11:48:19 tee -a /home/peff/compile/git/t/test-results/t4053-diff-no-index.stress-8.out

All of these have been hung for several minutes. We can investigate one
and see that it's waiting to get EOF on its input:

  $ strace -p 713459
  strace: Process 713459 attached
  read(0,
  ^C

Who else has that descriptor open?

  $ lsof -a -p 713459 -d 0 +E
  COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
  tee     713459 peff    0r  FIFO   0,13      0t0 3943636 pipe 719203,sh,5w 719203,sh,7w 719203,sh,12w 719203,sh,13w
  sh      719203 peff    5w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,7w 719203,sh,12w 719203,sh,13w
  sh      719203 peff    7w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,12w 719203,sh,13w
  sh      719203 peff   12w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,7w 719203,sh,13w
  sh      719203 peff   13w  FIFO   0,13      0t0 3943636 pipe 713459,tee,0r 719203,sh,5w 719203,sh,7w 719203,sh,12w

It's a shell, presumably a subshell spawned by the main script. Though
it may seem odd, having the same descriptor open several times is not
unreasonable (they're all basically the original stdout/stderr of the
script that has been copied). And they should all close when the process
exits. So what's it doing? Curiously, it will exit as soon as we strace
it:

  $ strace -s 64 -p 719203
  strace: Process 719203 attached
  openat(AT_FDCWD, "pipe", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 ENOENT (No such file or directory)
  write(2, "./t4053-diff-no-index.sh: 7: eval: ", 35) = 35
  write(2, "cannot create pipe: Directory nonexistent", 41) = 41
  write(2, "\n", 1)                       = 1
  exit_group(2)                           = ?
  +++ exited with 2 +++

I think what happens is this:

  - it is blocking in the openat() call for the pipe, as we expect (so
    this is definitely the backgrounded subshell mentioned above)

  - strace sends signals (probably STOP/CONT); those cause the kernel to
    stop blocking, but libc will restart the system call automatically

  - by this time, the "pipe" fifo is gone, so we'll actually try to
    create a regular file. But of course the surrounding directory is
    gone, too! So we get ENOENT, and then exit as normal.

So the blocking is something we expect to happen. But what we didn't
expect is for the process to still exist at all! It should have been
killed earlier when the parent process called "kill", but it wasn't. And
we can't catch the race at this point, because it happened much earlier.

One can guess, though, that there is some race with the shell setting up
the signal handling in the backgrounded subshell, and possibly blocking
or ignoring signals at the time that the "kill" is received.  Curiously,
the race does not seem to happen if I use "bash" instead of "dash", so
presumably bash's setup here is more atomic.

One fix might be to try killing the subshell more aggressively, either
using SIGKILL, or looping on kill/wait. But that seems complex and
likely to introduce new problems/races. Instead, we can observe that the
writer is not needed at all. Git will notice the pipe via stat() before
it is ever opened. So we can simply drop the writer subshell entirely.

If we ever changed Git to open the path and fstat() it, this would
result in the test hanging. But we're not likely to do that. After all,
we have to stat() paths to see if they are openable at all (e.g., it
could be a directory), so this seems like a low risk. And anybody who
does make such a change will immediately see the issue, as Git would
hang consistently.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4053-diff-no-index.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 1fb7d33462..6781cc9078 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -232,10 +232,6 @@ test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
 test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
 	test_when_finished "rm -f pipe" &&
 	mkfifo pipe &&
-	{
-		(>pipe) &
-	} &&
-	test_when_finished "kill $!" &&
 	test_must_fail git diff --no-index -- pipe a 2>err &&
 	grep "fatal: cannot compare a named pipe to a directory" err
 '
-- 
2.42.0.rc1.378.g7c0c59538f
