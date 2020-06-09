Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC30C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C491207C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc2Rv8z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgFIWwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:52:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58034 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 18:52:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58DF5C4C4C;
        Tue,  9 Jun 2020 18:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=69y9KFluzxj5iJ66lP7T+vqV2Ac=; b=bc2Rv8
        z7huvZ7H3vkGjSuOE2BJKViPO292IG1jDx/LsYsJPjdk+lqMrcQCFwbQi66ollws
        3oELR0j03eafXdXdyaeEXX2NaEvQCa9A5x60lKPZfjD0e+m9xU4l3WrHblTWRU+o
        o8v0QkT+KufzTWN/MohB6tcTj3yI9VPeJWSUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uxf9gAeAQczJpfAg6W9rKQ5rbGNeav0H
        zxEQnY+rq9fJiOFziwBojds+OtfPG+T4XCwYpUy2t9kFpSMjWBq0KVZrAV2isVfC
        fX9AUI1L815+MfsZSGKiIwnpm9IGT4dGyZ4fYdgWxSQWQIsaB6rYWCvGZ89LdnJL
        1uQkVkq+Pmw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50E52C4C4B;
        Tue,  9 Jun 2020 18:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B302C4C4A;
        Tue,  9 Jun 2020 18:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 2/3] git diff: improve A...B merge-base handling
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
        <100fa4034771e58b65cdac2f3dfb48531c07b735.1591729224.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 15:52:37 -0700
In-Reply-To: <100fa4034771e58b65cdac2f3dfb48531c07b735.1591729224.git.gitgitgadget@gmail.com>
        (Chris Torek via GitGitGadget's message of "Tue, 09 Jun 2020 19:00:22
        +0000")
Message-ID: <xmqqftb3hmx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB8338A0-AAA3-11EA-9B16-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
> +{
> +	int i, lcount = 0, rcount = 0, basecount = 0;
> +	int lpos = -1, rpos = -1, basepos = -1;
> +	struct bitmap *map = NULL;

The logic around rcount and rpos in this function still smells
fishy.  For example, rcount is counted up from 0 but its value is
never consulted, so we should be able to get rid of it.

For that matter, lcount and lpos look somewhat redundant.  lpos
begins with -1 to signal "have not seen any left end of symmetric
range yet", and we won't allow more than two symmetric ranges
anyway, so we should be able to get rid of lcount and base the error
condition purely on lpos by

 * when we see SYMMETRIC_LEFT, check if lpos is already non-negative,
   and die otherwise right there.  We don't need "if lcount != 1, die"
   after the loop.

 * after the loop, if lpos is still -1, we know we didn't see
   symmetric difference.

> +	/*
> +	 * Use the whence fields to find merge bases and left and
> +	 * right parts of symmetric difference, so that we do not
> +	 * depend on the order that revisions are parsed.  If there
> +	 * are any revs that aren't from these sources, we have a
> +	 * "git diff C A...B" or "git diff A...B C" case.  Or we
> +	 * could even get "git diff A...B C...E", for instance.
> +	 *
> +	 * If we don't have just one merge base, we pick one
> +	 * at random.
> +	 *
> +	 * NB: REV_CMD_LEFT, REV_CMD_RIGHT are also used for A..B,
> +	 * so we must check for SYMMETRIC_LEFT too.  The two arrays
> +	 * rev->pending.objects and rev->cmdline.rev are parallel.
> +	 */
> +	for (i = 0; i < rev->cmdline.nr; i++) {
> +		struct object *obj = rev->pending.objects[i].item;
> +		switch (rev->cmdline.rev[i].whence) {
> +		case REV_CMD_MERGE_BASE:
> +			if (basepos < 0)
> +				basepos = i;
> +			basecount++;
> +			break;		/* do mark all bases */
> +		case REV_CMD_LEFT:
> +			if (obj->flags & SYMMETRIC_LEFT) {
> +				lpos = i;
> +				lcount++;
> +				break;	/* do mark A */
> +			}
> +			continue;
> +		case REV_CMD_RIGHT:
> +			rpos = i;
> +			rcount++;
> +			continue;	/* don't mark B */

It is unclear if we want to allow "git diff A..B C..D" (or
alternatively "git diff A...B C..D") and if so why.  

It appears that you are allowing both, but I am not sure if that is
a good idea.  Read a bit further below.

> +		default:
> +			continue;
> +		}
> +		if (map == NULL)
> +			map = bitmap_new();
> +		bitmap_set(map, i);
> +	}
> +
> +	if (lcount == 0) {	/* not a symmetric difference */
> +		bitmap_free(map);
> +		sym->warn = 0;
> +		sym->skip = NULL;
> +		return;
> +	}
> +
> +	if (lcount != 1)
> +		die(_("cannot use more than one symmetric difference"));
> +
> +	if (basecount == 0) {
> +		const char *lname = rev->pending.objects[lpos].name;
> +		const char *rname = rev->pending.objects[rpos].name;
> +		die(_("%s...%s: no merge base"), lname, rname);

When "git diff A...B C..D" is given, what do we want to do?  A is
the only element marked with REV_CMD_LEFT, which is pointed at by
lpos and lcount gets incremented to become one.  When we see B, we
make rpos point at it, but then later, when we see D, wouldn't rpos
get updated to point at it?  What error message would we give when
we see no merge base then?  We would want to say the symdiff between
A and B has no merge bases, but wouldn't we end up mentioning D
instead of B?

> +	}
> +	bitmap_unset(map, basepos);	/* unmark the base we want */
> +	sym->base = basepos;
> +	sym->left = lpos;
> +	sym->right = rpos;
> +	sym->warn = basecount > 1;
> +	sym->skip = map;
> +}

> @@ -394,8 +494,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			die(_("invalid object '%s' given."), name);
>  		if (obj->type == OBJ_COMMIT)
>  			obj = &get_commit_tree(((struct commit *)obj))->object;
> -

Do not lose this blank line.  It does not make a difference to the
compiler, but it is semantically significant to human readers.

>  		if (obj->type == OBJ_TREE) {
> +			if (sdiff.skip && bitmap_get(sdiff.skip, i))
> +				continue;
>  			obj->flags |= flags;
>  			add_object_array(obj, name, &ent);
>  		} else if (obj->type == OBJ_BLOB) {

> diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
> new file mode 100755
> index 00000000000..7b5988933da
> --- /dev/null
> +++ b/t/t4068-diff-symmetric.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +...
> +test_expect_success setup '
> +	git commit --allow-empty -m A &&
> +	echo b >b &&
> +	git add b &&
> +	git commit -m B &&
> +	git checkout -b br1 HEAD^ &&
> +	echo c >c &&
> +	git add c &&
> +	git commit -m C &&
> +	git tag commit-C &&
> +	git merge -m D master &&
> +	git tag commit-D &&
> +	git checkout master &&
> +	git merge -m E commit-C &&
> +	git checkout -b br2 commit-C &&
> +	echo f >f &&
> +	git add f &&
> +	git commit -m F &&
> +	git checkout br1 &&
> +	git merge -m G br2 &&
> +	git checkout --orphan br3 &&
> +	git commit -m H
> +'
> +
> +test_expect_success 'diff with one merge base' '
> +	git diff commit-D...br1 >tmp &&
> +	tail -1 tmp >actual &&

Let's make sure we spell "tail -n 1" (same for "head -1" -> "head -n 1").
I know there are a handful of existing offenders, but that does not mean
it is OK to make things worse.

> +	echo +f >expect &&
> +	test_cmp expect actual
