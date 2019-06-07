Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB661F462
	for <e@80x24.org>; Fri,  7 Jun 2019 19:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfFGTPz (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 15:15:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:53753 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfFGTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 15:15:55 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 714573F4083;
        Fri,  7 Jun 2019 15:15:54 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:5d6e:aba4:2027:955c] (unknown [IPv6:2001:4898:a800:1012:ea2:aba4:2027:955c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3A04D3F400C;
        Fri,  7 Jun 2019 15:15:54 -0400 (EDT)
Subject: Re: [RFC PATCH 11/13] walken: add filtered object walk
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <20190607010811.52944-1-emilyshaffer@google.com>
 <20190607010811.52944-12-emilyshaffer@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <712ced21-cc7a-0a4a-9cf2-64b1e7c5127a@jeffhostetler.com>
Date:   Fri, 7 Jun 2019 15:15:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607010811.52944-12-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/6/2019 9:08 PM, Emily Shaffer wrote:
> Demonstrate how filter specs can be used when performing a revision walk
> of all object types. In this case, tree depth is used. Contributors who
> are following the revision walking tutorial will be encouraged to run
> the revision walk with and without the filter in order to compare the
> number of objects seen in each case.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   builtin/walken.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/walken.c b/builtin/walken.c
> index 408af6c841..f2c98bcd6b 100644
> --- a/builtin/walken.c
> +++ b/builtin/walken.c
> @@ -13,6 +13,7 @@
>   #include "pretty.h"
>   #include "line-log.h"
>   #include "list-objects.h"
> +#include "list-objects-filter-options.h"
>   #include "grep.h"
>   
>   static const char * const walken_usage[] = {
> @@ -154,7 +155,22 @@ static int walken_object_walk(struct rev_info *rev)
>   	blob_count = 0;
>   	tree_count = 0;
>   
> -	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
> +	if (1) {
> +		/* Unfiltered: */
> +		printf(_("Unfiltered object walk.\n"));
> +		traverse_commit_list(rev, walken_show_commit,
> +				walken_show_object, NULL);
> +	} else {
> +		printf(_("Filtered object walk with filterspec 'tree:1'.\n"));
> +		/*
> +		 * We can parse a tree depth of 1 to demonstrate the kind of
> +		 * filtering that could occur eg during shallow cloning.
> +		 */

I think I'd avoid the term "shallow clone" here.  Shallow clone
refers to getting a limited commit history.  That's orthogonal from
partial clone and the filtered tree walk that operates *within* a commit
or a series of commits.

Granted, a user might want to do both a shallow and partial clone (and
then later partial fetches), but I wouldn't mix the concepts here.


> +		parse_list_objects_filter(&filter_options, "tree:1");
> +
> +		traverse_commit_list_filtered(&filter_options, rev,
> +			walken_show_commit, walken_show_object, NULL, &omitted);
> +	}
>   
>   	printf(_("Object walk completed. Found %d commits, %d blobs, %d tags, "
>   	       "and %d trees.\n"), commit_count, blob_count, tag_count,
> 
