Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158E920985
	for <e@80x24.org>; Tue, 13 Sep 2016 22:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756789AbcIMWe7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:34:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50750 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755700AbcIMWe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F4E53EA76;
        Tue, 13 Sep 2016 18:34:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2b0Md1A/5FYkHdXhKEpnTiNLeBk=; b=KO0G0hTILSQwkNl9QYjy
        gyutiB0R9SEn052Qyk3BfX6hhaVCFikVKntJbnEgAydwpJqdNQBId3N/x+SAzgtf
        shWpd4Jb4gZfJ+VboS5h1M/qZJ5J6NxTsl2nDe2yRgMQ8FXIyiJNQtbiC4wfMNdu
        CAbgCcOrxb0l9huM3mqlUWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=d7+6e/2PrG5Pr8GtlKe9joYGvtbhZciGMmoG1/1nF5MVsH
        gfG5tZCMTKzxt9P7btyl1euoPvHrZaXWYc9REg2cxQFPmO3IorjSzsVh2iqf3AnG
        luCfXKFgJEaFmKEhE6LsVYBatYq7wTjQCkcDG0U7P1veftsuJkFUvK488xswY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8825D3EA75;
        Tue, 13 Sep 2016 18:34:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D249B3EA74;
        Tue, 13 Sep 2016 18:34:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <20160913142628.15440-1-benpeart@microsoft.com>
Date:   Tue, 13 Sep 2016 15:34:53 -0700
Message-ID: <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BA14DDE-7A02-11E6-B862-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> +static int needs_working_tree_merge(const struct checkout_opts *opts,
> +	const struct branch_info *old,
> +	const struct branch_info *new)
> +{
> +...
> +}

I do not think I need to repeat the same remarks on the conditions
in this helper, which hasn't changed since v2.  Many "comments" in
the code do not explain why skipping is justified, or what they
claim to check looks to me just plain wrong.

For example, there is

       /*
        * If we're not creating a new branch, by definition we're changing
        * the existing one so need to do the merge
        */
       if (!opts->new_branch)
               return 1;
	
but "git checkout" (no other argument) hits this condition.  It
disables the most trivial optimization opportunity, because we are
not "creating".

"By definition, we're changing"?  Really?  Not quite.

If you disable this bogus check, "git checkout" (no other argument)
would be allowed to skip the merge_working_tree(), and that in turn
reveals another case that the helper is not checking when
unpack_trees() MUST be called.

    Note: namely, when sparse checkout is in effect, switching from
    HEAD to HEAD can nuke existing working tree files outside the
    sparse pattern -- YUCK!  See penultimate test in t1011 for
    an example.

This yuckiness is not your fault, but needs_working_tree_merge()
logic you added needs to refrain from skipping unpack_trees() call
when sparse thing is in effect.  I'd expect "git checkout -b foo"
instead of "git checkout" (no other argument) would fail to honor
the sparse thing and reveal this bug, because the above bogus
"!opts->new_branch" check will not protect you for that case.

In other words, these random series of "if (...) return 1" are bugs
hiding other real bugs and we need to reason about which ones are
bugs that are hiding what other bugs that are not covered by this
function.  As Peff said earlier for v1, this is still an unreadable
mess.  We need to figure out a way to make sure we are skipping on
the right condition and not accidentally hiding a bug of failing to
check the right condition.  I offhand do not have a good suggestion
on this; sorry.

>  static int merge_working_tree(const struct checkout_opts *opts,
>  			      struct branch_info *old,
>  			      struct branch_info *new,
>  			      int *writeout_error)
>  {
> +	/*
> +	 * Optimize the performance of "git checkout -b foo" by avoiding
> +	 * the expensive merge, index and working directory updates if they
> +	 * are not needed.
> +	 */
> +	if (!needs_working_tree_merge(opts, old, new))
> +		return 0;
> +
>  	int ret;
>  	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));

With the change you made at the beginning of this function, it no
longer compiles with -Wdecl-after-stmt, but that is the smallest of
the problems.

It is a small step in the right direction to move the call to the
helper from the caller to this function, but it is a bit too small.

Notice that the lines after the above context look like this:

	hold_locked_index(lock_file, 1);
	if (read_cache_preload(NULL) < 0)
		return error(_("index file corrupt"));

	resolve_undo_clear();
	if (opts->force) {
		ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
		if (ret)
			return ret;
	} else {
		struct tree_desc trees[2];
		...

I would have expected that the check goes inside the "else" thing
that actually does a two-tree merge, and the helper loses the check
with opts->force, at least.  That would still be a change smaller
than desired, but at least a meaningful improvement compared to the
previous one.  As I have already pointed out, in the "else" clause
there is a check "is the index free of conflicted entries? if so
error out", and that must be honored in !opt->force case, no matter
what your needs_working_tree_merge() says.  I also was hoping that
you would notice, when you were told about the unmerged check, by
reading the remainder of the merge_working_tree(), that we need to
call show_local_changes() when we are not doing force and when we
are not quiet---returning early like the above patch will never be
able to call that one downstream in the function.

Regardless of what the actual checks end up to be, the right place
to do this "optimization" would look more like:

 builtin/checkout.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b50a49..a6b9e17 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -508,14 +508,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			topts.dir->flags |= DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
 		}
+
+		if ( we know we can skip the unpack ) {
+			ret = 0;
+		} else {
 			tree = parse_tree_indirect(old->commit ?
 						   old->commit->object.oid.hash :
 						   EMPTY_TREE_SHA1_BIN);
 			init_tree_desc(&trees[0], tree->buffer, tree->size);
 			tree = parse_tree_indirect(new->commit->object.oid.hash);
 			init_tree_desc(&trees[1], tree->buffer, tree->size);
-
 			ret = unpack_trees(2, trees, &topts);
+		}
+
 		if (ret == -1) {
 			/*
 			 * Unpack couldn't do a trivial merge; either

I'd think.  Note that the determination of "we can skip" would
involve knowing the object names of the two trees involved, so for
performance reasons, some of the parse-tree calls may have to come
before the call to "do we know we can skip?", but that does not
fundamentally change the basic code structure.

Thanks.
