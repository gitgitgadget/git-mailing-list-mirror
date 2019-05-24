Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16211F462
	for <e@80x24.org>; Fri, 24 May 2019 19:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfEXTd7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 15:33:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:57435 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfEXTd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 15:33:59 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 185C03F408D;
        Fri, 24 May 2019 15:33:59 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:a930:ecfb:793f:8fff] (unknown [IPv6:2001:4898:a800:1012:5a64:ecfb:793f:8fff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 940CD3F4047;
        Fri, 24 May 2019 15:33:58 -0400 (EDT)
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3ac687d6-d534-13c8-db9a-f481403634d1@jeffhostetler.com>
Date:   Fri, 24 May 2019 15:33:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524120318.4851-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/24/2019 8:03 AM, Christian Couder wrote:
> If someone wants to use as a filter a sparse file that is in the
> repository, something like "--filter=sparse:oid=<ref>:<path>"
> already works.
> 
> So 'sparse:path' is only interesting if the sparse file is not in
> the repository. In this case though the current implementation has
> a big security issue, as it makes it possible to ask the server to
> read any file, like for example /etc/password, and to explore the
> filesystem, as well as individual lines of files.
> 
> If someone is interested in using a sparse file that is not in the
> repository as a filter, then at the minimum a config option, such
> as "uploadpack.sparsePathFilter", should be implemented first to
> restrict the directory from which the files specified by
> 'sparse:path' can be read.
> 
> For now though, let's just disable 'sparse:path' filters.
> ---
>   list-objects-filter-options.c |  9 ++++++---
>   list-objects-filter-options.h |  2 --
>   list-objects-filter.c         | 22 ----------------------
>   3 files changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index c0036f7378..007c104b93 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -78,9 +78,12 @@ static int gently_parse_list_objects_filter(
>   		return 0;
>   
>   	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
> -		filter_options->choice = LOFC_SPARSE_PATH;
> -		filter_options->sparse_path_value = strdup(v0);
> -		return 0;
> +		if (errbuf) {
> +			strbuf_addstr(
> +				errbuf,
> +				_("sparse:path filters are now disabled"));
> +		}
> +		return 1;
>   	}
>   	/*
>   	 * Please update _git_fetch() in git-completion.bash when you
[...]

We should update git-completion.bash to remove this option.

Jeff

