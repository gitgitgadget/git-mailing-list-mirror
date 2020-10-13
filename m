Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F5C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D094520EDD
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgJMTJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:09:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:58790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbgJMTJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:09:14 -0400
Received: (qmail 11733 invoked by uid 109); 13 Oct 2020 19:09:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Oct 2020 19:09:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7229 invoked by uid 111); 13 Oct 2020 19:09:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Oct 2020 15:09:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Oct 2020 15:09:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
Message-ID: <20201013190913.GB2994107@coredump.intra.peff.net>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
 <20201013185515.GA2994107@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013185515.GA2994107@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 02:55:15PM -0400, Jeff King wrote:

> But then in fbd76cd450 (sideband: reverse its dependency on pkt-line,
> 2019-01-16), the function became demultiplex_sideband(). The loop went
> away, and we pump only a single packet on each call. When we see
> sideband 2, we do an early return. But on sideband 1, we continue to the
> cleanup: label, which flushes the scratch buffer.
> 
> I think we need to return from there without hitting that cleanup label,
> like this:

By the way, the reason this works is that the "scratch" buffer persists
beyond individual calls to demultiplex_sideband(). So we can get away
with letting it persist between the two.

However unlike the original recv_sideband(), which broke out of the loop
on error and then flushed scratch, our post-fbd76cd450 does not do the
same. It now looks like:

int recv_sideband(const char *me, int in_stream, int out)
{
        char buf[LARGE_PACKET_MAX + 1];
        int len;
        struct strbuf scratch = STRBUF_INIT;
        enum sideband_type sideband_type;

        while (1) {
                len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
                                  0);
                if (!demultiplex_sideband(me, buf, len, 0, &scratch,
                                          &sideband_type))
                        continue;
                switch (sideband_type) {
                case SIDEBAND_PRIMARY:
                        write_or_die(out, buf + 1, len - 1);
                        break;
                default: /* errors: message already written */
                        return sideband_type;
                }
        }
}

I wondered if we could ever have a case where we broke out of the loop
with data left over in "scratch" (or its buffer left allocated). I think
the answer is no. We only break out of the loop if
demultiplex_sideband() returned non-zero _and_ its not the primary
sideband. So both before and after my suggested fix, we'd have hit the
cleanup label in demultiplex_sideband(), which flushes and frees the
buffer.

I do have to say that the original loop before that commit was a lot
easier to follow, though.

Another weirdness I noticed is that it doesn't distinguish a flush
packet (expected) from a zero-byte packet (an error). But neither did
the original. I would have guessed the zero-byte packet was meant to
trigger this second conditional:

        if (len == 0) {
                *sideband_type = SIDEBAND_FLUSH;
                goto cleanup;
        }
        if (len < 1) {
                strbuf_addf(scratch,
                            "%s%s: protocol error: no band designator",
                            scratch->len ? "\n" : "", me);
                *sideband_type = SIDEBAND_PROTOCOL_ERROR;
                goto cleanup;
        }

but we'd hit the first conditional before then. We would still trigger
the second if we saw EOF while reading the packet (because we set the
length to -1 then), but then it's arguably the wrong error to be
showing.

So I think this could be improved a bit by using
packet_read_with_status() in the recv_sideband() caller.

-Peff
