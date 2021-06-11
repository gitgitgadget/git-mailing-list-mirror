Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458DC4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5646023C
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFKDyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:54:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51227 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFKDyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 23:54:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4E70133874;
        Thu, 10 Jun 2021 23:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jahxZuFIaz+0r/ZWtBpMsW4kgGQQcTDOzxsUKn
        LY56k=; b=iENap9P3VIVMOqgFTXHZroUtvhxWPm/jmhBZ6WeJh7tdhACMd5B87I
        og46UOi/U3dGXU+3FuUTlTH8LnZqWkR63D1l1Nazj9rkyZ26hJdEqu7TTfjyXpAS
        SstZ7Ay/8SXP2SbUuPLtuj5RAHo9kZ50yLSIBat4Cn39iYOmHN8hY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDB1C133873;
        Thu, 10 Jun 2021 23:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35A91133872;
        Thu, 10 Jun 2021 23:52:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] add_pending_object_with_path(): work around "gcc -O3"
 complaint
References: <YMIOY6Hp6//yGrFm@coredump.intra.peff.net>
        <YMIPb+9e2PtaLZhl@coredump.intra.peff.net>
Date:   Fri, 11 Jun 2021 12:52:08 +0900
In-Reply-To: <YMIPb+9e2PtaLZhl@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 10 Jun 2021 09:11:11 -0400")
Message-ID: <xmqqzgvx3vo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 660B1C2A-CA68-11EB-B4AD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 10, 2021 at 09:06:44AM -0400, Jeff King wrote:
>
>> We can work around this by replacing our "did we hit the trailing NUL"
>> subscript dereference with a length check. We do not even have to pay
>> the cost for an extra strlen(), as we can pass our new length into
>> interpret_branch_name(), which was converting our "0" into a call to
>> strlen() anyway.
>> [...]
>> -		if (0 < len && name[len] && buf.len)
>> +		if (0 < len && len < namelen && buf.len)
>>  			strbuf_addstr(&buf, name + len);
>
> I guess another option would be to drop the check entirely. It is only
> protecting us from calling strbuf_addstr() with an empty string, which
> is a noop anyway (it would not even cause a useless allocation, since we
> know that buf is non-empty, and that it won't need to grow).
>
> I think I still prefer my original solution, though.

It may still work without the guard but it is not apparent to the
readers if it just happens to work by accident or by design.  At
least the guard makes it clear what is going on, I would think.

