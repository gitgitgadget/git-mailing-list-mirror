Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D461C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B4D2399A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 15:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eIVnHEIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIVPvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:51:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61046 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVPvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 11:51:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 442CCFCEE8;
        Tue, 22 Sep 2020 11:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GKhqJm1yxSUDITktnxUmwCSnXo4=; b=eIVnHE
        IXg0xoUNoIC5uXQ4h8r3ODVOZfQEoVA3z5F775PdBjZqog4AWqjqGypS+pVEUupZ
        FRo5SvVVS88Ampvi+P5+Ul2u1PlmlG/didG6IWgK36Cyq5ElMaqY4NiJJRhKhCXj
        EFyqM8QltD62KU4/0gnUz1dj0KZPJ42kfHFnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yTIoCB6BXWimNoiUteuxl/DL07TLwKLx
        Doj5pJBg54zGV4z4BlxG45dcVsYHf1TmzM0P3XcSXc1YIR9OQw0Fm/foY5qdT8I1
        E/R9FIfMgS2gcA/m8rPr7UooPGdRVdiiaWRlEn+vQ/9YtTdyxe5w3EP8jaCYtzbw
        2qf057e9BHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C227FCEE7;
        Tue, 22 Sep 2020 11:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81781FCEE6;
        Tue, 22 Sep 2020 11:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/2] fetch: do not override partial clone filter
References: <cover.1600743698.git.jonathantanmy@google.com>
        <070a717aabbac31ae44567dbe54a325029f9931f.1600743698.git.jonathantanmy@google.com>
        <xmqq363acqj9.fsf@gitster.c.googlers.com>
        <b59f00b6-2787-261e-a295-35eb4a6f442b@gmail.com>
Date:   Tue, 22 Sep 2020 08:51:44 -0700
In-Reply-To: <b59f00b6-2787-261e-a295-35eb4a6f442b@gmail.com> (Derrick
        Stolee's message of "Tue, 22 Sep 2020 07:35:12 -0400")
Message-ID: <xmqqk0wllshb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84E6A77C-FCEB-11EA-AD5E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/22/2020 1:46 AM, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>>> +test_expect_success 'ensure that filter is written to config' '
>>> +	FILTER=$(git -C client config --get remote.blah.partialclonefilter) &&
>>> +	test "$FILTER" == "blob:limit=0"
>> 
>> I'll do s/==/=/ locally because otherwise the test-lint-shell-syntax
>> will choke on this line.  No need to resend only this line.
>
> Wouldn't "test_cmp_config" be a better here? It seems like
> this is testing the "git clone" behavior of the previous test,
> so it could be added to that test instead.

TIL that one ;-) "git config --get" gives only a single instance,
but in this particular case, shouldn't we be verifying not just that
the expected one is found, but it is the only one, with "--get-all"?

FWIW, many uses of that test helper may want to be tightened the
same way.  In short, unless we are testing the last-one-wins
behaviour, and especially when we are interested in what changes our
tested operation makes to the config file's contents, we should be
using "--get-all" instead of the default "--get", I suspect.

Thanks.
