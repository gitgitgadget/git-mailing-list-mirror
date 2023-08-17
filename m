Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC0C2FC04
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbjHQFgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 01:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348114AbjHQFg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 01:36:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CA6E48
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 22:36:28 -0700 (PDT)
Received: (qmail 18763 invoked by uid 109); 17 Aug 2023 05:36:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 05:36:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25998 invoked by uid 111); 17 Aug 2023 05:36:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 01:36:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 01:36:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [Leftoverbits] exit code clean-up?
Message-ID: <20230817053627.GC3006160@coredump.intra.peff.net>
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
 <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
 <xmqqjztvezen.fsf@gitster.g>
 <xmqqsf8iex5v.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf8iex5v.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 10:04:28AM -0700, Junio C Hamano wrote:

> We could either
> 
>  * Be more prescriptive and add "EXIT CODES" section to each and
>    every document to describe how we fail in the current code.
> 
> or
> 
>  * Describe "In general, 0 is success, non-zero is failure, but some
>    commands may signal more than that with its non-zero exit codes"
>    in "git help git", and add "EXIT CODES" section to the manual
>    page of the commands whose exit codes matter (there are a
>    handful, like "git diff --exit-code" that explicitly says "1" is
>    the signal that it found difference as opposed to it failing).
> 
> I'd prefer if community agrees that we should do the latter, but I
> am OK if the community consensus goes the other way.

I left some notes on upload-pack specifically elsewhere in the thread,
in which I argue that we should definitely not lock ourselves into its
current behavior.

But in the more general sense, yeah, I think that trying to document
specific exit codes for each command is a mistake. It is not just "let's
find which exit codes they use and document them". I suspect it is a
rat's nest of unplanned behaviors that come from unexpected die() calls
deep in the stack. We would not necessarily want to make promises about
what is happening in those, nor do I think it would even be sensible to
find every possible exit.

We _could_ document "128 means something really unexpected happened and
we called die() deep in the code". But even that seems misleading to me,
as we also die() for everyday shallow things (like "the name you gave is
not valid"). The value really means very little in practice, and the
biggest reason not to change it is that we know it doesn't conflict with
any codes that programs _do_ promise are meaningful (like "1" from "diff
--exit-code").

So saying "0 is success, non-zero is failure, and some commands may
document specific codes" is the closest thing to the reality of what we
as developers know and have planned.  (Of course another project is not
just to figure out the possible situations/codes but to catalogue and
organize them. But that seems like an order of magnitude more work, if
not several orders).

-Peff
