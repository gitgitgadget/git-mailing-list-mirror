Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C3A1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 02:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdJFCXR (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 22:23:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53358 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751485AbdJFCXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 22:23:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE274A79C0;
        Thu,  5 Oct 2017 22:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P72DTjAIuVee
        SuNhYHINoWG4tOc=; b=CRj5ZKwQBP3ZkuHSWlxH+lk2qxsIMXvvVFQ8es7K+w4b
        DOPHu4YMA80r6Sd0ZwOgFksja9/qg10T80EcdsalEKwDaJU8t8mxtWXFG2fMbkk7
        F8TvBv8qIff80a52ioSAI5J50GQ8Yig+4IIKS9gL5FdWxI2SpUgIrkH6KLqENa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YpsMO2
        IvJN5w31jYXD73A/dKIExCrtLlf/vUjVi9hNRqtu222uugR+0Mv8zZUBV/8CTwj1
        s+Jyf7z7Rt+bJQo2CJpZsCo2GqEhzHaTFa8G5icoeMR/JbJd5nXbzh1UVaG6maDS
        YPKQzt1DLYRynGuRxcVhci0dXSBTqIyEq8zFM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6573A79BF;
        Thu,  5 Oct 2017 22:23:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C8F6A79BE;
        Thu,  5 Oct 2017 22:23:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH v2] fsck: handle NULL return of lookup_blob() and lookup_tree()
References: <20171003102215.9952-1-szeder.dev@gmail.com>
        <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
        <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
        <6bbe21c0-024e-ceed-6076-25f2330e598d@web.de>
Date:   Fri, 06 Oct 2017 11:23:14 +0900
In-Reply-To: <6bbe21c0-024e-ceed-6076-25f2330e598d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 5 Oct 2017 21:41:26 +0200")
Message-ID: <xmqq8tgpypyl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F01413E-AA3D-11E7-A918-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> An error message is already shown by object_as_type(), which is called
> by the lookup functions.  The walk callback functions are expected to
> handle NULL object pointers passed to them, but put_object_name() needs
> a valid object, so avoid calling it without one.

Thanks for getting the details right ;-)

> +	blob_bin=3D$(echo $blob | hex2oct) &&
> +	tree=3D$(
> +		printf "40000 dir\0${blob_bin}100644 file\0${blob_bin}" |

Wow, that's ... cute.

> +		git hash-object -t tree --stdin -w --literally

Makes me curious why --literally is here.  Even if we let
check_tree() called from index_mem() by taking the normal path,
it wouldn't complain the type mismatch, I suspect.  I guess doing it
this way is a future-proof against check_tree() getting tightened in
the future, in which case I think it makes sense.

And for the same reason, hashing "--literally" like this patch does
is a better solution than using "git mktree", which would have
allowed us to avoid the hex2oct and instead feed the tree in a bit
more human-readable way.

Thanks, will queue.

> +	) &&
> +	commit=3D$(git commit-tree $tree) &&
> +	git update-ref refs/heads/type_mismatch $commit &&
> +	test_must_fail git fsck >out 2>&1 &&
> +	test_i18ngrep "is a blob, not a tree" out &&
> +	test_i18ngrep ! "dangling blob" out
> +'
> +
>  test_expect_success 'tag pointing to nonexistent' '
>  	cat >invalid-tag <<-\EOF &&
>  	object ffffffffffffffffffffffffffffffffffffffff
