Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88854C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5E206D9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgKZAxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:53:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:43212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgKZAxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:53:13 -0500
Received: (qmail 12388 invoked by uid 109); 26 Nov 2020 00:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 00:53:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12349 invoked by uid 111); 26 Nov 2020 00:53:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 19:53:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 19:53:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
Message-ID: <X778eIAr3uzdh0H0@coredump.intra.peff.net>
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 01:42:24PM -0800, Junio C Hamano wrote:

> In the meantime, I may queue this on 'seen' but it cannot move
> forward without a signoff.
> 
> Thanks.
> 
> --- >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
> From: René Scharfe <l.s.r@web.de>
> Date: Fri, 20 Nov 2020 19:52:45 +0100
> Subject: [PATCH] upload-pack: kill pack-objects helper on signal or exit
> 
> We spawn an external pack-objects process to actually send objects
> to the remote side. If we are killed by a signal during this
> process, the pack-objects will hang around as a zombie.  We should
> take it down when we go down.

I think this is a good thing to do. I'd probably avoid the word "zombie"
here, though. The orphaned pack-objects does not become a zombie process
in the traditional Unix sense of the word, waiting to be reaped by a
parent which is not paying attention. Instead it is still running but
doing work for a caller that will never read the result.

So maybe:

  We spawn an external pack-objects process to actually send objects to
  the remote side. If we are killed by a signal during this process,
  then pack-objects may continue to run. As soon as it starts producing
  output for the pack, it will see a failure writing to upload-pack and
  exit itself. But before then, it may do significant work traversing
  the object graph, compressing deltas, etc, which will all be
  pointless. So let's make sure to kill as soon as we know that the
  caller will not read the result.

-Peff
