Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E78C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8351923118
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbhAFL4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:56:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62882 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFL4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:56:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4AF49E958;
        Wed,  6 Jan 2021 06:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JPOuKxawOUmN1M/hxIapigltx
        Xg=; b=MkgdRiPPAohHN21t9v83uo7TTU9DizKDNfsJU/Sg4HeNZ55m1HqQx1S3b
        yAZac+o45BY8DwpfRsNx9CX/hTiS6B88Z9RgIl62rbApOdvpMmNbimZxfvaqwzZ1
        uYqcz3vGVjcQog6zGy7FhIjanQ27/xWNVEZc+jB+C2Kqc40zJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=mdk40jpj7qXL0al3kwv
        Y0l/vAFJ5TURB+2TnH9fFgKifqhI5Xboux5kuvwZEYQGlEd7kGlB8SoqHRkr+oVN
        Ekk81eR+I2a8FZd2IaBP7T3xXE+C1QsAKmDPeY2oKblZgQ2VvLvuviNaKW31bvrr
        KfYUgpMfHjw4yR16AecHQzCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDA089E956;
        Wed,  6 Jan 2021 06:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D8D19E955;
        Wed,  6 Jan 2021 06:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
References: <cover.1609874026.git.martin.agren@gmail.com>
        <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
Date:   Wed, 06 Jan 2021 03:55:22 -0800
Message-ID: <xmqq5z4as2j9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EDFCAC6-5016-11EB-9304-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/5/2021 2:23 PM, Martin =C3=85gren wrote:
>> I made a comment in [1] about how we could avoid peeking into a `struc=
t
>> lock_file` and instead use a helper function that we happen to have at
>> our disposal. I then grepped around a bit and found that we're pretty
>> good at avoiding such peeking at the moment, but that we could do
>> a bit better.
>>=20
>> Here's a series to avoid such `lk.tempfile.foo` in favor of
>> `get_lock_file_foo(&lk)`.
>>=20
>> [1] https://lore.kernel.org/git/CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+w=
z6NXCXTsfcvGg@mail.gmail.com/
>
> Thanks for being diligent and keeping the code clean.
>
> This series is good-to-go.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both.
