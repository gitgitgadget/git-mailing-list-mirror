Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086211F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbcHYWt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:49:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52376 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753343AbcHYWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D18F343DD;
        Thu, 25 Aug 2016 18:49:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aOVmAfktKkevo0Qi9nYOvdM4ff8=; b=m/37AU
        5AsaMrL06yrUe06KKOgRzG16lcDqxAUMTCjza74jZCbNnPhMv71yC2RFRjrft2Py
        MXjyHWBi3eFgtgch7I/3CtVXY55T0qWlMEyFhl2mH/46TLG20EnVmwUsMkb0mimR
        /FyeIAGtZ1bf96O4+HkqNtmDbRuEOujjYplEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L/kINg9Obo3lMyIDC2tQAAPvB4w5AIjM
        skeIRILGL1EPkOp5D7in0ar85I1RQroa3W6mGQG6JQN/GB10B4sRiUsm+u5PAKwc
        DzpU6cMf/3jWuQqmQAjCv8tIExOquWRXyePOd/eTvXaUddGzGbMA4pW8NDZ1rtpW
        3lU6jHTq8RY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 044A0343D8;
        Thu, 25 Aug 2016 18:49:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72AA0343CF;
        Thu, 25 Aug 2016 18:49:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 05/15] sequencer: lib'ify read_and_refresh_cache()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de>
Date:   Thu, 25 Aug 2016 15:49:16 -0700
In-Reply-To: <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:07:08 +0200
        (CEST)")
Message-ID: <xmqqmvk0jwgj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27EF8AC2-6B16-11E6-A21D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Instead of dying there, you let the caller high up in the callchain
to notice the error and handle it (by dying).  There are two call
sites of read_and_refresh_cache(), one of which is pick_commits(),
whose callers you already verified that they are prepared to do the
right thing given an "error" return from it when you did 3/15, so
the conversion is safe.  The other one, sequencer_pick_revisions()
is also prepared to relay an error return back to its caller and you
made sure its callers are all safe when you did 3/15.

Good.

> diff --git a/sequencer.c b/sequencer.c
> index b90294f..a8c3a48 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -638,18 +638,21 @@ static int prepare_revs(struct replay_opts *opts)
>  	return 0;
>  }
>  
> -static void read_and_refresh_cache(struct replay_opts *opts)
> +static int read_and_refresh_cache(struct replay_opts *opts)
>  {
>  	static struct lock_file index_lock;
>  	int index_fd = hold_locked_index(&index_lock, 0);
>  	if (read_index_preload(&the_index, NULL) < 0)
> -		die(_("git %s: failed to read the index"), action_name(opts));
> +		return error(_("git %s: failed to read the index"),
> +			action_name(opts));
>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
>  	if (the_index.cache_changed && index_fd >= 0) {
>  		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> -			die(_("git %s: failed to refresh the index"), action_name(opts));
> +			return error(_("git %s: failed to refresh the index"),
> +				action_name(opts));
>  	}
>  	rollback_lock_file(&index_lock);
> +	return 0;
>  }
>  
>  static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
> @@ -977,7 +980,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
>  				opts->record_origin || opts->edit));
> -	read_and_refresh_cache(opts);
> +	if (read_and_refresh_cache(opts))
> +		return -1;
>  
>  	for (cur = todo_list; cur; cur = cur->next) {
>  		save_todo(cur, opts);
> @@ -1041,7 +1045,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	if (opts->subcommand == REPLAY_NONE)
>  		assert(opts->revs);
>  
> -	read_and_refresh_cache(opts);
> +	if (read_and_refresh_cache(opts))
> +		return -1;
>  
>  	/*
>  	 * Decide what to do depending on the arguments; a fresh
