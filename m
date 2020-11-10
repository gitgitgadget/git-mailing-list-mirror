Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76FDC4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9CC206B2
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhjhOZib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgKJWXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:23:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJWXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:23:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21DA8107CA0;
        Tue, 10 Nov 2020 17:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=exZzrzm5YdAseEJ8kpSXC7l+dpA=; b=rhjhOZ
        ib/vXaeKcD8kRY5xla+ok7AFWB+1q2wQXj7Y13KXtXI3SEjSMIfTXxrv11jhkyt3
        xmNiEwE63Vt7SMaNEwzu6o3ScHbdpJgByQsXGDB9sGcMpwh9VTinDYTswAcvuAVO
        6XVDnu341ElnhA5eK7JKyS0vY8DV0qWPe7E14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+MxtXAaOheBEekMljcHIb5pbt13/jKO
        KlIoisU+jXNNky9f3CoO9RlVwC+Ey2xFRaY7c6WTfK3Z4gOO95+d/k16ng7Xyrtx
        HEc7btnuaAheEPtAymRXyUxMfUM1JKysEnGvRlPLVPEsWsHSLXZxI5XeZjqt9mXt
        9XBzYZsLgfk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A4E6107C9F;
        Tue, 10 Nov 2020 17:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 67242107C9E;
        Tue, 10 Nov 2020 17:23:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] rev-parse: handle --end-of-options
References: <20201110213544.GA3263091@coredump.intra.peff.net>
        <20201110214019.GC788740@coredump.intra.peff.net>
Date:   Tue, 10 Nov 2020 14:23:34 -0800
In-Reply-To: <20201110214019.GC788740@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 10 Nov 2020 16:40:19 -0500")
Message-ID: <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6021318A-23A3-11EB-AD25-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch lets callers write:
>
>   git rev-parse --end-of-options "$rev" -- "$path"
>
> and:
>
>   git rev-parse --verify --end-of-options "$rev"
>
> which will both treat "$rev" always as a revision parameter.

Nice.  The only iffy case I can think of is that we can never have
"--" to specify a rev, because with "git cmd -- -- path" we don't
know which double-dash among the two is the disambiguator that makes
the other double-dash to be either rev or path, but that is not a
new problem with this change.

> +test_expect_success 'verify respects --end-of-options' '
> +	git update-ref refs/heads/-tricky HEAD &&
> +	git rev-parse --verify HEAD >expect &&
> +	git rev-parse --verify --end-of-options -tricky >actual &&
> +	test_cmp expect actual
> +'

;-)  Or refs/heads/--tricky?

The whole thing looked good.  Thanks.
