Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E31D202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 14:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdJYOyh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 10:54:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:15309 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbdJYOyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 10:54:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D398284550;
        Wed, 25 Oct 2017 10:54:35 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 70DA18454D;
        Wed, 25 Oct 2017 10:54:35 -0400 (EDT)
Subject: Re: [PATCH 01/13] dir: allow exclusions from blob in addition to file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-2-git@jeffhostetler.com>
 <xmqq60b3iv79.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b063dec4-b9c4-7145-9b57-7df22ccbc655@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 10:54:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq60b3iv79.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 2:43 AM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> +static int add_excludes_from_buffer(char *buf, size_t size,
>> +				    const char *base, int baselen,
>> +				    struct exclude_list *el);
>> +
>>   /*
>>    * Given a file with name "fname", read it (either from disk, or from
>>    * an index if 'istate' is non-null), parse it and store the
>> @@ -754,9 +758,9 @@ static int add_excludes(const char *fname, const char *base, int baselen,
>>   			struct sha1_stat *sha1_stat)
>>   {
>>   	struct stat st;
>> -	int fd, i, lineno = 1;
>> +	int fd;
>>   	size_t size = 0;
>> -	char *buf, *entry;
>> +	char *buf;
>>   
>>   	fd = open(fname, O_RDONLY);
>>   	if (fd < 0 || fstat(fd, &st) < 0) {
> 
> The post-context of this hunk is quite interesting in that there is
> a call to read_skip_worktree_file_from_index(); which essentially
> pretends as if we read from the filesystem but in fact it grabs the
> blob object name registered in the index and reads from it.
> 
> The reason why it is interesting is because this patch adds yet
> nother "let's instead read from a blob object" function and there is
> no sign to make the existing one take advantage of the new function
> seen in this patch.
> 

The existing code handles use cases where you want to read the
exclusion list from a pathname in the worktree -- or from blob
named in the index when the pathname is not populated (presumably
because of the skip-worktree bit).

I was wanting to add a more general case (and perhaps my commit
message should be improved).  I want to be able to read it from
a blob not necessarily associated with the current commit or
not necessarily available on the local client, but yet known to
exist.  I'm thinking of the case the client could ask the server
to do a partial clone using a sparse-checkout specification stored
in a well-known location on the server.  The reason for this is
that, in this case, the client is pre-clone and doesn't have a
worktree or index.

With my "add_excludes_from_blob_to_list()", we can request a
blob-ish expression, such as "master:enlistments/foo".  In my
later commits associated with clone and fetch, we can use this
mechanism to let the client ask the server to filter using the
blob associated with this blob-ish.  If the client has the blob
(such as during a later fetch) and can resolve it, then it can
and send the server the OID, but it can also send the blob-ish
to the server and let it resolve it.

Jeff


