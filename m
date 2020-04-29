Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A212C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AC420787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 07:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD2H4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:56:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:43386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbgD2H4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 03:56:06 -0400
Received: (qmail 30653 invoked by uid 109); 29 Apr 2020 07:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Apr 2020 07:56:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11205 invoked by uid 111); 29 Apr 2020 08:07:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2020 04:07:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Apr 2020 03:56:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
Message-ID: <20200429075604.GA637261@coredump.intra.peff.net>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
 <20200414123257.27449-4-worldhello.net@gmail.com>
 <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
 <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
 <xmqqzhbc61jv.fsf@gitster.c.googlers.com>
 <CANYiYbGNTMpdvW7AGs-drOuwhzcR_CJnsCE9TjAWujZtb3cfEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANYiYbGNTMpdvW7AGs-drOuwhzcR_CJnsCE9TjAWujZtb3cfEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 01:00:00AM +0800, Jiang Xin wrote:

> For over a week, I have not received more comments on reroll v13 on
> this topic ("jx/proc-receive-hook"). Therefore, I invite Peff and
> Couder to review because I think it would be very interesting to add a
> centralized workflow to Github and Gitlab.
> 
>  * [PATCH v13 3/8]:
> https://public-inbox.org/git/20200418160334.15631-4-worldhello.net@gmail.com/
> 
> This patch introduces a new hook "proc-receive" on the server side. It
> won't break anything except GitHub's "spokes" architecture (I guess).
> Because in Alibaba, we have such issue when we implement our own
> "spokes" architecture.  In order to make this special push operation
> (on a special ref such as "refs/for/master/topic") idempotently on
> multiple replicas, we extended the protocol of "receive-pack" and let
> "spokes" to send a request with a flag, which specifies one replica as
> master replica to execute the "proc-receive" hook.

We don't do any magic ref-rewriting like this, so we wouldn't turn such
a hook on. Presumably without such a hook, the protocol would remain the
same (i.e., if there was no rewrite, then the report-status response
wouldn't have the extra field).

And I'm not sure if you're proposing to also use it as the trigger point
to coordinate the ref update across replicas. That wouldn't be helpful
for our architecture. All Git client connections to GitHub terminate at
a proxy layer that handles load balancing, authentication, and routing.
For pushes, that's the layer that multiplexes the packfile to each
replica, and it drives the ref update through an out-of-band procedure.
So there is no master replica at all; they're all talking equally to the
proxy layer which coordinates things (and the same is true for non-push
updates; they're coordinated by whichever entity is trying to perform
the update).

We do run receive-pack on each replica backend. We have a hacky patch
for a config option that tells receive-pack to just skip the actual
ref-transaction, leaving it up to the proxy layer to do. I've been
pushing for us to actually abandon receive-pack entirely, since most of
its heavy lifting can be done by sub-programs (for-each-ref for the
advertisement, index-pack to receive the pack, and update-ref to update
refs). But it's a non-trivial change, and the benefits are only
moderate, so it hasn't quite been worth the effort yet.

So I don't really have much of an opinion on it either way.

Reading the commit message for patch 3, I do have one small comment. I
see this:

  The reporting function from "receive-pack" to "send-pack" is extended
  using a backward compatible way by adding key-value pairs after an null
  character, like:
  
      # OK, run this command successfully with optional extended-status.
      ok <reference>\0ref=refs/pull/123/head old-oid=...
  
      # NO, I reject it.
      ng <reference> <error message>

but we should probably avoid trickery like stuffing extra data after a
NUL byte. We could quite easily extend the protocol with a new
capability here. The server advertises "report-status-v2" or something,
and the client responds with the appropriate capability to indicate that
it understands. And then the new format can be something more
extensible, like:

  pktline(ref=refs/heads/master)
  pktline(status=ok)
  pktline(old-oid=...)
  pktline(rewrite=refs/pull/123/head)
  delim-pkt(0001)
  pktline(ref=refs/heads/other)
  pktline(status=error)
  pktline(message=<error message>
  flush-pkt(0000)

which would give us room for more keys later, but without worrying about
parsing issues after the NUL, running out of room in a pktline if you
have too many keys, etc.

I don't have any real thoughts on the hook interface itself. It seems
like the ok/no/ft/alt responses would allow just about any hook you'd
want. It does seems to also use NUL trickery in the early part. If we're
designing from scratch, I think we should strive for a cleaner protocol.

-Peff
