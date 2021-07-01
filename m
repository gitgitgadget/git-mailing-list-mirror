Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410EC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385C4613CB
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhGAP7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:59:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55757 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhGAP7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:59:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E192DD3D97;
        Thu,  1 Jul 2021 11:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SBQIkHpbKqDz
        8OtOkbS6QWqjRaFEXaMxhv1aZV8l/C4=; b=YYz8c75XJaCXnB0M/A74ZSvX2o8g
        xn6QdeSHza9SqRud9aI4vXegVAPrgIhu6d+mt8uYH67/4Z+GW4iol+sPDTiZTddz
        gjTa0GjYV/HUv2P4KG4LjdXjE5hS9MkCQ1RzR3LbpEV8EsjYX/0G8SBE6nBMoGcG
        lLHEvO8yqo6FbFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA06ED3D95;
        Thu,  1 Jul 2021 11:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5ECD9D3D94;
        Thu,  1 Jul 2021 11:56:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] *.h: move some *_INIT to designated initializers
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
        <patch-1.5-9a92e7c216f-20210701T104855Z-avarab@gmail.com>
        <CAN0heSpsg=bwX9gbYfeWYqUbuen-zArR69FWxNmdtcQW_RubzA@mail.gmail.com>
Date:   Thu, 01 Jul 2021 08:56:46 -0700
In-Reply-To: <CAN0heSpsg=bwX9gbYfeWYqUbuen-zArR69FWxNmdtcQW_RubzA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 1 Jul 2021 17:00:02
 +0200")
Message-ID: <xmqq8s2qrps1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0B7B136-DA84-11EB-8157-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> -#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
>> +#define STRING_LIST_INIT_NODUP { 0 }
>
> This "NODUP" one is a bit of an odd case though. You don't actually
> change it to use designated initializers, as the patch says. Instead yo=
u
> change it in a slightly different way. In a sense, you assign the
> literal zero not to strdup_strings, but to the first field, which is a
> pointer, where I would have expected NULL.
>
> I think there's been some recent-ish "we can assign `{ 0 }` even if the
> first field is a pointer, because it's idiomatic and works out fine"
> even if assigning 0 to a pointer looks a bit odd. So it might not be
> wrong as such, but it doesn't match what the commit message claims, and
> I think it would be more clear to use `{ .strdup_strings =3D 0 }` here:
> We're explicitly interested in *not* duplicating the strings. It's not
> just some default "let's leave everything as zero/NULL".

Well reasoned.  I agree that it is not wrong per-se, and the
solution to use designated initializer is indeed in line with the
theme of the topic.

