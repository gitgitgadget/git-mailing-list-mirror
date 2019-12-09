Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE0DC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4FE206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfLIGrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:47:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:41728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726165AbfLIGrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 01:47:41 -0500
Received: (qmail 18221 invoked by uid 109); 9 Dec 2019 06:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Dec 2019 06:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18327 invoked by uid 111); 9 Dec 2019 06:51:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Dec 2019 01:51:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Dec 2019 01:47:40 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/9] pack-bitmap: don't rely on
 bitmap_git->reuse_objects
Message-ID: <20191209064740.GD40570@coredump.intra.peff.net>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-5-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115141541.11149-5-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:15:36PM +0100, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> We will no longer compute bitmap_git->reuse_objects in a
> following commit, so we cannot rely on it anymore to
> terminate the loop early; we have to iterate to the end.

Hmm. In my original work from 2015 (which you never saw as individual
commits), this came somewhere in the middle, after moving to per-object
reuse.

I think by dropping these hunks now, the state of the code at this point
would mean that we might write the objects twice. We'd mark them as
"reused" and send them as part of write_reused_pack(). But we'd also
send them to pack-objects via the show_reachable_fn callback, and it
would add them to the usual packing list.

And indeed, t5310.10 fails at this point in the series with:

  Cloning into bare repository 'clone.git'...
  remote: Enumerating objects: 331, done.        
  remote: Counting objects: 100% (331/331), done.        
  remote: Compressing objects: 100% (111/111), done.        
  remote: Total 662 (delta 108), reused 331 (delta 108), pack-reused 331        
  Receiving objects: 100% (662/662), 53.14 KiB | 17.71 MiB/s, done.
  Resolving deltas: 100% (216/216), done.
  fatal: The same object 00c1d3730931e66eb08dabe3a3c9fa16621d728a appears twice in the pack
  fatal: index-pack failed

and then starts working again after the final patch.

-Peff
