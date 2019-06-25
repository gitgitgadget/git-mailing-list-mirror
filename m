Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8374F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 21:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFYVfs (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 17:35:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:50624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfFYVfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 17:35:47 -0400
Received: (qmail 406 invoked by uid 109); 25 Jun 2019 21:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jun 2019 21:35:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25758 invoked by uid 111); 25 Jun 2019 21:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Jun 2019 17:36:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jun 2019 17:35:45 -0400
Date:   Tue, 25 Jun 2019 17:35:45 -0400
From:   Jeff King <peff@peff.net>
To:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "liu.denton@gmail.com" <liu.denton@gmail.com>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Message-ID: <20190625213545.GA23411@sigill.intra.peff.net>
References: <20190620052125.GA12434@sigill.intra.peff.net>
 <SN6PR09MB3248412C9E5AE197B65A8D878AE40@SN6PR09MB3248.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR09MB3248412C9E5AE197B65A8D878AE40@SN6PR09MB3248.namprd09.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 07:29:36PM +0000, Pugh, Logan wrote:

> Thanks for the explanation. It sounds like I was under the incorrect 
> assumption that I could use the difftool command the same way as the 
> diff command. Part of my confusion could be blamed on the git-difftool 
> documentation (https://git-scm.com/docs/git-difftool) which near the top 
> states:

Well, it _is_ true that you can use it the same way. It's just that you
need to configure it to use whatever 3rd-party tool you want (and if you
do not want to configure a tool, then you are better off just using
git-diff directly). It was only due to a bug/historical accident that it
behaved just like git-diff in the no-index case (but not in the regular
case -- AFAICT, that would have been broken for your script always).

> My use case is a CLI program I've written that processes and then 
> compares two arbitrary files using the git difftool apparatus as 
> configured by the end user, leaving the choice to them whether to use 
> the internal diff tool or an external tool.
> 
> Now, if I'm understanding correctly, I should not rely on the behavior 
> of git difftool --no-index passing through to git diff. I could add 
> another CLI switch and code path to my program that calls git diff 
> directly instead of git difftool but the passthrough behavior seemed 
> more elegant at the time.
> 
> Ideally, in my mind, git difftool should work as it says on the tin, as 
> a straight up passthrough to git diff *unless* explicitly configured to 
> use external tools (e.g. diff.tool and diff.guitool).

That does make some sense to me for your use case. But I'm worried it
would be a worse experience for people new to difftool (they run it and
scratch their heads why it does not do anything different, whereas now
they get walked through an interactive configuration).

I dunno. I do not use difftool myself, so I don't have strong opinions.

In the meantime, I think you can probably switch behavior in your script
by checking if the diff.tool config is set. It might be nice if difftool
had a better way to query that without you having to know if it's
configured. Or in your case I suppose even better would just be an
option like "--if-not-configured-just-use-regular-diff". Then it would
do what you want, without impacting users who do want the interactive
setup.

-Peff
