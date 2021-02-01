Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A5C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F9164E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhBARsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:48:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56540 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhBARsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6345691666;
        Mon,  1 Feb 2021 12:47:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WglttV88gpJQ
        towyyeeZyBUwtYc=; b=DVHUAsIJIxMV1QtcnvfBFpsDi8jknCSOFYLqilWCti3C
        N8Qt3GPaZoGn8Li9VV+g/BxqmWfG2Momu/6RnqjgZv9ziJYVPDqgVAI1IvuP54as
        8zGqBhBbPVIMrawpf3Da2KYmvhbRI9jkzJYo2y8tCpfIFtoKcQ1k9Z1LNjuwH6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ix5WMr
        QrIdt5+qSq6ryDyZsU9orPhUoMqurehzQ7jZUb0mZ28yK/CD/bA3zcCjaDyAgJ9S
        cZ++7bxDJQapk/xAeH2ev8e38Waw+BseKU52mjo5GgTy2ZlMVBJn0AKY7nQ0YhNv
        avjTA4gZMZoH8rDD/PF+dc6MxE3/rYgTRep2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59AF591664;
        Mon,  1 Feb 2021 12:47:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9951A91663;
        Mon,  1 Feb 2021 12:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Lefevre <vincent@vinc17.net>
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
        <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
        <87czxjomn8.fsf@evledraar.gmail.com>
Date:   Mon, 01 Feb 2021 09:47:28 -0800
In-Reply-To: <87czxjomn8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 01 Feb 2021 16:03:55 +0100")
Message-ID: <xmqqtuqvn0i7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8DD6FCC4-64B5-11EB-90C2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/pager.c b/pager.c
>> index ee435de675..5922d99dc8 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -34,6 +34,8 @@ static void wait_for_pager_atexit(void)
>>  static void wait_for_pager_signal(int signo)
>>  {
>>  	wait_for_pager(1);
>> +	if (signo =3D=3D SIGPIPE)
>> +		exit(0);
>
> As shown in
> https://lore.kernel.org/git/20210201144921.8664-1-avarab@gmail.com/ thi=
s
> leaves us without guard rails where the pager dies/segfaults or
> whatever.
>
> That's an existing bug, but by not carrying the SIGPIPE forward it
> changes from "most of the time we'd exit with SIGPIPE anyway" to "we'll
> never notice".

Would it be the matter of propagating the exit status of the pager
noticed by wait_or_white() down thru finish_command_in_signal() and
wait_for_pager(1) to here, so

 - If we know pager exited with non-zero status, we would report,
   perhaps with warning(_("..."));

 - If we notice we got a SIGPIPE, we ignore it---it is nothing of
   interest to the end-user;

 - Otherwise we do not do anything differently.

would be sufficient?  Implementors of "git -p" may know that "git"
happens to implement its paging by piping its output to an external
pager, but the end-users do not care.  Implementors may say they are
giving 'q' to their pager "less", but to the end-users, who report
"I ran 'git log' and after reading a pageful, I told it to 'q'uit",
the distinction does not have any importance.

Or are there more to it, in that the exit status we get from the
pager, combined with the kind of signal we are getting, is not
sufficient for us to tell what is going on?
