Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C05C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C73A207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TF/BTHOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBUHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:07:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55400 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBUHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:07:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FDFA7F53C;
        Wed,  2 Sep 2020 16:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=29gtlQIlhWI1EDLUorBOiBwnYUw=; b=TF/BTH
        Oh+C4Z/4os+5PAiUt69xEYeStE21gRYosBVy6quNPYLVJTxsfNFi4kTXhCDHOApH
        vKaN/NOqg89Xg1COJiKFPbUGBK3EE6ot8s4WZFw67z4XGlgvZwnz3oMIFotggcWe
        lv/Uvbjxg4/QMQU8V/OZkl8bHnLxC1W87a6xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bv0Jkx48ORbCx2gKfO6ZQsIOACQBjfNH
        r5MV6rOvVG8MX6gjMPNtpLLPlmv2QsW1JhjQU2VFeuPOEz1YkEJcAxPE8lz3pLp0
        l2HH6iSGV02g3C7lkcoOr23NKhzQjvtc8/JpPi8h+RZPcbJj7Ck1iPPAec9A83eb
        9WvxPtdyMnE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 380AB7F53B;
        Wed,  2 Sep 2020 16:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFB087F53A;
        Wed,  2 Sep 2020 16:07:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH] fetch: no FETCH_HEAD display if --no-write-fetch-head
References: <20200902190232.317477-1-jonathantanmy@google.com>
Date:   Wed, 02 Sep 2020 13:07:16 -0700
In-Reply-To: <20200902190232.317477-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 2 Sep 2020 12:02:32 -0700")
Message-ID: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6BDE1C0-ED57-11EA-9253-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> 887952b8c6 ("fetch: optionally allow disabling FETCH_HEAD update",
> 2020-08-18) introduced the ability to disable writing to FETCH_HEAD
> during fetch, but did not suppress the "<source> -> FETCH_HEAD" message
> when this ability is used. This message is misleading in this case,
> because FETCH_HEAD is not written.

Thanks for noticing, but I wonder if we should keep this for users
of dry-run, which tends to give more output to what _would_ have
been done if it were not dry-run?

> This might be important for Stolee's maintenance prefetch patch [1] too
> - presumably we don't want to show FETCH_HEAD there, as it would be
> misleading and would clutter in the same way (albeit to a lesser
> extent).

Yes, that makes sense.

> Also, because "fetch" is used to
> lazy-fetch missing objects in a partial clone, this significantly
> clutters up the output in that case since the objects to be fetched are
> potentially numerous. Therefore, suppress this message when
> --no-write-fetch-head is passed.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is on origin/jt/lazy-fetch.

I think this patch, with possible correction for "we are not writing
FETCH_HEAD but we do want to show what would have been done when the
user asked --dry-run", should be done as a brown-paper-bag bugfix
directly on jc/no-update-fetch-head topic and merged quicly down to
'master', instead of taken hostage of some other topic in flight,
but it would soon already be a week since jt/lazy-fetch was merged
to 'next', so it probably is OK to apply on jt/lazy-fetch, and it
indeed is easier to manage that way.

> [1] https://lore.kernel.org/git/da64c51a8182ec13aeed8f0157079fb29a09ee85.1598380599.git.gitgitgadget@gmail.com/
> ---
>  builtin/fetch.c          | 3 ++-
>  t/t0410-partial-clone.sh | 7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 320ba9471d..442df05f5a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1023,11 +1023,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				rc |= update_local_ref(ref, what, rm, &note,
>  						       summary_width);
>  				free(ref);
> -			} else
> +			} else if (write_fetch_head) {
>  				format_display(&note, '*',
>  					       *kind ? kind : "branch", NULL,
>  					       *what ? what : "HEAD",
>  					       "FETCH_HEAD", summary_width);
> +			}
>  			if (note.len) {
>  				if (verbosity >= 0 && !shown_url) {
>  					fprintf(stderr, _("From %.*s\n"),
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index d681e90640..584a039b85 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -183,7 +183,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
>  '
>  
>  test_expect_success 'fetching of missing objects' '
> -	rm -rf repo &&
> +	rm -rf repo err &&
>  	test_create_repo server &&
>  	test_commit -C server foo &&
>  	git -C server repack -a -d --write-bitmap-index &&
> @@ -194,7 +194,10 @@ test_expect_success 'fetching of missing objects' '
>  
>  	git -C repo config core.repositoryformatversion 1 &&
>  	git -C repo config extensions.partialclone "origin" &&
> -	git -C repo cat-file -p "$HASH" &&
> +	git -C repo cat-file -p "$HASH" 2>err &&
> +
> +	# Ensure that no spurious FETCH_HEAD messages are written
> +	! grep FETCH_HEAD err &&

Test also --dry-run, but that perhaps needs to be done outside the
context of partial-clone.  The above "lazy fetching should be silent
and should not bother users with mention of FETCH_HEAD" is good test
in the context of partial-clone, though.

jc/no-update-fetch-head added its own test to t/t5510, and both the
"output lacks FETCH_HEAD when --no-write-fetch-head is given" test
and the "output still mentions FETCH_HEAD with --dry-run" test
belong there.

Thanks.
