Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FBBC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 05:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbiEYFLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 01:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiEYFLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 01:11:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4013E94
        for <git@vger.kernel.org>; Tue, 24 May 2022 22:11:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C95712F15B;
        Wed, 25 May 2022 01:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SNhIWbiYM0eTWyHznr2RABbWEWJ+zLoQuXtKHE
        6f8d0=; b=u6T2hnHZ0SBziYpmLMEWH8QRmTMlzkzihCPlRP3x++EhykY53QzZCO
        MaK9IqPFjhhX8N6Jq45PdlO4kRbI0tLzHOst6VfuDNhx2ZoYwCEUHfiWsvAhIK4s
        wHmbG3gt5TA0TCpzl5F1tY62cV7nuGgoOXiNHsiYtJ1QLKXZATaSw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33A4A12F15A;
        Wed, 25 May 2022 01:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A67B12F159;
        Wed, 25 May 2022 01:11:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4] setup: don't die if realpath(3) fails on getcwd(3)
References: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
        <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
        <xmqqk0aafwsd.fsf@gitster.g>
        <CABPp-BHZQXt-=XtTk7Ez463rhbcQQBNGUVkbbWiavZT+Rsjn_A@mail.gmail.com>
Date:   Tue, 24 May 2022 22:11:35 -0700
In-Reply-To: <CABPp-BHZQXt-=XtTk7Ez463rhbcQQBNGUVkbbWiavZT+Rsjn_A@mail.gmail.com>
        (Elijah Newren's message of "Tue, 24 May 2022 20:51:50 -0700")
Message-ID: <xmqq7d6ab3i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26CE262C-DBE9-11EC-8F4E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> diff --git i/git-compat-util.h w/git-compat-util.h
>> index 58fd813bd0..56c6c48461 100644
>> --- i/git-compat-util.h
>> +++ w/git-compat-util.h
>> @@ -976,7 +976,7 @@ int xstrncmpz(const char *s, const char *t, size_t len);
>>   * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
>>   * that ptr is used twice, so don't pass e.g. ptr++.
>>   */
>> -#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
>> +#define FREE_AND_NULL(p) do { free((void*)p); (p) = NULL; } while (0)
>>
>>  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
>>  #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
>
> I also like this change, even if it feels like it should be part of a
> separate patch.

Sorry, but I did fail to make it clear that I didn't mean the above
to be anything related to Kevin's patch.  It was "if FREE_AND_NULL()
were defined like this, then we could have used it".  I didn't mean
to say "let's update FREE_AND_NULL() this way so that we can use
it".

Thanks.
