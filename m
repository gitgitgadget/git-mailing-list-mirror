Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E148C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 04:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C2461249
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 04:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHEf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:35:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64131 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFHEf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 00:35:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDCC2143ACF;
        Tue,  8 Jun 2021 00:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dlnw2nanfdWAxmd8nO0eXxwMSJ7MrKp5AG72DI
        aRn9s=; b=HSUpQXL1fnpC1k1DpZnFJvnE0nHMAe3let4xGodRpmKVowBZmua1GP
        CH2Uz/9n/m6G9qWq0u7EQbqnuXP0bUcNaE3YCj3y9KG0DwkwzYRDrpVSBA9M21JU
        U6Eq7i40T54sSPJUF97rd8qnrNxZEXzLZQXK3JhOzO+XZIMH1mwX4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B50F8143ACD;
        Tue,  8 Jun 2021 00:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D939143ACB;
        Tue,  8 Jun 2021 00:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <5b41569aced7fbd95ee2d0b4e871d03ffd8dcd67.1623111879.git.jonathantanmy@google.com>
Date:   Tue, 08 Jun 2021 13:33:32 +0900
In-Reply-To: <5b41569aced7fbd95ee2d0b4e871d03ffd8dcd67.1623111879.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 7 Jun 2021 17:25:59 -0700")
Message-ID: <xmqqim2pq8kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF498A32-C812-11EB-B9D2-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  		/* Check if it is a missing object */
> -		if (fetch_if_missing && has_promisor_remote() &&
> -		    !already_retried && r == the_repository &&
> +		if (fetch_if_missing && repo_has_promisor_remote(r) &&
> +		    !already_retried &&

Turning has_promisor_remote() into repo_has_promisor_remote(r) does
make tons of sense.  Is this part of the code ready to lose "'r' must
be the_repository because has_promisor_remote() only works on the
primary in-core repository" we had before?

> @@ -21,6 +22,11 @@ static int fetch_objects(const char *remote_name,
>  
>  	child.git_cmd = 1;
>  	child.in = -1;
> +	if (repo != the_repository) {
> +		prepare_other_repo_env(&child.env_array);
> +		strvec_pushf(&child.env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> +			     repo->gitdir);
> +	}

This is what prepare_submodule_repo_env_in_gitdir() does; it makes
me wonder if it (i.e. set up environment for that other repository,
including the GIT_DIR and possibly other per-repository environment
variable override) should be the primary API callers would want,
instead of a more limited prepare_other_repo_env() that does not
even take 'repo' parameter.  Doesn't it feel somewhat strange for a
function that is supposed to help preparing a part of child process
by filling appropriate environ[] array to be run in a repository
that is different from ours (which is "other repo" part of its name)
not to want to even know which repository the "other" repo is?

> diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> new file mode 100644
> index 0000000000..3f102cfddd
> --- /dev/null
> +++ b/t/helper/test-partial-clone.c
> @@ -0,0 +1,43 @@
> +#include "cache.h"
> +#include "test-tool.h"
> +#include "repository.h"
> +#include "object-store.h"
> +
> +/*
> + * Prints the size of the object corresponding to the given hash in a specific
> + * gitdir. This is similar to "git -C gitdir cat-file -s", except that this
> + * exercises the code that accesses the object of an arbitrary repository that
> + * is not the_repository. ("git -C gitdir" makes it so that the_repository is
> + * the one in gitdir.)
> + */

The reason why this only gives size is because it will eventually
become unnecessary once the main code starts running things in a
submodule repository properly (i.e. without doing the alternate odb
thing), and a more elaborate check is not worth your engineering
effort?  Object type and object sizes are something that you can
safely express in plain text, would be handy for testing, and would
not require too much extra code, I'd imagine.

> +static void object_info(const char *gitdir, const char *oid_hex)
> +{
> +	struct repository r;
> +	struct object_id oid;
> +	unsigned long size;
> +	struct object_info oi = {.sizep = &size};
> +	const char *p;
> +
> +	if (repo_init(&r, gitdir, NULL))
> +		die("could not init repo");
> +	if (parse_oid_hex(oid_hex, &oid, &p))
> +		die("could not parse oid");
> +	if (oid_object_info_extended(&r, &oid, &oi, 0))
> +		die("could not obtain object info");
> +	printf("%d\n", (int) size);

Mimicking what builtin/cat-file.c::cat_one_file() does, for example, and
using

	printf("%"PRIuMAX"\n", (uintmax_t)size);

might be better (I was wondering if we can extract reusable helpers,
but I do not think that is worth doing, if this is meant to be
temporary stop-gap measure).

Thanks.

