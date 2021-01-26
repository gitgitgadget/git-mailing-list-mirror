Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870CC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7765A22CE3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbhAZFFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:05:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50792 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbhAZC0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:26:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AB7C94335;
        Mon, 25 Jan 2021 21:25:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I5Z5UWbi+6au+JeO9HhGzEYDyMw=; b=iWng4P
        uEZne/xuVX+W+pZZMbxvNNevoLbQIpS10rn5zU+wWBFxTlDqMSFNsrxDxCBa4LS3
        xtitWgMojwhvoiyEYpNRv86zNekIK8ikuiG4d7d5wErZ67OpJeb8JZP96wXDqO7S
        xGEcYvvMwRl2CKObyA2UK7/piq2FmItSq3Eg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=outWV+UiEA+gWF6/PH9XFZbjVtOu1qkk
        F30frzfWyzoBMjcrbNKpEjCUWJltgH7PfFsl/iYAAVUHIA7jIb8t0/KZO2c6mUk3
        2zYi34SacAfM7bO6BfoeiWBeiZr0bwlbb4oTUk3+5BY17OfPf9zBAJysh+0vVQhq
        TW0MED6VcUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BB8494330;
        Mon, 25 Jan 2021 21:25:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A8B89432E;
        Mon, 25 Jan 2021 21:25:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v2] upload-pack.c: fix filter spec quoting bug
References: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
        <20210125170921.14291-1-jacob@gitlab.com>
        <xmqqlfcgyf0o.fsf@gitster.c.googlers.com>
        <YA81LEon1RPzT0T9@coredump.intra.peff.net>
Date:   Mon, 25 Jan 2021 18:25:29 -0800
In-Reply-To: <YA81LEon1RPzT0T9@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 25 Jan 2021 16:16:28 -0500")
Message-ID: <xmqqlfcg4ep2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C265825E-5F7D-11EB-9EFC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 25, 2021 at 11:48:07AM -0800, Junio C Hamano wrote:
>
>> I suspect that 0b6069fe (fetch-pack: test support excluding large
>> blobs, 2017-12-08) sort-of fixed half of the problem (i.e. the half
>> when there is no hook used) while leaving the other half still
>> broken as before.
>> 
>> But because .use_shell does not affect if we should or should not
>> quote, we can unconditionally drop the use of sq_quote_buf().
>
> Yep. That was the same conclusion I came to in my earlier reply:
>
>   https://lore.kernel.org/git/YAs2RMT1rEH%2F2LSp@coredump.intra.peff.net/

Thanks.  As I am behind, I needed to think it aloud to make sure I
am on the same page as others ;-)  A sanity check like this is
greatly appreciated.
