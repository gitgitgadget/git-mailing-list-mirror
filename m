Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172D41F424
	for <e@80x24.org>; Wed, 28 Mar 2018 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeC1JwH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 05:52:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:45764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752717AbeC1JwF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 05:52:05 -0400
Received: (qmail 15968 invoked by uid 109); 28 Mar 2018 09:52:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 09:52:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6751 invoked by uid 111); 28 Mar 2018 09:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 05:53:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 05:52:03 -0400
Date:   Wed, 28 Mar 2018 05:52:03 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180328095203.GB1523@sigill.intra.peff.net>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
 <20180327173024.GA5017@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180327173024.GA5017@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 07:30:24PM +0200, Duy Nguyen wrote:

> On Tue, Mar 27, 2018 at 07:09:36PM +0200, Duy Nguyen wrote:
> > I would rather have something like ref_store_reinit() in the same
> > spirit as the second call of set_git_dir() in setup_work_tree. It is
> > hacky, but it works and keeps changes to minimal (so that it could be
> > easily replaced later).
> 
> So in the name of hacky and dirty things, it would look something like
> this. This passed your test case. The test suite is still running
> (slow laptop) but I don't expect breakages there.

I think this is the right direction. I mentioned in my last reply that
it would be nice for this to be a bit more generic, in case we need to
use it again (and also just to keep the module boundaries sane).

This part confused me at first:

> +void make_main_ref_store_use_absolute_paths(void)
> +{
> +	files_force_absolute_paths(get_main_ref_store());
> +}
> +
> +void make_main_ref_store_use_relative_paths(const char *cwd)
> +{
> +	files_make_relative_paths(get_main_ref_store(), cwd);
> +}

since I thought you were actually turning things into absolute paths.
But your procedure is basically "turn absolute, then after chdir, turn
them back relative".

I think it might be clearer if a single call is given both the old and
new paths. That requires the caller of chdir() storing getcwd() before
it moves, but I don't think that should be a big deal.

-Peff
