Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC27E1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeDCUcj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 16:32:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753078AbeDCUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 16:32:36 -0400
Received: (qmail 17678 invoked by uid 109); 3 Apr 2018 20:32:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 20:32:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32057 invoked by uid 111); 3 Apr 2018 20:33:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 16:33:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 16:32:33 -0400
Date:   Tue, 3 Apr 2018 16:32:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Palus <jpalus@fastmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Timing issue in t5570 "daemon log records all attributes"
Message-ID: <20180403203233.GB15157@sigill.intra.peff.net>
References: <1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 09:33:10PM +0200, Jan Palus wrote:

> My understanding of test "daemon log records all attributes" is that daemon
> process is started in background, some git command is executed and daemon's
> output (saved to daemon.log) is compared against expected value. However
> daemon.log is not a straight redirect to file -- it is being piped through fifo,
> read by a loop in test-git-daemon.sh, additional processing is performed and
> finally it makes it to daemon.log. All of this performed concurrently with test
> execution. My question is how do you exactly avoid timing issues here? grep on
> daemon.log is performed immediately after git invocation:
> 
>         >daemon.log &&
>         GIT_OVERRIDE_VIRTUAL_HOST=localhost \
>                 git -c protocol.version=1 \
>                         ls-remote "$GIT_DAEMON_URL/interp.git" &&
>         grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
> 
> how can you be sure grep operates on daemon.log that already includes all output
> and not on intermediate state that is just being processed by while loop? Same
> question applies to ">daemon.log" since shell might still be processing output
> of previous test and its content might possibly land in the file after zeroing.

You're right, this is racy. You can see it much more obviously with:

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index edbea2d986..3c7fea169b 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -62,6 +62,7 @@ start_git_daemon() {
 		(
 			while read -r line <&7
 			do
+				sleep 1
 				printf "%s\n" "$line"
 				printf >&4 "%s\n" "$line"
 			done

I'm not sure of the best solution. Even if we removed the shell-loop
pumping the data from the fifo, it's still possible to race if
git-daemon hangs up the client socket before flushing its log output
(since our only real synchronization is waiting for the client to exit).

Nor could we even wait for an EOF on the fifo, since we won't get one
until the daemon actually exits.

If we want to do it without polling, I think the best we could do is
have the pumping loop key on some particular line in the output as a
synchronization point, and then trigger _another_ fifo that the test
snippet listens on. Yuck.

I'm tempted to say we should just scrap this test. It was added
relatively recently and only shows the fix for a pretty minor bug.
It's probably not worth the contortions to make it race-proof.

-Peff
