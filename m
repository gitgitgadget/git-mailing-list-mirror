Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F5C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C149564E22
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBRTcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56539 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhBRTG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 14:06:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BD0712ACF4;
        Thu, 18 Feb 2021 14:05:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zQDooGK3EV9SzuAbjXCA8IIJ8pI=; b=KGJVBD
        xpLQdU/DsuX9NDiPrqslMQfn6SO82nzfSbBPAX+LzjuRI4Ef0vHOZVN8sqQcsmW2
        q+KuW4tfbipKR+w6QVDM+AAk1FKxHIDWKKTKy1MxDGAVNWYy+FWoqFd2sjZWwBQx
        G3nh3Zu2FP5vghP9r23Gr5sRwkRXUlXnK7xvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ezT1UXVXJbo1zKe+IHM3rRFK9NrjIVn9
        roDG9SHJ8liawWW/2Co2x5An9rcyIGuaUJ2TGAlgP4JQ0RGKF6ORvsFA0wCkL6OD
        f+UT8Ky7kTMc9K0tA8lxlUR6HsOi2nN0z4sVwtuR9LjdtLi+BmR+Qn4I4nc8IBlu
        CnYpZUUfhI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74C2612ACF3;
        Thu, 18 Feb 2021 14:05:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C45B12ACF0;
        Thu, 18 Feb 2021 14:05:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
References: <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
        <20210218143837.16527-1-matheus.bernardino@usp.br>
Date:   Thu, 18 Feb 2021 11:05:42 -0800
In-Reply-To: <20210218143837.16527-1-matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 18 Feb 2021 11:38:37 -0300")
Message-ID: <xmqq5z2pgprt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CB58930-721C-11EB-82EC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Then, the test would become:
>
> 	setup_sparse_entry &&
> 	test-tool cached_mtime sparse_entry >before &&
> 	test-tool chmtime -60 sparse_entry &&
> 	git add --refresh sparse_entry &&
> 	test-tool cached_mtime sparse_entry >after &&
> 	test_cmp before after
>
> What do you think?

I do not see much point in introducing a duplicated "ls-files --debug"
that gives only a subset of its output.  Even if we add test-tool,
we would need to reserve the right to change its output format any time,
so I am not sure what we'd be gaining by avoiding the use of
existing one.

Thanks.
