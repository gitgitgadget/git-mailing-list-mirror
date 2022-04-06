Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C59C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiDFRnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiDFRnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:43:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768D1F7632
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:53:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F0D012FEFA;
        Wed,  6 Apr 2022 11:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1GvEVG1R9F+p
        H8pu7qpTkXoolwpdBAT3D18gBrsLJHQ=; b=ojttobnj1aB1i22mDrH2wI7HeEzN
        HX9Ya39EZyQWjb9XU9JDJFJfQSpKcpeP3YbSktb8lD9G0pU2BEqrSaguKHDYDbC6
        KXC8qI8slsUONfrGaXzhysLvWjKb8Zj0DxcVYYhfE5CkV9/VpgVx0PU+wMzE5n+b
        ak4gyh8O13xTyWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45F6112FEF9;
        Wed,  6 Apr 2022 11:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A824012FEF8;
        Wed,  6 Apr 2022 11:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
        <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2203301430540.379@tvgsbejvaqbjf.bet>
        <220406.86bkxeecoi.gmgdl@evledraar.gmail.com>
Date:   Wed, 06 Apr 2022 08:53:08 -0700
In-Reply-To: <220406.86bkxeecoi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 06 Apr 2022 11:29:18 +0200")
Message-ID: <xmqq4k361a57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8366C5E-B5C1-11EC-9444-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Briefly: The entire reason I changed those bits is exactly to avoid the
> sort of CI lock-in you're talking about, to th point where this series
> effectively adds another CI target: You can run everything it's doing
> with a normal "make" invocation.

I'll comment only on this part. =20

FWIW, the above matches my impression fromt he base part of the
rewrite.  As long as a particular CI integration runs shell
scriptlets that invoke "make", moving the code that is shared common
among CI platforms from the shell scriptlets to the recipe in
Makefile should not make it harder to support it, and ...

>> A better approach would be to use the already-generic code and adapt i=
t
>> e.g. to extend to the CirrusCI definition we have.
>
> This series doesn't change .cirrus.yml or how it functions, but it just
> does:
>
>   build_script:
>     - su git -c gmake
>   test_script:
>     - su git -c 'gmake test'
>
> Which, after this series is exactly what your "main" CI does. So we're
> set up to make it easier to unify the two.

... BSDs or any POSIXy system I would expect to fall into the same
"shell scriptlets eventually driving make" pattern.

The same argument may not apply if another CI platform uses shell
scriptlets but does not want to use "make" at all.  The "do more in
'make'" movement could be hurting such a user.  I do not know if
Windows' preference to use cmake plays a role there, or if Dscho's
resistance comes from there, though.

> Anyway, I really hope we can find some way past what seems to be an
> impasse with these various CI changes. All the best.

Yup.

Thanks.
