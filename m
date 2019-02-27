Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5884720248
	for <e@80x24.org>; Wed, 27 Feb 2019 12:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfB0MJC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 07:09:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:59736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728916AbfB0MJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 07:09:01 -0500
Received: (qmail 31048 invoked by uid 109); 27 Feb 2019 12:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 12:09:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5159 invoked by uid 111); 27 Feb 2019 12:09:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 07:09:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 07:08:59 -0500
Date:   Wed, 27 Feb 2019 07:08:59 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
Message-ID: <20190227120859.GB10305@sigill.intra.peff.net>
References: <20190221121943.19778-1-pclouds@gmail.com>
 <20190226105851.32273-1-pclouds@gmail.com>
 <20190226105851.32273-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226105851.32273-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 05:58:51PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
> significant until 3a3b9d8cde (refs: new ref types to make per-worktree
> refs visible to all worktrees - 2018-10-21), where worktree name could
> be part of a refname and must follow refname rules.
> 
> Update 'worktree add' code to remove special characters to follow
> these rules. The code could replace chars with '-' more than
> necessary, but it keeps the code simple. In the future the user will
> be able to specify the worktree name by themselves if they're not
> happy with this dumb character substitution.

So notably this gets around ".." and ".lock" by just disallowing "."
entirely. I think I'm OK with that for worktrees. It does make me a
little nervous to see this new public function, though:

> +int char_allowed_in_refname(int ch)
> +{
> +	return 0 <= ch && ch < ARRAY_SIZE(refname_disposition) &&
> +		refname_disposition[ch] == 0;
> +}

because it's not entirely accurate, as you noted above. I wonder if we
could name this differently to warn people that the refname rules are
not so simple.

If we just cared about saying "is this worktree name valid", I'd suggest
actually constructing a sample refname with the worktree name embedded
in it and feeding that to check_refname_format(). But because you want
to actually sanitize, I don't think there's an easy way to reuse it.

So this approach is probably the best we can do, though I do still think
it's worth renaming that function (and/or putting a big warning comment
in front of it).

Other than that, I didn't see anything objectionable in the patch.

-Peff
