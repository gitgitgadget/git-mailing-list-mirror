Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C08201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 02:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbdKMClo (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 21:41:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751204AbdKMCln (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 21:41:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 848D19612B;
        Sun, 12 Nov 2017 21:41:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5rTlHDyinFgKC3G5v9woba8246o=; b=kog1rv
        zrYv4ql0tdjdAVX5DGO2RpRP9d9lLjJ9dq+CCEJ76523RbYNGqPyXNYS5f4eCEzd
        uXllsnPrpBquxw1nn51ULZ3CbWqLvKhYEsUNeSJrdFAA94z7YX+uDMd6wr1sPrN3
        vvY/5DUFlzSxCJmcxECUIAimxTbF0njmzdtcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i1ZwUEJXexmGZUZDLdh9sA7d8XqbvKmS
        UucaoLy2BfvI2QlLYiDbF9ZikzU4jcPM1EhgF4uc032xCIPiw3SptAKoQ0eQyD0C
        Ga/UzUMiY7poS3nakxAgQNcDFhS/1YvExAjwDfAoSTrbCp1m37snY/ddSbGFOMOo
        xwk3ZRYLLEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D80D9612A;
        Sun, 12 Nov 2017 21:41:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0010696129;
        Sun, 12 Nov 2017 21:41:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 1/2] checkout: factor out functions to new lib file
References: <20171112134305.3949-1-t.gummerer@gmail.com>
Date:   Mon, 13 Nov 2017 11:41:40 +0900
In-Reply-To: <20171112134305.3949-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 12 Nov 2017 13:43:04 +0000")
Message-ID: <xmqq7euuc32z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E5671A0-C81C-11E7-AD31-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Factor the functions out, so they can be re-used from other places.  In
> particular these functions will be re-used in builtin/worktree.c to make
> git worktree add dwim more.
>
> While there add a description to the function.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> I'm not sure where these functions should go ideally, they don't seem
> to fit in any existing library file, so I created a new one for now.
> Any suggestions for a better home are welcome!
>
>  Makefile           |  1 +
>  builtin/checkout.c | 41 +----------------------------------------
>  checkout.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
>  checkout.h         | 14 ++++++++++++++
>  4 files changed, 59 insertions(+), 40 deletions(-)
>  create mode 100644 checkout.c
>  create mode 100644 checkout.h

I am not sure either.  I've always considered that entry.c is the
libified thing codepath that want to do a "checkout" should call,
but the functions that you are moving is at a "higher layer" that
does not concern the core-git data structures (i.e. the 'tracking'
is a mere "user" of the ref API, unlike things in entry.c such as
checkout_entry() that is a more "maintainer" of the index integrity),
so perhaps it makes sense to have new file for it.

> diff --git a/checkout.c b/checkout.c
> new file mode 100644
> index 0000000000..a9cf378453
> --- /dev/null
> +++ b/checkout.c
> @@ -0,0 +1,43 @@
> +#include "cache.h"
> +

A useless blank line.

> +#include "remote.h"
> +

This one is useful ;-)

> +struct tracking_name_data {
> ...
> diff --git a/checkout.h b/checkout.h
> new file mode 100644
> index 0000000000..9272fe1449
> --- /dev/null
> +++ b/checkout.h
> @@ -0,0 +1,14 @@
> +#ifndef CHECKOUT_H
> +#define CHECKOUT_H
> +
> +#include "git-compat-util.h"
> +#include "cache.h"

Try "git grep -e git-compat-util Documentation/CodingGuidelines" and
just keep inclusion of "cache.h".
