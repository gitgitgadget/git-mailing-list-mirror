Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5186E20954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdKXHnz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:43:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63313 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751577AbdKXHnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:43:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1AFFAD8B0;
        Fri, 24 Nov 2017 02:43:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TmIubwv2WQlZVybdK0hSfBQk4fg=; b=atGaoA
        QwOzLbIEqgLFdnAfRPsatMTbwcy2j0VDCGufjdoJi/En0MwrOV87iIY3tQIwLET9
        P/Taz0Jo60nGO+t7Of/7H6k7OsnLZtlKpUcDShAvLPS4LqzIYc3S4xl0lvGV8Q5/
        xb54PsxHMuwD3xRu8RXpjuwc5/MYLhuie/oYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLW+PEZZhvdgyZpPUhmlw1tgNZvaMYlF
        NeVi9wylAZjCH4t02f3+F3jNufEgh9CsuQPC2JjU4c1O7dG0m20U53kgb0GJqrRO
        fTU/SCFq0H/0qSTl+Vr/z8ouRyOtUH33VZl5+k5HNhDHoysD47rsp3pMZu47En+d
        0eE9DJKJTYA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9A5CAD8AF;
        Fri, 24 Nov 2017 02:43:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22A6DAD8AE;
        Fri, 24 Nov 2017 02:43:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171120222529.24995-1-sbeller@google.com>
        <20171120222529.24995-2-sbeller@google.com>
Date:   Fri, 24 Nov 2017 16:43:49 +0900
In-Reply-To: <20171120222529.24995-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 20 Nov 2017 14:25:29 -0800")
Message-ID: <xmqqpo88m896.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36B1471C-D0EB-11E7-A35A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])
>
> One might be tempted to extend git-describe to also work with blobs,
> such that `git describe <blob-id>` gives a description as
> '<commit-ish>:<path>'.  This was implemented at [2]; as seen by the sheer
> number of responses (>110), it turns out this is tricky to get right.
> The hard part to get right is picking the correct 'commit-ish' as that
> could be the commit that (re-)introduced the blob or the blob that
> removed the blob; the blob could exist in different branches.
>
> Junio hinted at a different approach of solving this problem, which this
> patch implements. Teach the diff machinery another flag for restricting
> the information to what is shown. For example:
>
>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>   b2feb64309 Revert the whole "ask curl-config" topic for now
>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
>
> we observe that the Makefile as shipped with 2.0 was introduced in
> v1.9.2-471-g47fbfded53 and replaced in v2.0.0-rc1-5-gb2feb64309 by
> a different blob.
>
> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
> [2] https://public-inbox.org/git/20171028004419.10139-1-sbeller@google.com/
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> On playing around with this, trying to find more interesting cases, I observed:
>
>     git log --oneline --blobfind=HEAD:COPYING
>     703601d678 Update COPYING with GPLv2 with new FSF address
>     
>     git log --oneline --blobfind=703601d678^:COPYING
>     459b8d22e5 tests: do not borrow from COPYING and README from the real source
>     703601d678 Update COPYING with GPLv2 with new FSF address
>     075b845a85 Add a COPYING notice, making it explicit that the license is GPLv2.
>
>     t/diff-lib/COPYING may need an update of the adress of the FSF,
>     # leftoverbits I guess.

I do not think so.  See tz/fsf-address-update topic for details.

Please do not contaminate the list archive with careless mention of 
"hash-mark plus left over bits", as it will make searching the real
good bits harder.  Thanks.

> Another interesting case that I found was
>    git log --oneline --blobfind=v2.14.0:Makefile
>    3921a0b3c3 perf: add test for writing the index
>    36f048c5e4 sha1dc: build git plumbing code more explicitly
>    2118805b92 Makefile: add style build rule
>
> all of which were after v2.14, such that the introduction of that blob doesn't
> show up; I suspect it came in via a merge as unrelated series may have updated
> the Makefile in parallel, though git-log should have told me?

If that is the case, shouldn't we make this new mode imply
--full-history to forbid history simplification?  "git log" is a
tool to find _an_ explanation of the current state, and the usual
history simplification makes tons of sense there, but blobfind is
run most likely in order to find _all_ mention of the set of blobs
given.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index dd0dba5b1d..252a21cc19 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -500,6 +500,10 @@ information.
>  --pickaxe-regex::
>  	Treat the <string> given to `-S` as an extended POSIX regular
>  	expression to match.
> +--blobfind=<blob-id>::
> +	Restrict the output such that one side of the diff
> +	matches the given blob-id.
> +
>  endif::git-format-patch[]

Can we have a blank line between these enumerations to make the
source easier to read?  Thanks.

> diff --git a/diffcore-blobfind.c b/diffcore-blobfind.c
> new file mode 100644
> index 0000000000..5d222fc336
> --- /dev/null
> +++ b/diffcore-blobfind.c
> @@ -0,0 +1,51 @@
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
> +	int i, j = 0, c = q->nr;
> +
> +	if (!options->blobfind)
> +		BUG("blobfind oidset not initialized???");
> +
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +
> +		if (DIFF_PAIR_UNMERGED(p) ||
> +		    (DIFF_FILE_VALID(p->one) &&
> +		     oidset_contains(options->blobfind, &p->one->oid)) ||
> +		    (DIFF_FILE_VALID(p->two) &&
> +		     oidset_contains(options->blobfind, &p->two->oid)))
> +			continue;

So, we keep an unmerged pair, a pair that mentions a sought-blob on
one side or the other side?  I am not sure if we want to keep the
unmerged pair for the purpose of this one.

> +		diff_free_filepair(p);
> +		q->queue[i] = NULL;
> +		c--;

Also, if you are doing the in-place shrinking and have already
introduced another counter 'j' that is initialized to 0, I think it
makes more sense to do the shrinking in-place.  'i' will stay to be
the source-scan pointer that runs 0 thru q->nr, while 'j' can be
used in this loop (where you have 'continue') to move the current
one that is determined to survive from q->queue[i] to q->queue[j++].

Then you do not need 'c'; when the loop ends, 'j' would be the
number of surviving entries and q->nr can be adjusted to it.  Unlike
the usual pattern taken by the other diffcore transformations where
a new queue is populated and the old one discarded, this would leave
the q->queue[] over-allocated, but I do not think it is too bad.
