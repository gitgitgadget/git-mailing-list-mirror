Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8AC54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D67B20774
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCVJrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:47:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:46934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726866AbgCVJrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 05:47:00 -0400
Received: (qmail 27307 invoked by uid 109); 22 Mar 2020 09:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 09:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31101 invoked by uid 111); 22 Mar 2020 09:56:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 05:56:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 05:46:59 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] partial-clone: set default filter with --partial
Message-ID: <20200322094659.GA635598@coredump.intra.peff.net>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <6f340d9aadf71d394ad320ad162f1d140b632f2c.1584638887.git.gitgitgadget@gmail.com>
 <xmqqr1xmbwn1.fsf@gitster.c.googlers.com>
 <2a75325b-ea50-a6f6-87dc-12184e706ac2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a75325b-ea50-a6f6-87dc-12184e706ac2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 04:38:27PM -0400, Derrick Stolee wrote:

> > Specifically, I find it unsatisifying to see the "0" optimization at
> > this level.  Shouldn't it be done in parse_list_objects_filter() to
> > parse "blob:limit=<num>" and after realizing <num> is zero, pretend
> > as if it got "blob:none" to optimize?  That way, people can even say
> > "--partial=0k" and get it interpreted as "--filter=blob:none", right?
> 
> I suppose it would be worth checking the recent server-side improvements
> to see if they translate a limit=0k to a "size 0" and then ignore the
> size check and simply remove all blobs.

The new bitmap code doesn't do anything special there. It does rely on
the normal filter parsing, though. If we rewrote it at that level,
perhaps like this (completely untested):

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe..0225b61912 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -49,7 +49,10 @@ static int gently_parse_list_objects_filter(
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
-			filter_options->choice = LOFC_BLOB_LIMIT;
+			if (filter_options->blob_limit_value)
+				filter_options->choice = LOFC_BLOB_LIMIT;
+			else
+				filter_options->choice = LOFC_BLOB_NONE;
 			return 0;
 		}
 

then it would just work for regular and bitmapped filters.

One interesting user-visible effect would be in the patches we've been
discussing to limit which filters are allowed. If you allowed, say,
blob:none but not blob:limit, this would quietly allow blob:limit=0
(because it really _is_ blob:none under the hood). 

I'm not sure if that would be confusing or convenient. I doubt anybody
cares much for the blob filters (you'd either enable neither or both,
because they cost about the same). But in another thread, I mentioned
that doing "tree:depth=0" _would_ be cheap to do with bitmaps, but
tree:depth=1" wouldn't. If we quietly rewrote the former to tree:none
(which doesn't yet exist, but could), that would let you distinguish
between the two (of course if tree:none existed, perhaps nobody would
have any reason to write tree:depth=0 in the first place).

-Peff
