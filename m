Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D4CC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A08160F4C
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhH1BYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:24:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhH1BYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:24:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C05ADFB96;
        Fri, 27 Aug 2021 21:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tQv4mKbd1Jr4
        kj1xp8jtdlhqhsl9wvtglpAGeYva9d4=; b=RlcbwgbvBJrSdtYwXSZXtcGqU3Jt
        DaIKj4WO5eVAFsIeC60W/8Qoaf3FWAvzlrUK5B39F54vn0b/ZaClivIgBBn5+X/t
        kimqJcURFAsYARjRGuRUoF26SLMP6u32OCDLfGLO6Lzo4mjYSQiPQd5W8KlLHiwr
        ZMC5PSxbgYcvyHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D55DFB95;
        Fri, 27 Aug 2021 21:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C31BDFB94;
        Fri, 27 Aug 2021 21:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
Date:   Fri, 27 Aug 2021 18:23:26 -0700
In-Reply-To: <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 Aug
 2021 16:05:48
        +0200")
Message-ID: <xmqq8s0m9xbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8BEA076C-079E-11EC-8CA6-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a strvec_pushvec() function to concatenate two "struct strvec *"
> together, and modify code added in 50d89ad6542 (submodule: use
> argv_array instead of hand-building arrays, 2012-09-01) to use it. In
> a subsequent commit we'll gain another API user.
>
> This could also have been named strvec_concat()[1], but I opted to
> make its name consistent with the strbuf_addbuf() function instead. We
> only name these sorts of functions *_concat() in one instance:
> parse_options_concat().

FWIW pushvec() is a much better name than concat() for this.

concat(A, B) could be an operation that is non-destructive for both
A and B that returns a new vector C.  I would imagine that it would
be how, if not majority of, but at least a nontrivial percentage of,
readers expect a function called concat() to behave.  A better name
for destructive version would probably be append(), if there is no
other constraints on naming.

The name pushvec(A, B) makes it clear, thanks to similarity with
other push*(A, ...) variants, that A is mutated using the other
arguments.  The name is much more clear with less chance of
misunderstanding.

> +void strvec_pushvec(struct strvec *array, const struct strvec *items)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < items->nr; i++)
> +		strvec_push(array, items->v[i]);
> +}

This implementation is not wrong per-se, but is somewhat
disappointing.  When items->nr is large, especially relative to the
original array->alloc, it would incur unnecessary reallocations that
we can easily avoid by pre-sizing the array before pushing the
elements of items from it.

In the original code that became the first user of this helper, it
may not have made much difference, but now it is becoming a more
generally reusable API function, we should care.

Other than that, looks quite straight-forward.

Thanks.
