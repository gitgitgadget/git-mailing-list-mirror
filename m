Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B7C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D118664DA8
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBBJpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:45:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhBBJpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:45:11 -0500
Received: (qmail 12657 invoked by uid 109); 2 Feb 2021 09:44:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 486 invoked by uid 111); 2 Feb 2021 09:44:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:44:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:44:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 03/14] pkt-line: add write_packetized_from_buf2() that
 takes scratch buffer
Message-ID: <YBke/evrHFAC0se1@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <e671894b4c0419138e66270aa9699053bdd504be.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e671894b4c0419138e66270aa9699053bdd504be.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:36PM +0000, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create version of `write_packetized_from_buf()` that takes a scratch buffer
> argument rather than assuming a static buffer.  This will be used later as
> we make packet-line writing more thread-safe.

OK, this is extending the changes from the first patch...

>  int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
>  {
>  	static struct packet_scratch_space scratch;
> +
> +	return write_packetized_from_buf2(src_in, len, fd_out, &scratch);
> +}
> +
> +int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
> +			       struct packet_scratch_space *scratch)

Oof, that name. I know we are guilty of a lot of "foo_1()" helpers for
foo(), but they are usually internal static functions that don't get
spread around. This one is a public function.

Something like "_with_scratch" might be a bit more descriptive. Though
given that there is exactly one caller of the original currently, I'd be
tempted to say that it should just learn the scratch-space argument.

(All of this is moot, of course, if you follow either of my suggestions
from the earlier patch to drop the need for this scratch space
entirely).

-Peff
