Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2726FC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0809620758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgERU64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:58:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:50308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726270AbgERU64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:58:56 -0400
Received: (qmail 21687 invoked by uid 109); 18 May 2020 20:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 20:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6729 invoked by uid 111); 18 May 2020 20:58:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 16:58:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 16:58:54 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200518205854.GB63978@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <20200518165056.GD42240@coredump.intra.peff.net>
 <20200518173652.GB2462058@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518173652.GB2462058@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 01:36:52PM -0400, Denton Liu wrote:

> > So I dunno. The "0002" solution is slightly more flexible, but I'm not
> > sure it helps in practice. And it does eat up one of our two remaining
> > special packet markers.
> 
> Yeah, I was worried about consuming a special packet. One alternative
> that I considered but is kind of gross is sending something like
> "0028gitremote-helper: response complete\n" instead of "0002". Then,
> instead of "0002" checks, we can check for that special string instead.
> I don't _think_ that stateless-connect currently allows for completely
> arbitrary data but I might be mistaken.

Yeah, I think we should avoid using any packet that could be confused
with regular output. A well-functioning server should have sent a flush
already, and so the worst case would probably be that we would mistake
their "0028" packet for ours if the network happens to cut out right at
that moment (and even that is obviously exceedingly unlikely). But it
just seems easier to reason about if we know we can't get confused.

> This was the original approach that I was working on but I found it to
> be much too invasive for my liking. (Also, I never actually managed to
> get it working ;) ) I think I gave up when I realised I had to insert
> reframing logic into index-pack and unpack-objects.

Yuck. :) I think v0 does it by unwrapping the extra layer in fetch-pack,
but I'd have to double check. But I'm not going to, because I think we
both agree that your other approaches are way nicer.

> > So I think either of your solutions (enforcing a final flush, or the
> > 0002 packet) is preferable. I'm on the fence between them.
> 
> I'm mostly on the fence too. One advantage of 0002, however, is that a
> malicious server can't end a request with 0002 as that's explicitly
> prevented. If a malicious server closes a connection after sending a
> 0000, I think that they could cause a deadlock to happen if there are
> multiple flush packets expected in a response. You mentioned in a
> sibling email that this currently doesn't happen wrt stateless-connect
> although I'm not sure if in the future, this is something that might
> change. I dunno.

Yeah, agreed that the efficacy of the "must end in flush" strategy
depends on there not being internal flushes. At least against a
determined attacker. But it may also be less random than you might
think, if the pattern is to send a flush, then do a bunch of work, etc.
A "random" hangup or error might be more likely to happen at the flush
points then (from the client's perspective).

So let's see if we can answer that question with less hand-waving.

The outer v2 capabilities conversation only writes out the capabilities
list, followed by a single flush (the packet_flush() call in
advertise_capabilities()). So far so good.

The only two v2 commands defined in serve.c are "ls-refs" and "fetch".

For "ls-refs", we end up in ls_refs(). That writes only regular packets
via send_ref(), and then concludes with a single flush (we don't even
send a delim; the client does that to specify options). Good.

For "fetch", we end up in upload_pack_v2(). We write via
process_haves_and_send_acks(), which will either:

  1. Write nothing and return 1.

  2. Write a delim and return 1.

  3. Write a flush packet and return 0.

In the final case, we jump to FETCH_DONE. So this really is the final
thing we say. Good.

In the first two cases, we jump to FETCH_SEND_PACK. We may write out
wanted-ref info, followed by a delim. OK. Then shallow info, followed by
a delim. OK. Then the actual packfile via create_pack_file(). There our
write behavior depends on use_sideband. If not set, we just dump data
directly. If set, then we packetize. And it will always be set for v2
(we do it unconditionally in the beginning of upload_pack_v2()).

So we only need to care about use_sideband cases. And there we may send
keepalives, but those are "0005\1" empty data packets. OK. We may send
data via send_client_data(), but those will be real data packets. And
then finally we give a single packet_flush(). Good.

So I think we can say that yes, the protocol as designed will send a
flush at the end of every response, and will not ever send another
flush.

_But_ that's if all goes well. If upload-pack sees an error, it may:

  - write an ERR packet in the earlier non-sideband steps, and then die

  - write a sideband 3 packet in later steps, and then die

  - just die() in some cases (e.g., pack-objects failed to start)

Obviously these are all an error on the client. And that third one
especially is probably a hanging case that we'd like to fix with this
series. But in the other two, we'd definitely want to make sure that
remote-curl doesn't complain too early or too loudly, and that the error
is shown to the user.

I think if remote-curl is just asking "did we see a flush packet at the
end" then it is likely to complain unnecessarily in that case. And I
don't think it should be inspecting packets for ERR or sideband-3. It
doesn't know enough about the rest of the conversation to know which is
correct. Though I guess we'd really only have to inspect the final
packet.

I really wish we had converted all ERRs into packet 0002 as part of the
v2 conversion. Then somebody reading only at the pktline level could
truly understand or proxy a full conversation without understanding
anything about what's in the pktlines. But it's too late for that now.

So I think our options are probably:

  1. detect flush packets in remote-curl, and either:

     a. don't print an error, just hang up. That prevents a hang in the
	caller and produces no extra message on a real error. It may be
	less informative than it could be if the connection hangs up
	(though we may print a curl error message, and the caller will
	at least say "the helper hung up")

     b. like (a), but always print an error; this is your original
	patch, but I _suspect_ (but didn't test) that it would produce
	extra useless messages for errors the server reports

     c. between the two: inspect the final packet data for evidence of
        ERR/sideband 3 and suppress any message if found

  2. helper signals end-of-response to caller (then it never produces a
     message itself; only the caller does, and it would abort on an ERR
     packet before then)

     a. using a special pktline (your "0002" patch)

     b. some other out-of-band mechanism (e.g., could be another fd)

I think this is pushing me towards 2a, your "0002" patch. It sidesteps
the error-message questions entirely (and I think 2b is too convoluted
to be worth pursuing, especially on Windows where setting up extra pipes
is tricky). But I'd also be OK with 1a or 1c.

-Peff
