Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F988C2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 05:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C920644
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 05:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405847AbgDPFJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:09:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404971AbgDPFJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 01:09:11 -0400
Received: (qmail 16467 invoked by uid 109); 16 Apr 2020 05:09:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Apr 2020 05:09:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25730 invoked by uid 111); 16 Apr 2020 05:19:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2020 01:19:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Apr 2020 01:09:09 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Order of operations at the end of fast-import?
Message-ID: <20200416050909.GB21547@coredump.intra.peff.net>
References: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 01:24:49PM +0900, Mike Hommey wrote:

> I just noticed that the order of operations at the end of fast-import
> are:
> - end_packfile
> - dump_branches
> - dump_tags
> 
> The first may create loose objects if the pack is small (per
> fastimport.unpackLimit, defaulting to 100). The latter two create refs.
> 
> There seems to be a theoretical race condition here, if something else
> triggers a gc at the "wrong" time, the loose objects might be cleaned up
> and the branches/tags refs become dangling.
>
> I understand that the packfile does need to be finished before creating
> the refs, and that the unpacking replaces that when there aren't enough
> objects, but wouldn't it be more data-safe to actually finish the pack,
> create the refs, and then unpack?

That race is there even without the unpacking step. Another gc might
remove the pack, dropping its unreferenced objects.

We do add a ".keep" between writing the pack and updating the refs, but
it doesn't look like it's done atomically (i.e., we write the .idx file
and _then_ add the .keep). So there's a small race there.

But all of this is also true of any operation, like git-commit. It's
creating new loose objects, and then will try to reference them. In
between, a simultaneous gc will think they're unreachable. Likewise,
receiving a push may write a pack (with a .keep, though in the correct
order) or even loose objects.

This is usually handled by the gc expiration time, which is compared
against the file mtime. The default is 2 weeks, but even something short
like 5 minutes would be plenty to avoid this race (even for a long
import, we should be updating the mtime every time we call write()).

In fact, gc will use the same expiration for clearing out tempfiles. So
even before we write the final pack and its .keep, any temporary files
we're writing into would be at risk. But again, if we're actively
writing, their mtimes should save them.

-Peff
