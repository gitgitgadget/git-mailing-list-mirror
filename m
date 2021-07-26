Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EFC432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220CA60F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhGZVjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:39:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64482 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhGZVjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 17:39:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67F3DDE886;
        Mon, 26 Jul 2021 18:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F5pndBhJru5lqvqwBMEgNHliLmveDJlKZIwJQb
        6c0Xk=; b=hJukP1SZ//AB2ZHEXZiw5Sm6rwmYBqBdn9ttObzI4xlTPjuyKrINVT
        Hzea50Q4fK+NRrq2rAjIjWDKTNXPwYkEvS/lx7W6JLS4BEqzZZ+mboEzyp/Km7F/
        fzFTjnNsWIgS5+Qc4rzw1nN+HSeJ8BCl7mjQBahq7KDIm5/KcwVYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 414FFDE885;
        Mon, 26 Jul 2021 18:20:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B561DE884;
        Mon, 26 Jul 2021 18:20:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: run `make sparse` as part of the GitHub workflow
References: <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
        <pull.994.v3.git.1627331236817.gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:20:17 -0700
In-Reply-To: <pull.994.v3.git.1627331236817.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 26 Jul 2021 20:27:16
        +0000")
Message-ID: <xmqq8s1shg4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8C97988-EE5F-11EB-A581-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Occasionally we receive reviews after patches were integrated, where
> `sparse` (https://sparse.docs.kernel.org/en/latest/ has more information
> on that project) identified problems such as file-local variables or
> functions being declared as global.
>
> By running `sparse` as part of our Continuous Integration, we can catch
> such things much earlier. Even better: developers who activated GitHub
> Actions on their forks can catch such issues before even sending their
> patches to the Git mailing list.
>
> This addresses https://github.com/gitgitgadget/git/issues/345
>
> Note: Not even Ubuntu 20.04 ships with a new enough version of `sparse`
> to accommodate Git's needs. The symptom looks like this:
>
>     add-interactive.c:537:51: error: Using plain integer as NULL pointer
>
> To counter that, we download and install the custom-built `sparse`
> package from the Azure Pipeline that we specifically created to address
> this issue.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

OK, this is with Peff's "oh, we need 'apt-get update' to avoid stale
package list" fix already rolled in?  It seems you took both of them,
and they look good to me, too.

Unfortunately, ci-make-sparse has already been in 'next' for the
past week or so, so incrementals are vastly preferred.

Let me squish in your "Acked-by" to both of Peff's patches and queue
them on top of js/ci-make-sparse topic.

Thanks.

