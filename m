Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B4BC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF04C60E75
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhKIFhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 00:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbhKIFgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 00:36:47 -0500
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Nov 2021 21:33:53 PST
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AECC061225
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 21:33:53 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4HpGdP4VR6zGp5G;
        Tue,  9 Nov 2021 05:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onenetbeyond.org;
        s=stigmate; t=1636435497;
        bh=x5F2FxmoXzIja92UC9ZTIH76XrUBtpDFJQlLwDMqBZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N09vW/H5+pKpQlV0lwZ9cyCkxPglaU8znOJ0n04a3Uj8AV3uCsyuGK6KvxQYedovv
         Q1jiaGF+YAHv8kjfErG8KvnTxFObPwJe7lalfORYMiqPcoKdlWsz6/ymQ1n2eQGkbJ
         0UySV+jxmXYTCe/Cs2J4Mm7XP7Y0UmHeXUYVRYRA=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: kumar@onenetbeyond.org) by localhost (Postfix) with ESMTPSA id 4HpGdN6jLfzGp4Y;
        Tue,  9 Nov 2021 05:24:56 +0000 (UTC)
Message-ID: <6c6ef97c-9de5-176f-f328-c4dffd96d495@onenetbeyond.org>
Date:   Tue, 9 Nov 2021 05:24:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0
Subject: Re: List all commits of a specified file in oldest to newest order
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
 <YYTorS1DiuTXv0/V@coredump.intra.peff.net>
From:   Vipul Kumar <kumar@onenetbeyond.org>
In-Reply-To: <YYTorS1DiuTXv0/V@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/21 8:17 AM, Jeff King wrote:

> So yes, it's a bug in the sense that the behavior is nonsense and it
> doesn't work as one might expect. But it's also the hacky "--follow"
> working as designed, and is just a limitation of its approach. It would
> need to be rewritten completely to work correctly.  Arguably we should
> at least disallow the combination of --reverse and --follow for now, as
> it will never help (OTOH, if there is nothing to follow it should behave
> OK, and I suspect some people and scripts may add --follow "just in
> case").

I think, it's a good idea to disallow the combination of "--reverse" and 
"--follow", just like we did for "--reverse" and "--walk-reflogs" 
combination. Because this combination never going to help anybody:

   * If there is nothing to follow, people shouldn't use "--follow" 
option. Using "--follow" along with "--reverse" might arise 
misconception to users that they are also following renames also, which 
actually they don't.

   * But if there are things to follow, using combination of "--follow" 
and "--reverse" only shows a single commit which points to the "rename 
of the file". I quite didn't understand why is this happening? Once we 
encounter rename commit (from "a.txt to b.txt") while traversing in 
reverse order, our pathspec is now "b.txt". So we should also get list 
of commits which changes b.txt file.

> As a workaround, you can get what you want by two separate traversals:
> 
>    git log --follow --format=%H -- $your_file |
>    git log --stdin --no-walk --reverse [--oneline, -p, etc]

Thank you!


-v
