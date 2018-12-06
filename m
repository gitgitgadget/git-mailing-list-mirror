Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6247F211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeLFBMt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 20:12:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62300 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 20:12:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC72B12121A;
        Wed,  5 Dec 2018 20:12:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UY7xIEeXtGj1+mGDmhV7SxDYE/0=; b=TFDkZv
        oR8N6G44orJ78RqYPrYx27aU7jq+Ny9zv7ZOAyzxFN0v8mnBHBgFw7eShmG8RMO6
        rSBapFdZlNBM4L3dml+A8f0LbCh/WSjculTjZA/LPamwF4ZaW8CIa/XazowgwKdx
        jd41/gjeAkZ5jI7DnOvT31k8kGu7Z0hs8zYMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OIr7tcZedkKMCnbWuuJb4anejcEaGDqG
        ocipUYcw+kIJr6rjeP5jHy+okI1W18g6xF9kcrIi5jIeMSsA7Q4HHCoR764twqvg
        SzXonwZDmpyS53J2p37kxIG5Lf7a8wVPKo81XuSyBwjfPxOKz6MtLRD2cuhWUEAd
        MwLQotWtwOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C424E121219;
        Wed,  5 Dec 2018 20:12:43 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A8D5121218;
        Wed,  5 Dec 2018 20:12:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com,
        matvore@comcast.net
Subject: Re: [PATCH v3] list-objects.c: don't segfault for missing cmdline objects
References: <20181023215745.245333-1-matvore@google.com>
        <20181205214346.106217-1-matvore@google.com>
Date:   Thu, 06 Dec 2018 10:12:42 +0900
In-Reply-To: <20181205214346.106217-1-matvore@google.com> (Matthew DeVore's
        message of "Wed, 5 Dec 2018 13:43:46 -0800")
Message-ID: <xmqqsgzba25x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0877077E-F8F4-11E8-A3F0-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> When a command is invoked with both --exclude-promisor-objects,
> --objects-edge-aggressive, and a missing object on the command line,
> the rev_info.cmdline array could get a NULL pointer for the value of
> an 'item' field. Prevent dereferencing of a NULL pointer in that
> situation.
>
> Properly handle --ignore-missing. If it is not passed, die when an
> object is missing. Otherwise, just silently ignore it.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>

Thanks for an update.  Will replace.

> ---
>  revision.c               |  2 ++
>  t/t0410-partial-clone.sh | 16 ++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 13e0519c02..293303b67d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1729,6 +1729,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  	if (!cant_be_filename)
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
> +	if (!object)
> +		return revs->ignore_missing ? 0 : -1;
>  	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
>  	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
>  	free(oc.path);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index ba3887f178..169f7f10a7 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -349,7 +349,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
>  	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
>  '
>  
> -test_expect_success 'rev-list accepts missing and promised objects on command line' '
> +test_expect_success 'rev-list dies for missing objects on cmd line' '
>  	rm -rf repo &&
>  	test_create_repo repo &&
>  	test_commit -C repo foo &&
> @@ -366,7 +366,19 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
>  
>  	git -C repo config core.repositoryformatversion 1 &&
>  	git -C repo config extensions.partialclone "arbitrary string" &&
> -	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
> +
> +	for OBJ in "$COMMIT" "$TREE" "$BLOB"; do
> +		test_must_fail git -C repo rev-list --objects \
> +			--exclude-promisor-objects "$OBJ" &&
> +		test_must_fail git -C repo rev-list --objects-edge-aggressive \
> +			--exclude-promisor-objects "$OBJ" &&
> +
> +		# Do not die or crash when --ignore-missing is passed.
> +		git -C repo rev-list --ignore-missing --objects \
> +			--exclude-promisor-objects "$OBJ" &&
> +		git -C repo rev-list --ignore-missing --objects-edge-aggressive \
> +			--exclude-promisor-objects "$OBJ"
> +	done
>  '
>  
>  test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
