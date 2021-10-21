Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A279BC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F38A60E78
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUSxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:53:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51728 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJUSxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:53:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B85E3167496;
        Thu, 21 Oct 2021 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DM+XpdvyOk/3
        Ma5930qI2TpBl1dH1uR/9wGzaZ3Up6o=; b=Pkp896sYqMYKAvs5E3w5FN2FsfIP
        DAAFiJu5fARmvC+fblqf+HLunHrJij3mQHFdle+YnrfwHNH+GQh9nejnPNLhLlm/
        OxZ6oeHMpvjmleebnN+PKe0ippVXp1plBSjppN0ZIkzCw4ZWJS4LMNK9KQES0bfy
        UCdX7fLpocTcg3g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1C18167495;
        Thu, 21 Oct 2021 14:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14B3F167491;
        Thu, 21 Oct 2021 14:51:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] leak tests: free() before die for two API functions
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
        <FD837FF9-E83F-42AA-AC13-EADD161D20BE@ahunt.org>
Date:   Thu, 21 Oct 2021 11:51:32 -0700
In-Reply-To: <FD837FF9-E83F-42AA-AC13-EADD161D20BE@ahunt.org> (Andrzej Hunt's
        message of "Thu, 21 Oct 2021 17:33:41 +0200")
Message-ID: <xmqqcznyky8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E98AB3A4-329F-11EC-ACD2-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt <andrzej@ahunt.org> writes:

>> On 21 Oct 2021, at 13:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> =EF=BB=BFCall free() just before die() in two API functions whose test=
s are
>> asserted under SANITIZE=3Dleak. Normally this would not be needed due =
to
>> how SANITIZE=3Dleak works, but in these cases my GCC version (10.2.1-6=
)
>> will fail tests t0001 and t0017 under SANITIZE=3Dleak depending on the
>> optimization level.
>
> I=E2=80=99m curious - to me this seems like a compiler/sanitiser bug, c=
an
> it also be reproduced with clang, or even newer versions of gcc?
> Similarly, can it be reproduced with your gcc version, using
> ASAN+LSAN (as opposed to LSAN by itself)? I remember seeing some
> false positives in the past for some permutations of compilers and
> sanitisers, but I=E2=80=99ve lost track of the details.
>
> These kinds of fixes seem noisy if it=E2=80=99s just to work around wha=
t
> appears to be a bug (and to be philosophical: we wouldn=E2=80=99t want =
to
> do the same for all =E2=80=9Cleaks=E2=80=9D up the call stack if a spec=
ific
> compiler complained about them after a die() - after all there
> will be many more allocations that didn=E2=80=99t get free=E2=80=99d fl=
oating
> around - so why is it OK for these =E2=80=9Cleaks=E2=80=9D?)

Exactly my feeling.  I'll leave this patch hanging on the list
without picking it up until we know this is a reasonable "fix" on
our side and not adding noize only to work around the bug in the
tools.

Thanks.
