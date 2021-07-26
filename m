Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85472C4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCE560F8F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGZRHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:07:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZRHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:07:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78338CFCB2;
        Mon, 26 Jul 2021 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Kt3bR1WZ6OXp
        w2fVtIxm3lr0n5XkPDI8wqeOWa4JkHw=; b=wXvPc7xj3JEqdbuBfIFEkBU9iIFA
        SbkSDQRE2W1rB/Ec9sp5+SvwL9JwBC/yz68aWXJ1lp34aWbG2KzDUfBzlF5d9G+6
        4vnmByWBmIYDl0J4XGe7wxeG2LVKbaiLUANnkBQxKCdQPmrdCLCODsrZiRO5ebMm
        Eo0jB5Gpa/BY5iQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F2B5CFCB1;
        Mon, 26 Jul 2021 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F153ECFCAF;
        Mon, 26 Jul 2021 13:47:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
        <xmqq35s7efb3.fsf@gitster.g> <xmqqy29zd0dv.fsf@gitster.g>
        <CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=_-nEu6367pteCxwA@mail.gmail.com>
        <87lf5wstlv.fsf@evledraar.gmail.com> <xmqqzguclpr2.fsf@gitster.g>
        <87fsw1skcb.fsf@evledraar.gmail.com>
Date:   Mon, 26 Jul 2021 10:47:43 -0700
In-Reply-To: <87fsw1skcb.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 26 Jul 2021 07:39:47 +0200")
Message-ID: <xmqqpmv5j7b4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94AFF2A4-EE39-11EB-B23D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> If you feed const oid to *_reflog_expire() method of any backend
>> (including the ones that that are *not* files backend), and if you
>> expect they all will use lockfile API to copy it into lock->old_oid
>> so that it can be fed safely to prepare_fn(), then the arrangement
>> for constness you have set up in your series would work out OK for
>> everybody.  But for any backend that does not use one-file-per-ref
>> filesystem mapping, it is rather strange to use lockfile API for
>> locking refs, no?  THat is what I meant by files-backend specific.
>
> It won't be using the lockfile API, but as an implementation detail the
> non-const old_oid is where the "struct object id *" you get passed come=
s
> from in the file API.
>
> Is that what you mean by the behavior being file-backend specific?

It wasn't that deep.  It was just

 - The constness of the oids _expire() method of backends and
   _prepare() callback take used to be the same;

 - The recent files backend update made them different, because the
   callback made to _prepare() by the files backend wants to lose
   constness because files backend wants to pass the oid embedded in
   the lock object now.

But do we expect other backends, like reftable, to also use lockfile
API so that they will have a writable oid handy to pass their calls
to _prepare()?  I somehow doubted it.  If they want to obtain a
writable place because _prepare() callback now wants to take a
writable oid, they can of course create an on-stack copy and pass
it, but that feels to be working around this "files-backend centric"
change.

In any case, we seem to be focusing on an irrelevant tangent in this
discussion; what made me feel that this change was files-backend
centric does not matter much in the larger picture.  What matters
more now is that this change does not work well with Han-Wen's
latest round, and we need to know what the final shape of these APIs
are.

Thanks.
