Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546491FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbcH2Uoi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:44:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63561 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751950AbcH2Uoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:44:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8B6A3AC8E;
        Mon, 29 Aug 2016 16:44:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NezNCHi+JQbL4Ht3bX0GlJ994ww=; b=dqsAVt
        FnNtNNzttmdeqS8LuWNnigAenr4TQFJKUpR/lgOr2c7vVYzq1NnpRLWfFfAreT1c
        S7HT+l/6G1rPNJ9wVjfL78cjXjeuiEZ8+yq+pGAdfZzvlx828OJoFN8SPNHHr25h
        UqZ6xpLvtBmPJ2XAZGO/HHDORT479YsUoIy2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ljUZ8jAw+fTCIKqKueMPzyaBqfQG/XDt
        zQwqi7CPRBpng+LPE7ZafTt7JOFlg80B6JjLjzOIwu/ukEbWgQlVcNZAaE704T1S
        5zqon3dLXATVS5/r1xW7sB+tiPvRFotOPC/+F1fcDYpbbLI9iEvHsie1/fUXmg+N
        iV9CqrCdwwE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1CDB3AC8D;
        Mon, 29 Aug 2016 16:44:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 477003AC8C;
        Mon, 29 Aug 2016 16:44:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/14] sequencer: lib'ify read_and_refresh_cache()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <99f3ab3a30a469b271300ff61309ac4c4a8af448.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:44:33 -0700
In-Reply-To: <99f3ab3a30a469b271300ff61309ac4c4a8af448.1472219214.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 26 Aug 2016 15:47:50 +0200
        (CEST)")
Message-ID: <xmqq7faz9ufi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6543E402-6E29-11E6-B65E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Instead of dying there, let the caller high up in the callchain
> notice the error and handle it (by dying, still).
>
> There are two call sites of read_and_refresh_cache(), one of which is
> pick_commits(), whose callers were already prepared to do the right
> thing given an "error" return from it by an earlier patch, so the
> conversion is safe.
>
> The other one, sequencer_pick_revisions() was also prepared to relay
> an error return back to its caller in all remaining cases in an
> earlier patch.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index c006cae..e30aa82 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -640,18 +640,21 @@ static int prepare_revs(struct replay_opts *opts)
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

With the current set of callers, a caller that notices an error from
this function will immediately exit without doing any further
damage.

So in that sense, this is a "safe" conversion.

But is it a sensible conversion?  When the caller wants to do
anything else (e.g. clean-up and try something else, perhaps read
the index again), the caller can't, as the index is still locked,
because even though the code knows that the lock will not be
released until the process exit, it chose to return error without
releasing the lock.

For a file-scope static helper, that probably is sufficient.  But if
this can be reached from a public entry point in the API, the caller
of that entry point will find this not-so-useful, I would think.

I suspect doing the "right thing" to future-proof it may not be too
much more work.

	static int read_and_refresh_cache(struct replay_opts *opts)
        {
+        	int retval = 0; /* assume success */
		...
                if (read_idnex_preload(...) < 0) {
			retval = error(...);
                        goto finish;
		}
                refresh_index(...);
                if (...changed...) {
                	if (write_locked_index(...))
                        	retval = error(...);
		}
+	finish:
                rollback_lock_file(&index_lock);
                return retval;
	}

or something like that on top?
