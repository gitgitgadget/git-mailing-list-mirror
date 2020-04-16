Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BBBC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E8821841
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgDPS6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:58:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728928AbgDPS6W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 14:58:22 -0400
Received: (qmail 29508 invoked by uid 109); 16 Apr 2020 18:58:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Apr 2020 18:58:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6323 invoked by uid 111); 16 Apr 2020 19:09:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2020 15:09:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Apr 2020 14:58:21 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Order of operations at the end of fast-import?
Message-ID: <20200416185821.GA1289786@coredump.intra.peff.net>
References: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
 <20200416050909.GB21547@coredump.intra.peff.net>
 <4b3493c9-8a4b-c55e-6749-cccc9dee87b6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3493c9-8a4b-c55e-6749-cccc9dee87b6@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 08:34:27PM +0200, Johannes Sixt wrote:

> > This is usually handled by the gc expiration time, which is compared
> > against the file mtime. The default is 2 weeks, but even something short
> > like 5 minutes would be plenty to avoid this race (even for a long
> > import, we should be updating the mtime every time we call write()).
> 
> Except that on Windows the times are only updated reliably when all file
> handles refering to the file are closed. Would that poke a hole in your
> argument? (I don't think  so, as long as expiration times are not
> ridiculously short; and people who do gc --prune=now should know what
> they are doing -- and when.)

Yes, if you do "git gc --prune=5.minutes" while an hour-long fast-import
is running, you might be in trouble. Don't do that.

Though on _any_ system, there are other cases where objects sit
untouched before being referenced. I guess we pull from the index for
reachability, so "git add" is safe for blobs. I don't know if we are
clever enough to use cache-tree (and it might not even be there), so
possibly those trees are at risk until you run "git commit" (or even
after you run while waiting in the editor).

Certainly I think the whole pruning system is a patchwork of assumptions
that could be violated in extreme cases. But it has been that way for 15
years. If people aren't routinely finding objects pruned out from under
them, I'm not inclined to spend a lot of time digging on it.

-Peff
