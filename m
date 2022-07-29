Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiG2Ps4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiG2Psy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:48:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF687F4A
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:48:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3A561A1060;
        Fri, 29 Jul 2022 11:48:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DxbhESDWnPJg
        1HofD0J6tRa9ohKMABSgzbhg25IeIqE=; b=V2EsLWJ19N71Tpvk+jwQcBzRPfHR
        ZhvuNxl44pH6NwiVfJdhSBa00EGj2AFvHqPt7HBU4wYoHAo78Tbztm++97eO/l8y
        h/hVOfYdI/dt4v71Giu08UN/N1bGVe2FlzY2x6CYUlGp0mR8w9r0QOZxlVvVERTC
        Bqf5My4DB1oKsp0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC8331A1059;
        Fri, 29 Jul 2022 11:48:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C7511A1057;
        Fri, 29 Jul 2022 11:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
Date:   Fri, 29 Jul 2022 08:48:46 -0700
In-Reply-To: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Fri, 29 Jul
 2022 16:05:55 +0700")
Message-ID: <xmqqbkt7api9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EF07FB82-0F55-11ED-83C2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> mmfs is an array of struct, xmparamt_t's first field is a struct,
> mmfs's element and xmparamt_t's first field must be initialised
> with {0}.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>
>  This warning is available in master

Thanks, but didn't we discuss this recently and decided that such
(false) complaints by ancient compiler is not worth catering to by
deliberately deviating the "zero initializing a struct is always
done via { 0 }" idiom?

cf. https://lore.kernel.org/git/CAPig+cSgNB=3DSzAZLhXvteSYmy0HvJh+qWHMYyB=
xcX_EA9__u4A@mail.gmail.com/

I think the concensus was that we should squelch the false warning
on older compilers with -Wno-missing-braces, but then the discussion
has stalled by a suggestion to introduce a way to detect older
compilers that is different from how we do so at the same time, and
went nowhere.

Hopefully we can add a simple -Wno-* without waiting for whole
config.mak thing getting revamped this time?


