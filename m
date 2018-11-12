Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251611F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 10:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeKLUED (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 15:04:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64124 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLUED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 15:04:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BEFC10486B;
        Mon, 12 Nov 2018 05:11:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RltgMalWWIdjrXkUiIkbL84WP2M=; b=H+dWRK
        MDRC8qMnQQi8rQvRrSAusQM9aXopV9ub0xVDBpt5vvSUygGAwlwrLZoJgijmRApx
        QzsmqvZVrdFPtf25/NuvB+0xPJjsgkHqpIZN/UpWrSi6z9kTBdLy5IIfbMTQZ7MD
        6tMaTWoig77TzAAGHUexJlJ5VGBczxRYsZ2XU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k7OsrGm0tokZmW7tAf5OivykY5hLaZGz
        XZftuyVkfFMnIZYDnZ4Q9iGBONcgrQmr15H0EuJNBZ7ckudp4+dwSOyhhcabudb6
        L4CyXbR5ZctG6rtNCogqBS37xiUenqQtRTPxmDvchXH9+DBz3XNLDGuEtqpQfdBH
        IqGEkYVamBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6284710486A;
        Mon, 12 Nov 2018 05:11:25 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7A61104867;
        Mon, 12 Nov 2018 05:11:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     rafa.almas@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
References: <20180927204049.GA2628@rigel>
        <20181111235831.44824-1-nbelakovski@gmail.com>
        <20181111235831.44824-2-nbelakovski@gmail.com>
Date:   Mon, 12 Nov 2018 19:11:23 +0900
In-Reply-To: <20181111235831.44824-2-nbelakovski@gmail.com> (nbelakovski's
        message of "Sun, 11 Nov 2018 15:58:30 -0800")
Message-ID: <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FB67ED8-E663-11E8-BAB0-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

>  
> +static int worktree_head_atom_parser(const struct ref_format *format,
> +									 struct used_atom *atom,
> +									 const char *arg,
> +									 struct strbuf *unused_err)

This and ...

> +{
> +	struct worktree **worktrees = get_worktrees(0);
> +	int i;
> +
> +	string_list_init(&atom->u.worktree_heads, 1);
> +
> +	for (i = 0; worktrees[i]; i++) {
> +		if (worktrees[i]->head_ref)
> +			string_list_append(&atom->u.worktree_heads,
> +							   worktrees[i]->head_ref);

... this makes me suspect that you are using tabstop != 8 and that
is causing you to indent these lines overly deeply.

Please don't, while working on this codebase.


> +	}
> +
> +	string_list_sort(&atom->u.worktree_heads);
> +
> +	free_worktrees(worktrees);
> +	return 0;
> +}

So..., this function collects any and all branches that are checked
out in some worktree, and sort them _without_ dedup.  The user of
the resulting information (i.e. atom->u.worktree_heads) cannot tell
where each of the listed branches is checked out.

I wonder if "The worktree at /local/src/wt1 has this branch checked
out" is something the user of %(worktree) atom, or a variant thereof
e.g. "%(worktree:detailed)", may want to learn, but because that
information is lost when this function returns, such an enhancement
cannot be done without fixing this funciton.

Also, I am not sure if this "list of some info on worktrees" really
belongs to an individual atom.  For one thing, if a format includes
more than one instance of %(worktree) atoms, you'd iterate over the
worktrees as many times as the number of these atoms you have.  Is
there another existing atom that "caches" expensive piece of
information per used_atom[] element like this one?  Essentially I am
trying to convince myself that the approach taken by the patch is a
sane one by finding a precedent.

> +		} else if (!strcmp(name, "worktree")) {
> +			if (string_list_has_string(&atom->u.worktree_heads, ref->refname))

I thought we were moving towards killing the use of string_list as a
look-up table, as we do not want to see thoughtless copy&paste such
a code from parts of the code that are not performance critical to a
part.  Not very satisfying.

	I think we can let this pass, and later add a wrapper around
	hashmap that is meant to only be used to replace string-list
	used for this exact purpose, i.e. key is a string, and there
	is no need to iterate over the existing elements in any
	sorted order.  Optionally, we can limit the look up to only
	checking for existence, if it makes the code for the wrapper
	simpler.

> +				v->s = xstrdup("+");
> +			else
> +				v->s = xstrdup(" ");
> +			continue;
>  		} else if (starts_with(name, "align")) {
>  			v->handler = align_atom_handler;
>  			v->s = xstrdup("");
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fc067ed672..5e6d249d4c 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
>  	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
>  '
>  
> +test_expect_success '"add" a worktree' '
> +	mkdir worktree_dir &&
> +	git worktree add -b master_worktree worktree_dir master
> +'
> +
> +test_expect_success 'validate worktree atom' '
> +	cat >expect <<-\EOF &&
> +	master: checked out in a worktree
> +	master_worktree: checked out in a worktree
> +	side: not checked out in a worktree

As you started the here-doc with <<-, the next line EOF does not
have to be flushed to the left.  Indent it just the same way with a
tab.

> +EOF

The following line begins with a broken indentation, it seems.

> +    git for-each-ref --format="%(refname:short): %(if)%(worktree)%(then)checked out in a worktree%(else)not checked out in a worktree%(end)" refs/heads/ >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
