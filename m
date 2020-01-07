Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B49C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229EB24680
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FhH+ebjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgAGQ6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:58:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGQ6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:58:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EB04322FD;
        Tue,  7 Jan 2020 11:58:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YqP88eaVxGIE4xHG+xidstrZWv8=; b=FhH+eb
        jmp4QxnYB48VeZXSu64Z+cH4s9VoGUrTWO7DOIAtwj7ii/NoNAUrFa3Kb3RfN8tU
        XiOY6w72ErHK05aGXiRXyC707syvdMfUZwyd3U5ojuckcJbaUUXK1FVRYg1AK0as
        4opkadJSgdQkGFEtCY+XUiRcTylgzo8wOsMCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HE79VY+czC7mItipaQ5DDqw6zN5C2cYk
        d6Ed1bIm7sOuS7qSj8FmDkG54WJuDqVf9sxT+G77xXZTQ4u+6druPjb/DmjUo3Bt
        lDQ4vNJ7bsjbnPKGuy7SJRPQPuhQhZn4JQPQ6v86yHQT0uG87sjHxFeyJOz8MpUY
        aMI/+mn94Ns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76CEC322FC;
        Tue,  7 Jan 2020 11:58:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DEBD6322F9;
        Tue,  7 Jan 2020 11:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
        <20200107110145.GA1073219@coredump.intra.peff.net>
Date:   Tue, 07 Jan 2020 08:58:09 -0800
In-Reply-To: <20200107110145.GA1073219@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jan 2020 06:01:45 -0500")
Message-ID: <xmqqzhez5hlq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2C9FEDC-316E-11EA-B9D9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2020 at 01:36:40AM +0000, brian m. carlson wrote:
>
>> In this function, we free the pointer we get from locate_in_PATH and
>> then check whether it's NULL.  However, this is undefined behavior if
>> the pointer is non-NULL, since the C standard no longer permits us to
>> use a valid pointer after freeing it.
>> 
>> The only case in which the C standard would permit this to be defined
>> behavior is if r were NULL, since it states that in such a case "no
>> action occurs" as a result of calling free.
>> 
>> It's easy to suggest that this is not likely to be a problem, but we
>> know that GCC does aggressively exploit the fact that undefined
>> behavior can never occur to optimize and rewrite code, even when that's
>> contrary to the expectations of the programmer.  It is, in fact, very
>> common for it to omit NULL pointer checks, just as we have here.
>
> OK, I agree it makes sense to be on the safe side here (and the patch is
> obviously the right fix).
>
>> Noticed-by: Miriam R. <mirucam@gmail.com>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>
> I think Miriam actually posted the same patch in her initial email:
>
>   https://lore.kernel.org/git/CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com/
>
> I don't know how we want to handle authorship.

I think the explanation in the log message has as much value as, if
not more than, the actual patch text, in this case.  Noticed-by: may
be striking the right balance.

Thanks, all.
