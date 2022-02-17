Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB7AC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 23:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiBQXLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:11:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBQXL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 18:11:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB13525B
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 15:11:03 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B093110481F;
        Thu, 17 Feb 2022 18:10:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lLCF5y8lqZkEZt9IVlzHYomJJ4CWCO9Qw9ohGU
        v+s1g=; b=PcxtwapKtguEtCQfxyYIbFFZRen2aKbeR3e6wlgqME5+IFBm/RrLP7
        t0p4035drg7lYPB/W4xgajFIrLJOMBcnLzSAtq6JMDKKTDNjUqpk69lKIt2c1usC
        NXTqRPR7H1bb2nuxvtwkIIn/XObN9N20dZ9LV/1xXSMciQ5G7GGsE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A70CC10481E;
        Thu, 17 Feb 2022 18:10:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 182AE10481D;
        Thu, 17 Feb 2022 18:10:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: make informational messages from recursive
 merges clearer
References: <pull.1121.git.1645079923090.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 15:10:38 -0800
In-Reply-To: <pull.1121.git.1645079923090.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 17 Feb 2022 06:38:42
        +0000")
Message-ID: <xmqqsfsh5btd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D23FD54E-9046-11EC-974A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> This is another simple change with a long explanation...
>
> merge-recursive and merge-ort are both based on the same recursive idea:
> if there is more than one merge base, merge the merge bases (which may
> require first merging the merge bases of the merges bases, etc.).  The
> depth of the inner merge is recorded via a variable called "call_depth",
> which we'll bring up again later.  Naturally, the inner merges
> themselves can have conflicts and various messages generated about those
> files.
>
> merge-recursive immediately prints to stdout as it goes, at the risk of
> printing multiple conflict notices for the same path separated far apart
> from each other with many intervenining conflict notices for other paths
> between them.  And this is true even if there are no inner merges
> involved.  An example of this was given in [1] and apparently caused
> some confusion:
>
>     CONFLICT (rename/add): Rename A->B in HEAD. B added in otherbranch
>     ...dozens of conflicts for OTHER paths...
>     CONFLICT (content): Merge conflicts in B
>
> In contrast, merge-ort collects messages and stores them by path so that
> it can print them grouped by path.  Thus, the same case handled by
> merge-ort would have output of the form:
>
>     CONFLICT (rename/add): Rename A->B in HEAD. B added in otherbranch
>     CONFLICT (content): Merge conflicts in B
>     ...dozens of conflicts for OTHER paths...
>
> This is generally helpful, but does make a separate bug more
> problematic.  In particular, while merge-recursive might report the
> following for a recursive merge:
>
>       Auto-merging dir.c
>       Auto-merging midx.c
>       CONFLICT (content): Merge conflict in midx.c
>     Auto-merging diff.c
>     Auto-merging dir.c
>     CONFLICT (content): Merge conflict in dir.c
>
> merge-ort would instead report:
>
>     Auto-merging diff.c
>     Auto-merging dir.c
>     Auto-merging dir.c
>     CONFLICT (content): Merge conflict in dir.c
>     Auto-merging midx.c
>     CONFLICT (content): Merge conflict in midx.c
>
> The fact that messages for the same file are together is probably
> helpful in general, but with the indentation missing for the inner
> merge it unfortunately serves to confuse.  This probably would lead
> users to wonder:
>
>   * Why is Git reporting that "dir.c" is being merged twice?
>   * If midx.c has conflicts, why do I not see any when I open up the
>     file and why are no conflicts shown in the index?
>
> Fix this output confusion by changing the output to clearly
> differentiate the messages for outer merges from the ones for inner
> merges, changing the above output from merge-ort to:
>
>     Auto-merging diff.c
>       From inner merge:  Auto-merging dir.c
>     Auto-merging dir.c
>     CONFLICT (content): Merge conflict in dir.c
>       From inner merge:  Auto-merging midx.c
>       From inner merge:  CONFLICT (content): Merge conflict in midx.c
>
> (Note: the number of spaces after the 'From inner merge:' is
> 2*call_depth).

So "From inner merge: " label is what we get extra, compared to the
recursive one that just gives deeper leading-space indentation?

> One other thing to note here, that I didn't notice until typing up this
> commit message, is that merge-recursive does not print any messages from
> the inner merges by default; the extra verbosity has to be requested.
> merge-ort currently has no verbosity controls and always prints these.
> We may also want to change that, but for now, just make the output
> clearer with these extra markings and indentation.

Yup, I found that the messages on inner conflicts, especially when
they "cancel out" at the outer merge, are mostly noise that carries
very little useful information (by being noisy, the user gets a sense
of how complex the histories being merged are).  Reducing the default
messaging level would probably be a good idea.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1121%2Fnewren%2Fmerge-ort-clearer-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1121/newren/merge-ort-clearer-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1121
>
>  merge-ort.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index d85b1cd99e9..55decb2587e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -651,6 +651,11 @@ static void path_msg(struct merge_options *opt,
>  	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
>  
>  	va_start(ap, fmt);
> +	if (opt->priv->call_depth) {
> +		strbuf_addchars(dest, ' ', 2);
> +		strbuf_addstr(dest, "From inner merge:");
> +		strbuf_addchars(dest, ' ', opt->priv->call_depth * 2);

I am unsure if the long label adds much value, but I am perfectly OK
tostart from more verbose and see if people complain (or not).  This
is for human consumption and not meant to be machine parseable so we
can iterate.

Will queue.  Thanks.
