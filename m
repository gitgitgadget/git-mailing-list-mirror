Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A1520450
	for <e@80x24.org>; Wed,  1 Nov 2017 04:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdKAEL5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 00:11:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54367 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750766AbdKAEL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 00:11:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C6B9BAD00;
        Wed,  1 Nov 2017 00:11:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k29Ek6JTfDZMM8Cd/7X10Q5HSI8=; b=O/ypyV
        chjBhQhKwfLHQSCF1AJm6TnRmRUcOjNSXrH4mXMsN+wUFkG8OVOqAjq3rXUqQpt9
        IH4/QpOMbEHphkbZZa7+gw3BtNLs50/SpFBffbBscRlVPaqIiJ4F9OWLUPOyyCHn
        0hRwtsk48+ugLdEcDuiigc5q1uFV2RNUu+mwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c6ntMEh9leWxJzXrR0cRgzkIghJ1ja1Z
        tSLID7EaZRBxXGkelOHDGUIoQd0pcKnSI1CQXpDVJ/qBqajt1R7Sj/0K6dvVFJij
        7DDW9cXLU7qLKFqIU2IlkgVW1vdLpcGFWHlNAkc7v59klBGoxmbDcnT34my+y35B
        8Zh8X63xzjg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 834F0BACFF;
        Wed,  1 Nov 2017 00:11:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2D27BACFE;
        Wed,  1 Nov 2017 00:11:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-7-sbeller@google.com>
Date:   Wed, 01 Nov 2017 13:11:53 +0900
In-Reply-To: <20171031211852.13001-7-sbeller@google.com> (Stefan Beller's
        message of "Tue, 31 Oct 2017 14:18:51 -0700")
Message-ID: <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBC71C5C-BEBA-11E7-BE70-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +If the given object refers to a blob, it will be described
> +as `<commit-ish>:<path>`, such that the blob can be found
> +at `<path>` in the `<commit-ish>`. Note, that the commit is likely

Does the code describe a9dbc3f12c as v2.15.0:GIT-VERSION-GEN, or
would it always be <commit>:<path>?

> +not the commit that introduced the blob, but the one that was found
> +first; to find the commit that introduced the blob, you need to find

Because we do not want to descend into the same tree object we saw
earlier, this "we show the name we happened to find first without
attempting to refine it for a better name" is a rather fundamental
limitation of this approach.  Hopefully we can later improve it with
more thought, but for now it is better than nothing (and much better
than "git log --raw | grep").

> +the commit that last touched the path, e.g.
> +`git log <commit-description> -- <path>`.
> +As blobs do not point at the commits they are contained in,
> +describing blobs is slow as we have to walk the whole graph.

Is it true that we walk the "whole graph", or do we stop immediately
we find a path to the blob?  The former makes it sound like
completely useless.

> -#define SEEN		(1u << 0)

Interesting.  Now we include revision.h this becomes redundant.

> +static void describe_blob(struct object_id oid, struct strbuf *dst)
> +{
> +	struct rev_info revs;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct process_commit_data pcd = { null_oid, oid, dst};
> +
> +	argv_array_pushl(&args, "internal: The first arg is not parsed",
> +		"--all", "--reflog", /* as many starting points as possible */

Interesting.  

Do we also search in the reflog in the normal "describe" operation?
If not, perhaps we should?  I wonder what's the performance
implications would be.

That tangent aside, as "describe blob" is most likely a "what
reaches and is holding onto this blob?" query, finding something
that can only be reached from a reflog entry would make it more
helpful than without the option.

> +		/* NEEDSWORK: --all is incompatible with worktrees for now: */

What's that last colon about?

> +		"--single-worktree",
> +		"--objects",
> +		"--in-commit-order",
> +		NULL);
> +
> +	init_revisions(&revs, NULL);
> +	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
> +		BUG("setup_revisions could not handle all args?");
> +
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
> +
> +	traverse_commit_list(&revs, process_commit, process_object, &pcd);
> +	reset_revision_walk();
> +}
> +

OK.

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 1c0e8659d9..3be01316e8 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -310,6 +310,21 @@ test_expect_success 'describe ignoring a borken submodule' '
>  	grep broken out
>  '
>  
> +test_expect_success 'describe a blob at a tag' '
> +	echo "make it a unique blob" >file &&
> +	git add file && git commit -m "content in file" &&
> +	git tag -a -m "latest annotated tag" unique-file &&
> +	git describe HEAD:file >actual &&
> +	echo "unique-file:file" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'describe a surviving blob' '
> +	git commit --allow-empty -m "empty commit" &&
> +	git describe HEAD:file >actual &&
> +	grep unique-file-1-g actual
> +'
> +

I am not sure what "surviving" means in this context.  The word
hinted that the test would be finding a blob that only appears in a
commit that only appears as a reflog entry, but that wasn't the
case, which was a bit disappointing.



