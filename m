Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA537151
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AvPWx+3h"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B412C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 09:06:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 885FA1AF84B;
	Wed, 18 Oct 2023 12:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zAqkaGoY4QlYIfK/lz65tCdfVhJzSwLIQ8LVmj
	cFvO8=; b=AvPWx+3hQIpmOEj8Py4/AEEGcdNyIBr49rxSxn/0l8ivDneO0cJXCA
	aYrT0/k+J3r4ra3gSKoeWqYPUgDyNBR//tdiBvyBB7fGuf64ZPHJtO7S/vy23U4x
	xOx7OnSjYuldwnBODMS9bsRGoyj7iwT1VPyZSLSPAldN5Wd+ja64g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F02C1AF84A;
	Wed, 18 Oct 2023 12:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAE571AF848;
	Wed, 18 Oct 2023 12:06:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 01/11] t: add helpers to test for reference existence
In-Reply-To: <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:07 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 09:06:50 -0700
Message-ID: <xmqqmswfud7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5993231C-6DD0-11EE-B828-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> There are two major ways to check for the existence of a reference in
> our tests:
>
>     - `git rev-parse --verify` can be used to check for existence of a
>       reference. This only works in the case where the reference is well
>       formed though and resolves to an actual object ID. This does not
>       work with malformed reference names or invalid contents.
>
>     - `test_path_is_file` can be used to check for existence of a loose
>       reference if it is known to not resolve to an actual object ID. It
>       by necessity reaches into implementation details of the reference
>       backend though.

True.  It would be ideal if we can limit the use of latter when we
_care_ how the ref is stored (e.g., "we expect it to be stored as a
loose ref, not packed").  "The ref R at must be pointing at the
commit X" is better asserted by using the former (or "git show-ref")
as we not just only want to see the .git/refs/R file holding the
object name X, but also want to see the production git tools observe
the same---if what rev-parse or show-ref observes is different from
the expected state and they say ref R does not point at commit X, we
should complain (rev-parse or show-ref may be broken in the version
of Git being tested, but we can assume that their breakage will be
caught elsewhere in the test suite as well, so as long as we trust
them, using them as the validator is better than going into the
implementation detail and assuming things like "new refs always
appear as a loose ref" that we might want to change in the future).

> Similarly, there are two equivalent ways to check for the absence of a
> reference:
>
>     - `test_must_fail git rev-parse` can be used to check for the
>       absence of a reference. It could fail due to a number of reasons
>       though, and all of these reasons will be thrown into the same bag
>       as an absent reference.
>
>     - `test_path_is_missing` can be used to check explicitly for the
>       absence of a loose reference, but again reaches into internal
>       implementation details of the reference backend.
>
> So both our tooling to check for the presence and for the absence of
> references in tests is lacking as either failure cases are thrown into
> the same bag or we need to reach into internal implementation details of
> the respective reference backend.

> Introduce a new subcommand for our ref-store test helper that explicitly
> checks only for the presence or absence of a reference. This addresses
> these limitations:
>
>     - We can check for the presence of references with malformed names.

But for the purpose of tests, we can control the input.  When we
perform an operation that we expect a ref R to be created, we would
know R is well formed and we can validate using a tool that we know
would be broken when fed a malformed name.  So I do not see this as
a huge "limitation".

>     - We can check for the presence of references that don't resolve.

Do you mean a dangling symbolic ref?  We are using a wrong tool if
you are using rev-parse for that, aren't we?  Isn't symbolic-ref
there for us for this exact use case?  That is

>     - We can explicitly handle the case where a reference is missing by
>       special-casing ENOENT errors.

You probably know the error conditions refs_read_raw_ref() can be
broken better than I do, but this feels a bit too intimate with how
the method for the files backend happens to be implemented, which at
the same time, can risk that [a] other backends can implement their
"ref does not resolve to an object name---is it because it is
missing?" report incorrectly and [b] we would eventually want to
know error conditions other than "the ref requested is missing" and
at that point we would need more "special casing", which does not
smell easy to scale.

>     - We don't need to reach into implementation details of the backend,
>       which would allow us to use this helper for the future reftable
>       backend.

This is exactly what we want to aim for.

> Next to this subcommand we also provide two wrappers `test_ref_exists`
> and `test_ref_missing` that make the helper easier to use.

Hmmmm.  This may introduce "who watches the watchers" problem, no?
I briefly wondered if a better approach is to teach the production
code, e.g., rev-parse, to optionally give more detailed diag.  It
essentially may be the same (making the code in test-ref-store.c
added by this patch available from rev-parse, we would easily get
there), so I do not think the distinction matters.

> diff --git a/t/README b/t/README
> index 61080859899..779f7e7dd86 100644
> --- a/t/README
> +++ b/t/README
> @@ -928,6 +928,15 @@ see test-lib-functions.sh for the full list and their options.
>     committer times to defined state.  Subsequent calls will
>     advance the times by a fixed amount.
>  
> + - test_ref_exists <ref>, test_ref_missing <ref>
> +
> +   Check whether a reference exists or is missing. In contrast to
> +   git-rev-parse(1), these helpers also work with invalid reference
> +   names and references whose contents are unresolvable. The latter
> +   function also distinguishes generic errors from the case where a
> +   reference explicitly doesn't exist and is thus safer to use than
> +   `test_must_fail git rev-parse`.
> +
>   - test_commit <message> [<filename> [<contents>]]
>  
>     Creates a commit with the given message, committing the given
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 48552e6a9e0..7400f560ab6 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -1,6 +1,6 @@
>  #include "test-tool.h"
>  #include "hex.h"
> -#include "refs.h"
> +#include "refs/refs-internal.h"
>  #include "setup.h"
>  #include "worktree.h"
>  #include "object-store-ll.h"
> @@ -221,6 +221,30 @@ static int cmd_verify_ref(struct ref_store *refs, const char **argv)
>  	return ret;
>  }
>  
> +static int cmd_ref_exists(struct ref_store *refs, const char **argv)
> +{
> +	const char *refname = notnull(*argv++, "refname");
> +	struct strbuf unused_referent = STRBUF_INIT;
> +	struct object_id unused_oid;
> +	unsigned int unused_type;
> +	int failure_errno;
> +
> +	if (refs_read_raw_ref(refs, refname, &unused_oid, &unused_referent,
> +			      &unused_type, &failure_errno)) {
> +		/*
> +		 * We handle ENOENT separately here such that it is possible to
> +		 * distinguish actually-missing references from any kind of
> +		 * generic error.
> +		 */
> +		if (failure_errno == ENOENT)
> +			return 17;

Can we tell between the cases where the ref itself is missing, and
the requested ref is symbolic and points at a missing ref?  This
particular case might be OK, but there may other cases where this
"special case" may not be narrow enough.

As long we are going to spend cycles to refine the classification of
error conditions, which is a very good thing to aim for the reason
described in the proposed log message, namely "rev-parse can fail
for reasons other than the ref being absent", I have to wonder again
that the fruit of such an effort should become available in the
production code, instead of being kept only in test-tool.
