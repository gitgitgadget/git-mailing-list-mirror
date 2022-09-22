Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFF9ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiIVWJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIVWJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:09:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D491129E3
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:09:26 -0700 (PDT)
Received: (qmail 9272 invoked by uid 109); 22 Sep 2022 22:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 22:09:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8409 invoked by uid 111); 22 Sep 2022 22:09:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 18:09:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 18:09:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH 1/3] wincred: ignore unknown lines (do not die)
Message-ID: <YyzdFBaiWgCJzMWX@coredump.intra.peff.net>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
 <6426f9c3954866b3fd9259d1a58d2c41dc42e17f.1663865974.git.gitgitgadget@gmail.com>
 <xmqqbkr7xg28.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkr7xg28.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 02:19:43PM -0700, Junio C Hamano wrote:

> > It is the expectation that credential helpers be liberal in what they
> > accept and conservative in what they return, to allow for future growth
> > and evolution of the protocol/interaction.
> 
> That is nice in principle, and the updated code below may work well
> with existing "other side of the connection" (codepaths in "git"
> that asks credential API to talk to the helpers), but I am not sure
> if this is always a safe thing to do.
> 
> When we gain a new "command" in the protocol, if we just read it
> without understanding it, would we open ourselves to a risk of
> breaking the protocol communication, worst of which may be to
> deadlock?  A new command, when received by a more recent helper that
> understands how to react to it, may _require_ it to write more than
> "username" and "password" back to "git" from get_credential(), for
> example, but the helper with this patch alone, while not complaining
> about seeing such a new and unknown command, would not know how to
> compute and write that third thing other than "username" and
> "password"---would the other side who issued that new command get
> stuck waiting for us to return the third thing?  Worse yet, the new
> command may expect us to read further in get_credential()
> (e.g. maybe they will give us a challenge, which may need to be used
> when yielding the "username" and "password" things), but because we
> do not even know we need to read, their attempt to write to us may
> get them stuck, and that is when we are expecting to write to them,
> easily leading to a deadlock, no?

This open-endedness was an intentional part of the original
credential-helper design. Helpers are always "best effort", and it is OK
if they ignore a request, or return a partial result. If the sending
side really wants to extend the protocol in a way that the other side
doesn't act at all (say, they "username" to be used _only_ if the helper
also understands a new "foobar" key), then they should be adding the new
fields as an atomic unit. I.e., "foobar", "foobar-userame", and so on.
And then existing helpers which don't understand the new feature will
just ignore it totally.

In practice, I think it's not that big a deal either way, because the
setup of these helpers is under the control of the user. So if you
really want to use "foobar" but a helper doesn't support it, then you'd
just remove that helper from your config.

-Peff
