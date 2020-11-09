Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0023C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932BE206D8
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CNlL0F+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgKITsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:48:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56039 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbgKITsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08EC610636F;
        Mon,  9 Nov 2020 14:48:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VYwSOhd9ehgVOy2k6VJKvJqtPN4=; b=CNlL0F
        +esVhyMgKrQs6dlkR4NMHeG4kyIu0pzOvk61Oz95HpP+QANvEFBCfqYYQXht9JTv
        P4t2EG0+62t3Rr7xX86Tm/l7jUa469cLh3RssJ6yYBJDso7Lh/6yXtf52NddisPm
        HoOGBSb/yS4ToQ1lGXha3i57bfnIXP8PkiBwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aN33P/1znxLcrbKL4VtAUHxTwhLNOLnD
        x+85oy9LZ4JYyyHrclNOfiL9n1CX/bq1ku0xL9rRs5lq3oWBDwhwb2Ark0EqXiRn
        pNc5PyHnYrSPA4am4wTOqegFlKnW6kVFlVJi8MgU3tsk1/cxYANbWpWIAPrtoOKO
        tyqlQ9hqbDo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0112610636E;
        Mon,  9 Nov 2020 14:48:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D04010636D;
        Mon,  9 Nov 2020 14:48:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/4] t1400: Avoid touching refs on filesystem
References: <cover.1604501265.git.ps@pks.im> <cover.1604908834.git.ps@pks.im>
        <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
Date:   Mon, 09 Nov 2020 11:48:20 -0800
In-Reply-To: <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 9 Nov 2020 11:06:47 +0100")
Message-ID: <xmqqpn4mb9bv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8613C19E-22C4-11EB-9E3E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> many tests directly read and write references via the filesystem,
> assuming that we always use loose and/or packed references. While this
> is true now, it'll change with the introduction of the reftable backend.
>
> Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> possible. As some tests exercise behaviour with broken references and
> neither of those tools actually allows writing or reading broken
> references, this commit doesn't adjust all tests.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1400-update-ref.sh | 63 ++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 4c01e08551..957bef272d 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -14,6 +14,12 @@ n=$n_dir/fixes
>  outside=refs/foo
>  bare=bare-repo
>  
> +# Some of the tests delete HEAD, which causes us to not treat the current
> +# working directory as a Git repository anymore. To avoid using any potential
> +# parent repository to be discovered, we need to set up the ceiling directories.
> +GIT_CEILING_DIRECTORIES="$PWD/.."
> +export GIT_CEILING_DIRECTORIES
> +

Interesting.  The current tests do not need to do this because the
HEAD-less broken state is transitory and is corrected without using
"git" at all (e.g. echoing a valid value into .git/HEAD), I presume?

>  create_test_commits ()
>  {
>  	prfx="$1"
> @@ -48,17 +54,17 @@ test_expect_success "fail to delete $m with stale ref" '
>  	test $B = "$(git show-ref -s --verify $m)"
>  '
>  test_expect_success "delete $m" '
> -	test_when_finished "rm -f .git/$m" &&
> +	test_when_finished "git update-ref -d $m" &&
>  	git update-ref -d $m $B &&
> -	test_path_is_missing .git/$m
> +	test_must_fail git show-ref --verify -q $m
>  '
>  
>  test_expect_success "delete $m without oldvalue verification" '
> -	test_when_finished "rm -f .git/$m" &&
> +	test_when_finished "git update-ref -d $m" &&
>  	git update-ref $m $A &&
>  	test $A = $(git show-ref -s --verify $m) &&
>  	git update-ref -d $m &&
> -	test_path_is_missing .git/$m
> +	test_must_fail git show-ref --verify -q $m
>  '
>  
>  test_expect_success "fail to create $n" '
> @@ -80,26 +86,26 @@ test_expect_success "fail to delete $m (by HEAD) with stale ref" '
>  	test $B = $(git show-ref -s --verify $m)
>  '
>  test_expect_success "delete $m (by HEAD)" '
> -	test_when_finished "rm -f .git/$m" &&
> +	test_when_finished "git update-ref -d $m" &&
>  	git update-ref -d HEAD $B &&
> -	test_path_is_missing .git/$m
> +	test_must_fail git show-ref --verify -q $m
>  '

During the above test, we are on the branch ${m#refs/heads/}, so
"update-ref -d HEAD" is removing the underlying branch ref, making
it an unborn branch, without destroying the repository, so this is
perfectly sensible.

This is a tangent, but what makes this test doubly interesting is
that "git update-ref -d HEAD" would have allowed us to make it a
non-repository if HEAD were detached, and it seems that we do not
require "--force" to do so.  We probably should forbid removing HEAD
that id detached without "--force", which is such a destructive
operation.

>  cp -f .git/HEAD .git/HEAD.orig
>  test_expect_success 'delete symref without dereference' '
>  	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
>  	git update-ref --no-deref -d HEAD &&
> -	test_path_is_missing .git/HEAD
> +	test_must_fail git show-ref --verify -q HEAD
>  '

This is an example of breaking the repository.  I am not sure if the
test_must_fail is a good replacement--it would fail even if you say
"git show-ref --verify -q refs/heads/$branch" where $branch is a
name of a branch that exists, no?

For now, I think this is fine, but we'd probably clean it up so that
without --force update-ref would not corrupt the repository like
this.  When used with --force, or before adding such a safety
measure, how we test if we successfully corrupted the repository is
an interesting matter.  I'd say

	git update-ref --force --no-deref -d HEAD &&
	test_must_fail git show-ref --verify -q HEAD &&
	cp -f .git/HEAD.orig .git/HEAD &&
	git show-ref --verify -q "$m"

to ensure that other than removing HEAD and corrupting the
repository, it did not cause permanent damage by removing the
underlying ref, perhaps.

We may want to add some NEEDSWORK comment around such tests.

>  test_expect_success 'delete symref without dereference when the referred ref is packed' '
> @@ -208,7 +214,7 @@ test_expect_success 'delete symref without dereference when the referred ref is
>  	git commit -m foo &&
>  	git pack-refs --all &&
>  	git update-ref --no-deref -d HEAD &&
> -	test_path_is_missing .git/HEAD
> +	test_must_fail git show-ref --verify -q HEAD
>  '

Does this share the same issue as the above?

Thanks.
