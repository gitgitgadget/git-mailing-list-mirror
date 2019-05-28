Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 992E21F462
	for <e@80x24.org>; Tue, 28 May 2019 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1RBa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:01:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54161 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1RBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:01:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E338C143A3E;
        Tue, 28 May 2019 13:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5QmzH6BfOPlJL8XwoTTHGb5m7LY=; b=qlAA2r
        CKpwz/5MHyA++VjUXmMad8+5qejnleCooZJDHRpP8v88w4+sFdqfvJRFO/J2QkJk
        zipcUH7AoiWhBdp8vGSxMp+Mg2871dduJlIyDFM5qWJEDMoUd37gV22T8DEyj8LH
        aEQSH+GRvuMRrjoM7oj4KhLn9vaZalE2DRNOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSaO++0xtm5CwR2ItDIx6IqGwgxjSI7N
        PqgJmoBkqoVDaeAOneVL5/XtexN2A+0S0x4XdfCmqRwsG6hnHxJXSSMxlWhadOQ2
        ecsRS5C2n7QQCEYiCsMKJc8C90eaWBaq96ijI8SLQ3qK6/tVsHo/TCHWCY7wyBbJ
        8GDEC7rtmWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBAF8143A3D;
        Tue, 28 May 2019 13:01:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31A76143A3C;
        Tue, 28 May 2019 13:01:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v2] upload-pack: strip namespace from symref data
References: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com>
        <20190521214630.GD14807@sigill.intra.peff.net>
        <20190522043146.GA2563@sigill.intra.peff.net>
        <875zq2vkvf.fsf@evledraar.gmail.com>
        <20190523061121.GB20871@sigill.intra.peff.net>
Date:   Tue, 28 May 2019 10:01:21 -0700
In-Reply-To: <20190523061121.GB20871@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 23 May 2019 02:11:21 -0400")
Message-ID: <xmqq4l5e4iou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 384742EE-816A-11E9-AD93-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Revised patch below.

Thanks.  I never took the "separate namespaces" thing as a serious
feature, so it is understandable that I ignored it completely when I
did 7171d8c15f.

The explanation and the code both look good.  Thanks.


> -- >8 --
> Subject: [PATCH] upload-pack: strip namespace from symref data
>
> Since 7171d8c15f (upload-pack: send symbolic ref information as
> capability, 2013-09-17), we've sent cloning and fetching clients special
> information about which branch HEAD is pointing to, so that they don't
> have to guess based on matching up commit ids.
>
> However, this feature has never worked properly with the GIT_NAMESPACE
> feature.  Because upload-pack uses head_ref_namespaced(find_symref), we
> do find and report on refs/namespaces/foo/HEAD instead of the actual
> HEAD of the repo. This makes sense, since the branch pointed to by the
> top-level HEAD may not be advertised at all. But we do two things wrong:
>
>   1. We report the full name refs/namespaces/foo/HEAD, instead of just
>      HEAD. Meaning no client is going to bother doing anything with that
>      symref, since we're not otherwise advertising it.
>
>   2. We report the symref destination using its full name (e.g.,
>      refs/namespaces/foo/refs/heads/master). That's similarly useless to
>      the client, who only saw "refs/heads/master" in the advertisement.
>
> We should be stripping the namespace prefix off of both places (which
> this patch fixes).
>
> Likely nobody noticed because we tend to do the right thing anyway. Bug
> (1) means that we said nothing about HEAD (just refs/namespace/foo/HEAD).
> And so the client half of the code, from a45b5f0552 (connect: annotate
> refs with their symref information in get_remote_head(), 2013-09-17),
> does not annotate HEAD, and we use the fallback in guess_remote_head(),
> matching refs by object id. Which is usually right. It only falls down
> in ambiguous cases, like the one laid out in the included test.
>
> This also means that we don't have to worry about breaking anybody who
> was putting pre-stripped names into their namespace symrefs when we fix
> bug (2). Because of bug (1), nobody would have been using the symref we
> advertised in the first place (not to mention that those symrefs would
> have appeared broken for any non-namespaced access).
>
> Note that we have separate fixes here for the v0 and v2 protocols. The
> symref advertisement moved in v2 to be a part of the ls-refs command.
> This actually gets part (1) right, since the symref annotation
> piggy-backs on the existing ref advertisement, which is properly
> stripped. But it still needs a fix for part (2). The included tests
> cover both protocols.
>
> Reported-by: Bryan Turner <bturner@atlassian.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ls-refs.c                        |  3 ++-
>  t/t5509-fetch-push-namespaces.sh | 28 ++++++++++++++++++++++++++++
>  upload-pack.c                    |  4 ++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 0a7dbc6442..818aef70a0 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -57,7 +57,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  		if (!symref_target)
>  			die("'%s' is a symref but it is not?", refname);
>  
> -		strbuf_addf(&refline, " symref-target:%s", symref_target);
> +		strbuf_addf(&refline, " symref-target:%s",
> +			    strip_namespace(symref_target));
>  	}
>  
>  	if (data->peel) {
> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> index c88df78c0b..75cbfcc392 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -124,4 +124,32 @@ test_expect_success 'try to update a hidden full ref' '
>  	test_must_fail git -C original push pushee-namespaced master
>  '
>  
> +test_expect_success 'set up ambiguous HEAD' '
> +	git init ambiguous &&
> +	(
> +		cd ambiguous &&
> +		git commit --allow-empty -m foo &&
> +		git update-ref refs/namespaces/ns/refs/heads/one HEAD &&
> +		git update-ref refs/namespaces/ns/refs/heads/two HEAD &&
> +		git symbolic-ref refs/namespaces/ns/HEAD \
> +			refs/namespaces/ns/refs/heads/two
> +	)
> +'
> +
> +test_expect_success 'clone chooses correct HEAD (v0)' '
> +	GIT_NAMESPACE=ns git -c protocol.version=0 \
> +		clone ambiguous ambiguous-v0 &&
> +	echo refs/heads/two >expect &&
> +	git -C ambiguous-v0 symbolic-ref HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone chooses correct HEAD (v2)' '
> +	GIT_NAMESPACE=ns git -c protocol.version=2 \
> +		clone ambiguous ambiguous-v2 &&
> +	echo refs/heads/two >expect &&
> +	git -C ambiguous-v2 symbolic-ref HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 24298913c0..4d2129e7fc 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1037,8 +1037,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
>  	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
>  	if (!symref_target || (flag & REF_ISSYMREF) == 0)
>  		die("'%s' is a symref but it is not?", refname);
> -	item = string_list_append(cb_data, refname);
> -	item->util = xstrdup(symref_target);
> +	item = string_list_append(cb_data, strip_namespace(refname));
> +	item->util = xstrdup(strip_namespace(symref_target));
>  	return 0;
>  }
