Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0A41F462
	for <e@80x24.org>; Fri, 26 Jul 2019 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfGZSUD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 14:20:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56030 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGZSUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 14:20:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E88B7826F;
        Fri, 26 Jul 2019 14:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aFfXYGQV4taTVXUsCegAayYubsM=; b=CAxWOI
        maIz9oyquKibJAM7j6A1fQ0RN/tTIrao+DMthXAJl+EjdhpBBFZq/bXcknw9OvE6
        KGFXhBPojWFZ1CQuZsxskyP/X0W9Y1wOXH1IueeauVkTgNHU5a8guvKN3oTMrViV
        RkZdzQ2VA7qEfWHTlhm8O3uuJ9xvLFjP3sK8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OX2MhYPURY7PCqW86haCQ4qURR0M93Mg
        KBguKwB05SVpjEhyR25vAeO9jTtRz3pXvb8ezQXyV8ZESdmoF/OXdgThNOFRmQST
        V+atMh3OvqifZt5BFOrSTl+Wd1mf2fvFkL14rg5N6Ls40LmXl2fz5rhVe1nvxGKM
        ao98Wn4jAx8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F27EB7826E;
        Fri, 26 Jul 2019 14:19:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 145717826D;
        Fri, 26 Jul 2019 14:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2] reset: unstage empty deleted ita files
References: <20190712150235.12633-1-vcnaik94@gmail.com>
        <20190726044806.2216-1-vcnaik94@gmail.com>
Date:   Fri, 26 Jul 2019 11:19:53 -0700
In-Reply-To: <20190726044806.2216-1-vcnaik94@gmail.com> (Varun Naik's message
        of "Thu, 25 Jul 2019 21:48:06 -0700")
Message-ID: <xmqqsgqsodyu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F85747CE-AFD1-11E9-81F6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> It is possible to delete a committed file from the index and then add it
> as intent-to-add. After `git reset HEAD`, the file should be identical
> in the index and HEAD. This patch provides the desired behavior even
> when the file is empty in the index.

The first and the second sentence describes what you want to achieve
concisely and sensibly.  There is a vast leap between them and the
last sentence.  What's missing is:

 - What goes wrong without this one-liner fix and how does the
   command make a wrong decision to leave the path 'empty' (in the
   new test) different from that of the tree of the HEAD?

 - How does the change help the machinery to make a right decision
   instead?

I had to briefly wonder if this change interacts with "reset -N" in
any way.  In that mode, we want to make sure that diff sees the
entries that are missing from the index that exist in the tree of
the HEAD, so that update_index_from_diff() can add them back to the
index as I-T-A entries.

Making I-T-A entries invisible in the index for the purpose of
running that diff would mean that they appear as removed, but it is
OK because we'll add them back as I-T-A entries anyway, so it all
evens out, I think.

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 26ef9a7bd0..47a088f4b7 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -163,6 +163,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>  	opt.format_callback_data = &intent_to_add;
>  	opt.flags.override_submodule_config = 1;
>  	opt.repo = the_repository;
> +	opt.ita_invisible_in_index = 1;
>  
>  	if (do_diff_cache(tree_oid, &opt))
>  		return 1;
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 97be0d968d..9f3854e8f0 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -566,4 +566,15 @@ test_expect_success 'reset --mixed sets up work tree' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'reset --mixed adds deleted intent-to-add file back to index' '
> +	echo "nonempty" >nonempty &&
> +	>empty &&
> +	git add nonempty empty &&
> +	git commit -m "create files to be deleted" &&
> +	git rm --cached nonempty empty &&
> +	git add -N nonempty empty &&
> +	git reset HEAD nonempty empty &&
> +	git diff --staged --exit-code

We are not testing if the "diff --staged" synonym (that is not even
in "git diff --help") behaves identically to "diff --cached" here
(if we wanted to do such a test, we should do so somewhere in t4xxx
series, not here), so let's spell it in the canonical form, like so:

	git diff --cached --exit-code HEAD

At this point, we have three paths (empty, nonempty and secondfile)
in the tree of the HEAD, and we just resetted the entries for the
first two paths in the index to match.  The 'secondfile' added, in
previous tests, is still there unchanged, and is not shown in the
diff output.  The 'new-file', added as I-T-A in previous tests, is
also still there unchanged, and is not shown in the diff output.

How does the internal do_diff_cache() behave differently before and
after this patch on 'empty' and 'nonempty'?  How does the difference
affect the final outcome of "git reset" operation?

 - without ita-is-invisible bit set, we end up comparing the mode
   and blob object name; for 'nonempty', HEAD records a blob object
   name for the non-empty content, but the index has an empty blob
   object name (with I-T-A bit set, but that does not participate in
   the diff operation at the level of diff-lib.c::do_oneway_diff())
   and are deemed "modified".  Even though we should say "deleted",
   the end result turns out to be the same---we restore from the
   tree of the HEAD.

 - however, for 'empty', we mistakenly end up saying "both are empty
   blobs, so no difference; nothing to be done", leaving the i-t-a
   entry in the index.

 - with ita-is-invisible bit set, both 'nonempty' and 'empty' are
   immediately marked as "deleted" in do_oneway_diff().  This causes
   both paths to be resurrected from the tree of the HEAD the same
   way.

With the above kind of analysis, a reader can fill in the leap in
the explanation between the second and the third sentence in the
proposed log message.  But we shouldn't force readers to make that
effort to understand how the patch was meant to improve things.

Thanks.

> +'
> +
>  test_done
