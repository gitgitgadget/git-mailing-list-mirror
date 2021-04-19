Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB70FC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9957860FF1
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhDSSIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:08:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43698 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhDSSId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 14:08:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9ACE51F4B4;
        Mon, 19 Apr 2021 18:08:03 +0000 (UTC)
Date:   Mon, 19 Apr 2021 18:08:03 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: Re: Strategy to deal with slow cloners
Message-ID: <20210419180803.GA10171@dcvr>
References: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> Hello:
> 
> I try to keep repositories routinely repacked and optimized for clones, in
> hopes that most operations needing lots of objects would be sending packs
> straight from disk. However, every now and again a client from a slow
> connection requests a large clone and then takes half a day downloading it,
> resulting in gigabytes of RAM being occupied by a temporary pack.

Yeah, I'm familiar with the problem.

> Are there any strategies to reduce RAM usage in such cases, other than
> vm.swappiness (which I'm not sure would work, since it's not a sleeping
> process)? Is there a way to write large temporary packs somewhere to disk
> before sendfile'ing them?

public-inbox-httpd actually switched buffering strategies in
2019 to favor hitting ENOSPC instead of ENOMEM :)

  https://public-inbox.org/meta/20190629195951.32160-11-e@80x24.org/

It doesn't support sendfile, currently (I didn't want separate
HTTPS vs HTTP code paths), but that's probably not too big of a
deal, especially with slow clients.

It's capable of serving non-public-inbox coderepos (and running
cgit).  Instead of configuring every [coderepo "..."] manually,
publicinbox.cgitrc can be set in ~/.public-inbox/config to
mass-configure [coderepo] sections.  It's only lightly-tested
for my setup atm, though.

Mapping publicinbox.<name>.coderepo to [coderepo "..."]
entries for solver (blob reconstruction) isn't required;
it's a bit of a pain at a large scale and I haven't figured
out how to make it easier.
