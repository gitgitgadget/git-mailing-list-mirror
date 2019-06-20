Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A7A1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 05:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFTFVa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 01:21:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:45156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725857AbfFTFV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 01:21:29 -0400
Received: (qmail 16065 invoked by uid 109); 20 Jun 2019 05:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 05:18:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12339 invoked by uid 111); 20 Jun 2019 05:22:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 01:22:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 01:21:25 -0400
Date:   Thu, 20 Jun 2019 01:21:25 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Message-ID: <20190620052125.GA12434@sigill.intra.peff.net>
References: <SN6PR09MB3248331E45EED2DD26CA55528AE50@SN6PR09MB3248.namprd09.prod.outlook.com>
 <20190620011744.GA3696@archbookpro.localdomain>
 <20190620024517.GA24321@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620024517.GA24321@archbookpro.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 10:45:17PM -0400, Denton Liu wrote:

> Using the following command on git.git,
> 
> 	$ HOME=/dev/null ./git --exec-path=. difftool --no-index color.c color.h
> 
> I did a quick bisect on the issue and it seems like the cause of this
> bug is actually 287ab28bfa (diff: reuse diff setup for --no-index case,
> 2019-02-16). I'll do a bit more digging tomorrow.

I don't know much about how git-difftool works, but it looks like it
sets GIT_EXTERNAL_DIFF=git-difftool--helper.

Prior to 287ab28bfa, we would not have respected any external diff
command when running git-diff. But after it, we do.

In the case that he user has not provided --no-index, then this all
works as I guess difftool is meant to: it runs the helper and says "hey,
you have not configured this".

It seems like the behavior of the above command prior to 287ab28bfa was
not intentional. It would run git-diff, expecting it to trigger the
helper, but it never did (and instead just did a normal no-index diff).

So it seems like the new behavior is actually the right thing, as it
makes the --no-index case consistent with the regular one? I'm not
at all clear why you would run "difftool" here if you it is not
configured and you just want the straight diff output.

-Peff
