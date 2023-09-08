Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD7EE8011
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbjIHPAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHPAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 11:00:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2851BF1
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 08:00:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B661AD84B;
        Fri,  8 Sep 2023 11:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=42/eAmISvdKCb7j0+kk18VbI6O7JNfin2GRnQq
        b+sG8=; b=gtUz2VVFxI95jE6q8KTd1HIeJZMq2CEQRhrfppLSZbBlcRpYNJUFuW
        PgriUE68c0fF+socUxd9ijOnkFV3Cua8ve0vZPa1k5leFLsqjgGgKdHwcQHBPM1Q
        Wsr5rzlIN4t5c3QJXAHEw3HSyDTiyYRu3QhKOD2apyp+ClszlDB/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ACFE1AD845;
        Fri,  8 Sep 2023 11:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B492B1AD837;
        Fri,  8 Sep 2023 11:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v2] diff-lib: Fix check_removed when fsmonitor is on
In-Reply-To: <CAJiyOigsH=Pac1g_5ztB01uEaCBjefazUpnH5k3ARZ-COm0uLA@mail.gmail.com>
        (Josip Sokcevic's message of "Thu, 7 Sep 2023 16:08:42 -0700")
References: <20230906203726.1526272-1-jonathantanmy@google.com>
        <20230907170119.1536694-1-sokcevic@google.com>
        <xmqqa5txluvz.fsf@gitster.g>
        <CAJiyOigsH=Pac1g_5ztB01uEaCBjefazUpnH5k3ARZ-COm0uLA@mail.gmail.com>
Date:   Fri, 08 Sep 2023 08:00:00 -0700
Message-ID: <xmqqjzt0vhfz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 641A491A-4E58-11EE-9CB6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:

>> > @@ -39,11 +39,22 @@
>> >  static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
>> >  {
>> >       assert(is_fsmonitor_refreshed(istate));
>>
>> Not a problem this patch introduces, but doesn't this call path
>>
>>   diff_cache()
>>   -> unpack_trees()
>>      -> oneway_diff()
>>         -> do_oneway_diff()
>>            -> show_new_file(), show_modified()
>>                -> get_stat_data()
>>                   -> check_removed()
>>
>> violate the assertion?  If so, perhaps we should rewrite it into a
>> more explicit "if (...) BUG(...)" that is not compiled away.
>
> True, I will update it.

Not as a part of this series, though.

I think this came from the same series that were merged at 858119f6
(Merge branch 'nk/diff-index-fsmonitor', 2021-03-24), so if we just
simply do a moral "revert" of the series, then it should disappear.

More importantly, you'd want to ask help from folks who are more
familiar with fsmonitor, which would take some time, and fixing this
assertion can be backburnered while you are fixing the original
issue that got you started here.  I see JeffH is already Cc:ed,
which is good.

>> > -     if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
>> > -             if (!is_missing_file_error(errno))
>> > -                     return -1;
>> > -             return 1;
>> > +     if (ce->ce_flags & CE_FSMONITOR_VALID) {
>> > +             /*
>> > +              * Both check_removed() and its callers expect lstat() to have
>> > +              * happened and, in particular, the st_mode field to be set.
>> > +              * Simulate this with the contents of ce.
>> > +              */
>> > +             memset(st, 0, sizeof(*st));
>>
>> It is true that the original, when CE_FSMONITOR_VALID bit is set,
>> bypasses lstat() altogether and leaves the contents of st completely
>> uninitialized, but this is still way too insufficient, isn't it?
>>
>> There are three call sites of the check_removed() function.
>>
>>  * The first one in run_diff_files() only cares about st.st_mode and
>>    other members of the structure are not looked at.  This makes
>>    readers wonder if the "st" parameter to check_removed() should
>>    become "mode_t *st_mode" to clarify this point, but the primary
>>    thing I want to say is that this caller will not mind if we leave
>>    other members of st bogus (like 0-bit filled) as long as the mode
>>    is set correctly.
>>
>>  * The second one in run_diff_files() passes the resulting &st to
>>    match_stat_with_submodule(), which in turn passes it to
>>    ie_match_stat(), which cares about "struct stat" members that are
>>    used for quick change detection, like owner, group, mtime.
>>    Giving it a bogus st will most likely cause it to report a
>>    change.
>>
>>  * The third one is in get_stat_data().  This also uses the &st to
>>    call match_stat_with_submodule(), so it is still totally broken
>>    to give it a bogus st, the same way as the second caller above.
>>
>> > +             st->st_mode = ce->ce_mode;
>>
>> Does this work correctly when the cache entry points at a gitlink,
>> which uses 0160000 that is not a valid st_mode?  I think you'd want
>> to use a reverse function of create_ce_mode().
>
> I realized this too but after I sent the patch. I don't think we have
> a good way to reverse it, so the best we can do is to guess it. But I
> don't think we should do that. Instead, should we just zero the struct
> and add a TODO? Alternative could be to use a double pointer for stat
> and do more checks in call sites, but I'm not familiar with the
> codebase to how that branching would need to look like.
>
> Any preference?

My preference in the short term actually is to teach this codepath
to ignore CE_FSMONITOR_VALID bit and always run lstat() instead.

That will unbreak this "optimization" that allowed the code to do a
wrong thing quickly.

The solution suitable for a bit longer term becomes rather obvious
when we step back a bit and think about the purpose of this block
inside "if ce_flags says CE_FSMONITOR_VALID is true, do this".  The
fsmonitor has already checked and knows that the path has not been
updated, i.e.  what we have in the in-core index still matches what
we would get from running lstat().  So now what we need to do is to
pretend as if we called lstat(), recreating the data in "struct
stat" from "struct cache_entry" well enough to fool ie_match_stat()
into saying that the cached stat data in ce still matches what is in
st.

Can we do that?  Of course we can.  When we added or refreshed the
cache entry, we should have had "struct stat" taken out of lstat()
for the path, and copied some data from the members of "struct stat"
into "struct cache_entry".  After all, that is how we can later ask
ie_match_stat() if the cached stat data in the "struct cache_entry"
matches the current "struct stat" data to tell if the path hasn't
been touched since we last refreshed.

We want to have a helper function that we can ask:

    With the data in this 'struct cache_entry', please populate this
    'struct stat'.  Do so well enough that ie_match_stat() says "ok,
    the path is unchanged".

You can write such a function by studying two code paths.

 * ie_match_stat() and its helpers to find out which members of
   "struct stat" matters (i.e. compared against corresponding
   members in "struct cache_entry").

 * add_to_index() and its helpers, fill_stat_cache_info() in
   particular, to see which members of "struct stat" are used to
   populate ce->ce_stat_data and how (e.g. some members lose
   precision and that is find---the reverse operation will also be
   lossy and the resulting "struct stat" you will forge will *not*
   exactly match what you would obtain from real lstat(), but it is
   good enough to fool ie_match_stat() because you'll be comparing
   against an existing ce that was populated in a lossy way).

Then, replace the above partial assignment to st with a call to such
a helper function, which should live in statinfo.c next to
fill_stat_data() and whose function signature should look like

    void fill_stat_from_stat_data(struct stat *st, struct stat_data *sd);

You'd probably need to define two macros to update nsec part of c/mtime
members that is conditional near where ST_CTIME_NSEC() macro is
defined to write that reverse function of fill_stat_data(), perhaps
along the lines of ...

	#ifdef NO_NSEC
	#define FILL_ST_CTIME_NSEC(st, nsec) do { ; /* noop */ } while (0)
	#else
	#ifdef USE_ST_TIMESPEC
	#define FILL_ST_CTIME_NSEC(st, nsec) (st)->st_ctimespec.tv_nsec = (nsec)
	#else
	#define FILL_ST_CTIME_NSEC(st, nsec) (st)->st_ctim.tv_nsec = (nsec)
	#endif
	#endif


