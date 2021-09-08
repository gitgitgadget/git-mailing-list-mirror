Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBCC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5309E6115B
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbhIHRDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:03:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51436 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhIHRDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 13:03:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBF3A1662E7;
        Wed,  8 Sep 2021 13:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bvzyR6ISQT+j
        af+5QUqx/3J56tLI1q+6mCI5YYIZSKU=; b=cTBawM2IEkBFxnIKevp53k3/7hLq
        RkU1exn4s0k9ZNnZqjK/+knz38Nv9zWCs0sOBE+eJT3JdlOZ/Tntw0Ca+sKMf7dR
        mjYHHhCet4/WaS46RY9swpfcXMRpUxZqSs51RXjSbepHrRbA6MCSbOdoYcA+GsqD
        JdXC5x9LS5mIZc4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B482A1662E6;
        Wed,  8 Sep 2021 13:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00D6E1662E5;
        Wed,  8 Sep 2021 13:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 4/6] help: refactor "for_human" control flow in cmd_help()
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <patch-4.6-e4bc7e57a6d-20210908T151949Z-avarab@gmail.com>
        <CAPig+cQVsFvkLMXrm7d3mCUoJKj7x+0PNcAYJ0-uFHaqbRw0ag@mail.gmail.com>
Date:   Wed, 08 Sep 2021 10:02:12 -0700
In-Reply-To: <CAPig+cQVsFvkLMXrm7d3mCUoJKj7x+0PNcAYJ0-uFHaqbRw0ag@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 8 Sep 2021 12:41:46 -0400")
Message-ID: <xmqqsfyf3srv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83AA98BA-10C6-11EC-9309-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 8, 2021 at 11:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Instead of having two lines that call list_config_help(for_human)
>> let's setup the pager and print the trailer conditionally. This makes
>> it clearer at a glance how the two differ in behavior.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>> @@ -574,13 +574,12 @@ int cmd_help(int argc, const char **argv, const =
char *prefix)
>> -               if (!for_human) {
>> -                       list_config_help(for_human);
>> -                       return 0;
>> -               }
>> -               setup_pager();
>> +               if (for_human)
>> +                       setup_pager();
>>                 list_config_help(for_human);
>> -               printf("\n%s\n", _("'git help config' for more informa=
tion"));
>> +               if (for_human)
>> +                       printf("\n%s\n", _("'git help config' for more=
 information"));
>> +
>
> For what it's worth, I find the original logic easier to reason about
> since it gets the "simple" case out of the way early, thus I don't
> have to keep as much (or any) state in mind as I'm reading the rest of
> the code. However, it's highly subjective, of course; just one
> person's opinion.

FWIW, it makes two of us ;-)

Quite honestly, I do not see much commonality in the code above that
targets two different audiences, so whether you handle simple one or
complex one first, a single big switch upfront that gives clearly
separate control flow to two distinct cases is easier to follow than
"as the middle step that calls list_config_help() is the same, let's
have two conditionals before and after and serve these two audiences
with a single code path that is slightly tweaked", which is the
result of this patch.

