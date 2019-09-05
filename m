Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBDC1F4B7
	for <e@80x24.org>; Thu,  5 Sep 2019 22:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfIEWAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:00:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57394 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfIEWAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:00:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23E73759E0;
        Thu,  5 Sep 2019 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ilWnNCJzaxr7XHnW886PronN3Ts=; b=wXOEMZ
        sDuIkhPf/ZSAp9utixjt9paNG62FmIm76cZgFv7f8PpjYAGLfZExdqGn82KSjPkm
        9EWNDpgdcdrKfopAZqR0CFT4t6AR/PJpl3E8vEbp4kwM81WZQ4ybf/QwtYLW+IEc
        59hDBUwoV2sZbdCHhdjRPrxk6CrFBw0DysDJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tEeb1ikT1OHeHxgtkd7Cwk7pBnczFqEn
        y4pSSgSZ2H6ODdzCgV8Pkook5qeX5vdOTdzse6eODLAidjDhLiAIUCuQmnWFPiOv
        K22komQC0NpEykUT3qEauj7BWaUK72si5bfC7ZdUGgKAJEOgRH5haEiCZw6b4U3b
        SkApYZi40UU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B6F3759DF;
        Thu,  5 Sep 2019 18:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6DC4759DC;
        Thu,  5 Sep 2019 18:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/3] factor out refresh_and_write_cache function
References: <20190829182748.43802-1-t.gummerer@gmail.com>
        <20190903191041.10470-1-t.gummerer@gmail.com>
        <20190903191041.10470-2-t.gummerer@gmail.com>
Date:   Thu, 05 Sep 2019 15:00:34 -0700
In-Reply-To: <20190903191041.10470-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Tue, 3 Sep 2019 20:10:39 +0100")
Message-ID: <xmqqwoemo131.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 975DFDD8-D028-11E9-AE46-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Getting the lock for the index, refreshing it and then writing it is a
> pattern that happens more than once throughout the codebase, and isn't
> trivial to get right.  Factor out the refresh_and_write_cache function
> from builtin/am.c to read-cache.c, so it can be re-used in other
> places in a subsequent commit.
>
> Note that we return different error codes for failing to refresh the
> cache, and failing to write the index.  The current caller only cares
> about failing to write the index.  However for other callers we're
> going to convert in subsequent patches we will need this distinction.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/am.c | 16 ++--------------
>  cache.h      | 16 ++++++++++++++++
>  read-cache.c | 19 +++++++++++++++++++
>  3 files changed, 37 insertions(+), 14 deletions(-)

I think this goes in the right direction, but obviously conflicts
with what Dscho wants to do in the builtin-add-i series, and needs
to be reconciled by working better together.

For now, I'll eject builtin-add-i and queue this for a few days to
give it a bit more exposure, but after that requeue builtin-add-i
and discard these three patches.  By that time, hopefully you two
would have a rerolled version of this one and builtin-add-i that
agree what kind of refresh-and-write-index behaviour they both want.

The differences I see that need reconciling are:

 - builtin-add-i seems to allow 'gentle' and allow returning an
   error when we cannot open the index for writing by passing false
   to 'gentle'; this feature is not used yet, though.

 - This version allows to pass pathspec, seen and header_msg, while
   the one in builtin-add-i cannot limit the part of the index
   getting refreshed with pathspec.  It wouldn't be a brain surgery
   to use this version and adjust the caller (there only is one) in
   the builtin-add-i topic.

 - This version does not write the index back when refresh_index()
   returns non-zero, but the one in builtin-add-i ignores the
   returned value.  I think, as a performance measure, it probably
   is a better idea to write it back, even when the function returns
   non-zero (the local variable's name is has_errors, but having an
   entry in the index that does not get refreshed is *not* an error;
   e.g. an unmerged entry is a normal thing in the index, and as
   long as we refreshed other entries while having an unmerged and
   unrefreshable entry, we are making progress that is worth writing
   out).

Thanks.

> +int repo_refresh_and_write_index(struct  repository *repo,
> +				 unsigned int refresh_flags,
> +				 unsigned int write_flags,
> +				 const struct pathspec *pathspec,
> +				 char *seen, const char *header_msg)
> +{
> +	struct lock_file lock_file = LOCK_INIT;
> +
> +	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> +	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg)) {
> +		rollback_lock_file(&lock_file);
> +		return 1;
> +	}
> +	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | write_flags))
> +		return -1;
> +	return 0;
> +}
> +
> +
>  int refresh_index(struct index_state *istate, unsigned int flags,
>  		  const struct pathspec *pathspec,
>  		  char *seen, const char *header_msg)
