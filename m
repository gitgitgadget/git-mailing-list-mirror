Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65830C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE4021655
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784288AbgJZTTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:19:00 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:50439 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783888AbgJZTS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:18:58 -0400
X-Greylist: delayed 2069 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 15:18:58 EDT
Received: from [87.165.17.105] (helo=[192.168.2.222])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kX7QI-0002wF-Fm; Mon, 26 Oct 2020 19:40:50 +0100
Subject: Re: Questions about partial clone with '--filter=tree:0'
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        marc.strapetz@syntevo.com, me@ttaylorr.com
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
 <20201026182417.2105954-1-jonathantanmy@google.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <2f04c074-3eee-766c-bedb-2e3cc0a91528@syntevo.com>
Date:   Mon, 26 Oct 2020 19:44:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026182417.2105954-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.10.2020 19:24, Jonathan Tan wrote:
> Sorry for the late reply - I have been out of office for a while.

I'm quite happy to get the replies at all, even if later. Thanks!

> As Taylor said in another email, it's good for some use cases but
> perhaps not for the "blame" one that you describe later.

OK, so our expectations seem to match your expectations, that's good.

> That's true. I made some progress with cbe566a071 ("negotiator/noop: add
> noop fetch negotiator", 2020-08-18) (which adds a no-op negotiatior, so
> the client never reports its own commits as "have") but as you said in
> another email, we still run into the problem that if we have the commit
> that we're fetching, we still won't fetch it.

Right, I already discovered 'fetch.negotiationAlgorithm=noop' and gave 
it a quick try, but it didn't seem to help at all.

> To clarify: we partially support the last point - "git clone" now
> supports "--sparse". When used with "--filter", only the blobs in the
> sparse checkout specification will be fetched, so users are already able
> to download only the objects in a specific path.

I see. Still, it seems that two other problems will be solved.

> Having said that, I
> think you also want the histories of these objects, so admittedly this
> is not complete for your use case.

Right.

> Having such an option (and teaching "blame" to use it to prefetch) would
> indeed speed up "blame". But if we implement this, what would happen if
> the user ran "blame" on the same file twice? I can't think of a way of
> preventing the same fetch from happening twice except by checking the
> existence of, say, the last 10 OIDs corresponding to that path. But if
> we have the list of those 10 OIDs, we could just prefetch those 10 OIDs
> without needing a new filter.

I must admit that I didn't notice this problem. Still, it seems easy 
enough to solve with this approach:

1) Estimate number of missing things
2) If "many", just download everything for <path> as described before
    and consider it done.
3) If "not so many", assemble a list of OIDs on the boundary of unknown
    (for example, all root tree OIDs for commits that are missing any
    trees) and use the usual fetch to download all OIDs in one go.
4) Repeat step 3 multiple times. Only N=<maximum tree depth> requests
    are needed, regardless of the number of commits.

> Another issue (but a smaller one) is this does not fetch all objects
> necessary if the file being "blame"d has been renamed, but that is
> probably solvable - we can just refetch with the old name.

Right, we also discussed this and figured that we'd just query more
things as needed. Maybe also individual other blobs for rename detection.

> Another possible solution that has been discussed before (but a much
> more involved one) is to teach Git to be able to serve results of
> computations, and then have "blame" be able to stitch that with local
> data. (For example, "blame" could check the history of a certain path to
> find the commit(s) that the remote has information of, query the remote
> for those commits, and then stitch the results together with local
> history.) This scheme would work not only for "blame" but for things
> like "grep" (with history) and "log -S", whereas
> "--filter=sparse:parthlist" would only work with "blame". But
> admittedly, this solution is more involved.

I understand that you're basically talking about implementing 
prefetching in git itself? To my understanding, this will still need 
either the command I suggested, or implement graph walking with massive 
OID requests as described above in 1)2)3)4). The latter will not require 
protocol changes, but will involve sending quite a bit of OIDs around.
