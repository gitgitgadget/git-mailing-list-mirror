Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD4C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2EB61492
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEKTHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:07:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:16066 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhEKTHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:07:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BBC263F4090;
        Tue, 11 May 2021 15:06:04 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6BE403F4047;
        Tue, 11 May 2021 15:06:04 -0400 (EDT)
Subject: Re: [PATCH v4 1/8] dir: convert trace calls to trace2 equivalents
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com>
Date:   Tue, 11 May 2021 15:06:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/11/21 2:34 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   dir.c                             |  43 +++++--
>   t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
>   t/t7519-status-fsmonitor.sh       |   8 +-
>   3 files changed, 155 insertions(+), 101 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 3474e67e8f3c..122fcbffdf89 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2760,15 +2760,34 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>   	return root;
>   }
>   
> +static void trace2_read_directory_statistics(struct dir_struct *dir,
> +					     struct repository *repo,
> +					     const char *path)
> +{
> +	if (!dir->untracked)
> +		return;
> +	trace2_data_string("read_directory", repo, "path", path);

I'm probably just nit-picking here, but should this look more like:

	if (path && *path)
		trace2_data_string(...)
	if (!dir->untracked)
		return;

Then when you add the visitied fields in the next commit,
you'll have the path with them (when present).

(and it would let you optionally avoid the tmp strbuf in
the caller.)

Jeff
