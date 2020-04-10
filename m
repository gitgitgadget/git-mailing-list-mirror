Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82419C2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BC320768
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hDbWmtSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDJAuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:50:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 20:50:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 391E1BDCAF;
        Thu,  9 Apr 2020 20:50:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnCEbBqDnm/3KN6q0EUsTs7fyVI=; b=hDbWmt
        SrWAXtiL8dqSd77fqHwEN57NbYuBb5XKEGFN8sC8B25REJ0xORfaAMPwx9UcFgDT
        NTQUVLRGeM5WBzLnADXvouogag3tstRaW7f2GIY74Q0zYcpof82CKn+8jS+GKEan
        tJa9i3Z+9KGVZFf6M95NWiXitU5rDV9BIO4TI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tg+es7A4q7df4nlIplvM9XdI28BbSdp6
        oPlnYxbdJ49MxBgU3AJ+7Rh/c2n6lIN4WTEAKu7yEWjpKWkhioJDgXL6uezS8HKr
        p2w7OVZnzUp5YdY7btUDYh64vUPEnuOW6Y9V62jGTFzSl3wajhrzK2TPcbg0vV2T
        D/9sCTRZoOU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30AC3BDCAE;
        Thu,  9 Apr 2020 20:50:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77213BDCAC;
        Thu,  9 Apr 2020 20:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 17:50:17 -0700
In-Reply-To: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 09 Apr 2020 23:26:39
        +0000")
Message-ID: <xmqqimi8kvue.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 405A8270-7AC5-11EA-B62D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> While many users who intentionally create empty commits do not want them
> thrown away by a rebase, there are third-party tools that generate empty
> commits that a user might not want.  In the past, users have used rebase
> to get rid of such commits (a side-effect of the fact that the --apply
> backend is not currently capable of keeping them).  While such users
> could fire up an interactive rebase and just remove the lines
> corresponding to empty commits, that might be difficult if the
> third-party tool generates many of them.  Simplify this task for users
> by marking such lines with a suffix of " # empty" in the todo list.
>
> Suggested-by: Sami Boukortt <sami@boukortt.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     rebase -i: mark commits that begin empty in todo editor
>     
>     If this isn't enough, we could talk about resurrecting --no-keep-empty
>     (and making --keep-empty just exist to countermand an earlier
>     --no-keep-empty), but perhaps this is good enough?

This does look like an unsatisfying substitute for the real thing,
but perhaps looking for " # empty" and turning them a drop is simple
enough?  Emacs types may do something like

    C-x h C-u M-| 
    sed -e '/ # empty$/s/^pick /drop /'
    <RET>

and vi folks have something similar that begins with a ':'.

But it would not beat just being able to say "--no-keep-empty" (or
"--discard-empty"), would it?

On the other hand, even if there were "--discard-empty" available,
there may still be two classes of empty ones (e.g. ones that were
created by third-party tools, the others that were deliberately
empty) that the user may need and want to sift through, and for such 
a use case, the marking this patch does would be very valuable.

So, from that point of view, this may not be enough, but a "throw
away all" option is not enough, either.  We'd want to have both to
serve such users better.

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-757%2Fnewren%2Frebase-mark-empty-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-757/newren/rebase-mark-empty-v1
> Pull-Request: https://github.com/git/git/pull/757
>
>  Documentation/git-rebase.txt | 3 ++-
>  sequencer.c                  | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607f..8ab0558aca2 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -620,7 +620,8 @@ commits that started empty, though these are rare in practice.  It
>  also drops commits that become empty and has no option for controlling
>  this behavior.
>  
> -The merge backend keeps intentionally empty commits.  Similar to the
> +The merge backend keeps intentionally empty commits (though with -i
> +they are marked as empty in the todo list editor).  Similar to the
>  apply backend, by default the merge backend drops commits that become
>  empty unless -i/--interactive is specified (in which case it stops and
>  asks the user what to do).  The merge backend also has an
> diff --git a/sequencer.c b/sequencer.c
> index e528225e787..ce9fd27a878 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4656,6 +4656,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  			strbuf_addf(&buf, "%s %s %s", cmd_pick,
>  				    oid_to_hex(&commit->object.oid),
>  				    oneline.buf);
> +			if (is_empty)
> +				strbuf_addf(&buf, " %c empty",
> +					    comment_line_char);
>  
>  			FLEX_ALLOC_STR(entry, string, buf.buf);
>  			oidcpy(&entry->entry.oid, &commit->object.oid);
> @@ -4861,6 +4864,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  		strbuf_addf(out, "%s %s ", insn,
>  			    oid_to_hex(&commit->object.oid));
>  		pretty_print_commit(&pp, commit, out);
> +		if (is_empty)
> +			strbuf_addf(out, " %c empty", comment_line_char);
>  		strbuf_addch(out, '\n');
>  	}
>  	return 0;
>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
