Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0152021B
	for <e@80x24.org>; Mon, 13 Nov 2017 05:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbdKMFQk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 00:16:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64928 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbdKMFQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 00:16:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38D7498E1E;
        Mon, 13 Nov 2017 00:16:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+nNrNb0re03CFZ1SVsH0gl8VZGE=; b=lX7AO0
        wehGMdDwVyhzJ0tuvPB0Mxz4/F0eE2dO0OMtOFuw6kO6zuURzHinl1wf/A8UI7G6
        imNU2Y6saV7tt9JQUReoa2AhEpe+R+jHlzi91qdBEc7p8AxiejWmlwRpKJlcD0NX
        Uz3KXiWo6Uz7NR5H/CQcVuvxn7Gu69gXvs/DM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AHstz6LWUbIkQ1koKgqxvrZLIR7q9LU7
        lru5/E73hhnIqzpEVLOINLXZ+U7tDWXCW8/rNkAOCuG9zQLxnp02DJTGG8M1sRCd
        5LOzATk1bGQOXakCf68WD/Uy1RAyhOHihxc2V/MH5vuotXcHyffAMb9CQc/ALf0n
        imqUU7FFPFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3084C98E1D;
        Mon, 13 Nov 2017 00:16:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3C4198E1B;
        Mon, 13 Nov 2017 00:16:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] sequencer: Warn when internal merge may be suboptimal due to renameLimit
References: <20171110173956.25105-1-newren@gmail.com>
        <20171110173956.25105-2-newren@gmail.com>
Date:   Mon, 13 Nov 2017 14:16:36 +0900
In-Reply-To: <20171110173956.25105-2-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 09:39:53 -0800")
Message-ID: <xmqqy3na92rv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2FDB654-C831-11E7-A037-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Subject: Re: [PATCH 1/4] sequencer: Warn when internal merge may be suboptimal due to renameLimit

Style: please downcase s/Warn/warn/ to fit this better in "shortlog --no-merges"
output.

> Having renamed files silently treated as deleted/modified conflicts
> instead of correctly resolving the renamed/modified case has caused lots
> of pain for some users.  Eventually, some of them figured out to set
> merge.renameLimit to something higher, but without feedback about what
> value it should have, they were just repeatedly guessing and retrying.

It would have been _much_ easier to read if you refrained from
stating the gripes more prominently than the source of the gripe
that you are fixing.  E.g.

	If one side of a merge have renamed more paths than
	merge.renamelimit since the sides diverged, the recursive
	merge strategy stops detecting renames and instead leaves
	these many paths as delete/modify conflicts, without warning
	what is going on and giving hints on how to tell Git that it
	is allowed to spend more cycles to detect renames.

perhaps.

The addition of a call to diff_warn_rename_limit looks quite
sensible.

Thanks.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index f2a10cc4f2..2b4cecb617 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -462,6 +462,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	if (is_rebase_i(opts) && clean <= 0)
>  		fputs(o.obuf.buf, stdout);
>  	strbuf_release(&o.obuf);
> +	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
>  	if (clean < 0)
>  		return clean;
