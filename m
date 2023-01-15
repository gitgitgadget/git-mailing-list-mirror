Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB7C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 18:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjAOSfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 13:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAOSfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 13:35:45 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9010AA2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 10:35:43 -0800 (PST)
Received: (qmail 7701 invoked by uid 109); 15 Jan 2023 18:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 18:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22289 invoked by uid 111); 15 Jan 2023 18:35:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 13:35:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 13:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?RnLDqWTDqXJpYw==?= Fort <fortfrederic@free.fr>,
        git@vger.kernel.org
Subject: Re: Segmentation fault within git read-tree
Message-ID: <Y8RHfjFFLRdW3WRh@coredump.intra.peff.net>
References: <d0f9520d-9ccc-a899-609e-fbbb4529e005@free.fr>
 <CAP8UFD0pKZT57jpUOg7gckcr4stoq24YDB2Fu0-AwbGPrEweqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0pKZT57jpUOg7gckcr4stoq24YDB2Fu0-AwbGPrEweqg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 12:53:25PM +0100, Christian Couder wrote:

> From a very quick look, it seems that in setup_traverse_info() in
> tree-walk.c we do:
> 
>     static struct traverse_info dummy;
> ...
>     if (pathlen)
>         info->prev = &dummy;
> 
> but then later in debug_path() in unpack-trees.c we check
> *info->prev->name which segfaults.
> 
> I am not very familiar with this code and don't have much time right
> now, so I think I will leave it to others to investigate this further.

I'm not sure if Frédéric is seeing another segfault in practice (when
not using --debug-unpack), but yeah, it is very easy to trigger this
segfault. It does not even have to do with sparse checkouts, etc. Here's
an even more minimal example:

  git init repo
  cd repo
  touch file
  git add file
  git commit -m added
  git read-tree --debug-unpack --prefix=subtree HEAD

I was going to bisect, but it looks like it was broken all the way back
to Junio's ba655da537 (read-tree --debug-unpack, 2009-09-14).

-Peff
