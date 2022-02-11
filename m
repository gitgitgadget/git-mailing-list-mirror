Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D2C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351913AbiBKRHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:07:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349563AbiBKRHs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 12:07:48 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2181A1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 09:07:47 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3BDD169D07;
        Fri, 11 Feb 2022 12:07:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ylh1j8oTPO7z7nWhL53DHRISKOOGky5a588Wt0
        5EXUA=; b=Sz8CXUZwgRP15n8mS9BmjkZiYB0bXpGAxkbm2ZxeQysw+vxlaJZPwT
        NRIHImHw/ROOx9Ule49V6DDHbwUQU1ydZ+OJ4zwbZWvaSt/vqwzly8n1oqHLJvwS
        F+JXHkcLrDJjWvr83BU5hLRo3ICMxnct46Dpa5yoFJ0JrYGWK3Y1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCA72169D05;
        Fri, 11 Feb 2022 12:07:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10544169D01;
        Fri, 11 Feb 2022 12:07:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
References: <20220210044152.78352-1-chooglen@google.com>
        <20220210044152.78352-8-chooglen@google.com>
        <xmqqtud6e3r8.fsf@gitster.g>
        <kl6lbkzdyitt.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 11 Feb 2022 09:07:42 -0800
In-Reply-To: <kl6lbkzdyitt.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 11 Feb 2022 15:15:58 +0800")
Message-ID: <xmqq5yple3hd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20D6B19E-8B5D-11EC-818C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +static struct fetch_task *
>>> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
>>> +			    const char **default_argv, struct strbuf *err)
>>> +{
>>
>>> @@ -1553,7 +1628,10 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>>>  {
>>>  	struct submodule_parallel_fetch *spf = data;
>>>  	const char *default_argv = NULL;
>>> -	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
>>> +	struct fetch_task *task =
>>> +		get_fetch_task_from_index(spf, &default_argv, err);
>>> +	if (!task)
>>> +		task = get_fetch_task_from_changed(spf, &default_argv, err);
>>
>> Hmph, intersting.  So if "from index" grabbed some submodules
>> already, then the "from the changes in the superproject, we know
>> these submodules need refreshing" is not happen at all?  I am afraid
>> that I am still not following this...
>
> Hm, perhaps the following will help:
>
> - get_next_submodule() is an iterator, specifically, it is a
>   get_next_task_fn passed to run_processes_parallel_tr2(). It gets
>   called until it is exhausted.

Ahh, yeah, I totally forgot how we designed these things to work.

Even though these functions have a loop, (1) they start iterating at
the point where they left off in the last call, and (2) they return
as soon as they find the first item in the loop, which should have
stood out as a typical generator pattern, but somehow I missed these
signs.

> So in practice:
> ...
> - get_next_submodule() has now been exhausted and we are done.

But my original question (based on my misunderstanding that a single
call to these would grab all submodules that needs fetching by
inspecting either the index or the history) still stands, doesn't it?

Presumably the "history scan" part is because we assume that we
already had all the necessary submodule commits to check out any
superproject commits before this recursive fetch started.  That is
the reason why we do not scan the history behind the "old tips".  We
inspect only the history newer than them, leading to the "new tips",
and try to grab all submodule commits that newly appear, to ensure
that we can check out all the superproject commits we just obtained
and have no missing submodule commits necessary to do so.  Combined
with the assumption on the state before this fetch that we had all
necessary submodule commits to check out the superproject commits up
to "old tips", we maintain the invariant that we can check out any
superproject commits recursively, no?

If we are doing so, especially with this series where we do the
"history scan" to complete submodule commits necessary for all new
commits in the superproject, regardless of the branch being checked
out in the superproject, why do we still need to scan the index to
ensure that the current checkout can recurse down the submodule
without hitting a missing commit?

The only case the "index scan" may make a difference is when the
assumption, the invariant that we can check out any superproject
commits recursively, did not hold before we started the fetch, no?
