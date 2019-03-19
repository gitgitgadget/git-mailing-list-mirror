Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BC0202BB
	for <e@80x24.org>; Tue, 19 Mar 2019 19:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCSTxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:53:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:27180 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfCSTxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:53:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 477E13F4021;
        Tue, 19 Mar 2019 15:53:35 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 10D433F401E;
        Tue, 19 Mar 2019 15:53:35 -0400 (EDT)
Subject: Re: [PATCH v2 3/4] midx: verify: add midx packfiles to the packed_git
 list
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.166.git.gitgitgadget@gmail.com>
 <pull.166.v2.git.gitgitgadget@gmail.com>
 <ced7f1cb3486885aef018d91fae37958282a351e.1553006268.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e09812cf-5c9a-4829-9b6e-0cf8c4fb79c7@jeffhostetler.com>
Date:   Tue, 19 Mar 2019 15:53:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <ced7f1cb3486885aef018d91fae37958282a351e.1553006268.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/19/2019 10:37 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Fix "git multi-pack-index verify" to handle repos with thousands
> of packfiles.
> 
> Midx verify adds the individual "packed_git" structures to the
> multi_pack_index.packs array, but it does not add them to the
> "repository.objects.packed_git" list.  During the verification
> code, each packfile is opened and scanned.  And "pack_open_fds"
> is incremented.  If "pack_open_fds" equals the "pack_max_fds"
> open_packed_git_1() calls close_one_pack() to LRU-style close
> an already open packfile.  But because the packfiles were never
> added to the "packed_git" list, close_one_pack() does nothing.
> If there are very many packfiles, Git runs out of file descriptors
> and fails.
> 
> Note that this was observed on Windows when build with GCC and
> in a repository with more than (2048-25) packfiles.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   midx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/midx.c b/midx.c
> index 24141a7c62..b2f33bcd90 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -975,6 +975,9 @@ int verify_midx_file(const char *object_dir)
>   	for (i = 0; i < m->num_packs; i++) {
>   		if (prepare_midx_pack(m, i))
>   			midx_report("failed to load pack in position %d", i);
> +
> +		if (m->packs[i])
> +			install_packed_git(the_repository, m->packs[i]);
>   	}
>   
>   	for (i = 0; i < 255; i++) {
> 

I'd like to drop this commit from this series.

I talked with Stolee offline about this.  It does
address the problem in this one instance, but it leads
us to think about other places where there may be a
similar problem.

Also, the sort by packfile in the next commit in this
series means we'll only have 1 packfile open at a time
and so this commit isn't needed in this particular case.

Thanks,
Jeff

