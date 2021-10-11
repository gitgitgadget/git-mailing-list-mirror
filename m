Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A7C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B714160C4C
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhJKUw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:52:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhJKUw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:52:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EADE5163798;
        Mon, 11 Oct 2021 16:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WXTM/1ZLssGF
        qGteBLWPx+X2NmtQHggwYZkP5CNjOOY=; b=czUK3qoIg84mXmJOXHpGq3ehR4FH
        OtPblmeNo7rsPQU6lyM2lArfkePEUYd2+2UDuZnBA94g78VvctW3TK6TA2NPv6xM
        5VLz+TGkfLNyt8Eeo7rA6fx3SnyZ5bJmiW20VGB9Gk4wITGYAUajakK+2bGbRNu3
        EwAGJ5o5yPt24Ps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E34BA163796;
        Mon, 11 Oct 2021 16:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76361163795;
        Mon, 11 Oct 2021 16:50:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH 1/2] unwritable tests: assert exact error output
References: <patch-1.2-a5ef8ea47f4-20211009T133354Z-avarab@gmail.com>
Date:   Mon, 11 Oct 2021 13:50:52 -0700
In-Reply-To: <patch-1.2-a5ef8ea47f4-20211009T133354Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 9 Oct
 2021 15:34:02 +0200")
Message-ID: <xmqq5yu3b80j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ECBEDD52-2AD4-11EC-8542-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In preparation for fixing a regression where we started emitting some
> of these error messages twice, let's assert what the output from "git
> commit" and friends is now in the case of permission errors.

Usually we frown upon expecting an exact error message, but I guess
that the nature of the bug this series tries to address justifies
it.

> -	test_must_fail git write-tree
> +
> +	cat >expect <<-\EOF &&
> +	error: insufficient permission for adding an object to repository dat=
abase .git/objects
> +	fatal: git-write-tree: error building trees
> +	EOF
> +	test_must_fail git write-tree 2>actual &&
> +	test_cmp expect actual
>  '

OK.

>  test_expect_success POSIXPERM,SANITY 'commit should notice unwritable =
repository' '
>  	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
>  	chmod a-w .git/objects .git/objects/?? &&
> -	test_must_fail git commit -m second
> +
> +	cat >expect <<-\EOF &&
> +	error: insufficient permission for adding an object to repository dat=
abase .git/objects
> +	error: insufficient permission for adding an object to repository dat=
abase .git/objects
> +	error: Error building trees
> +	EOF

This is odd.  Shouldn't the test expect one message from write-tree
and be marked as expecting a failure until the bug gets fixed?

> +	test_must_fail git commit -m second 2>actual &&
> +	test_cmp expect actual
>  '
