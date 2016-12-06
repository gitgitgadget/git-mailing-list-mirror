Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603C71FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 19:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbcLFTUZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 14:20:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56876 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752984AbcLFTUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 14:20:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DED5F54D97;
        Tue,  6 Dec 2016 14:20:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dDkvL+O8kBHKvhlSwoiyVQlFxkU=; b=yG/Ihc
        nRBpQKUlONLp5keP6krewpLctxztsJSWlvgCJolGnLZ1Amrq1baStnY95hEqbkwp
        8UJgm1QtVwaI/cbpWmo4+VK5MBhe8qIHpZovCZk+aNuOy4e2KGWNSAM6TjJi3TmS
        H8r//eKBL3FTl80XN3mzBqh2PbEH7zaS314og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LfU2tyboCDR7ZUweJEF4KJz25cK5p6tw
        pttywwtcw5EjkvI6KtUNRU1P0nztRcEeovwTT/quseL7Gl7kQhw7VpeKSOyWPF3q
        ZVque78KS/R/XrOt6UelIp8d8CgO/L366e5+pPoHuuUjonxVPzi0wKrl7yAaPFI2
        W43PaTfjbkU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9FD854D95;
        Tue,  6 Dec 2016 14:20:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32D4854D94;
        Tue,  6 Dec 2016 14:20:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew Patey <matthew.patey2167@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
        <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
        <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
        <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
        <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 11:20:18 -0800
In-Reply-To: <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 10:41:21 -0500")
Message-ID: <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0719A2DC-BBE9-11E6-AF91-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If you run:
>> 
>>   git -c diff.renames=false stash
>> 
>> then it works.
>
> And here's a patch to fix it.

Yuck.  This obviously has easier to bite more people since we
enabled the renames by default.  Thanks for a quick fix.

I wonder why we are using "git diff" here, not the plumbing,
though.

>
> -- >8 --
> Subject: [PATCH] stash: disable renames when calling git-diff
>
> When creating a stash, we need to look at the diff between
> the working tree and HEAD. There's no plumbing command that
> covers this case, so we do so by calling the git-diff
> porcelain. This means we also inherit the usual list of
> porcelain options, which can impact the output in confusing
> ways.
>
> There's at least one known problem: --name-only will not
> mention the source side of a rename, meaning that we will
> fail to stash a deletion in such a case.
>
> The correct solution is to move to an appropriate plumbing
> command. But since there isn't one available, in the short
> term we can plug this particular problem by manually asking
> git-diff not to respect renames.
>
> Reported-by: Matthew Patey <matthew.patey2167@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> There may be other similar problems lurking depending on the various
> config options you have set, but I don't think so. Most of the options
> only affect --patch output.
>
> I do find it interesting that --name-only does not mention the source
> side of a rename. The longer forms like --name-status mention both
> sides. Certainly --name-status does not have any way of saying "this is
> the source side of a rename", but I'd think it would simply mention both
> sides. Anyway, even if that were changed (which would fix this bug), I
> think adding --no-renames is still a good thing to be doing here.
>
>  git-stash.sh     | 2 +-
>  t/t3903-stash.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 4546abaae..40ab2710e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -115,7 +115,7 @@ create_stash () {
>  			git read-tree --index-output="$TMPindex" -m $i_tree &&
>  			GIT_INDEX_FILE="$TMPindex" &&
>  			export GIT_INDEX_FILE &&
> -			git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
> +			git diff --name-only -z --no-renames HEAD -- >"$TMP-stagenames" &&
>  			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
>  			git write-tree &&
>  			rm -f "$TMPindex"
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index e1a6ccc00..2de3e18ce 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -766,4 +766,13 @@ test_expect_success 'stash list --cc shows combined diff' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'stash is not confused by partial renames' '
> +	mv file renamed &&
> +	git add renamed &&
> +	git stash &&
> +	git stash apply &&
> +	test_path_is_file renamed &&
> +	test_path_is_missing file
> +'
> +
>  test_done
