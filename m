Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1EC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 01:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiISBLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISBLd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 21:11:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0961839A
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 18:11:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25CEE148F03;
        Sun, 18 Sep 2022 21:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1sUjjAs5EU1AWdXqbG9UIuyPxi68b1TA8WQs/2
        T/OrA=; b=MQ8WX1MJkcFc9UGwmhQZHzFLdWFTPpzqChABFcYK/2xkVnnS0kIueu
        NpRDKEx5+QLj3AyWAyRcLOjwHqSoRkEldf+L2t8PxCBulMMSr9qg4WeeJESuqswV
        XYw7yV8nmjjUovZ5saDOzECjMtZ03tpjTBGJmQlyyoG+lBIR+KhQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C056148F02;
        Sun, 18 Sep 2022 21:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 823D4148F00;
        Sun, 18 Sep 2022 21:11:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <YyZWDkZWAkS7q+Wf@gmail.com>
        <20220918121053.880225-1-aclopte@gmail.com>
Date:   Sun, 18 Sep 2022 18:11:24 -0700
In-Reply-To: <20220918121053.880225-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Sun, 18 Sep 2022 07:10:53 -0500")
Message-ID: <xmqqh714dv7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB731110-37B7-11ED-896F-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> First, OID matches are given precedence over subject prefix
> matches.  Second, instead of prefix-matching OIDs, we use
> lookup_commit_reference_by_name().  This means that if 012345 is a
> branch name, we will apply the fixup commit to the tip of that branch
> (if that is present in the todo list).

Good finding.

I think that both are results from imprecise conversion from the
original done carelessly.  A rewrite does not necessarily have to be
bug-to-bug equivalent, and the precedence between object names vs
subject prefix is something I think does not have to be kept the
same as the original (in other words, a user who gives a token after
"fixup" that is ambiguous between the two deserves whatever the
implementation happens to give).  But use of _by_name() that does
not limit the input to hexadecimal _is_ a problem exactly for the
reason why we have this discussion thread.  The function accepts
more than we want to accept, and anybody who reads the original
commit 68d5d03b (rebase: teach --autosquash to match on sha1 in
addition to message, 2010-11-04) and understands why we added it
wouldn't have used it.

Your solution looks somewhat surprising to me, as I would naively
have thought to fix the use of _by_name() and limit its use only
when the input token is all hexadecimal, or something.  I'd need to
think more to convince myself why this is the right solution.

Thanks.

> Demonstrate both behavior changes by adding two test cases for
> "fixup! foo" where foo is a commit-ish that is not an OID-prefix.
> Arguably, this feature is very weird.  If no one uses it we should
> consider removing it.
>
> Regardless, there is one bad edge case to fix.  Let refspec "foo" point
> to a commit with the subject "fixup! foo". Since rebase --autosquash
> finds the fixup target via lookup_commit_reference_by_name(), the
> fixup target is the fixup commit itself. Obviously this can't work.
> We proceed with the broken invariant and drop the fixup commit
> entirely.
>
> The self-fixup was only allowed because the fixup commit was already
> added to the preliminary todo list, which it shouldn't be.  Rather,
> we should first compute the fixup target and only then add the fixup
> commit to the todo list. Make it so, avoiding this error by design,
> and add a third test for this case.
>
> Reported-by: Erik Cervin Edin <erik@cervined.in>
> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> ---
>  sequencer.c                  |  4 ++--
>  t/t3415-rebase-autosquash.sh | 44 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 484ca9aa50..777200a6dc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6287,8 +6287,6 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  			return error(_("the script was already rearranged."));
>  		}
>  
> -		*commit_todo_item_at(&commit_todo, item->commit) = item;
> -
>  		parse_commit(item->commit);
>  		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
>  		find_commit_subject(commit_buffer, &subject);
> @@ -6355,6 +6353,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  					strhash(entry->subject));
>  			hashmap_put(&subject2item, &entry->entry);
>  		}
> +
> +		*commit_todo_item_at(&commit_todo, item->commit) = item;
>  	}
>  
>  	if (rearranged) {
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 78c27496d6..879e628512 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -232,6 +232,50 @@ test_expect_success 'auto squash that matches longer sha1' '
>  	test_line_count = 1 actual
>  '
>  
> +test_expect_success 'auto squash that matches regex' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "hay needle hay" &&
> +	git commit --allow-empty -m "fixup! :/[n]eedle" &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH hay needle hay # empty
> +	fixup HASH fixup! :/[n]eedle # empty
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'auto squash of fixup commit that matches branch name' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "wip commit (just a prefix match so overshadowed by branch)" &&
> +	git commit --allow-empty -m "tip of wip" &&
> +	git branch wip &&
> +	git commit --allow-empty -m "unrelated commit" &&
> +	git commit --allow-empty -m "fixup! wip" &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH wip commit (just a prefix match so overshadowed by branch) # empty
> +	pick HASH tip of wip # empty
> +	fixup HASH fixup! wip # empty
> +	pick HASH unrelated commit # empty
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'auto squash of fixup commit that matches branch name which points back to fixup commit' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "fixup! self-cycle" &&
> +	git branch self-cycle &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH second commit
> +	pick HASH fixup! self-cycle # empty
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_auto_commit_flags () {
>  	git reset --hard base &&
>  	echo 1 >file1 &&
