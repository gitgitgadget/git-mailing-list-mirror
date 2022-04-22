Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD4DC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiDVWvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiDVWvL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:51:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83AF4B865
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 15:12:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72C8412BFBF;
        Fri, 22 Apr 2022 18:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yMakVKUMS8qwgQjppuJK1JHGW7X/XhQQg7+4nW
        WF33M=; b=VjzAsJ3AjGnI5aFEUr32+BmcQomU5fyJ7YIR5z9NJs0uVrDdMUGwat
        eKlbD+a5rM4iIuhFXLgCm679sU6wVQAJLX+EEVdPle8CZqknggZnMFmRRVO3vROT
        2YrkrcqtR7R2PRTRy+rsHyFI7D2HZ16TPdxTdRLsREhYErnCUDB5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6845012BFBE;
        Fri, 22 Apr 2022 18:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEE0412BFBC;
        Fri, 22 Apr 2022 18:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH v6] log: "--since-as-filter" option is a non-terminating
 "--since" variant
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
        <xmqqtub3moa0.fsf@gitster.g>
        <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
        <xmqqilrfk14q.fsf@gitster.g> <xmqqzgkd7y42.fsf@gitster.g>
        <YmMJqvKN6itSHEZW@vmiklos.hu>
Date:   Fri, 22 Apr 2022 15:11:11 -0700
In-Reply-To: <YmMJqvKN6itSHEZW@vmiklos.hu> (Miklos Vajna's message of "Fri, 22
        Apr 2022 22:01:46 +0200")
Message-ID: <xmqqee1o6a68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F08FA26-C289-11EC-A1C0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@vmiklos.hu> writes:

> The "--since=<time>" option of "git log" limits the commits displayed by
> the command by stopping the traversal once it sees a commit whose
> timestamp is older than the given time and not digging further into its
> parents.
>
> This is OK in a history where a commit always has a newer timestamp than
> any of its parents'.  Once you see a commit older than the given <time>,
> all ancestor commits of it are even older than the time anyway.  It
> poses, however, a problem when there is a commit with a wrong timestamp
> that makes it appear older than its parents.  Stopping traversal at the
> "incorrectly old" commit will hide its ancestors that are newer than
> that wrong commit and are newer than the cut-off time given with the
> --since option.  --max-age and --after being the synonyms to --since,
> they share the same issue.
>
> Add a new "--since-as-filter" option that is a variant of
> "--since=<time>".  Instead of stopping the traversal to hide an old
> enough commit and its all ancestors, exclude commits with an old
> timestamp from the output but still keep digging the history.
>
> Without other traversal stopping options, this will force the command in
> "git log" family to dig down the history to the root.  It may be an
> acceptable cost for a small project with short history and many commits
> with screwy timestamps.
>
> It is quite unlikely for us to add traversal stopper other than since,
> so have this as a --since-as-filter option, rather than a separate
> --as-filter, that would be probably more confusing.
>
> Signed-off-by: Miklos Vajna <vmiklos@vmiklos.hu>
> ---
>
> Hi Junio,
>
> On Fri, Apr 22, 2022 at 11:48:45AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Now I had some time to think about it, I have a feeling that it is
>> quite unlikely for us to add traversal stopper other than since, so
>> having a separate "--as-filter" would probably be more confusing
>> than adding "--since-as-filter", stressing on "only the 'show
>> commits with timestamp after this one' has two variants".
>
> I'm fine with this approach, it goes back to the initial version. I 
> rather reworked v5 in practice, to keep the other improvements.
>
> Here is a patch that does this.
>
> Regards,
>
> Miklos

Thanks.  Now 2.36 release is behind us, let's queue this in 'seen'
and after getting reviewed by somebody else---I do not trust
anything looked at by me and nobody else---merge it down, aiming for
graduation during this cycle.

> +--since-as-filter=<date>::
> +	Show all commits more recent than a specific date. This visits
> +	all commits in the range, rather than stopping at the first commit which
> +	is older than a specific date.

> diff --git a/revision.c b/revision.c
> index 7d435f8048..ee933a11c7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
>  		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
>  		    !revs->line_level_traverse)
>  			continue;

Much ealrier than this part in the same loop there is

		if (revs->max_age != -1 && (commit->date < revs->max_age))
			obj->flags |= UNINTERESTING;
		if (process_parents(revs, commit, &original_list, NULL) < 0)
			return -1;

which taints the commit we are looking at as UNINTERESTING, cutting
the traversal down to its parents, if its timestamp is older than
max_age, and it would need to be taught not to do that, no?

Ah, OK, max_age_as_filter is *NOT* a boolean (false is -1 and true
is something else) but is an independent timestamp and the
expectation is that max_age is left to be -1 when --since is not in
use.  --since-as-filter's timestamp is stored in max_age_as_filter
so the earlier "compare with max_age and use UNINTERESTING bit to
stop traversal" code does not have to be modified.

> +		if (revs->max_age_as_filter != -1 &&
> +			(commit->date < revs->max_age) && !revs->line_level_traverse)
> +			continue;
>  		date = commit->date;
>  		p = &commit_list_insert(commit, p)->next;

And if that is the assumption of this code, shouldn't this part be
using "if max_age is set (i.e. not -1) and the commit is older than
that and we are not doing -La,b traversal"?  "--since-as-filter"
being used does not mean max_age must be set to a value that can be
compared to timestamps in commits in the world order of this version
of the patch, right?

> @@ -1838,6 +1841,7 @@ void repo_init_revisions(struct repository *r,
>  	revs->dense = 1;
>  	revs->prefix = prefix;
>  	revs->max_age = -1;
> +	revs->max_age_as_filter = -1;
>  	revs->min_age = -1;
>  	revs->skip_count = -1;
>  	revs->max_count = -1;
> @@ -2218,6 +2222,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
>  		revs->max_age = approxidate(optarg);
>  		return argcount;
> +	} else if ((argcount = parse_long_opt("since-as-filter", argv, &optarg))) {
> +		revs->max_age_as_filter = approxidate(optarg);
> +		return argcount;

OK, so max_age_as_filter is a timestamp to be compared with commits
when --since-as-filter option is given.

> @@ -3862,6 +3869,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  	if (revs->min_age != -1 &&
>  	    comparison_date(revs, commit) > revs->min_age)
>  			return commit_ignore;
> +	if (revs->max_age_as_filter != -1 &&
> +	    comparison_date(revs, commit) < revs->max_age_as_filter)
> +			return commit_ignore;

This one does make sense.

> diff --git a/revision.h b/revision.h
> index 5bc59c7bfe..e80c148b19 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -263,6 +263,7 @@ struct rev_info {
>  	int skip_count;
>  	int max_count;
>  	timestamp_t max_age;
> +	timestamp_t max_age_as_filter;
>  	timestamp_t min_age;

So does this.

Everything except that "why are we checking if --since-as-filter is
set and then comparing with the value came from --since?" part looks
great to me.  If that indeed is a bug (it is very possible that I am
misreading the logic and the comparison with continue is perfectly
correct), and if the tests added by this patch didn't catch it, then
the test script may need a bit more work to catch such a mistake.

Thanks.
