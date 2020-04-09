Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEA7C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FA12074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDIXlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:41:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726327AbgDIXlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 19:41:53 -0400
Received: (qmail 22590 invoked by uid 109); 9 Apr 2020 23:41:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 23:41:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24545 invoked by uid 111); 9 Apr 2020 23:52:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 19:52:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 19:41:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4lyaWNv?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] segmentation fault in git-diff
Message-ID: <20200409234152.GA42330@coredump.intra.peff.net>
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
 <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
 <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
 <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 03:57:00PM -0700, Junio C Hamano wrote:

> $ git checkout v2.22.0 && make && ./git-rev-parse :/any/path/
> 
> segfaults, while
> 
> $ git checkout v2.21.0 && make && ./git-rev-parse :/any/path/
> 
> is OK.  We should be able to bisect this fairly straightforward
> between these two.

Indeed. The culprit is c931ba4e78 (sha1-name.c: remove the_repo from
handle_one_ref(), 2019-04-16), which swapped out for_each_ref() for
refs_for_each_ref(repo->refs). But it misses the access method for
repo->refs which lazy-initializes the pointer.

So the immediate fix is:

diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..c679e246cd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1771,8 +1771,8 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 
 			cb.repo = repo;
 			cb.list = &list;
-			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
-			refs_head_ref(repo->refs, handle_one_ref, &cb);
+			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
+			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}

But there are a bunch of other commits around the same time replacing
the_repository, and it seems like an easy mistake to make. Perhaps we
should rename the "refs" member of "struct repository" to something more
clearly private, which would force callers to use the access method.

I also wonder if there should be a repo_for_each_ref() which does it for
us, though I guess there a bazillion variants (like head_ref()) that
would need similar treatment. Asking each caller to use
get_main_ref_store() isn't too bad.

-Peff
