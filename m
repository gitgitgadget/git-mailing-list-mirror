Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDB7C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 15:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiEPPgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiEPPgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 11:36:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97FE20F53
        for <git@vger.kernel.org>; Mon, 16 May 2022 08:36:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B659D190B0F;
        Mon, 16 May 2022 11:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OfPAUT7+ZK6k/SGSEoPcqKijBO0FxXHISDmgdf
        HmO3E=; b=uitjdmhNJ8debj4BH5V5vS31BqXYXTeG8bq9gISBXw0ZcnE4IVv+4F
        ZE8kaJr+zovNB8nnjcnHX60CYZNC8L04D5S8Nl5hALkpUQpQUihsP0BfK+sYZ8ni
        sS2g52p/DFx7ygKYck7OKKfR/cNvyHdpIkN9upCpvrn1YSWI28aA0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0002190B0E;
        Mon, 16 May 2022 11:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56B8C190B0C;
        Mon, 16 May 2022 11:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlos L." <00xc@protonmail.com>
Cc:     Paul Eggert <eggert@cs.ucla.edu>,
        "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, GNU grep developers <grep-devel@gnu.org>
Subject: Re: [PATCH] grep: add --max-count command line option
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
        <xmqqilq658b3.fsf@gitster.g>
        <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
        <MHNbacVw7D6ZU3OJvgIqqRMu70HlgYIYQPduUEUnzWCqkGUsUGRLopGGWj-CbyjNilDcUfLB6elfSRgDOaob9cPpjeAf-I6xuMArQZ0y3io=@protonmail.com>
Date:   Mon, 16 May 2022 08:36:09 -0700
In-Reply-To: <MHNbacVw7D6ZU3OJvgIqqRMu70HlgYIYQPduUEUnzWCqkGUsUGRLopGGWj-CbyjNilDcUfLB6elfSRgDOaob9cPpjeAf-I6xuMArQZ0y3io=@protonmail.com>
        (Carlos L.'s message of "Mon, 16 May 2022 08:38:05 +0000")
Message-ID: <xmqq1qwt5w2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E929C072-D52D-11EC-BE68-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlos L." <00xc@protonmail.com> writes:

>> Even if we want to handle the zero just like you do, I think this patch
>> needs a few tests. We should make sure to test the 0-case (whatever we
>> end up wanting it to behave like), and probably the "suppress an earlier
>> -m by giving --no-max-count" case. It also seems wise to set up some
>> test scenario where there are several files involved so that we can see
>> that we don't just print the first m matches globally, but that the
>> counter is really handled per file.
>
> This seems sound. Is there any documentation on how to write tests for git?

t/README and Documentation/MyFirstContribution would be two good
places to start.

>> What "git grep -m -1" should do? IIRC, OPT_INTEGER is for signed
>> integer but the new .max_count member, as well as the existing
>> "count" that is compared with it, are of "unsigned" type. Either
>> erroring out or treating it as unlimited is probably fine, but
>> whatever we do, we should document and have a test for it.
>
> I would favor treating it as an error. As mentioned above, using 0
> to describe "unlimited matches" (e.g. the default) is my
> preference, but I am willing to concede if someone can think of a
> good use for `-m 0`.

With Devil's advocate hat on.

"GNU grep has been doing so for the past 20 years and existing users
of the command expects '-m 0' to behave that way" is a good enough
reason, especially if '-m 0' is not the only possible way to say
"unlimited".

> Also, from the implementation side (although
> not as important) it looks better: if we allow negative values, we
> need to distinguish between -1 (unlimited) and -4 (display error
> to user, probably)

If we are going to document "you can pass a negative value to
explicitly say 'unlimited', which is a useful way to countermand
another `-m <num>` that appear earlier on the command line", then -1
and -4 would equally be 'unlimited' and there is no need to
distinguish anything.

Devil's advocate hat off.

I personally do not mind if "-m <non-positive>" means "unlimited",
as long as that is clearly documented and tested, but for long time
"GNU grep" users "-m 0" might appear surprising (not necessarily
because they would find that the "-m 0" that immediately fails is
useful, but because the behaviour is deliberately made different).

Thanks.

