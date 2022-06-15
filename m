Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A920C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 16:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiFOQl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiFOQl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 12:41:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4DA4BFE9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:41:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E061A123D6C;
        Wed, 15 Jun 2022 12:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RTmjxS/2t76J
        FRpzMxDG0cfxziJc4cfdCV+mlTrLYtc=; b=fFkC8kuK7TAzIw+EvJ/J5hwZhJn0
        pZLe6kzhkI86kLqQt0DJ1+RXUXGJuEVjVtv96H9UaVda7MkcvKzTU8WNhnUMVpdQ
        Fbps86oFJ6/BEWfEqEL/eCutRzcV0WsDmSr7PednM7SROj2pRnpPEMxX9vAIXGPx
        Y+4gq+vm1GW1H9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D735E123D6A;
        Wed, 15 Jun 2022 12:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50186123D69;
        Wed, 15 Jun 2022 12:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
References: <pull.145.git.gitgitgadget@gmail.com>
        <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
        <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de>
        <xmqqk09k449y.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
        <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
        <nycvar.QRO.7.76.6.2206141802310.353@tvgsbejvaqbjf.bet>
        <4b4da5b3-7898-e97b-af74-a6874c8cb7e2@web.de>
Date:   Wed, 15 Jun 2022 09:41:21 -0700
In-Reply-To: <4b4da5b3-7898-e97b-af74-a6874c8cb7e2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 14 Jun 2022 22:04:59 +0200")
Message-ID: <xmqqletx2826.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD461F52-ECC9-11EC-8892-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> archive-tar.c (and archive-zip.c) use other static variables, so a
> static gzhead won't break or block anything in this regard.  There was
> no interest in running it in parallel threads so far AFAIK, and it's
> hard for me to imagine the usefulness of creating multiple .tgz files a=
t
> the same time.

;-)  FWIW I had exactly the same reaction. =20

If this were a lot isolated piece of helper function, perhaps, but
no, reentrancy for this helper function specifically written for
this code path is not a very good argument.

The code structure the (not very good) argument tried to suport,
however, is a good thing to have regardless, and if the code is
written in such a way from the beginning, there is no reason to
reject it.  If it opens the door to a unified way to deal with all
the other static global variables (e.g. have a "archiver_state"
structure that collects all of them, with this one included, and
pass it around, or something), that would be great.

Short of that, I do not care too much either way.  As this topic is
not even in 'next', "once written in one way, it is not worth the
code churn to rewrite it in the other way, when these two ways are
both reasonable" does not yet apply here, so ...

> But that's all just minor quibbling -- I'll include your changes in the
> next version, they look fine overall.

... that's fine, too.

Thanks, both.
