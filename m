Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD2C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbiFMUxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbiFMUwo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:52:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA4E29819
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 13:11:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FCD31981E6;
        Mon, 13 Jun 2022 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vx03GRD+vzh9WxXRInHxV5wXV+7JTSZJ6LYOev
        ph+R4=; b=IGSRvZ+eQmKV6jXPoJmACJqnegIzM2LM0hgH/ew3YYnHbfezaiQpLm
        lZ23oiYMHHU7pjltzwleIykihcbAV9C5A8CZhezMf3zlrphP82dtHABWCwdsEFLS
        H2/85JliUAlCv5mLtOWseJag0ZaBcdQhIXqVUWhocixwPErpT4mtk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 399701981E5;
        Mon, 13 Jun 2022 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF3741981DE;
        Mon, 13 Jun 2022 16:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
References: <xmqqfskdieqz.fsf@gitster.g>
        <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
Date:   Mon, 13 Jun 2022 13:11:16 -0700
In-Reply-To: <7cd41846-e6ef-7a24-0426-6031a529360f@github.com> (Derrick
        Stolee's message of "Mon, 13 Jun 2022 11:15:03 -0400")
Message-ID: <xmqqczfc5nob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBE21C04-EB54-11EC-B8EF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/9/2022 7:44 PM, Junio C Hamano wrote:
>
>> +	struct string_list *resolve_undo = istate->resolve_undo;
>> +
>> +	if (!resolve_undo)
>> +		return 0;
>> +
>> +	for_each_string_list_item(item, resolve_undo) {
>
> I see this is necessary since for_each_string_list_item() does not
> handle NULL lists.  After attempting to allow it to handle NULL
> lists, I see that the compiler complains about the cases where it
> would _never_ be NULL, so that change appears to be impossible.

Heh, no such deep thought went into this.  I just copied what is
done in builtin/ls-files.c::show_ru_info() that grabs these blobs
and does something interesting and the only difference is this does
something else interesting.

We _could_ refactor these to into "take a callback and iterate over
resolve-undo information" shell plus two callback functions, one to
print them and the other to mark them still reachable, but the
iterator being relatively short, I doubt that it is worth it.

> The patch looks good. I liked the comments for the three phases
> of the test.

Thanks.
