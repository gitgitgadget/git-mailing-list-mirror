Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3AE22047F
	for <e@80x24.org>; Thu, 27 Jul 2017 01:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdG0BIo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 21:08:44 -0400
Received: from avasout06.plus.net ([212.159.14.18]:54848 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdG0BIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 21:08:43 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id pd8g1v00918PUFB01d8hRg; Thu, 27 Jul 2017 02:08:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7c8W14kr3H2GgJVUqoEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Devin Lehmacher <lehmacdj@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] credential-cache: interpret an ECONNRESET as on EOF
Message-ID: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
Date:   Thu, 27 Jul 2017 02:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Since commit 612c49e94d ("credential-cache: add tests for XDG
functionality", 17-03-2017), the cygwin build has been failing all the
new tests added by that commit. In particular, the 'git credential-cache
exit' command, as part of the test cleanup code, has been die-ing with
the message:

    fatal: read error from cache daemon: Connection reset by peer

As this git command is part of an && chain in a 'test_when_finished'
call, the remaining test cleanup is not happening, so practically all
remaining tests fail due to the unexpected presence of various socket
files and directories.

A simple means of getting the tests to pass, is to simply ignore the
failure of 'git credential-cache exit' command and make sure all test
cleanup is done. For example, the diff for test #12 would look like:

    diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
    index fd92533ac..87e5001bb 100755
    --- a/t/t0301-credential-cache.sh
    +++ b/t/t0301-credential-cache.sh
    @@ -17,7 +17,7 @@ helper_test cache

     test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
            test_when_finished "
    -               git credential-cache exit &&
    +               (git credential-cache exit || :) &&
                    rmdir -p .cache/git/credential/
            " &&
            test_path_is_missing "$HOME/.git-credential-cache" &&

... and so on for all remaining tests. While this does indeed make all
tests pass, it is not really a solution.

As an aside, while looking to debug this issue, I added the '--debug'
option to the invocation of the 'git-credential-cache--daemon' child
process (see the spawn_daemon() function). This not only fixed the tests,
but also stopped git-credential-cache exiting with a failure. Since the
only effect of passing '--debug' was to suppress the redirection of stderr
to the bit-bucket (/dev/null), I have no idea why this seems to fix the
protocol interaction between git and git-credential-cache--daemon. (I
did think that maybe it was a timing issue, so I tried sleeping before
reading from the daemon on Linux, but that only slowed down the tests!)

All descriptions of the "Connection reset by peer" error, that I could
find, say that the peer had destroyed the connection before the client
attempted to perform I/O on the connection. Since the daemon does not
respond to an "exit" message from the client, it just closes the socket
and deletes the socket file (via the atexit handler), it seems that the
expected result is for the client to receive an EOF.  Indeed, this is
exactly what seems to be happening on Linux. Also a comment in
credential-cache--daemon.c reads:

    else if (!strcmp(action.buf, "exit")) {
            /*
             * It's important that we clean up our socket first, and then
             * signal the client only once we have finished the cleanup.
             * Calling exit() directly does this, because we clean up in
             * our atexit() handler, and then signal the client when our
             * process actually ends, which closes the socket and gives
             * them EOF.
             */
            exit(0);
    }

On cygwin this is not the case, at least when not passing --debug to the
daemon, and the read following the "exit" gets an error with errno set
to ECONNRESET.

In order to suppress the fatal exit in this case, check the read error
for an ECONNRESET and return as if no data was read from the daemon.
This effectively converts an ECONNRESET into an EOF.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index 91550bfb0..1cccc3a0b 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -25,7 +25,7 @@ static int send_request(const char *socket, const struct strbuf *out)
 		int r;
 
 		r = read_in_full(fd, in, sizeof(in));
-		if (r == 0)
+		if (r == 0 || (r < 0 && errno == ECONNRESET))
 			break;
 		if (r < 0)
 			die_errno("read error from cache daemon");
-- 
2.13.0
