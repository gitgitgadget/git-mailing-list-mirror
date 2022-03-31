Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA3C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiCaVQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiCaVQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:16:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D4191426
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:14:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A160187106;
        Thu, 31 Mar 2022 17:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eKpsH4qfEo9b
        XSQCfkHpZV5Fum8CCqgjIUKGoVW57FE=; b=WP4fLPLWTRnAMV71p6mj8mfpvhdX
        p8lxAvs0iOzxrZzU1eyxQQ2VebV6xCBhfOOf5vWklxaVu1KMvYJ1SYPVsub1tbsR
        0bE+kq2/Y2BprbknbZH524zh1r6x3RX3MfS8Et7+9hdD1/UpYTkQLverj/jQiABk
        O0D3jODpFfDDC6A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82617187105;
        Thu, 31 Mar 2022 17:14:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E15EE187103;
        Thu, 31 Mar 2022 17:14:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 09/27] revisions API users: use release_revisions()
 needing REV_INFO_INIT
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <patch-v4-09.27-2f4e65fb534-20220331T005325Z-avarab@gmail.com>
Date:   Thu, 31 Mar 2022 14:14:42 -0700
In-Reply-To: <patch-v4-09.27-2f4e65fb534-20220331T005325Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 31 Mar
 2022 03:11:14
        +0200")
Message-ID: <xmqq1qyh25a5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95FDDC4A-B137-11EC-AB38-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use release_revisions() to various users of "struct rev_list" which
> need to have their "struct rev_info" zero-initialized before we can
> start using it.
>
> To do this add a stub "REV_INFO_INIT" macro, ideally macro would be
> able to fully initialize a "struct rev_info", but all it does is the
> equivalent of assigning "{ 0 }" to the struct, the API user will still
> need to use repo_init_revisions(). In some future follow-up work we'll
> hopefully make REV_INFO_INIT be a "stand-alone" init likke STRBUF_INIT
> and other similar macros.

I do not think we want to leave such a misleading paragraph to
future developers.

Yes, We may want to move some of what init_revisions() does to
REV_INFO_INIT(), and for that, it helps to start using greppable
string REV_INFO_INT early rather than { 0 } to ease such transition,
and that is what we should be stressing, instead of ranting "it does
not do anything, so why are we stupidly introducing a name, instead
of writing { 0 }, which is what amounts to it anyway?" without
explicitly saying so but hinting with words like "stub", "all it
does is", and "will still need to".

Is that some kind of passive-aggressive thing?

You cannot use get_revision() even after calling init_revisions(),
and still need to use setup_revisions() before hand, but that does
not mean init_revisions() is not doing its job.  It may be
implemented as the zero-initialization right now, but it misses the
point to put a stress on the fact that it doesn't do much now.
