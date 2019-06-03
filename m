Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D491F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFCSIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:08:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58373 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCSIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:08:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1520C6B8CD;
        Mon,  3 Jun 2019 14:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iq23zFfNp1X9K3SENoh4IiIkJbk=; b=ZG8NOJ
        5YOiAxJ8mXeujZ69ZPd+LFrTlRaK9drHNG9wX9LvHM3OxwO5/3VQPlpEDW++lnw5
        qAPA/fhnwjV8/V6xs/T9zUmYfKYjGalw71fYwdpjzQ26HCzVLceD+J1ESrK+hYDC
        w7L6E0cwWrF6m3YOCVuR3faVJQehaNrnJPByE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IxxFhAY+WeVb0j1hgIA8ZZEdruNhY/3I
        vxZDaMk0jQ2v3M6SimkjZjKYXBqXWfJ0k5snSQsGOxcf+ZfNiGCr8uIcQb46TIIV
        MkPsKQ9QIwpEcEtvwF5rycD+jCv5z1bwl57q0koIA8TUV7f/TWwo/Rqhro9jPesU
        sSa0kqidH+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C59D6B8CC;
        Mon,  3 Jun 2019 14:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24BFC6B8C8;
        Mon,  3 Jun 2019 14:08:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     michael@platin.gs, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame - fix some issues identified by coverage report.
References: <20190601210925.15339-1-michael@platin.gs>
        <10bbee35-4df1-1a6d-8301-6866c7445e2d@google.com>
Date:   Mon, 03 Jun 2019 11:08:00 -0700
In-Reply-To: <10bbee35-4df1-1a6d-8301-6866c7445e2d@google.com> (Barret
        Rhoden's message of "Mon, 3 Jun 2019 11:26:52 -0400")
Message-ID: <xmqqk1e2v8xr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86E90A1C-862A-11E9-8D7B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> Hi Michael -
>
> On 6/1/19 5:09 PM, michael@platin.gs wrote:
>> From: Michael Platings <michael@platin.gs>
>>
>> Thanks to Derrick Stolee for highlighting missing coverage.
>>
>> In the case of "certainties[i] = CERTAINTY_NOT_CALCULATED" this was
>> defeating an optimization that preserved results of calculations
>> between line-matching passes. This had caused other code to never
>> be executed - that code is now executed and only discards calculation
>> results that are no longer valid.
>>
>> In the case of "max_search_distance_b = 0" this was never executed
>> because another statement was added earlier in the function to return
>> early in such a case.
>>
>> Signed-off-by: Michael Platings <michael@platin.gs>
>
> If it's OK with you, I can squash this into your existing patch in the
> blame-ignore patch set.

Thanks, both.  That'd make my life easier ;-) by allowing me to
ignore this patch for now, knowing you two are on top of the issue.

