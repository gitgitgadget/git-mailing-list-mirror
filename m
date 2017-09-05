Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7407C208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdIEKC7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 06:02:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750896AbdIEKC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 06:02:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACAEEA31FE;
        Tue,  5 Sep 2017 06:02:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=0S/QDDimAzcijzc2xa0ln4dp6
        yM=; b=M1YCb8tOGQkrptJT1bH9mZFxeZZtRSvAWxXNi/TQnq8Z+IHJqhCqqWhiq
        RI55D8e05YyanL2tsvCv45pDmdnlRJSDzheRscVI0VL5bekg+IqaOf2Aj07waJEu
        tODG5HTSLEAw0CcmnwIm77lr+gamnrChpI8ahC2VOohajcm4WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=j9aAg0jtDt6dJHYOEWW
        V9BBtODnp5Qj7k0Tm//pMT9B/AZpu/Sc79wZKX8m9iphrJNKb17ZajajsrDWn9wj
        u91FMZR0aznenO86Vlr8AvI+cf5sxRYkE7i2zMVvzRYocTN08X8oeiR53fmNCTmG
        oBh3T3DpjOE/NBe5th2hpHr0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3C75A31FD;
        Tue,  5 Sep 2017 06:02:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F3E2A31FA;
        Tue,  5 Sep 2017 06:02:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of string to list
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
        <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
        <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
        <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
Date:   Tue, 05 Sep 2017 19:02:55 +0900
Message-ID: <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6433777C-9221-11E7-B2E4-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 30 August 2017 at 04:52, Michael Haggerty <mhagger@alum.mit.edu> wro=
te:
>> v3 looks good to me. Thanks!
>>
>> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>
> Thank _you_ for very helpful feedback on the earlier versions.
>
> Martin

Yes, the earlier attempt was sort-of barking up a wrong tree. =20

Once we step back and observe other users of affected_refnames and
realize that the list is meant to to point at a refname field of an
existing instance of another structure by borrowing, the blame
shifts from files_transaction_prepare() to the real culprit.
Michael's review gave us a very good "let's step back a bit" that
made the huge improvement between v1 and v2/v3.

I wonder if we should be tightening the use of affected_refnames
even further, though. =20

It is may be sufficient to make sure that we do not throw anything
that we would need to free as part of destroying affected_refnames
into the string list, purely from the "leak prevention" perspective.

But stepping back a bit, the reason why the string list exists in
the first place is to make sure we do not touch the same ref twice
in a single transaction, the set of all possible updates in the
single transaction exists somewhere, and each of these updates know
what ref it wants to update. =20

And that is recorded in transaction->updates[]->refname no?

So it seems to me that logically any and all string that is
registered in affected_refnames list must be the refname field of
a ref_update structure in the transaction.

And from that point of view, doesn't split_head_update() wants a
similar fix?  It attempts to insert "HEAD", makes sure it hasn't
been inserted and then hangs a new update transaction as its util.
It is not wrong per-se from purely leak-prevention point of view,
as that "HEAD" is a literal string we woudn't even want to free,
but from logical/"what each data means" point of view, it still
feels wrong.


