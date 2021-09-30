Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE3C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E6E61381
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 18:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbhI3SgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:36:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55358 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhI3SgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 14:36:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9D5A1490F3;
        Thu, 30 Sep 2021 14:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YLpg3y+UeK9zA0IT98Ea/psxFwKUBt3DOaq3pH
        S+OJw=; b=RGC1hxed3yIeI69WDnrZ1hsd4Yr4NoQaHpIHN/V1u8buOsZTdUMUO+
        MULTPfa9BbT03gtFFwOxP0TQ/AIE8kJhK35Tp02SJw84lWlhOccaCeGB4zYrchi6
        crOLdj8hK5G9ti4jssJ6lSVnXcmbhy+ysA27/EwNZGM06zZI1J678=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A23071490F2;
        Thu, 30 Sep 2021 14:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F10A51490EF;
        Thu, 30 Sep 2021 14:34:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/7] reset: behave correctly with sparse-checkout
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <65905bf4e001118e8b9ced95c1bcecbacb6334ac.1633013461.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 11:34:28 -0700
In-Reply-To: <65905bf4e001118e8b9ced95c1bcecbacb6334ac.1633013461.git.gitgitgadget@gmail.com>
        (Kevin Willford via GitGitGadget's message of "Thu, 30 Sep 2021
        14:50:55 +0000")
Message-ID: <xmqqpmspc3pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C7500B0-221D-11EC-848C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -127,12 +129,49 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>  		struct diff_options *opt, void *data)
>  {
>  	int i;
> +	int pos;
>  	int intent_to_add = *(int *)data;
>  
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filespec *one = q->queue[i]->one;
> +		struct diff_filespec *two = q->queue[i]->two;
>  		int is_missing = !(one->mode && !is_null_oid(&one->oid));
> +		int was_missing = !two->mode && is_null_oid(&two->oid);

Not a problem introduced by this patch per-se, but is_missing is a
counter-intuitive name for what the boolean wants to represent, I
think, which was brought in by b4b313f9 (reset: support "--mixed
--intent-to-add" mode, 2014-02-04).  Before the commit, we used to
say

 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
		if (one->mode && !is_null_sha1(one->sha1)) {
			... create ce out of one and add to the	index ...
		} else
 			remove_file_from_cache(one->path);
		...

i.e. "if one is not missing, create a ce and add it, otherwise
remove the path".

It should have been called "one_is_missing" if we wanted to
literally express the condition the code checked, but an even better
name would have been given after the intent of what the code wants
to do with the information.  If the resetted-to tree (that is what
'one' side of the comparison in diff_cache() is) has a valid blob,
we want it to be in the index, and otherwise, we do not want it in
the index.

Now, the patch makes things worse and I had to do the above digging
to see why the new code is even more confusing.  The 'two' side of
the comparison is what is in the to-be-corrected-by-reset index.
"was_missing" in contrast to "is_missing" makes it sound as if it
was the state before whatever "is_missing" tries to represent, but
that is not what is happening.  "is_missing" does not mean "the
entry is currently not there in the index", but "was_missing" does
mean exactly that: "the entry is currently not there in the index".

There isn't any "was" missing about it.  It "is" missing in the
index.  Instead of renaming, I wonder if we can do without this new
variable.  Let's read on the patch.

Also, now the code uses both sides of the filepair, we must double
check that our do_diff_cache() is *not* doing any rename detection.
It might be even prudent to ensure that 

	if (strcmp(one->path, two->path))
		BUG("reset drove diff-cache with rename detection");

but it might be with too much paranoia.  I dunno.

>  		struct cache_entry *ce;
> +		struct cache_entry *ce_before;
> +		struct checkout state = CHECKOUT_INIT;

These two new variables do not need this wide a scope, I would
think.  Shouldn't it be inside the body of the new "if" statement
this patch adds?

> +		/*
> +		 * When using the sparse-checkout feature the cache entries
> +		 * that are added here will not have the skip-worktree bit
> +		 * set. Without this code there is data that is lost because
> +		 * the files that would normally be in the working directory
> +		 * are not there and show as deleted for the next status.
> +		 * In the case of added files, they just disappear.
> +		 *
> +		 * We need to create the previous version of the files in
> +		 * the working directory so that they will have the right
> +		 * content and the next status call will show modified or
> +		 * untracked files correctly.
> +		 */
> +		if (core_apply_sparse_checkout && !file_exists(two->path)) {

In a sparsely checked out working tree, there is nothing in the
working tree at the path.  It may be because it is sparse and we
didn't want to have anything there, or it may be because the user
wanted to get rid of it and said "rm path" (not "git rm path") and
this part of the tree were of interest even if the sparse checkout
feature was used to hide other parts of the tree.  With the above
two checks alone, we cannot tell which.  Let's read on.

> +			pos = cache_name_pos(two->path, strlen(two->path));

We check the index to see if there is an entry for it.  I suspect
that because we need to do this check anyway, we shouldn't even have
to look at 'two' (and add a new 'was_missing' variable), because
'one' and 'two' came from a comparison between the resetted-to tree
object and the current index, and if cache_name_pos() for the path
(we can use 'one->path') says there is an entry in the index, by
definition, 'two' would not be showing a "removed" state (i.e. "the
resetted-to tree had it, the index does not" is what "was_missing"
wants to say).

So I wonder if it is better to

 - use one->path for !file_exists() above and cache_name_pos() here
   instead of two->path.

 - drop the confusingly named 'was_missing', because (pos < 0) is
   equivalent to it after this point, and we didn't need it up to
   this point.

> +			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&

And we do find an entry for it.  So this path is not something
sparse cone specifies not to check out (otherwise we would have a
tree-like entry that covers this path in the index and not an entry
for this specific path)?

Anyway, if it is marked with the skip-worktree bit, does that mean
there is no risk that the reason why two->path does not exist in the
working tree is because we earlier gave it in the working tree but
it was later removed by the user?  Just making sure that we are not
breaking the end-user's wish that the path should be removed by
resurrecting it in the working tree with a new call to
checkout_entry().

> +			    (is_missing || !was_missing)) {

And in such a case, if the resetted-to tree says we shouldn't have
the path in the resulting index, or if the original state in the
index had this path (but because (0 <= pos) must be true for us to 
reach this point, I am not sure if "was_missing" can ever be true
here), then do the following, which is ...

> +				state.force = 1;
> +				state.refresh_cache = 1;
> +				state.istate = &the_index;
> +
> +				ce_before = make_cache_entry(&the_index, two->mode,
> +							     &two->oid, two->path,
> +							     0, 0);
> +				if (!ce_before)
> +					die(_("make_cache_entry failed for path '%s'"),
> +						two->path);
> +
> +				checkout_entry(ce_before, &state, NULL, NULL);

... to resurrect the last "git add"ed state from the index and write
it out to the working tree.  As I suspected, ce_before and state
should be scoped inside this block and not visible outside, no?

I am not sure why this behaviour is desirable.  The "mixed" reset
should not have to touch the working tree in the first place.

The large comment before this block says "... will not have the
skip-worktree bit set", but we are dealing with a case where the
original index had a cache entry there with skip-worktree bit set,
so isn't the more desirable outcome that the cache entry added back
to the index has the skip-worktree bit still set and there is no
working tree file that the user did not desire to have?

And isn't it the matter of preserving the skip-worktree bit when the
code in the post context of this hunk this patch did not touch adds
the entry back to the index?

> +			}
> +		}
>  
>  		if (is_missing && !intent_to_add) {
>  			remove_file_from_cache(one->path);

If we look at the code after this point, we do use "is_missing"
information to tweak ce->ce_flags with the intent-to-add bit.

Perhaps we can do a similar tweak to the cache entry to mark it with
skip-worktree bit if the index had a cache entry at the path with
the bit set?  The code that needs to do so would only have to
remember if the one->path is in the current index and the cache
entry for the path has the skip-worktree bit in the body of the new
if() statement about (core_apply_sparse_checkout && !file_exists())
added by this patch (I am not sure if !file_exists() even matters,
though, as the approach I am suggesting is to preserve the skip bit
and not disturb the working tree files at all).

Thanks.




