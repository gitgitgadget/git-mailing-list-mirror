Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56AC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiHIWsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHIWsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 18:48:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BF65828
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 15:48:52 -0700 (PDT)
Received: (qmail 31846 invoked by uid 109); 9 Aug 2022 22:48:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 22:48:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6025 invoked by uid 111); 9 Aug 2022 22:48:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 18:48:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 18:48:51 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: Re: fsck: BAD_FILEMODE diagnostic broken / never triggers
Message-ID: <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 06, 2022 at 03:43:56PM +0200, Xavier Morel wrote:

> However looking at fsck_tree, it does have a fair amount of code to
> validate entry modes and a dedicated message id for this (BAD_FILEMODE
> / badFilemode), it even has a code path for legacy entries with
> S_IWGRP set (extensively documented under `git fsck --strict`).
> 
> I guess, over time mode canonicalisation has slowly creeped earlier
> the tree-parsing code, and (seemingly for several years) it has been
> occurring before "git fsck" gets tree entry information, so git fsck
> simply can not see invalid entry modes?

Yes, I think you're right. I didn't bisect, but I suspect this goes back
to 7146e66f08 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06).

We probably need to provide version of decode_tree_entry() which gives
the non-canonical mode, and to call it from fsck.

-Peff
