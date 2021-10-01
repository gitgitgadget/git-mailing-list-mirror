Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B78C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6E761A57
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352139AbhJAG0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 02:26:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhJAG0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 02:26:37 -0400
Received: (qmail 26196 invoked by uid 109); 1 Oct 2021 06:24:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Oct 2021 06:24:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8272 invoked by uid 111); 1 Oct 2021 06:24:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Oct 2021 02:24:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Oct 2021 02:24:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
Message-ID: <YVaptAklXNShTY0j@coredump.intra.peff.net>
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
 <20210930132004.16075-1-chiyutianyi@gmail.com>
 <xmqqczoqdn4m.fsf@gitster.g>
 <CANYiYbHfw1=MLVv1+utXPUtg3mn1DoZGL0t5WH+w8sjdDrkHYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbHfw1=MLVv1+utXPUtg3mn1DoZGL0t5WH+w8sjdDrkHYA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:15AM +0800, Jiang Xin wrote:

> > Sure, it is called max_INPUT_object_size and we can say we are not
> > limiting the final disk size, and that might be a workable excuse
> > to check based on the obj->size here, but then its usefulness from
> > the point of view of end users, who decide to set the variable to
> > limit "some" usage, becomes dubious.
> 
> Just like what I replied to Ævar, if the max_input_object_size is
> greater than core.bigFileThreshold, is it save to save the size here
> is almost the actual "file size"?

If we are storing a pack with index-pack, the on-disk size will match
exactly this input size. If we unpack it to loose, then big files don't
tend to have deltas or to compress with zlib, but that is not always the
case. I have definitely seen people try to store gigantic text files.

If your goal is introduce a user-facing object-size limit, then I think
the "logical" size of the uncompressed object is the only thing that
makes sense. Everything else is subject to change, and can be gamed in
weird ways.

If your goal is to avoid malicious pushers causing you to allocate too
much memory, then you might want to have some limits on the compressed
sizes you'll deal with, especially for deltas. But I don't think the
checks here do that, because I can send a small delta that reconstructs
a much larger object (which we'd eventually reconstruct in order to
compute its sha1).

-Peff
