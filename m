Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C9C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37C206F1
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 02:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCMCe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:34:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726246AbgCMCe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 22:34:28 -0400
Received: (qmail 17003 invoked by uid 109); 13 Mar 2020 02:34:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Mar 2020 02:34:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3878 invoked by uid 111); 13 Mar 2020 02:43:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 22:43:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 22:34:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
Message-ID: <20200313023427.GB900007@coredump.intra.peff.net>
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
 <20200312211638.GA872402@coredump.intra.peff.net>
 <20200312212613.GB872402@coredump.intra.peff.net>
 <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
 <20200313023034.GA900007@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313023034.GA900007@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:30:34PM -0400, Jeff King wrote:

> So that would actually argue that your patch is putting it in the right
> place. It's _not_ fetch's responsibility to reprepare_packed_git(). It's
> the loop in check_connected() that is skipping the usual reprepare
> logic, and shouldn't.
> 
> And one fix (which you did) is to just preemptively reprepare right
> above that loop. Some other solutions are:

I know I've now suggested that your patch is both wrong and right. :)

Just to be clear, at this point I think I'd be OK with either solution.

If it's going into check_connected(), the commit message should argue
that the loop there is at fault for not doing the usual fallback, and a
single explicit reprepare() is cheap enough to cover the case we care
about (and that we don't have to worry about racing with somebody else
repacking because the point of that flag is that we're in a brand new
repo).

Repreparing earlier in the transport-helper code _could_ still protect
against other similar loops, which is an argument for putting it there.
But I'd be inclined to say those other loops should be corrected.

-Peff
