Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63B5C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 22:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99DF610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 22:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbhIIW7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:59:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:43402 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347053AbhIIW7I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 18:59:08 -0400
Received: (qmail 1242 invoked by uid 109); 9 Sep 2021 22:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 22:57:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17819 invoked by uid 111); 9 Sep 2021 22:57:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 18:57:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 18:57:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Max Kirillov <max@max630.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5562: use alarm() to interrupt timed child-wait
Message-ID: <YTqRdU1Tgn/HVhdA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The t5562 script occasionally takes 60 extra seconds to complete due to
a race condition in the invoke-with-content-length.pl helper.

The way it's supposed to work is this:

  - we set up a SIGCLD handler

  - we kick off http-backend and write to it with a set content-length,
    but _don't_ close the pipe

  - we sleep for 60 seconds, assuming that SIGCLD from http-backend
    finishing will interrupt us

  - after the sleep finishes (whetherby 60 seconds or because it was
    interrupted by the signal), we check a flag to see if our SIGCLD
    handler was called. If not, then we complain.

This usually completes immediately, because the signal interrupts our
sleep. But very occasionally the child process dies _before_ we hit the
sleep, so we don't realize it. The test still completes successfully
(because our $exited flag is set), but it takes an extra 60 seconds.

There's no way to check the flag and sleep atomically. So the best we
can do with this approach is to sleep in smaller chunks (say, 1 second)
and check the flag incrementally. Then we waste a maximum of 1 second if
we lose the race. This was proposed in:

  https://lore.kernel.org/git/20190218205028.32486-1-max@max630.net/

and it does work. But we can do better.

Instead of blocking on sleep and waiting for the child signal to
interrupt us, we can block on the child exiting and set an alarm signal
to trigger the timeout.

This lets us exit the script immediately when the child behaves (with no
race possible), and wait a maximum of 60 seconds when it doesn't.

Note one small subtlety: perl is very willing to restart the waitpid()
call after the alarm is delivered, even if we've thrown an exception via
die. "perldoc -f alarm" claims you can get around this with an eval/die
combo (and even has some example code), but it doesn't seem to work for
me with waitpid(); instead, we continue waiting until the child exits.

So instead, we'll instruct the child process to exit in the alarm
handler itself. In the original code this was done by calling
close($out). That would continue to work, since our child is always
http-backend, which should exit when its stdin closes. But we can be
even more robust against a hung or confused child by sending a KILL
signal, which should terminate it immediately.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was discussed recently in:

  https://lore.kernel.org/git/YRretXfEfiVujSeO@coredump.intra.peff.net/

I had planned to resurrect Max's patch (linked above), but came up with
this better solution.

 t/t5562/invoke-with-content-length.pl | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 0943474af2..718dd9b49d 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -13,11 +13,6 @@
 defined read($body_fh, $body_data, $body_size) or die "Cannot read $body_filename: $!";
 close($body_fh);
 
-my $exited = 0;
-$SIG{"CHLD"} = sub {
-        $exited = 1;
-};
-
 # write data
 my $pid = open(my $out, "|-", @command);
 {
@@ -29,8 +24,13 @@
 }
 print $out $body_data or die "Cannot write data: $!";
 
-sleep 60; # is interrupted by SIGCHLD
-if (!$exited) {
-        close($out);
+$SIG{ALRM} = sub {
+        kill 'KILL', $pid;
         die "Command did not exit after reading whole body";
+};
+alarm 60;
+
+my $ret = waitpid($pid, 0);
+if ($ret != $pid) {
+        die "confusing return from waitpid: $ret";
 }
-- 
2.33.0.731.g46856368d1
