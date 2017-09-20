Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C4120A28
	for <e@80x24.org>; Wed, 20 Sep 2017 02:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdITC3A (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 22:29:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdITC27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 22:28:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91DC694336;
        Tue, 19 Sep 2017 22:28:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ldocdKFEsS8jM+dvqKQpomfcSmA=; b=qYdclk
        Ytoy683O2Av3MRsRj5UWXbA/0nM+zSLY9mOO+pAsuBH34UBtG/ZF4BtLwzWBHE+9
        ATWOCo2Oa0WpQ4dCZoIbrUIZPU57H4jAFr14k6bb0hohDiqLd7yJEw+r5dVNDkzS
        HMih29hbAeHEbfgJWYHB3CfoRVqdJgSDO5aX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PP5d1epyCFlk2Te6DvcOpoQAnj5pMiGh
        D29LPKJPlVZZxoYLsBztjQ1GPVZdaYFBeuKl0Uaoy/8cR6s0GnQFVRQsHpkL7UPX
        5sVgBg4UwtyRmxqwcFdTLSCX5QDpSyjl0Ieh8ZZ5YlLp5Z5gXNPjMFGpVMRru38q
        8pWUHpQFgtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 885DF94335;
        Tue, 19 Sep 2017 22:28:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC8C894333;
        Tue, 19 Sep 2017 22:28:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-5-benpeart@microsoft.com>
Date:   Wed, 20 Sep 2017 11:28:56 +0900
In-Reply-To: <20170919192744.19224-5-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 19 Sep 2017 15:27:36 -0400")
Message-ID: <xmqqr2v2p0gn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7499952A-9DAB-11E7-93E7-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +/* do stat comparison even if CE_FSMONITOR_VALID is true */
> +#define CE_MATCH_IGNORE_FSMONITOR 0X20

Hmm, when should a programmer use this flag?

> +int git_config_get_fsmonitor(void)
> +{
> +	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> +		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");

Will the environment be part of the published API, or is it a
remnant of a useful tool for debugging while developing the feature?

If it is the former (and I'd say why not, even though "git -c
core.fsmontor=..." may be easy enough), we might want to rename it
to replace _TEST with _PROGRAM or something and document it.

> diff --git a/diff-lib.c b/diff-lib.c
> index 2a52b07954..23c6d03ca9 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -12,6 +12,7 @@
>  #include "refs.h"
>  #include "submodule.h"
>  #include "dir.h"
> +#include "fsmonitor.h"
>  
>  /*
>   * diff-files
> @@ -228,6 +229,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  
>  		if (!changed && !dirty_submodule) {
>  			ce_mark_uptodate(ce);
> +			mark_fsmonitor_valid(ce);

I notice all calls to mark_fsmonitor_valid(ce) always follow a call
to ce_mark_uptodate(ce).  Should the call to the former be made as
part of the latter instead?  Are there cases where we want to call
ce_mark_uptodate(ce) to mark the ce up-to-date, yet we do not want
to call mark_fsmonitor_valid(ce)?  How does a programmer tell when
s/he wants to call ce_mark_uptodate(ce) if s/he also should call
mark_fsmonitor_valid(ce)?

Together with "when to pass IGNORE_FSMONITOR" question, is there a
summary that guides new programmers to answer these questions in the
new documentation?

> diff --git a/dir.h b/dir.h
> index e3717055d1..fab8fc1561 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -139,6 +139,8 @@ struct untracked_cache {
>  	int gitignore_invalidated;
>  	int dir_invalidated;
>  	int dir_opened;
> +	/* fsmonitor invalidation data */
> +	unsigned int use_fsmonitor : 1;

This makes it look like we will add a bit more fields in later
patches that are about "invalidation" around fsmonitor, but it
appears that such an addition never happens til the end of the
series.  And use_fsmonitor boolean does not seem to be what the
comment says---it just tells us if fsmonitor is in use in the
operation of the untracked cache, no?

> diff --git a/entry.c b/entry.c
> index cb291aa88b..5e6794f9fc 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -4,6 +4,7 @@
>  #include "streaming.h"
>  #include "submodule.h"
>  #include "progress.h"
> +#include "fsmonitor.h"
>  
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -357,6 +358,7 @@ static int write_entry(struct cache_entry *ce,
>  			lstat(ce->name, &st);
>  		fill_stat_cache_info(ce, &st);
>  		ce->ce_flags |= CE_UPDATE_IN_BASE;
> +		mark_fsmonitor_invalid(state->istate, ce);
>  		state->istate->cache_changed |= CE_ENTRY_CHANGED;

Similar to "how does mark_fsmonitor_valid() relate to
ce_mark_uptodate()?" question earlier, mark_fsmonitor_invalid()
seems to often appear in pairs with the update to cache_changed.
Are there cases where we need CE_ENTRY_CHANGED bit added to the
index state yet we do not want to call mark_fsmonitor_invalid()?  I
am wondering if there should be a single helper function that lets
callers say "I changed this ce in this istate this way.  Please
update CE_VALID, CE_UPDATE_IN_BASE and CE_FSMONITOR_VALID
accordingly".

That "changed _this way_" is deliberately vague in my question
above, because it is not yet clear to me when mark-valid and
mark-invalid should and should not be called from the series.

> +	/* a fsmonitor process can return '*' to indicate all entries are invalid */
> +	if (query_success && query_result.buf[0] != '/') {
> +		/* Mark all entries returned by the monitor as dirty */

The comment talks about '*' and code checks if it is not '/'?  The
else clause of this if/else handles the "invalidate all" case, so
shouldn't we be comparing with '*' instead here?

Ah, fsmonitor-watchman section of the doc tells us to write the hook
in a way to return slash, so the comment above the code is stale and
the comparison with '/' is what we want, I guess.
