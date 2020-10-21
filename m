Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C94C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9521D43
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 10:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461872AbgJWKa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460449AbgJWKa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 06:30:56 -0400
X-Greylist: delayed 168 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Oct 2020 03:30:56 PDT
Received: from bounceout01.ispgateway.de (bounceout01.ispgateway.de [IPv6:2a00:1158:400:1::f1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C979C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 03:30:56 -0700 (PDT)
Received: from [80.67.31.35] (helo=smtprelay01.ispgateway.de)
        by bounceout01.ispgateway.de with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kVuIo-00087t-HM
        for git@vger.kernel.org; Fri, 23 Oct 2020 12:28:06 +0200
Received: from [84.175.187.233] (helo=[192.168.2.222])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kVI8R-0004rJ-Lh; Wed, 21 Oct 2020 19:42:51 +0200
Subject: Re: Questions about partial clone with '--filter=tree:0'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com, Marc Strapetz <marc.strapetz@syntevo.com>
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
 <20201020222934.GB93217@nand.local>
 <a4a20c67-4ee3-77b2-8d57-f30843572aa4@syntevo.com>
 <20201021173153.GC1237181@nand.local>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <67a5edc8-d2f3-735a-fc7c-0fb1b93a7cf3@syntevo.com>
Date:   Wed, 21 Oct 2020 19:46:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201021173153.GC1237181@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.10.2020 19:31, Taylor Blau wrote:

 > If you have a promisor remote which is missing objects, running
 > 'git blame' etc. will transparently download whatever objects it
 > is missing.

This is correct, but it downloads things one at a time, which in
case of larger repo such as Linux could take weeks to complete. And
downloading more things at once isn't easy without the suggested
command.

It is possible to traverse commit graph, requesting all discovered
objects at once, but again in case of Linux, that would mean sending
multiple requests with lists of 1 million+ oids. And the number of
requests is around the maximum tree depth. Doesn't sound nice.

> Jonathan Tan knows better than I do here. Maybe he could chime in.

I already CC'ed him, I hope he finds time to reply.

> I see what you're saying. Here sparse-checkout and partial clones
> confusingly diverge: what you really want is to say "I want all of the
> objects that I need to construct this directory at any point in history"
> so that you can run "git blame" on some path within that directory
> without the need for a follow-up fetch.

Right.

> In any case the '--filter=sparse:<oid>' bit is not recommended for use,
> but perhaps this is a convincing use-case. I didn't follow the partial
> clone development close enough to know whether this has already been
> discussed, but I'm sure that it has.

Unfortunately '--filter=sparse:<oid>' requires the list to be already
committed on server, which limits the usefulness of it a lot.
