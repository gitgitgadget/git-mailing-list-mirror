Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588C9C00523
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjITPcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjITPcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:32:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AD499
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:32:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 530F61AA269;
        Wed, 20 Sep 2023 11:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=shud45vWD5/1a4UEKCPbd2ZuK1cvzSeyxmLGMx
        0UUiM=; b=rQcqVoNx7Pr5QZKcLzSR7Dgn/4kIvREjJFTn+WJkE6ieWUZwwEjjBr
        jX4SfomVP4chR2IG5izK/mC3Z2r8Pgwp8LEoaq2aJwXdan/GBVZdnqYB3H51XsZ1
        Mlv41F0ckeUW1cWlLTC72ur4SqbVbsS1uL7sHeuE3GC3yBa8l0t+M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B3051AA268;
        Wed, 20 Sep 2023 11:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2CDA1AA267;
        Wed, 20 Sep 2023 11:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
In-Reply-To: <20230920104507.21664-1-karthik.188@gmail.com> (Karthik Nayak's
        message of "Wed, 20 Sep 2023 12:45:07 +0200")
References: <20230915083415.263187-1-knayak@gitlab.com>
        <20230920104507.21664-1-karthik.188@gmail.com>
Date:   Wed, 20 Sep 2023 08:32:07 -0700
Message-ID: <xmqqh6noc13c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC57F8FC-57CA-11EE-8D80-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a4a0cb93b2..8ee713db3d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -227,6 +227,15 @@ explicitly.
>  	Upon seeing an invalid object name in the input, pretend as if
>  	the bad input was not given.
>  
> +--ignore-missing-links::
> +	During traversal, if an object that is referenced does not
> +	exist, instead of dying of a repository corruption, pretend as
> +	if the reference itself does not exist. Running the command
> +	with the `--boundary` option makes these missing commits,
> +	together with the commits on the edge of revision ranges
> +	(i.e. true boundary objects), appear on the output, prefixed
> +	with '-'.

There needs an explanation of interaction with --missing=<action>
option here, no?  "--missing=allow-any" and "--missing=print" are
sensible choices, I presume.  The former allows the traversal to
proceed, as you described in one of your responses.  Also with
"--missing=print", the user can more directly find out which are the
missing objects, even without using the "--boundary" that requires
them to sift between missing objects and the objects that are truly
on boundary.

Here is my attempt:

        --ignore-missing-links::
                During traversal, if an object that is referenced does not
                exist, instead of dying of a repository corruption, allow
                `--missing=<missing-action>` to decide what to do.
        +
        `--missing=print` will make the command print a list of missing
        objects, prefixed with a "?" character.
        +
        `--missing=allow-any` will make the command proceed without doing
        anything special.  Used with `--boundary`, output these missing
        objects mixed with the commits on the edge of revision ranges,
        prefixed with a "-" character.

It might make sense to add

        +
        Use of this option with other 'missing-action' may probably not
        give useful behaviour.

at the end, but it may not be useful to the readers to say "we allow
even more extra flexibility but haven't thought through what good
they would do".

> +# With `--ignore-missing-links`, we stop the traversal when we encounter a
> +# missing link. The boundary commit is not listed as we haven't used the
> +# `--boundary` options.
> +test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
> +	hide_alternates &&
> +
> +	git -C alt rev-list --objects --no-object-names \
> +		--ignore-missing-links --missing=allow-any HEAD >actual.raw &&
> +	git -C alt cat-file  --batch-check="%(objectname)" \
> +		--batch-all-objects >expect.raw &&
> +
> +	sort actual.raw >actual &&
> +	sort expect.raw >expect &&
> +	test_cmp expect actual
> +'

This gives a good baseline.  "--missing=print" without "--boundary"
may have more obvious use cases, but is there a practical use case
for the output from an invocation with "--missing=allow-any" without
"--boundary"?  Just being curious if I am missing something obvious.

Perhaps add another test that uses "--missing=print" instead, and
check that the "? missing" output matches what we expect to be
missing?  The same comment applies to the other test that uses
"--missing=allow-any" without "--boundary" we see later.

> +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
> +# commits.
> +test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
> +	git -C alt rev-list --ignore-missing-links --boundary HEAD >got &&
> +	grep "^-$(git rev-parse HEAD)" got
> +'

This makes sure what we expect to appear in 'got' actually is in
'got', but we should also make sure 'got' does not have anything
unexpected.  

> +test_expect_success "setup for rev-list --ignore-missing-links with missing objects" '
> +	show_alternates &&
> +	test_commit -C alt 11
> +'
> +
> +for obj in "HEAD^{tree}" "HEAD:11.t"
> +do
> +	# The `--ignore-missing-links` option should ensure that git-rev-list(1)
> +	# doesn't fail when used alongside `--objects` when a tree/blob is
> +	# missing.
> +	test_expect_success "rev-list --ignore-missing-links with missing $type" '
> +		oid="$(git -C alt rev-parse $obj)" &&
> +		path="alt/.git/objects/$(test_oid_to_path $oid)" &&
> +
> +		mv "$path" "$path.hidden" &&
> +		test_when_finished "mv $path.hidden $path" &&

In the first iteration, we check without the tree object and we only
ensure that removed tree does not appear in the output---but we know
the blob that is referenced by that removed tree will not appear in
the output, either, don't we?  Don't we want to check that, too?

In the second iteration, we have resurrected the tree but removed
the blob that is referenced by the tree, so we would not see that
blob in the output, which makes sense.

> +		git -C alt rev-list --ignore-missing-links --missing=allow-any --objects HEAD \
> +			>actual &&
> +		! grep $oid actual
> +       '
> +done
> +
> +test_done

Thanks.
