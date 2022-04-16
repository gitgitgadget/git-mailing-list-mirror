Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB73C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiDPO0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDPO0B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 10:26:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31E31DE8
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 07:23:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2826B19AC00;
        Sat, 16 Apr 2022 10:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=1cyO+klhR368yl9pf2Q+2I6eI
        +CmBZSHZTmEOSNtYuw=; b=jYbhL4k5PDCNP5oV9EBMr4HgHZ7dweDAmZ9usjhCx
        yoxYn43rWe5nPJvHJfU+uw+XzBn2KnEScbYmrQWaNQf7EnNUnqF7+lG0YKF+BQ80
        L2TqnU5qE87QWWFnKNZkOpt/uk8qN7m0rPU6USf+Gaubj0JOqF8noBucoxn9sz42
        Z4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20FB619ABFF;
        Sat, 16 Apr 2022 10:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A399919ABFE;
        Sat, 16 Apr 2022 10:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-3-carenas@gmail.com>
        <xmqqh76taplg.fsf@gitster.g>
        <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
        <xmqqwnfp98ix.fsf@gitster.g>
        <220416.86lew5akh1.gmgdl@evledraar.gmail.com>
Date:   Sat, 16 Apr 2022 07:23:24 -0700
Message-ID: <xmqq1qxx6rab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C737420A-BD90-11EC-9726-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. the assignment earlier in the function is unconditional, why
> wouldn't the clearing of the data correspond to that assignment and
> clear it unconditionally?

The original problem description that introduced .finished member
indicates that inside the while() loop, the same slot object can be
completed (by feeding it to finish_active_slot(), which would also
clears its in_use thus making it reusable) and then later be reused
(by using it for a different request).

The dispatching is done by calling step_active_slots() repeatedly
inside the loop and I do not think there is any multi-threaded
concurrency to worry about here.  The protection is against a case
where such a slot, which was originally ours and pointed at our
on-stack finished variable with its finished member, is reused for a
different request, and its finished member is used in a similar way
to point at the on-stack finish variable in somebody else's
stackframe in the future code.  If the slot instance we were using
as ours upon the entry of this function is being used for another
request already (the fix that required the .finished member is an
enough explanation that it is a real concern), after we leave the
loop, the slot instance is no longer ours, so we need to be careful
when we clear it.

At the entry of this function, the story is vastly different. The
slot instance belongs to us---the caller chose the slot and decided
to use it to service a particular request and threw the slot
instance at us, so there is nothing wrong to unconditionally use the
.finished member of the slot and point it at a variable in our
stackframe.  But after the loop leaves, and the slot may or may not
be already reused to hold another request.  If .finished is set and
it is the value that points at the variable in our stackframe, then
we are the only one who could have set that and it is safe to clear.
Any other value other than NULL, we do not know at that point who
set it, and it is being used for a request that we have nothing to
do with.  That is why we want to refrain from touching it when it is
not clearly ours.



