Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A8A207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966745AbdD0Qps (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 12:45:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:15949 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939425AbdD0Qps (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 12:45:48 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D8AD6844CC;
        Thu, 27 Apr 2017 12:45:46 -0400 (EDT)
Subject: Re: [PATCH] read-cache: close index.lock in do_write_index
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
 <xmqq1ssepmaw.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c6a8bcbd-a0bd-e586-a672-77b01c4d2568@jeffhostetler.com>
Date:   Thu, 27 Apr 2017 12:45:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1ssepmaw.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/2017 11:21 PM, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach do_write_index() to close the index.lock file
>> before getting the mtime and updating the istate.timestamp
>> fields.
>>
>> On Windows, a file's mtime is not updated until the file is
>> closed.  On Linux, the mtime is set after the last flush.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> Published-As: https://github.com/dscho/git/releases/tag/do-write-index-mtime-v1
>> Fetch-It-Via: git fetch https://github.com/dscho/git do-write-index-mtime-v1
>>
>>  read-cache.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 008b335844c..b0276fd5510 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2051,9 +2051,10 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>>  		rollback_lock_file(lockfile);
>>  }
>>
>> -static int do_write_index(struct index_state *istate, int newfd,
>> +static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>>  			  int strip_extensions)
>>  {
>> +	int newfd = tempfile->fd;
>>  	git_SHA_CTX c;
>>  	struct cache_header hdr;
>>  	int i, err, removed, extended, hdr_version;
>> @@ -2162,7 +2163,11 @@ static int do_write_index(struct index_state *istate, int newfd,
>>  			return -1;
>>  	}
>>
>> -	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
>> +	if (ce_flush(&c, newfd, istate->sha1))
>> +		return -1;
>> +	if (close_tempfile(tempfile))
>> +		return error(_("could not close '%s'"), tempfile->filename.buf);
>> +	if (lstat(tempfile->filename.buf, &st))
>>  		return -1;
>
>
> stat/lstat with path may be slower than fstat on an open file
> descriptor, and I think that is the reason why we do it this way,
> but the performance difference would probably be unmeasurable and
> does not matter in practice.
>
> As we are not using the fact that we still have the file descriptor
> open when we do the stat for any purpose (e.g. like locking other
> processes out), this move to "close first and then stat" is a good
> workaround for the problem.  I wonder if we have been seeing false
> "racy git" problem more often due to this issue on Windows than
> other platforms.

I was wondering about that too.

>
> When code uses lstat, it gives a signal to the readers of the code
> that the code is prepared to see a symlink and when it is a symlink
> it wants to grab the property of the link itself, not the target of
> the link.  I do not think the temporary index can be a symbolic
> link, and even if that were the case, we do want the mtime of the
> link target, so it is a wrong signal to give to the readers.  Hence,
> it would be better to use stat() here from the readability's point
> of view.  Of course, when the path is always a regular file, lstat()
> vs stat() technically does not give any different result, so this
> comment is purely about the maintainability, not about correctness.
>
> Other than that, looks good to me.

Force of habit using lstat() rather than stat().  I'll change it.
Thanks.

