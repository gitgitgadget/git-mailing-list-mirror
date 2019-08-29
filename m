Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122931F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH2ONJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:13:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:32928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726852AbfH2ONJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:13:09 -0400
Received: (qmail 23917 invoked by uid 109); 29 Aug 2019 14:13:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 14:13:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23210 invoked by uid 111); 29 Aug 2019 14:14:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 10:14:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 10:13:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190829141307.GE1797@sigill.intra.peff.net>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 08:58:55AM -0400, Derrick Stolee wrote:

> However, I do have a theory: the process exits before flushing the
> packet line. Adding this line before exit(1) should fix it:
> 
> 	packet_writer_flush(writer);
> 
> I can send this in a v2, but it would be nice if you could test this
> in your environment that already demonstrated the failure.

I don't think we should need such a call. For one thing, if it were
necessary, that would mean we're not writing out the packet at all. But
your whole problem is that we're writing the message twice, one of which
comes from the packet.

Second is that this is not "flush the output stream", but "write a flush
packet". The packet_writer_error() function immediately calls write()
without buffering. And no matter where we are in the conversation, a
flush packet would not be necessary, because the error packet we send
would be interpreted immediately by the client as aborting the
connection.

-Peff
