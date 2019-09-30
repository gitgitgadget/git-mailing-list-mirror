Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908FE1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfI3BOg (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:14:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59412 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BOg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:14:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B0E41ED1E;
        Sun, 29 Sep 2019 21:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YOd/V6WdAxjBBEhWPiZ/twjNd2E=; b=ahJuuQ
        5GEJI1LOgJLgmG80XKQpbt/3qxqkMQLunPsbC9zaWqlA2EVFHkDlLkyI4DnPL9Yq
        swl1jBrLyh+xd8ubParmwdGGY+NVIa2nZV/bAVPqCJdm/yR7qa3XaqRGaT3LoXQo
        4jB/KvonKqSidb8UjqZyv0/BhbVRUx13r3MAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bJxKxKomqCTU1ZAcx3e1Iu8r0Vrec/KB
        3nxcFubYxLB9nmmFbXb2s1reb4ahaynv5jO2DYSpwzSp9gjc04tygWl9lp8R69gI
        NUE0uWcK4QDK8Qqn2Ayn2eCeRD7TtEq0+mnzIFuxwmzCEW83E2BSDq+A852QNVfs
        s36wrYDfXoY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 935741ED1D;
        Sun, 29 Sep 2019 21:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE7471ED1C;
        Sun, 29 Sep 2019 21:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     CB Bailey <cb@hashpling.org>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] diffcore-break: use a goto instead of a redundant if statement
References: <20190929005646.734046-1-alexhenrie24@gmail.com>
        <20190929093706.ylm5dsftwl2y2nnz@hashpling.org>
Date:   Mon, 30 Sep 2019 10:14:31 +0900
In-Reply-To: <20190929093706.ylm5dsftwl2y2nnz@hashpling.org> (CB Bailey's
        message of "Sun, 29 Sep 2019 10:37:06 +0100")
Message-ID: <xmqqpnjiio08.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8FA05AA-E31F-11E9-9159-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CB Bailey <cb@hashpling.org> writes:

> For easier discussion, I've snipped the original patch and replaced with
> one with enough context to show the entire function.
>
> I was reviewing this patch and it appeared to introduce a change in
> behaviour.
>
>> diff --git a/diffcore-break.c b/diffcore-break.c
>> index 875aefd3fe..f6ab74141b 100644
>> --- a/diffcore-break.c
>> +++ b/diffcore-break.c
>> @@ -262,44 +262,43 @@ static void merge_broken(struct diff_filepair *p,
>> 
>>  void diffcore_merge_broken(void)
>>  {
>>  	struct diff_queue_struct *q = &diff_queued_diff;
>>  	struct diff_queue_struct outq;
>>  	int i, j;
>> 
>>  	DIFF_QUEUE_CLEAR(&outq);
>> 
>>  	for (i = 0; i < q->nr; i++) {
>>  		struct diff_filepair *p = q->queue[i];
>>  		if (!p)
>>  			/* we already merged this with its peer */
>>  			continue;
>>  		else if (p->broken_pair &&
>>  			 !strcmp(p->one->path, p->two->path)) {
>>  			/* If the peer also survived rename/copy, then
>>  			 * we merge them back together.
>>  			 */
>>  			for (j = i + 1; j < q->nr; j++) {
>>  				struct diff_filepair *pp = q->queue[j];
>>  				if (pp->broken_pair &&
>>  				    !strcmp(pp->one->path, pp->two->path) &&
>>  				    !strcmp(p->one->path, pp->two->path)) {
>>  					/* Peer survived.  Merge them */
>>  					merge_broken(p, pp, &outq);
>>  					q->queue[j] = NULL;
>> -					break;
>> +					goto done;
>
> Previously, if the condition matched in the inner loop, the function
> would null out the entry in the queue that that inner loop had reached
> (q->queue[j] = NULL) and then break out of the inner loop. This meant
> that the outer loop would skip over this entry (if (!p)).
>
> The change introduced seems to break out of both loops as soon as we
> reach one match, whereas before other subsequent matches would be
> considered and merged. Not only this, but the outer 'else' case for all
> subsequent entries is skipped so the rest of the entries the original
> queue are missing from 'outq'.

Thanks.

Sometimes judicious use of 'goto' makes the resulting code easier to
follow, but quite honestly, I do not see it happening with this
change.  The original makes it much more clear that there are three
cases to worry about:

    A. an earlier round handled this one already;

    B. we have a broken pair and need to find the other one,
       B-1. if there is, we process it;
       B-2. otherwise we keep it in the outq.

    C. a normal one that does not need the complication of B is
       sent to the outq.

and I find it much easier to follow without any goto.

>
>>  				}
>>  			}
>> -			if (q->nr <= j)
>> -				/* The peer did not survive, so we keep
>> -				 * it in the output.
>> -				 */
>> -				diff_q(&outq, p);
>> +			/* The peer did not survive, so we keep
>> +			 * it in the output.
>> +			 */
>>  		}
>> -		else
>> -			diff_q(&outq, p);
>> +		diff_q(&outq, p);
>>  	}
>> +
>> +done:
>>  	free(q->queue);
>>  	*q = outq;
>> 
>>  	return;
>>  }
>
> I spent a bit of time trying to see if this change was user visible
> which turned out to be unneeded as t4008-diff-break-rewrite.sh already
> fails with this change for me in my environment, initially with this
> test but also 3 other tests in this file.
>
>> expecting success of 4008.6 'run diff with -B (#3)':
>> 	git diff-index -B reference >current &&
>> 	cat >expect <<-EOF &&
>> 	:100644 100644 $blob0_id $blob1_id M100	file0
>> 	:100644 100644 $blob1_id $blob0_id M100	file1
>> 	EOF
>> 	compare_diff_raw expect current
>> 
>> --- .tmp-1	2019-09-29 09:21:07.089070076 +0000
>> +++ .tmp-2	2019-09-29 09:21:07.093070086 +0000
>> @@ -1,2 +1 @@
>>  :100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M#	file0
>> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M#	file1
>> not ok 6 - run diff with -B (#3)
