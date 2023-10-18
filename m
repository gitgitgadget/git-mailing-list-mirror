Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336742907
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pJia8LIs"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A1FA
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 14:18:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2309C1B1F6F;
	Wed, 18 Oct 2023 17:18:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DoEA27u5RYYRwmyXvGVvQm7WFKuEQtScvZubsm
	7qNc8=; b=pJia8LIsfhe2vP3W+wvbYSdoLA2Z4zEuwQSRk3bFvcFWDkdxiXJ4xN
	AJuT8jsLSb6J5vkEPznyfDGn/foGJTK7QpF1k+dwcgDD6vCD6zvowqanyscJZHRv
	zBTlfcbFp5X7qGA7DCjm4/cGmgFXkwkOU8zQhMQ3IKWajulReVQvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19A0B1B1F6E;
	Wed, 18 Oct 2023 17:18:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7452A1B1F6D;
	Wed, 18 Oct 2023 17:18:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
In-Reply-To: <c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:20 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 14:18:27 -0700
Message-ID: <xmqqfs27r5ng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E1A4562E-6DFB-11EE-8D1B-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> @@ -434,7 +432,7 @@ test_expect_success 'Query "main@{2005-05-28}" (past end of history)' '
>  	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
>  '
>  
> -rm -f .git/$m .git/logs/$m expect
> +git update-ref -d $m

We are not clearing "expect" file.  I do not know if it matters
here, but I am only recording what I noticed.

> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 10a539158c4..5cce24f1006 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -115,15 +115,16 @@ test_expect_success 'zlib corrupt loose object output ' '
>  '
>  
>  test_expect_success 'branch pointing to non-commit' '
> -	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
> +	tree_oid=$(git rev-parse --verify HEAD^{tree}) &&
> +	test-tool ref-store main update-ref msg refs/heads/invalid $tree_oid $ZERO_OID REF_SKIP_OID_VERIFICATION &&

I have mixed feelings on this.

In olden days, plumbing commands tended to allow to pass anything
the user told them to use, but in more recent versions of Git, we,
probably by mistake, managed to butcher some of the plumbing
commands to make them unable to deliberately "break" repositories,
one victim being "update-ref", i.e.

    $ git update-ref refs/heads/invalid HEAD^{tree}

is rejected these days (I just checked with v1.3.0 and it allows me
to do this), and that is one of the reasons why we manually broke
the repository in these tests.  We need to have a warning message in
comments near the implementation of "ref-store update-ref" that says
never ever attempt to share code with the production version of
update-ref---otherwise this (or the "safety" given to the plumbing
command, possibly by mistake) will be broken, depending on which
direction such a sharing goes.  On the other hand, forcing us to
keep two separate implementations, one deliberately loose to allow
us corrupt repositories, the other for production and actively used,
would mean the former one that is only used for validation would risk
bitrotting.

>  	test_when_finished "git update-ref -d refs/heads/invalid" &&

Not a problem this patch introduces, but I think it is a better
discipline to have when_finished clean-up routine prepared before we
do actual damage, i.e. if I were writing this test today from scratch,
I would expect it to be before "git rev-parse >.git/refs/heads/invalid"
is done.

>  	test_must_fail git fsck 2>out &&
>  	test_i18ngrep "not a commit" out
>  '

A #leftoverbit that is not relevant to the topic; we should clean
these test_i18ngrep and replace them with a plain "grep".

>  test_expect_success 'HEAD link pointing at a funny object' '
> -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> -	mv .git/HEAD .git/SAVED_HEAD &&
> +	saved_head=$(git rev-parse --verify HEAD) &&
> +	test_when_finished "git update-ref HEAD ${saved_head}" &&
>  	echo $ZERO_OID >.git/HEAD &&

Are you sure .git/HEAD when this test is entered is a detached HEAD?
The title of the test says "HEAD link", and I take it to mean HEAD
is a symlink, and we save it away, while we create a loose ref that
points at 0{40} in a detached HEAD state.  Actually, the original
would also work if HEAD is detached on entry.  In either case,
moving SAVED_HEAD back to HEAD would restore the original state.

But the updated one only works if HEAD upon entry is already
detached.  Is this intended?

> @@ -131,8 +132,8 @@ test_expect_success 'HEAD link pointing at a funny object' '
>  '
>  
>  test_expect_success 'HEAD link pointing at a funny place' '
> -	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
> -	mv .git/HEAD .git/SAVED_HEAD &&
> +	saved_head=$(git rev-parse --verify HEAD) &&
> +	test_when_finished "git update-ref --no-deref HEAD ${saved_head}" &&

Likewise.  Use of "update-ref" in the previous one vs "update-ref
--no-deref" in this one to recover from the damage the tests make
makes me feel that we may be assuming too much.

>  	echo "ref: refs/funny/place" >.git/HEAD &&

Even though "git symbolic-ref" refuses to point HEAD outside refs/,
as plumbing command should, it allows it to point it outside refs/heads/.
so this line should probably become

	git symbolic-ref HEAD refs/funny/place

in the same spirit as the rest of the series.

> @@ -391,7 +393,7 @@ test_expect_success 'tag pointing to nonexistent' '
>  
>  	tag=$(git hash-object -t tag -w --stdin <invalid-tag) &&
>  	test_when_finished "remove_object $tag" &&
> -	echo $tag >.git/refs/tags/invalid &&
> +	git update-ref refs/tags/invalid $tag &&

Good (not just this one, but similar ones throughout this patch).


