Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F1C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEB7610A1
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhHaQlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:41:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50758 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhHaQla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:41:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFF15ED179;
        Tue, 31 Aug 2021 12:40:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g3yCh6uF11Br
        VQPOr+VtM3EVAI2PdHxGMtfuz6/XYH4=; b=Khq/dzwIBqcyniVAaJTxJW70EzuP
        NqHki93ccDxENc6HP7s1ED61Fen4FUPTFakkUQNQXsV5XoAs44ofjkwuCa+ihWJF
        EMj5Xq6Rf0fLLWanbvzlT/vB90A1PYpsK48YMn0bd5HDY9RBXEXz9nCQP4aCJcM1
        +px3WNEfpTbxluI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3D65ED178;
        Tue, 31 Aug 2021 12:40:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4098ED177;
        Tue, 31 Aug 2021 12:40:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH v4] pull, fetch: fix segfault in --set-upstream option
References: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
        <patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com>
Date:   Tue, 31 Aug 2021 09:40:33 -0700
In-Reply-To: <patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 31 Aug
 2021 15:58:17
        +0200")
Message-ID: <xmqqfsupwose.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 296202AA-0A7A-11EC-902E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>> Testing the new behaviour is a good idea.  I also agree with you
>> that die() would be more appropriate and does not risk regression,
>> if the original behaviour was to segfault.
>
> Indeed. I changed it due to your upthread
> <xmqqsg0anxix.fsf@gitster.g>.
>
> I think doing s/warning/die/ here makes sense, but similarly to the
> above comment: Let's punt on that and do it separately from this
> narrow segfault fix. If and when we change that we should change
> various other "warning()" around this codepath to "die()" as well.

I do not think that can be thrown into the same bin as "should UI
give irrelevant details?" issue.  If you make it not to segfault and
give just a warning(), it becomes impossible to make it die() later.

If we all agree that die() is a better action, that must be done
now, or it will become never once the change is released to the
field.


