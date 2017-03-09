Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746E3202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbdCIPrO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 10:47:14 -0500
Received: from siwi.pair.com ([209.68.5.199]:38496 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754427AbdCIPrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 10:47:13 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CA9618463F;
        Thu,  9 Mar 2017 10:46:54 -0500 (EST)
Subject: Re: [PATCH 01/10] pack-objects: eat CR in addition to LF after fgets.
To:     Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-2-git-send-email-jeffhost@microsoft.com>
 <20170309070128.we6hbraea5am3ado@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <52221b43-0c38-97a2-d96d-0dedf5f45796@jeffhostetler.com>
Date:   Thu, 9 Mar 2017 10:46:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170309070128.we6hbraea5am3ado@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/2017 2:01 AM, Jeff King wrote:
> On Wed, Mar 08, 2017 at 05:37:56PM +0000, Jeff Hostetler wrote:
>
>> From: Jeff Hostetler <git@jeffhostetler.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  builtin/pack-objects.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index f294dcf..7e052bb 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -2764,6 +2764,8 @@ static void get_object_list(int ac, const char **av)
>>  		int len = strlen(line);
>>  		if (len && line[len - 1] == '\n')
>>  			line[--len] = 0;
>> +		if (len && line[len - 1] == '\r')
>> +			line[--len] = 0;
>
> Rather than add features to this bespoke line-reader, can we switch this
> to use strbuf_getline()? That handles line endings, and avoids the
> awkward corner case where fgets "breaks" a long line across two calls.
>
> Something like the patch below. I suspect read_object_list_from_stdin()
> should get the same treatment.

Much nicer.  Will do.  Thanks!

>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 76b1919ca..6b9fffe9c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2765,7 +2765,7 @@ static void record_recent_commit(struct commit *commit, void *data)
>  static void get_object_list(int ac, const char **av)
>  {
>  	struct rev_info revs;
> -	char line[1000];
> +	struct strbuf buf = STRBUF_INIT;
>  	int flags = 0;
>
>  	init_revisions(&revs, NULL);
> @@ -2775,12 +2775,12 @@ static void get_object_list(int ac, const char **av)
>  	/* make sure shallows are read */
>  	is_repository_shallow();
>
> -	while (fgets(line, sizeof(line), stdin) != NULL) {
> -		int len = strlen(line);
> -		if (len && line[len - 1] == '\n')
> -			line[--len] = 0;
> -		if (!len)
> +	while (strbuf_getline(&buf, stdin) != EOF) {
> +		const char *line = buf.buf;
> +
> +		if (!buf.len)
>  			break;
> +
>  		if (*line == '-') {
>  			if (!strcmp(line, "--not")) {
>  				flags ^= UNINTERESTING;
> @@ -2800,6 +2800,7 @@ static void get_object_list(int ac, const char **av)
>  		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", line);
>  	}
> +	strbuf_release(&buf);
>
>  	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
>  		return;
>
