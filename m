Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DCCC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58B621BE5
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJZUI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:08:57 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:49051 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgJZUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 16:08:57 -0400
Received: from [87.165.17.105] (helo=[192.168.2.222])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1kX8kc-0006TW-Oo; Mon, 26 Oct 2020 21:05:54 +0100
Subject: Re: Questions about partial clone with '--filter=tree:0'
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        marc.strapetz@syntevo.com, me@ttaylorr.com
References: <2f04c074-3eee-766c-bedb-2e3cc0a91528@syntevo.com>
 <20201026194635.2119420-1-jonathantanmy@google.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <6a09c0cd-8e88-1f53-72ca-bc6f9182b517@syntevo.com>
Date:   Mon, 26 Oct 2020 21:08:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026194635.2119420-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.10.2020 20:46, Jonathan Tan wrote:
 > No - I did talk about prefetching earlier, but here I mean having
 > Git on the server perform the "blame" computation itself.

Oh! That's an interesting twist. Unfortunately for us, we are
implementing our own Blame logic. Thinking of which, I'm now becoming
more convinced that graph walking could be the best solution for us,
because it allows any logic, including custom file rename detection.

 > For example, let's say I want to run "blame" on foo.txt at HEAD. HEAD
 > and HEAD^ are commits that only the local client has, whereas HEAD^^ was
 > fetched from the remote. By comparing HEAD, HEAD^, and HEAD^^, Git knows
 > which lines come from HEAD and HEAD^. For the rest, Git would make a
 > request to the server, passing the commit ID and the path, and would get
 > back a list of line numbers and commits.

Sounds quite involved indeed! It's curious how git kind of shifts
towards classic server-side VCS such as SVN. When partial clones are
involved, that is.

 > Yes, prefetching will require graph walking with large OID requests but
 > will not require protocol changes, as you say. I'm not too worried about
 > the large numbers of OIDs - Git servers already have to support
 > relatively large numbers of OIDs to support the bulk prefetch we do
 > during things like checkout and diff.

Hmm, let's talk about Linux repository for the sake of the numbers.
The number of commits is ~1M. For a typical Blame (without rename
detection), every request will traverse the trees one level deeper, and
for just one file blamed, that would mean 1 or 0 trees per commit 
(depending on whether the tree was modified by the commit). The first
request to discover root trees is going to be the largest, and will
request (1*numCommits) OIDs. That makes 1M OIDs in worst case, with
subsequent requests probably at ~0.1M, and there will be 1 request per
every path component in blamed path.

So the question is, will git server (or git hosting) become upset
about requests for 1M OIDs? Never really tried what is the cost of such
request, what do you think?
