Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A521F454
	for <e@80x24.org>; Sun, 10 Nov 2019 06:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKJGLz (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 01:11:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61893 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfKJGLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 01:11:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 522A4AE6AD;
        Sun, 10 Nov 2019 01:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a+v8PBxTV0WZL1kPFBgj2YtCaE=; b=QahjN9
        LcUo2vglYnmHzy3XNuuSKkNZiY0OLhLazL6V+Bydom9ySXQdzOoLLMGQexHMMti0
        KyGwo0o5eA1vgqdHpduv0iIuzo3C7yftHmCFaHPsfgPQW04IRM/D4u53XLgcT36g
        4rZaQlawP7UoAiRtYKOA3DoRCBAlqfd9hV+as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nriny9BSReCRZatrxtqjsen69LKcmuvJ
        xgJhEl8hOkatjhe7PZ/FADoZ9fyI5iFuJEicoTjC1GSitijPjn5SAj5OWK/EiSu7
        e2RlLCCyZGtPW1VVVtuB7cGKJ/utl2WNTOk4tpHJo2pvF+ohaxi5IH8sONYXZ8UY
        dSskpIseZ4A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DCEDAE6AC;
        Sun, 10 Nov 2019 01:11:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 56EEBAE6AB;
        Sun, 10 Nov 2019 01:11:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
        <20191107184912.GA3115@cat>
        <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
        <20191108165929.GB3115@cat>
Date:   Sun, 10 Nov 2019 15:11:48 +0900
In-Reply-To: <20191108165929.GB3115@cat> (Thomas Gummerer's message of "Fri, 8
        Nov 2019 16:59:29 +0000")
Message-ID: <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBD13E48-0380-11EA-8D40-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 11/08, Junio C Hamano wrote:
>> So, I do not think removing that discard_cache() alone solves the
>> breakage exposed by 34933d0eff.  Discarding and re-reading the
>> on-disk index there would restore correctness, but then you would
>> want to make sure that we are not wasting the overall cost for the
>> I/O and refreshing.
>> 
>> I think the safer immediate short-term fix is to revert the change
>> to the quiet codepath and let it only refresh the in-core index.
>
> Yup, this is certainly my bad, we shouldn't be writing the discarded
> index of course.  I don't think what we were doing here before was
> correct either though.  The only thing that would be called after this
> is 'do_stash_drop()', which only executes external commands.

Right.  Removing discard alone would not be a correct fix exactly
for that reason: the in-core index was stale wrt the on-disk index.

If the program later used in-core index for further processing
(which is not, and that is why the short-term solution of reverting
that hunk would work), we would have been operating on a wrong data.
So for the fix that keeps data we have in-core always up-to-date, we
should be re-reading from the on-disk index there after discard().

And in the longer term, it would likely be the right direction, as
the "git status" invocation on the non-quiet codepath would want to
become an in-core direct calls into wt-status machinery instead of
fork+exec eventually.

> From what you are saying above, and from my testing I think this
> refresh is actually unnecessary, and we could just remove it outright.

Perhaps.  But later it will bite us when somebody wants to rewrite
the "status at the end" part in C.

Besides, if the original was "update-index -q --refresh" in the
scripted Porcelain after an pop was attempted, it would have shown
the unmerged paths as "needs merge", wouldn't it?  For that, we need
to have something (I do not remember if refresh_and_write_cache()
would be the in-core API call to do so offhand).

Thanks.
