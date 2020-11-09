Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F898C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA253206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQHpZFef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgKIWis (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:38:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63550 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgKIWis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:38:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6360692DFD;
        Mon,  9 Nov 2020 17:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jtd2n/P6Jaus9BM4XqrlQQCAMWo=; b=WQHpZF
        efAhuTKd9qAixIyRDLuA4FqdnpscXSlAojAObGqqx81zM1gqXbCfk1a1nN8YutyZ
        Jw4pJOqeLK07xjdNT+KGIw2NUZbTVEHc5dmsZZDxm0nat5WMVJSR1ScghRN51qvD
        ItCmhyRcoCfFlk7yXGOD9XPkob4ZITxBsKzyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ryLzjwWrxImx3oOXrFVPDWQvhh0WlukT
        6jsnnXFZoEj4z/gNfTTzP22es5jHC8i+RQ+a20oGGw3MSREZqHSvWinpZQHLk5n/
        m/eiQbsVdc+IKV9D6JriHXB9DJx/R4nVlRchhfHMQ+/mUBQKt9uS8EX9QL2Z73qg
        Zd5sQR6XX9c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BD3392DFB;
        Mon,  9 Nov 2020 17:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A443192DF9;
        Mon,  9 Nov 2020 17:38:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] update-ref: Allow creation of multiple transactions
References: <cover.1604501265.git.ps@pks.im> <cover.1604908834.git.ps@pks.im>
        <20201109223330.GC670413@coredump.intra.peff.net>
Date:   Mon, 09 Nov 2020 14:38:44 -0800
In-Reply-To: <20201109223330.GC670413@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 9 Nov 2020 17:33:30 -0500")
Message-ID: <xmqqzh3q9mvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53AC61A8-22DC-11EB-8F0F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 09, 2020 at 11:06:43AM +0100, Patrick Steinhardt wrote:
>
>> this is the second version of this patch series implementing support for
>> creation of multiple reference transactions in a single git-update-ref
>> process.
>> 
>> There's two changes compared to v1:
>> 
>>     - A small refactoring of t1400, which refactors many tests to not
>>       touch references via the filesystem but instead to use
>>       git-update-ref and git-show-ref. There's still tests in there
>>       which do, but converting them is harder as they create and read
>>       broken references.
>> 
>>     - I've added another commit on top which disallows restarting of
>>       transactions. E.g. writing "start\nstart\n" to git-update-ref is
>>       now going to fail.
>
> Thanks. Aside from the issues raised by Junio, this all looks good to me
> (and I agree on the fourth one it is just a matter of the commit
> message; what the code is doing is a definite improvement).

Yeah, I agree that it is just terminology.  If we were to explain it
as lack of nested transaction, however, the error message would need
to be updated.  Other than that, I think this is quite good.

Oh, Patrick, please do not forget that it is our convention not to
Capitalize the word immediately after <area>: on the title of the
commit (cf. "git shortlog --no-merges -200").

Thanks.
