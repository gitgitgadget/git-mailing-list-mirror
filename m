Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2628C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452B12176B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="izvW6DfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgJGShx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:37:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64639 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGShx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:37:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B9818D276;
        Wed,  7 Oct 2020 14:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGRI6ErR1fpw5wDGBQi3QBgEfZI=; b=izvW6D
        fUrjl+5Ej6/eV9RbnwhRhhBCACeY4epLJ7WTMlfLTEGQI+Te0aSmh9Zbs78gpWJm
        SqIdTMnw+c3QR1NdPktR56uMfphLbpLPJVROCfs1ZN0WQTSIeY52u9VWLk/7P2bz
        NXPCohpWWshdMcVZCGxC4o5BD5TC2P4z2jRFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QLSCkls14GHjP8zpywVjiyAKY/4pQyhA
        gkzeRZbm6r+WizwnpXb3hq7fMIiDvDRoyHYYCKylcRifzc4QgqtYlM6wvNRu7YTz
        H8zBd6lKd20ddS5hF9mwZIWR1rXTSmcBO65Z4IwsMbtXUUVPg//H14aT6Yz/EC4+
        izQn1ovNXPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83C058D275;
        Wed,  7 Oct 2020 14:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 117EF8D274;
        Wed,  7 Oct 2020 14:37:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
        <20201007074538.25891-3-shouryashukla.oo@gmail.com>
Date:   Wed, 07 Oct 2020 11:37:48 -0700
In-Reply-To: <20201007074538.25891-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 7 Oct 2020 13:15:37 +0530")
Message-ID: <xmqqtuv52877.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 333CEE3A-08CC-11EB-9371-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> From: Prathamesh Chavan <pc44800@gmail.com>
>
> Convert submodule subcommand 'add' to a builtin and call it via
> 'git-submodule.sh'.
>
> Also, since the command die()s out in case of absence of commits in the
> submodule, the keyword 'fatal' is prefixed in the error messages.
> Therefore, prepend the keyword in the expected output of test t7400.6.
>
> While at it, eliminate the extra preprocessor directive
> `#include "dir.h"` at the start of 'submodule--helper.c'.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Stefan Beller <stefanbeller@gmail.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  builtin/submodule--helper.c | 391 +++++++++++++++++++++++++++++++++++-
>  git-submodule.sh            | 161 +--------------
>  t/t7400-submodule-basic.sh  |   2 +-
>  3 files changed, 392 insertions(+), 162 deletions(-)

Whoa.  That looks like a huge change.  Makes me wonder if we want
this split into multiple pieces, but let's read on.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index de5ad73bb8..ec0a50d032 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -19,7 +19,6 @@
>  #include "diffcore.h"
>  #include "diff.h"
>  #include "object-store.h"
> -#include "dir.h"
>  #include "advice.h"
>  
>  #define OPT_QUIET (1 << 0)
> @@ -2744,6 +2743,395 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
>  	return !!ret;
>  }
>  
> +struct add_data {
> +	const char *prefix;
> +	const char *branch;
> +	const char *reference_path;
> +	const char *sm_path;
> +	const char *sm_name;
> +	const char *repo;
> +	const char *realrepo;
> +	int depth;
> +	unsigned int force: 1;
> +	unsigned int quiet: 1;
> +	unsigned int progress: 1;
> +	unsigned int dissociate: 1;
> +};
> +#define ADD_DATA_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 }

This is used in a context like this:

	struct add_data data = ADD_DATA_INIT;

It is a tangent, but wouldn't

	#define ADD_DATA_INIT { 0 }

be a more appropriate way to express that there is nothing other
than the initialization to zero values going on?

> +/*
> + * Guess dir name from repository: strip leading '.*[/:]',
> + * strip trailing '[:/]*.git'.
> + */

The original also strips trailing '/'.  The original does these in
order:

 - if $repo ends with '/', remove that.  The above description does
   not mention it.

 - if the result of the above ends with zero or more ':', followed
   by zero or more '/', followed by ".git", drop the matching part.
   The above description sounds as if it will remove ":/:/:.git"
   from the end (and the code seems to have the same bug, as
   after_slash_or_colon won't allow the code to know if the previous
   character before ".git" was slash or colon).

 - if the result of the above has '/' or ':' in it, remove everything
   before it and '/' or ':' itself.

> +static char *guess_dir_name(const char *repo)
> +{
> +	const char *p, *start, *end, *limit;
> +	int after_slash_or_colon;
> +
> +	after_slash_or_colon = 0;
> +	limit = repo + strlen(repo);
> +	start = repo;
> +	end = limit;
> +	for (p = repo; p < limit; p++) {
> +		if (starts_with(p, ".git")) {
> +			/* strip trailing '[:/]*.git' */
> +			if (!after_slash_or_colon)
> +				end = p;
> +			p += 3;
> +		} else if (*p == '/' || *p == ':') {
> +			/* strip leading '.*[/:]' */
> +			if (end == limit)
> +				end = p;
> +			after_slash_or_colon = 1;
> +		} else if (after_slash_or_colon) {
> +			start = p;
> +			end = limit;
> +			after_slash_or_colon = 0;
> +		}
> +	}
> +	return xstrndup(start, end - start);

So, this looks quite bogus and unnatural.  Checking for ".git" at
every position in the string is meaningless.

I wonder if something along the following (beware: not even compile
tested or checked for off-by-ones) would be easier to follow and
more faithful conversion to the original.

	ep = repo + strlen(repo);

        /*
         * eat trailing slashes - a conversion less faithful to
         * the original may want to loop to cull duplicated trailing
	 * slashes, but we can leave it as user-error for now.
	 */
	if (repo < ep - 1 && ep[-1] == '/')
		ep--;

	/* eat ":*/*\.git" at the tail */
	if (repo < ep - 4 && !memcmp(".git", ep - 4, 4)) {
		ep -= 4;
		while (repo < ep - 1 && ep[-1] == '/')
			ep--;
		while (repo < ep - 1 && ep[-1] == ':')
			ep--;
	}

	/* find the last ':' or '/' */
	for (sp = ep - 1; repo <= sp; sp--) {
		if (*sp == '/' || *sp == ':')
			break;
	}
        sp++; /* exclude '/' or ':' itself */

        /* sp point at the beginning, and ep points at the end */
	return xmemdupz(sp, ep - sp);

> +}

That's it for now; I didn't look at the remainder of this patch
during this sitting before I have to move on, but I may revisit the
rest at some other time.

Thanks.
