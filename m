Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665121F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfKMCHW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:07:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:46102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729697AbfKMCHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:07:21 -0500
Received: (qmail 10995 invoked by uid 109); 13 Nov 2019 02:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 02:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21531 invoked by uid 111); 13 Nov 2019 02:10:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 21:10:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 21:07:19 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: do people find t5504.8 flaky?
Message-ID: <20191113020719.GA435@sigill.intra.peff.net>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
 <20190423030254.GA19604@sigill.intra.peff.net>
 <20191113000747.GQ4348@szeder.dev>
 <20191113010337.GA20023@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113010337.GA20023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 08:03:37PM -0500, Jeff King wrote:

> So with that second patch above, the test failure goes away for me.

After poking at the behavior around connection dropping, I've convinced
myself this is the right thing to do. So here it is with a commit
message. I can't get the flaky test to fail anymore, but please let me
know if you do.

I didn't see a good way to use stock git to simulate a hung-up
connection (because it has to happen after the advertisement, while the
client is sending the pack). So I stuck an exit(0) at the end of
parse_pack_header() in receive-pack, just to verify how things work
before and after my patch (which, spoiler alert, is exactly the same).

-- >8 --
Subject: [PATCH] send-pack: check remote ref status on pack-objects failure

When we're pushing a pack and our local pack-objects fails, we enter an
error code path that does a few things:

  1. Set the status of every ref to REF_STATUS_NONE

  2. Call receive_unpack_status() to try to get an error report from
     the other side

  3. Return an error to the caller

If pack-objects failed because the connection to the server dropped,
there's not much more we can do than report the hangup. And indeed, step
2 will try to read a packet from the other side, which will die() in the
packet-reading code with "the remote end hung up unexpectedly".

But if the connection _didn't_ die, then the most common issue is that
the remote index-pack or unpack-objects complained about our pack (we
could also have a local pack-objects error, but this ends up being the
same; we'd send an incomplete pack and the remote side would complain).

In that case we do report the error from the other side (because of step
2), but we fail to say anything further about the refs. The issue is
two-fold:

  - in step 1, the "NONE" status is not "we saw an error, so we have no
    status". It generally means "this ref did not match our refspecs, so
    we didn't try to push it". So when we print out the push status
    table, we won't mention any refs at all!

    But even if we had a status enum for "pack-objects error", we
    wouldn't want to blindly set it for every ref. For example, in a
    non-atomic push we might have rejected some refs already on the
    client side (e.g., REF_STATUS_REJECT_NODELETE) and we'd want to
    report that.

  - in step 2, we read just the unpack status. But receive-pack will
    also tell us about each ref (usually that it rejected them because
    of the unpacker error).

So a much better strategy is to leave the ref status fields as they are
(usually EXPECTING_REPORT) and then actually receive (and print) the
full per-ref status.

This case is actually covered in the test suite, as t5504.8, which
writes a pack that will be rejected by the remote unpack-objects. But
it's racy. Because our pack is small, most of the time pack-objects
manages to write the whole thing before the remote rejects it, and so it
returns success and we print out the errors from the remote. But very
occasionally (or when run under --stress) it goes slow enough to see a
failure in writing, and git-push reports nothing for the refs.

With this patch, the test should behave consistently.

There shouldn't be any downside to this approach. If we really did see
the connection drop, we'd already die in receive_unpack_status(), and
we'll continue to do so. If the connection drops _after_ we get the
unpack status but before we see any ref status, we'll still print the
remote unpacker error, but will now say "remote end hung up" instead of
returning the error up the call-stack. But as discussed, we weren't
showing anything more useful than that with the current code. And
anyway, that case is quite unlikely (the connection dropping at that
point would have to be unrelated to the pack-objects error, because of
the ordering of events).

In the future we might want to handle packet-read errors ourself instead
of dying, which would print a full ref status table even for hangups.
But in the meantime, this patch should be a strict improvement.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 34c77cbb1a..a7322d3278 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -565,8 +565,6 @@ int send_pack(struct send_pack_args *args,
 
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref = remote_refs; ref; ref = ref->next)
-				ref->status = REF_STATUS_NONE;
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
@@ -574,10 +572,12 @@ int send_pack(struct send_pack_args *args,
 
 			/*
 			 * Do not even bother with the return value; we know we
-			 * are failing, and just want the error() side effects.
+			 * are failing, and just want the error() side effects,
+			 * as well as marking refs with their remote status (if
+			 * we get one).
 			 */
 			if (status_report)
-				receive_unpack_status(&reader);
+				receive_status(&reader, remote_refs);
 
 			if (use_sideband) {
 				close(demux.out);
-- 
2.24.0.739.gb5632e4929

