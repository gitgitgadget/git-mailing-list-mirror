Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A39C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A964D2064E
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wd9zUMdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgEMQUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:20:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgEMQUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:20:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 713426209A;
        Wed, 13 May 2020 12:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vmJAj6IwQSOG6l68Fn6Fp+CWkac=; b=wd9zUM
        dnXRZzelfBcQHD1Jnw7pV04m1dM303rB8tC3l8wCMkVVaGOC2EmVo9e6kyGKhTRp
        4/zm7NqcQSoF1yc1kOcngZIPLDYn+9f3yXxI9R4PB6XnhJI7uNAKXMegQeDvAu4M
        5C49DGNcXp75srBk4fhygwBZJcSc4GGUnVdjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d1ZGmudcEBMGkYabsnCZQAzroPy8UZGr
        sF4xxUYwGzJEzpToHkF5mEn7ohwOHgfwMVUt1glasj02GfFbFVQV/YAMs8S6MjLI
        nwEm3KoIG3pNGyFuXKUfZfjO46OLFmzWGb5ML0rineKQfd+ZxDXFHaM1s33GtdMR
        GjPyCgqYebs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6692A62099;
        Wed, 13 May 2020 12:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A04E862097;
        Wed, 13 May 2020 12:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] t4210: detect REG_ILLSEQ dynamically
References: <20200513111636.30818-1-carenas@gmail.com>
        <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
Date:   Wed, 13 May 2020 09:20:10 -0700
In-Reply-To: <CAPig+cTUc2-ddWQ+oww5Ez7_N9qKgCuErk8OuOgPkXNrACdppw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 13 May 2020 11:44:53 -0400")
Message-ID: <xmqqmu6bvmbp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EB9411E-9535-11EA-8296-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
>> @@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
>>  {
>> -       int flags = 0;
>> +       int ret, opt_s = 0, flags = 0;
>> [...]
>> +       if (!strcmp(argv[1], "--silent")) {
>> +               opt_s++;
>
> Nit: When reading the declaration of 'opt_s', I found the name
> inscrutable; it was only upon reading the actual code, that I
> understood that it reflected whether --silent had been used. How about
> giving it a more easily-understood name, such as 'silent'?

Yup, that is a reasonable fix to the readability problem.

>> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
>> @@ -56,21 +56,29 @@ test_expect_success !MINGW 'log --grep does not find non-reencoded values (latin
>> +test_have_prereq GETTEXT_LOCALE &&
>> +! LC_ALL=$is_IS_locale test-tool regex --silent $latin1_e $latin1_e EXTENDED &&
>> +test_set_prereq REGEX_ILLSEQ
>
> Nit: Is there precedent for formatting the code like this? At first
> glance, I read these as three distinct statements rather than one
> large composite statement. I wonder if indenting the continuation
> lines would make this more easily-digested.

It's not like we are running three tests and expecting all of them
to succeed (or report a failure otherwise).  The first two are the
conditions we want to trigger the action the third one represents.

I'd prefer to see it written with "if then fi".  That would also be
a worthwhile readability fix.

>> -       test_set_prereq REGEX_ILLSEQ
>> -       test_set_prereq POSIXPERM
>> -       test_set_prereq BSLASHPSPEC
>> -       test_set_prereq EXECKEEPSPID
>> -       ;;
>
> The commit message explains why you remove the 'REGEX_ILLSEQ', but why
> are all the other lines removed, as well? Such removal seems unrelated
> to the stated purpose of this patch.

Yup, I was wondering about the same thing.

Thanks.
