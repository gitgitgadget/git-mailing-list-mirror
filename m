Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F1D1F461
	for <e@80x24.org>; Sun,  1 Sep 2019 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfIAQBK (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 12:01:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57403 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfIAQBK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 12:01:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63FCD81F06;
        Sun,  1 Sep 2019 12:01:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U9KruQ6E5KBqfRQ3KeyVVYalqK4=; b=oV+uAm
        A5ZTqnLVB2Qr0R8GpWL6/oPnq2LBmlzGWdUS/HQFFoagR+DaIm1jbFF9/EJ53GfS
        a+QaNvnMpHYBFi+a7hZeUkhl+pGdYgZc67VkOHnAI4YEOQ9Srw2D45vC827p64WN
        sEf7jf4NrroJJtsc5e+XWpwgSNi6qMXlecOtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNvMrUNau8oEkxwwg6uJhtFUD3IiD7vk
        ZqxE9U/p3ut1G2QIGiU+T/bEDTjsDDt9Kf0eJKP7sk9yPvU3AN4BaJghbw0zV1wI
        oTYcb3Dx4RyIr0ZsbisMwZ1onsDy5SS7um8vbTatgn5UCUMY+TMpon23tgPlAlCE
        w5A/RnkYmQI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B5D681F05;
        Sun,  1 Sep 2019 12:01:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79C6881EF0;
        Sun,  1 Sep 2019 12:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 1/2] builtin/rebase.c: make sure the active branch isn't moved when autostashing
References: <20190829164757.7301-1-ben@wijen.net>
        <20190830151607.4208-1-ben@wijen.net>
        <20190830151607.4208-2-ben@wijen.net>
        <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
        <bf659b1d-b9a4-cb9e-e660-fa743b4db84c@wijen.net>
Date:   Sun, 01 Sep 2019 09:01:04 -0700
In-Reply-To: <bf659b1d-b9a4-cb9e-e660-fa743b4db84c@wijen.net> (ben@wijen.net's
        message of "Sat, 31 Aug 2019 09:17:09 +0200")
Message-ID: <xmqqr250uhtr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4CE96A2-CCD1-11E9-908B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben <ben@wijen.net> writes:

> On 30-08-2019 22:15, Junio C Hamano wrote:
>> Ben Wijen <ben@wijen.net> writes:
>> 
>>> +
>>>  			struct commit *head =
>>> -				lookup_commit_reference(the_repository,
>>> -							&options.orig_head);
>>> +				lookup_commit_reference(the_repository, &head_oid);
>> 
>> This introduces decl-after-statement error, doesn't it?
>> 
>> Perhaps like so...
>
> Would you like me to send in another patch or leave it like this?

As long as you make it clear that you are 100% happy with the
fixed-up result that appeared in 'pu', there is no need to resend
(if you want to make any other changes, I do want to avoid me
screwing up by listening to you and hand applying those changes; I'd
rather want updated patch(es) be sent in such a case).

Thanks.
