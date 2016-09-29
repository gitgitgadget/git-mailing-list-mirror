Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE133207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 22:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934997AbcI2Wga (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 18:36:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64302 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934868AbcI2Wg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 18:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6854443638;
        Thu, 29 Sep 2016 18:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WbNt/pDHu8MN
        fASuqZubYgN4owo=; b=neihnCONopRW7sO/3wEYU5VTEoz4a1FFiJaJnIH8Ejeq
        jJl+eICEC7tdiuG4HTbPvkbqtzXB7/igPdg2+12xw0o3LP/dVmTY5pvnVYBdRPqu
        38KAl6lUk71nN2Fet+lO6MIDXZa4FaHm21pu2NgUP21tlq74ML7rthgWEkKiid8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PIukZT
        LZxSB7zk7TR5I/7ZFujxSJ9frvyEvT2fwZViL9OAuvxtTZiCvbNdrnvATJzJ3NQd
        Bhs0IJww1I1GcnYBs6L0UbLlAT4qfIGQUBLelStMH8OAD8XSzTHSDgAY0ouWertz
        WPU7doG4lL5PP1l/kSswWHbFcaJBSAcuy7pbY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FA6343636;
        Thu, 29 Sep 2016 18:36:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4E2543635;
        Thu, 29 Sep 2016 18:36:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] add QSORT
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
Date:   Thu, 29 Sep 2016 15:36:24 -0700
In-Reply-To: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 29 Sep 2016 17:23:43 +0200")
Message-ID: <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 287CD9AA-8695-11E6-BBB9-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Add the macro QSORT, a convenient wrapper for qsort(3) that infers the
> size of the array elements and supports the convention of initializing
> empty arrays with a NULL pointer, which we use in some places.
>
> Calling qsort(3) directly with a NULL pointer is undefined -- even with
> an element count of zero -- and allows the compiler to optimize away an=
y
> following NULL checks.  Using the macro avoids such surprises.
>
> Add a semantic patch as well to demonstrate the macro's usage and to
> automate the transformation of trivial cases.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  contrib/coccinelle/qsort.cocci | 19 +++++++++++++++++++
>  git-compat-util.h              |  8 ++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 contrib/coccinelle/qsort.cocci

The direct calls to qsort(3) that this series leaves behind are
interesting.

1. builtin/index-pack.c has this:

	if (1 < opts->anomaly_nr)
		qsort(opts->anomaly, opts->anomaly_nr, sizeof(uint32_t), cmp_uint32);

where opts->anomaly is coming from pack.h:

    struct pack_idx_option {
            unsigned flags;
            ...
            int anomaly_alloc, anomaly_nr;
            uint32_t *anomaly;
    };

I cannot quite see how the automated conversion misses it?  It's not
like base and nmemb are type-restricted in the rule (they are both
just "expression"s).

2. builtin/shortlog.c has this:

	qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
	      log->summary ? compare_by_counter : compare_by_list);

where log->list is coming from shortlog.h:

    struct shortlog {
            struct string_list list;
    };

and string-list.h says:

    struct string_list {
            struct string_list_item *items;
            unsigned int nr, alloc;
            ...
    };

which seems to be a good candidate for this rule:

    type T;
    T *base;
    expression nmemb, compar;
    @@
    - qsort(base, nmemb, sizeof(T), compar);
    + QSORT(base, nmemb, compar);

if we take "T =3D=3D struct string_list_item".

3. builtin/show-branch.c does this:

    qsort(ref_name + bottom, top - bottom, sizeof(ref_name[0]),
          compare_ref_name);

where ref_name[] is a file-scope global:

    static char *ref_name[MAX_REVS + 1];

and top and bottom are plain integers.  The sizeof() does not take
the size of *base, so it is understandable that this does not get
automatically converted.

It seems that some calls to this function _could_ send the same top
and bottom, asking for 0 element array to be sorted, by the way.

Thanks for an amusing read.

