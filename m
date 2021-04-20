Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C7DC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792D46135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhDTPSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTPSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 11:18:00 -0400
X-Greylist: delayed 1486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Apr 2021 08:17:28 PDT
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A04C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 08:17:28 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lYrk0-0002JE-Gz; Tue, 20 Apr 2021 16:52:40 +0200
Subject: Re: Strategy to deal with slow cloners
To:     git@vger.kernel.org
References: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <f3b406a7-90cd-89c1-c532-d9a7c0f71599@virtuell-zuhause.de>
Date:   Tue, 20 Apr 2021 16:52:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1618931849;6dfd2338;
X-HE-SMSGID: 1lYrk0-0002JE-Gz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.04.2021 14:46, Konstantin Ryabitsev wrote:

> I try to keep repositories routinely repacked and optimized for clones, in
> hopes that most operations needing lots of objects would be sending packs
> straight from disk. However, every now and again a client from a slow
> connection requests a large clone and then takes half a day downloading it,
> resulting in gigabytes of RAM being occupied by a temporary pack.
> 
> Are there any strategies to reduce RAM usage in such cases, other than
> vm.swappiness (which I'm not sure would work, since it's not a sleeping
> process)? Is there a way to write large temporary packs somewhere to disk
> before sendfile'ing them?

There is the packfile-uris feature which allows protocol v2 servers to
advertise static packfiles via http/https. But clients must explicitly
enable it via fetch.uriprotocols. So this does only work for newish
clients which explicitly ask for it. See
Documentation/technical/packfile-uri.txt.

From my limited understanding one clone/fetch the server can only send
one packfile at most.

What is the advertised git clone command on the website? Maybe something
like git clone --depth=$num would help reduce the load? Usually not
everyone needs the whole history.

