Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A1420954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdLGVkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:40:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52701 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750895AbdLGVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:40:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D729C4C37;
        Thu,  7 Dec 2017 16:40:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d5BDgGMaYqkDKf+47qOuZo0wpMQ=; b=wftGaX
        Orpu0wtwBgMc6isEfKSwDu/0KzhB2QJ0BubEN91pxVKYirr7m8PwsmutS+UJjvA1
        +9/CZqr5o9ET73QA/l15vn9zbXNQd6jgVLsqPvjsINgadgVtLkO0BY42OZPS7Urt
        NxO17clG9P2JqwNR0+ZgW5kdJyZ3+4d0LSvso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KK7itvnsWkGpp/zmeZZV0QGIXSEHqUoF
        OD63XCrr/OMp/zh+56xlj1K664yzJ32zOE0rLGzUC2efCqgalju2d8Y5P+W3CbgT
        KBzObl37yLxU77GUIGoGqiLJhgAsbXzSF649dYiE5SFtaIr6EATlBatWvGoBHw+V
        wosjhrV1Avc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC84C4C34;
        Thu,  7 Dec 2017 16:40:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 381E9C4C32;
        Thu,  7 Dec 2017 16:40:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171120222529.24995-1-sbeller@google.com>
        <20171120222529.24995-2-sbeller@google.com>
        <xmqqpo88m896.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 07 Dec 2017 13:40:17 -0800
In-Reply-To: <xmqqpo88m896.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Nov 2017 16:43:49 +0900")
Message-ID: <xmqq8teecj3y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 387E3C06-DB97-11E7-B6B0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

After saying "Will merge to 'next'" in the recent "What's cooking"
report, I noticed that a few loose ends were never tied on this
topic.

>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index dd0dba5b1d..252a21cc19 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -500,6 +500,10 @@ information.
>>  --pickaxe-regex::
>>  	Treat the <string> given to `-S` as an extended POSIX regular
>>  	expression to match.
>> +--blobfind=<blob-id>::
>> +	Restrict the output such that one side of the diff
>> +	matches the given blob-id.
>> +
>>  endif::git-format-patch[]
>
> Can we have a blank line between these enumerations to make the
> source easier to read?  Thanks.
>
> ...
> So, we keep an unmerged pair, a pair that mentions a sought-blob on
> one side or the other side?  I am not sure if we want to keep the
> unmerged pair for the purpose of this one.
>
>> +		diff_free_filepair(p);
>> +		q->queue[i] = NULL;
>> +		c--;
>
> Also, if you are doing the in-place shrinking and have already
> introduced another counter 'j' that is initialized to 0, I think it
> makes more sense to do the shrinking in-place.  'i' will stay to be
> the source-scan pointer that runs 0 thru q->nr, while 'j' can be
> used in this loop (where you have 'continue') to move the current
> one that is determined to survive from q->queue[i] to q->queue[j++].
>
> Then you do not need 'c'; when the loop ends, 'j' would be the
> number of surviving entries and q->nr can be adjusted to it.  Unlike
> the usual pattern taken by the other diffcore transformations where
> a new queue is populated and the old one discarded, this would leave
> the q->queue[] over-allocated, but I do not think it is too bad.

Here is to illustrate the last point.  I still think we should keep
the unmerged entries for the purpose of blobfind but it should be
trivial to fix that.

 diffcore-blobfind.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/diffcore-blobfind.c b/diffcore-blobfind.c
index 5d222fc336..bf63ba61dc 100644
--- a/diffcore-blobfind.c
+++ b/diffcore-blobfind.c
@@ -8,40 +8,31 @@
 static void diffcore_filter_blobs(struct diff_queue_struct *q,
 				  struct diff_options *options)
 {
-	int i, j = 0, c = q->nr;
+	int src, dst;
 
 	if (!options->blobfind)
 		BUG("blobfind oidset not initialized???");
 
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
+	for (src = dst = 0; src < q->nr; src++) {
+		struct diff_filepair *p = q->queue[src];
 
 		if (DIFF_PAIR_UNMERGED(p) ||
 		    (DIFF_FILE_VALID(p->one) &&
 		     oidset_contains(options->blobfind, &p->one->oid)) ||
 		    (DIFF_FILE_VALID(p->two) &&
-		     oidset_contains(options->blobfind, &p->two->oid)))
-			continue;
-
-		diff_free_filepair(p);
-		q->queue[i] = NULL;
-		c--;
-	}
-
-	/* Keep it sorted. */
-	i = 0; j = 0;
-	while (i < c) {
-		while (!q->queue[j])
-			j++;
-		q->queue[i] = q->queue[j];
-		i++; j++;
+		     oidset_contains(options->blobfind, &p->two->oid))) {
+			q->queue[dst] = p;
+			dst++;
+		} else {
+			diff_free_filepair(p);
+		}
 	}
 
-	q->nr = c;
-
-	if (!c) {
+	if (!dst) {
 		free(q->queue);
 		DIFF_QUEUE_CLEAR(q);
+	} else {
+		q->nr = dst;
 	}
 }
 
