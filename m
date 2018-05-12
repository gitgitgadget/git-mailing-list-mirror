Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE0D1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeELJWo (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:22:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:37100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750786AbeELJWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:22:43 -0400
Received: (qmail 24614 invoked by uid 109); 12 May 2018 09:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:22:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13684 invoked by uid 111); 12 May 2018 09:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:22:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:22:41 -0400
Date:   Sat, 12 May 2018 05:22:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/12] blame: use commit-slab for blame suspects instead
 of commit->util
Message-ID: <20180512092241.GD28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:17AM +0200, Nguyễn Thái Ngọc Duy wrote:

> +define_commit_slab(blame_suspects, struct blame_origin *);
> +static struct blame_suspects blame_suspects;
> +
> +struct blame_origin *get_blame_suspects(struct commit *commit)
> +{
> +	struct blame_origin **result;
> +
> +	result = blame_suspects_peek(&blame_suspects, commit);
> +
> +	return result ? *result : NULL;
> +}

Hmm. You need this helper because you want to be able to peek and get a
NULL. But that's already what _at() would return, with the only
difference that we may extend the slab just to return NULL.

I wonder how much it matters in practice. We'd generally be extending
the slab to hit every commit anyway in this case, I would think.

I suppose it doesn't actually simplify the code that much to do it that
way, though. We could get rid of this helper, but the caller would still
look like:

  for (p = *blame_suspects_at(o->commit); p; p = p->next)

which is actually slightly uglier than get_blame_suspects(), because we
have to do the pointer-dereference ourselves.

-Peff
