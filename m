Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB812203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 21:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965299AbcKKVPj (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 16:15:39 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:57920 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965293AbcKKVPh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 16:15:37 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFt466Cbkz5tlD;
        Fri, 11 Nov 2016 22:15:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 03A01146;
        Fri, 11 Nov 2016 22:15:33 +0100 (CET)
Subject: Re: [PATCH v2] t6026: ensure that long-running script really is
To:     Junio C Hamano <gitster@pobox.com>
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
 <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
 <fbf517ad-7341-eb6d-ab38-4fe91410e57c@kdbg.org>
 <20161111084148.tgtsijn74z2pdylq@sigill.intra.peff.net>
 <6a421222-a138-5647-4965-8ede24d904b2@kdbg.org>
 <xmqq60nt3fqc.fsf@gitster.mtv.corp.google.com>
 <ba2b3f08-87b1-c954-2020-e5a4bece7f83@kdbg.org>
 <xmqqmvh5207k.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Andreas Schwab <schwab@suse.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c4cdd21e-0cef-8255-75f2-90c84f271e02@kdbg.org>
Date:   Fri, 11 Nov 2016 22:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvh5207k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 22:09 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 11.11.2016 um 21:48 schrieb Junio C Hamano:
>>> Johannes Sixt <j6t@kdbg.org> writes:
>>>
>>>> Good point. Here is an updated version.
>>>
>>> Unfortunately, I already took the version before this one and
>>> started my integration cycle today.  I'll wiggle this in; it
>>> essentially is about adding a big comment to explain what is going
>>> on and then moving the when-finished down below it, right?
>>
>> Correct.
>
> Thanks.  It has become like so:
>
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Fri, 11 Nov 2016 21:24:44 +0100
> Subject: [PATCH] t6026: clarify the point of "kill $(cat sleep.pid)"
>
> We lengthened the time the leftover process sleeps in the previous
> commit to make sure it will be there while 'git merge' runs and
> finishes.  It therefore needs to be killed before leaving the test.
> And it needs to be killed even when 'git merge' fails, so it has to
> be triggered via test_when_finished mechanism.
>
> Explain all that in a large comment, and move the use site of
> test_when_finished to immediately before 'git merge' invocation,
> where the process is spawned.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Perfect, thank you very much.

> ---
>  t/t6026-merge-attr.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 348d78b205..8f9b48a493 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -187,12 +187,20 @@ test_expect_success 'custom merge does not lock index' '
>  		sleep 3600 &
>  		echo $! >sleep.pid
>  	EOF
> -	test_when_finished "kill \$(cat sleep.pid)" &&
>
>  	test_write_lines >.gitattributes \
>  		"* merge=ours" "text merge=sleep-an-hour" &&
>  	test_config merge.ours.driver true &&
>  	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
> +
> +	# We are testing that the custom merge driver does not block
> +	# index.lock on Windows due to an inherited file handle.
> +	# To ensure that the backgrounded process ran sufficiently
> +	# long (and has been started in the first place), we do not
> +	# ignore the result of the kill command.
> +	# By packaging the command in test_when_finished, we get both
> +	# the correctness check and the clean-up.
> +	test_when_finished "kill \$(cat sleep.pid)" &&
>  	git merge master
>  '
>
>

