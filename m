Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F80C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581F723104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbhASXQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:16:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:60448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbhASXPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:15:55 -0500
Received: (qmail 15636 invoked by uid 109); 19 Jan 2021 23:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 23:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13796 invoked by uid 111); 19 Jan 2021 23:15:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 18:15:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 18:15:11 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAdn/zdQP1Hz70ba@coredump.intra.peff.net>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119143348.27535-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 03:33:48PM +0100, Jacob Vosmaer wrote:

> In git-pack-objects, we iterate over all the tags if the --include-tag
> option is passed on the command line. For some reason this uses
> for_each_ref which is expensive if the repo has many refs. We should
> use a prefix iterator instead.
> [...]
> -		for_each_ref(add_ref_tag, NULL);
> +		for_each_fullref_in("refs/tags/", add_ref_tag, NULL, 0);

Yeah, this is trivially correct, since the first thing we check in
add_ref_tag() is whether it starts with refs/tags/. It would be safe to
remove that check as part of this patch (and unlike the multi-prefix
one, I am comfortable assuming that for_each_fullref_in() will not
return anything outside of the prefix).

I also wondered if we could just use for_each_ref_in() here, but I think
we are better having the full refname to feed to peel_ref().

-Peff
