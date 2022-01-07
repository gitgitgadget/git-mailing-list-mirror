Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3896C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 22:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiAGWR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:17:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60623 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiAGWRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 17:17:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A156216FF19;
        Fri,  7 Jan 2022 17:17:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6Dq4QmALdjvh
        74hTm4PtqPo+W4q09PS0/uDKkjNcznc=; b=bEgLmsbC8YecL/eiuYmTaDUc6Auj
        R5NSBvkdxpH5sLtz5T3dSQOFE+syQ3N4jw9cY69t9prX9o+22XlE0k8tRsSUVe5+
        ODlVcguB/wbK39F9bCDAPWudshzB/JtOaqwJoax9cGkKZjRG37JjewPuMqgj4hcJ
        aU4K2Nkeolbi4xk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 980D316FF18;
        Fri,  7 Jan 2022 17:17:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F01E316FF17;
        Fri,  7 Jan 2022 17:17:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 0/6] refs: excessive hook execution with packed refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 14:17:21 -0800
In-Reply-To: <cover.1641556319.git.ps@pks.im> (Patrick Steinhardt's message of
        "Fri, 7 Jan 2022 12:55:09 +0100")
Message-ID: <xmqqiluv6vim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96477164-7007-11EC-ACEB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is a resend of version 1 of this patch series to hopefully entice
> some reviews. The only change is that v2 is rebased onto the current
> main branch at commit e83ba647f7 (The seventh batch, 2022-01-05). The
> following was from the orignial cover letter:

I'll add =C3=86var, who has been making a lot of changes to the refs
subsystem, and Han-Wen, whose work to add a new ref backend may need
to interact with this change, as possible stake-holders to the CC list.

> As reported by Waleed in [1], the reference-transaction hook is being
> executed when packing refs. Given that the hook ideally ought to track
> logical updates to refs instead of leaking low-level implementation
> details of how the files backend works, this is understandably leading
> to some confusion.
>
> This patch series aims to fix that by improving how the tandom of loose
> and packed refs backends interact such that we skip executing the hook
> when the loose backend:
>
>     - repacks references.
>     - needs to delete packed refs when deleting a loose ref would
>       uncover that packed ref.
>
> Patrick
>
> [1]: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.co=
m>
>
> Patrick Steinhardt (6):
>   refs: open-code deletion of packed refs
>   refs: allow passing flags when beginning transactions
>   refs: allow skipping the reference-transaction hook
>   refs: demonstrate excessive execution of the reference-transaction
>     hook
>   refs: do not execute reference-transaction hook on packing refs
>   refs: skip hooks when deleting uncovered packed refs
>
>  refs.c                           | 11 +++++--
>  refs.h                           |  8 ++++-
>  refs/files-backend.c             | 25 +++++++++++-----
>  refs/packed-backend.c            | 30 ++++++++++++++-----
>  refs/packed-backend.h            |  6 ++++
>  refs/refs-internal.h             |  1 +
>  sequencer.c                      |  2 +-
>  t/t1416-ref-transaction-hooks.sh | 50 ++++++++++++++++++++++++++++++++
>  8 files changed, 113 insertions(+), 20 deletions(-)
