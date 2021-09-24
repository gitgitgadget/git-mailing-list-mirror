Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A5C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AFD611C8
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbhIXUWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:22:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:54848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346333AbhIXUWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:22:44 -0400
Received: (qmail 19426 invoked by uid 109); 24 Sep 2021 20:21:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 20:21:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12909 invoked by uid 111); 24 Sep 2021 20:21:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 16:21:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 16:21:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] packfile: release bad_objects in close_pack()
Message-ID: <YU4zMj76HXP5PhCu@coredump.intra.peff.net>
References: <33a0120b-c10d-2709-49d3-7c3dc26565ee@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33a0120b-c10d-2709-49d3-7c3dc26565ee@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 08:10:10AM +0200, René Scharfe wrote:

> Unusable entries of a damaged pack file are recorded in the oidset
> bad_objects.  Release it when we're done with the pack.
> 
> This doesn't affect intact packs because an empty oidset requires
> no allocation.

Good catch. I wondered if this was related to your recent 09ef66179b
(packfile: use oidset for bad objects, 2021-09-11), but we'd have just
leaked the manual array before then.

> diff --git a/packfile.c b/packfile.c
> index 0e92bd7bd2..89402cfc69 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -339,6 +339,7 @@ void close_pack(struct packed_git *p)
>  	close_pack_fd(p);
>  	close_pack_index(p);
>  	close_pack_revindex(p);
> +	oidset_clear(&p->bad_objects);
>  }

Looks obviously correct.

-Peff
