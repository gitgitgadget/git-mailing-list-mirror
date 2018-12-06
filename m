Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9E1211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 04:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeLFErT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 23:47:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62318 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFErT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 23:47:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9A3E122867;
        Wed,  5 Dec 2018 23:47:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A2SCHMY7RC2YlqaucQoMrIBZ5bk=; b=tO3w50
        Ku/f9cTq/CVoIX9sHF2DCH8SpcTzve220eZZNQJr/b5d6GrdnV1Mw+PvQQwgxtDr
        IN6Ltp39kwF0u/ko4i1Erd/ZpWkv0VcTYMVhBKD4Fhh8gQyZo3RZlELxOVqQ+nro
        9LyTbQkNIRrllc4Lazkg0pg9UOtFGL2OwglX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t/p0xlDOKEcRFeIhHcHrL9N8uP1Qlx8C
        bYaDbjCuLMQ7NkytV/h0L60KiUoE170pV9aRLRZCXkpCWmEuGVvFob24u/49mFEq
        HFzyR7YxMgFSO70ZZCxGWb2QAk5W8xvFkA9XYTr/DgWz14A4lshluPzrCQrjgV8g
        c+F9vD5W0a4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1710122866;
        Wed,  5 Dec 2018 23:47:14 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D89D122865;
        Wed,  5 Dec 2018 23:47:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
References: <cover.1544048946.git.steadmon@google.com>
        <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
Date:   Thu, 06 Dec 2018 13:47:13 +0900
In-Reply-To: <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 5 Dec 2018 14:32:50 -0800")
Message-ID: <xmqqa7lj9s8e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00256552-F912-11E8-B684-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> new file mode 100644
> index 0000000000..420851d0d2
> --- /dev/null
> +++ b/fuzz-commit-graph.c
> @@ -0,0 +1,18 @@
> +#include "object-store.h"
> +#include "commit-graph.h"
> +
> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +	struct commit_graph *g;
> +
> +	g = parse_commit_graph((void *) data, -1, size);
> +	if (g)
> +		free(g);

As it is perfectly OK to free(NULL), please lose "if (g)" and a
level of indentation; otherwise, "make coccicheck" would complain.

Thanks.

> +	return 0;
> +}
