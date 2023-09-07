Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F73EC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 18:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbjIGSIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjIGSIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 14:08:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB066197
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 11:07:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 849F31A46A0;
        Thu,  7 Sep 2023 14:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=L3Nnqfh3sSY1lcVOmAu2MWf2rXpXgXJptygvM9
        1uS5o=; b=LRTmo9zBfr6inCFYDyBYGnYL2cuZ3sGH2QNKZOx0MOxfNI2AIgJPm2
        G4njvq1sN5BdH43wAr9niV4Gvk94I9BuF6OBxoN2vQmTbh+6WxLuFCYcqzwul1Fo
        MqaUE10A/rh17A7ugpg8FnlWSA8CcWVIO75cMGYeAWZermw3uNlLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B10A1A469F;
        Thu,  7 Sep 2023 14:07:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D9DC11A469E;
        Thu,  7 Sep 2023 14:07:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v2] diff-lib: Fix check_removed when fsmonitor is on
In-Reply-To: <20230907170119.1536694-1-sokcevic@google.com> (Josip Sokcevic's
        message of "Thu, 7 Sep 2023 10:01:19 -0700")
References: <20230906203726.1526272-1-jonathantanmy@google.com>
        <20230907170119.1536694-1-sokcevic@google.com>
Date:   Thu, 07 Sep 2023 11:07:28 -0700
Message-ID: <xmqqa5txluvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68DB21FE-4DA9-11EE-BB66-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index d8aa777a73..664613bb1b 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -39,11 +39,22 @@
>  static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
>  {
>  	assert(is_fsmonitor_refreshed(istate));

Not a problem this patch introduces, but doesn't this call path

  diff_cache()
  -> unpack_trees()
     -> oneway_diff()
        -> do_oneway_diff()
           -> show_new_file(), show_modified()
               -> get_stat_data()
                  -> check_removed()

violate the assertion?  If so, perhaps we should rewrite it into a
more explicit "if (...) BUG(...)" that is not compiled away.

> -	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
> -		if (!is_missing_file_error(errno))
> -			return -1;
> -		return 1;
> +	if (ce->ce_flags & CE_FSMONITOR_VALID) {
> +		/*
> +		 * Both check_removed() and its callers expect lstat() to have
> +		 * happened and, in particular, the st_mode field to be set.
> +		 * Simulate this with the contents of ce.
> +		 */
> +		memset(st, 0, sizeof(*st));

It is true that the original, when CE_FSMONITOR_VALID bit is set,
bypasses lstat() altogether and leaves the contents of st completely
uninitialized, but this is still way too insufficient, isn't it?

There are three call sites of the check_removed() function.

 * The first one in run_diff_files() only cares about st.st_mode and
   other members of the structure are not looked at.  This makes
   readers wonder if the "st" parameter to check_removed() should
   become "mode_t *st_mode" to clarify this point, but the primary
   thing I want to say is that this caller will not mind if we leave
   other members of st bogus (like 0-bit filled) as long as the mode
   is set correctly.

 * The second one in run_diff_files() passes the resulting &st to
   match_stat_with_submodule(), which in turn passes it to
   ie_match_stat(), which cares about "struct stat" members that are
   used for quick change detection, like owner, group, mtime.
   Giving it a bogus st will most likely cause it to report a
   change.

 * The third one is in get_stat_data().  This also uses the &st to
   call match_stat_with_submodule(), so it is still totally broken
   to give it a bogus st, the same way as the second caller above.

> +		st->st_mode = ce->ce_mode;

Does this work correctly when the cache entry points at a gitlink,
which uses 0160000 that is not a valid st_mode?  I think you'd want
to use a reverse function of create_ce_mode().

> +	} else {
> +		if (lstat(ce->name, st) < 0) {
> +			if (!is_missing_file_error(errno))
> +				return -1;
> +			return 1;
> +		}
>  	}

At this point, if FSMONITOR_VALID bit is not set, we will always
perform lstat() and get all the members of st populated properly,
which is a definite improvement.

While I think this does not make it worse (it is an existing bug
that the code is broken for a ce with the CE_FSMONITOR_VALID bit
set), we may want to leave a note that we _know_ the code after this
patch is still broken.  "Simulate this with ..." -> "Just setting
st_mode is still insufficient and will break majority of callers".

It may make sense, until we clean it up, to disable the check for
the FSMONITOR_VALID bit in this codepath and always perform lstat().
Optimization matters, but computing quickly in order to return an
incorrect result is optimizing for a wrong thing.  I dunno.

Thanks.
