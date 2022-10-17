Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D4C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQRq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJQRq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:46:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63715802
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:46:24 -0700 (PDT)
Received: (qmail 27362 invoked by uid 109); 17 Oct 2022 17:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8912 invoked by uid 111); 17 Oct 2022 17:46:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:46:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:46:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Message-ID: <Y02U7611DH6zFsK9@coredump.intra.peff.net>
References: <87czatrpyb.fsf@bernoul.li>
 <87a65xrnwz.fsf@bernoul.li>
 <221017.86h702jsiq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221017.86h702jsiq.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 06:50:06PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Sorry about the slowdown, the removal of "list" was just an in-between
> step to migrating "submodule" to a full built-in.
> 
> I can't reproduce anything like the 8ms v.s. ~600ms difference you note
> here, but for me migrating it to a built-in is around 10% slower with
> "foreach" than the old "list". I wonder what results you get?

I don't think "foreach" can ever be as performant as a bare "list". It
inherently is going to do O(n) fork+execs. So it's OK if you have one or
two submodules, but not if you have hundreds.

If it treated "echo" as a builtin and served it in-process, it could
avoid that extra overhead. But there are so many corner cases there,
you'd probably do better to add "list --format" instead.

-Peff
