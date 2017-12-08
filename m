Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD1E20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbdLHPE0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:04:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50768 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753542AbdLHPE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:04:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F284A39D2;
        Fri,  8 Dec 2017 10:04:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edCFG7Pjkgtk/5FqgyuSNemA/14=; b=mQjb2n
        5aam1vdEM4d3DucNynJ2HW6r4w5zVCa13GJSFktc1guXRq7NPqUCNP/cdPCY1AX3
        wV2Ln7dM69fTOVPmx+GGadeRoXmVL2Vg4FyuyYrrzfEQqEnAfld1GkWu6KD4/HF4
        Bnm/RC7UNB6MF1EOOE/Z2v1ZkuK5PkaqCQBfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mn8gTGh7P9lQpYOBxWSH2gznI3b6YuHL
        gtmqc+hxYjQ56z8nFlASAA56glPjAi5CepOmnaQr1C9hDp20up9kYGcdbQHtkatr
        f9Jnq8Oix5pAcGFp3KtEeIvvILWwKZD2nBbK2eazb5ins0l+zlJAfX85UzUx7wJ3
        i5LxKkrcU+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0744AA39D1;
        Fri,  8 Dec 2017 10:04:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72262A39CF;
        Fri,  8 Dec 2017 10:04:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171208002447.20261-1-sbeller@google.com>
        <20171208002447.20261-2-sbeller@google.com>
Date:   Fri, 08 Dec 2017 07:04:18 -0800
In-Reply-To: <20171208002447.20261-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 7 Dec 2017 16:24:47 -0800")
Message-ID: <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10FC9D98-DC29-11E7-8185-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/diffcore-blobfind.c b/diffcore-blobfind.c
> new file mode 100644
> index 0000000000..e65c7cad6e
> --- /dev/null
> +++ b/diffcore-blobfind.c
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (c) 2017 Google Inc.
> + */
> +#include "cache.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +
> +static void diffcore_filter_blobs(struct diff_queue_struct *q,
> +				  struct diff_options *options)
> +{
> +	int src, dst;
> +
> +	if (!options->blobfind)
> +		BUG("blobfind oidset not initialized???");
> +
> +	for (src = dst = 0; src < q->nr; src++) {
> +		struct diff_filepair *p = q->queue[src];
> +
> +		if ((DIFF_FILE_VALID(p->one) &&
> +		     oidset_contains(options->blobfind, &p->one->oid)) ||
> +		    (DIFF_FILE_VALID(p->two) &&
> +		     oidset_contains(options->blobfind, &p->two->oid))) {

Shouldn't this make sure that !DIFF_PAIR_UNMERGED(p) before looking
at the sides of the pair?  I think an unmerged pair is queued with
filespecs whose modes are cleared, but we should not be relying on
that---I think we even had bugs we fixed by introducing an explicit
is_unmerged field to the filepair struct.

> @@ -2883,6 +2884,8 @@ int prepare_revision_walk(struct rev_info *revs)
>  		simplify_merges(revs);
>  	if (revs->children.name)
>  		set_children(revs);
> +	if (revs->diffopt.blobfind)
> +		revs->simplify_history = 0;
>  	return 0;
>  }

It makes sense to clear this bit by default, but is this an
unconditonal clearing?  In other words, is there a way for the user
to countermand this default and ask for merge simplification from
the command line, e.g. "diff --simplify-history --blobfind=<blob>"?

> +test_description='test finding specific blobs in the revision walking'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	git commit --allow-empty -m "empty initial commit" &&
> +
> +	echo "Hello, world!" >greeting &&
> +	git add greeting &&
> +	git commit -m "add the greeting blob" && # borrowed from Git from the Bottom Up
> +	git tag -m "the blob" greeting $(git rev-parse HEAD:greeting) &&
> +
> +	echo asdf >unrelated &&
> +	git add unrelated &&
> +	git commit -m "unrelated history" &&
> +
> +	git revert HEAD^ &&
> +
> +	git commit --allow-empty -m "another unrelated commit"
> +'
> +
> +test_expect_success 'find the greeting blob' '
> +	cat >expect <<-EOF &&
> +	Revert "add the greeting blob"
> +	add the greeting blob
> +	EOF
> +
> +	git log --abbrev=12 --oneline --blobfind=greeting^{blob} >actual.raw &&
> +	cut -c 14- actual.raw >actual &&
> +	test_cmp expect actual

The hardcoded numbers look strange and smell like a workaround of
not asking for full object names.

Also, now it has the simplify-history bit in the change, don't we
want to check a mergy history, and also running "diff-files" while
the index has unmerged entries?

Other than that, the changes look quite sane and pleasnt read.

Thanks.


> +'
> +
> +test_done
