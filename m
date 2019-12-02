Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CEC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985A20705
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLBOFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:05:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:36560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727164AbfLBOFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 09:05:54 -0500
Received: (qmail 30113 invoked by uid 109); 2 Dec 2019 14:05:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Dec 2019 14:05:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6228 invoked by uid 111); 2 Dec 2019 14:09:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2019 09:09:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Dec 2019 09:05:52 -0500
From:   Jeff King <peff@peff.net>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git-status performance with submodules
Message-ID: <20191202140552.GB16534@sigill.intra.peff.net>
References: <CALnO6CCoXOZTsfag6yN_Ffn+H7KE-KTzm+P-GqLKnDMg8j_Qmg@mail.gmail.com>
 <xmqq5zizz0ei.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zizz0ei.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 01, 2019 at 10:50:29PM -0800, Junio C Hamano wrote:

> But the way "git status" code is structured, it probably takes a bit
> of preparatory refactoring.  If I recall correctly, it walks each
> path in the index in the superproject and notes how the file in the
> working tree is different from that of the index and the HEAD, under
> the assumption that inspection of each path is relatively cheap and
> at the same cost.  You'd first need to restructure that part so that
> inspecting groups of index entries can be sharded to separate
> subprocesses while the parent process waits, and have them report to
> the parent process, and let the parent process continue with the
> aggregated result, or something like that.

There's some prior art for this approach in git-checkout, where we have
a similar problem with latency of filters (e.g., for LFS). There the
individual status for a path becomes a tri-state: success, error, or
deferred. And then we collect the results from the deferred ones in a
loop.

I think (but didn't look carefully) that this could be slotted into the
diff code pretty easily. After the tree-level diff we have a queue of
candidates in memory. At that point we should be able to kick off a
process in parallel for each submodule, then wait for them all to finish
before proceeding. Maybe even as a stage of diffcore_std(), but I'm not
sure.

(Hand-wavey, I know, but just trying to point interested folks in the
right direction).

-Peff
