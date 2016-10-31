Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE802021E
	for <e@80x24.org>; Mon, 31 Oct 2016 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945896AbcJaTZz (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 15:25:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61898 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S945890AbcJaTZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 15:25:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACDB94B3C3;
        Mon, 31 Oct 2016 15:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NdlY5eNcKWlR
        48DYCPrAyQ8zx8M=; b=LE9Lg2bnw7+gQmvAlBf90CKrXyk57XIYZ3oKgi44iB/U
        r5ieMSDnJHo6GZSNQK1h6DXPYuBVKt1agGPmCs/eFlSqG8RlCvekB2cv/IU+gVK/
        +LNSs/1wokceJBm4TEk0MP5w6ciN6dRahsGfE8X+pi8eYdRVqEA7vsuWvSdqTcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZhKqR1
        D3hBnIrXR5qt3KNj1ifzfBmGExpTUVy9IkZfEJf86jTk7pB5WyvB+23bjOnj2AmT
        UfaCIiZ7XeUcGJgIUgfTNDtxlmeLPo5QA+0q/egAuBzjiIgLTLNVBirEiX8RuqWW
        Vc3ItHygTnrI7OtBeZclYAqfMIOws0ep2jZSA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A443C4B3C2;
        Mon, 31 Oct 2016 15:25:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1695C4B3C1;
        Mon, 31 Oct 2016 15:25:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: add --forget to cleanup rebase, leave HEAD untouched
References: <20161026094658.20704-1-pclouds@gmail.com>
        <xmqq60ofcavd.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CSz-2A56okV6kWBjGqUgiL7DrmmVJ=2jEQhKmqe41cRg@mail.gmail.com>
Date:   Mon, 31 Oct 2016 12:25:48 -0700
In-Reply-To: <CACsJy8CSz-2A56okV6kWBjGqUgiL7DrmmVJ=2jEQhKmqe41cRg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 27 Oct 2016 17:40:43 +0700")
Message-ID: <xmqqshrctj5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D4DA2FA4-9F9F-11E6-A99A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Oct 26, 2016 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> There are occasions when you decide to abort an in-progress rebase an=
d
>>> move on to do something else but you forget to do "git rebase --abort=
"
>>> first. Or the rebase has been in progress for so long you forgot abou=
t
>>> it. By the time you realize that (e.g. by starting another rebase)
>>> it's already too late to retrace your steps. The solution is normally
>>>
>>>     rm -r .git/<some rebase dir>
>>>
>>> and continue with your life. But there could be two different
>>> directories for <some rebase dir> (and it obviously requires some
>>> knowledge of how rebase works), and the ".git" part could be much
>>> longer if you are not at top-dir, or in a linked worktree. And
>>> "rm -r" is very dangerous to do in .git, a mistake in there could
>>> destroy object database or other important data.
>>>
>>> Provide "git rebase --forget" for this exact use case.
>>
>> Two and a half comments.
>>
>>  - The title says "leave HEAD untouched".  Are my working tree files
>>    and my index also safe from this operation, or is HEAD the only
>>    thing that is protected?
>
> Everything is protected. I will rephrase the title a bit. The option
> is basically a safe form of "rm -r .git/rebase-{apply,merge}".

We are not in a hurry, as it is not likely that this will hit 2.11
even if we saw a rerolled version yesterday, but it would be nice to
cook it on 'next' so that it can be on 'master' early after the
upcoming release.

Thanks.
