Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57082C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAA120719
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AOT9e5Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWQeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:34:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50698 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWQeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 12:34:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB717DDA9D;
        Wed, 23 Sep 2020 12:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rMTvBVv7UzL+RoO1os53zd4gnzg=; b=AOT9e5
        Zh3lnWJ6jQgcQjNvrMFZrcJhpoKt+s7Q6b8UaoeSOQVAgJA9QWQhnVLsCJTx5nuu
        Lke74ELtQLtqn6+M9VwCPVfNCj5l5I1nO/EzIRL+Tt6LnIazN+aED+sWYvffCkJF
        dqCbA06jkFxjb1MQfY5GQUgMZL45h6rtDoBJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XukhrfE4T9ry04uf+bMaPe2lPRN756s3
        CthrN8EwLvmqEXcsnKfp1GSN2kNGQgX4jFfkoWSSJmiP3ZTfcTXvZh9zUCdqCffE
        OSNYVFffUK/863I6+qm6dad5MkH42wTdU3s98HSTcbUPvXojlamq4iPhpVxANXnI
        lYhhP7X8lEg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3F09DDA9C;
        Wed, 23 Sep 2020 12:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A455DDA9A;
        Wed, 23 Sep 2020 12:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Chris Torek <chris.torek@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] sample hooks: become hash agnostic
References: <cover.1600427894.git.liu.denton@gmail.com>
        <cover.1600853895.git.liu.denton@gmail.com>
Date:   Wed, 23 Sep 2020 09:34:18 -0700
In-Reply-To: <cover.1600853895.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 23 Sep 2020 02:38:42 -0700")
Message-ID: <xmqqa6xgjvud.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A153AF2A-FDBA-11EA-84B1-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> There are currently two hooks that have hardcoded 40 zeros as the null
> OID and, thus, are not hash-agnostic. Rewrite these to get the zero OID using
>
> 	git hash-object --stdin </dev/null | tr '[0-9a-f]' '0'
>
> so that the zero OID is hash-agnostic.
>
> This was initially done by introducing `git rev-parse --null-oid` to get the
> zero OID but that seems like overkill. From a cursory search of Github, the
> only instances of the zero OID being used come from clones of the git.git
> repository (tests and sample hooks). Since we don't want to introduce an option
> that no one will use, don't go this route and just do the easiest thing.

Patches 2&3/3 look quite sensible.

Patch 1/3 is a borderline Meh, as we do not need to force _our_
coding convention to the end-users, even though we do do so on
ourselves.  But let's take it to make things more consistent.

Thanks.
