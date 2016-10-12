Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98807215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbcJLV3y (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:29:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57213 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751959AbcJLV3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:29:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9AEF46989;
        Wed, 12 Oct 2016 17:29:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cY4nYPRHDhuZJS043zPkj54WdkU=; b=VQxu6C
        zfxTCLmfzlWucs7JmYXXYX+scdHXZo9BlFrf62Ai3KhXGMi7niz9GDI6TcMiCJ8Q
        Nw3zjuZDkO54zsDBXM5MMmZVQA2ki2nqRXccowyb0M5fKJwRM7V1AoonsXuhMI7h
        CvOXfavXqpX5LriwM8xqo1FAx65zctNPkB+jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OfJ4/gAClRa1i5BkGFJk2E0mGt280vqG
        9EqTYlmDKnuNgfLAdjlsp9mvB4ovdVF9iyacwyewREH7k2hb2PNqesiMIqZ8JCgA
        ZbxwxaYvDby615joHFuRB4Z9ycg+cnXTaoLIKtbeF03+Lm+yFo+qlGe7QY51OEZ8
        iAMc385W0m8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A00BD46988;
        Wed, 12 Oct 2016 17:29:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DF9946987;
        Wed, 12 Oct 2016 17:29:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stepan Kasal <kasal@ucw.cz>, John Keeping <john@keeping.me.uk>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge-base: handle --fork-point without reflog
References: <20161012103716.GA31533@ucw.cz>
        <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
        <20161012201040.pyrp6bktz3fgmqzn@sigill.intra.peff.net>
Date:   Wed, 12 Oct 2016 14:29:49 -0700
In-Reply-To: <20161012201040.pyrp6bktz3fgmqzn@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 12 Oct 2016 16:10:40 -0400")
Message-ID: <xmqqd1j52r3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0233D5CC-90C3-11E6-9A8D-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: merge-base: handle --fork-point without reflog
>
> The --fork-point option looks in the reflog to try to find
> where a derived branch forked from a base branch. However,
> if the reflog for the base branch is totally empty (as it
> commonly is right after cloning, which does not write a
> reflog entry), then our for_each_reflog call will not find
> any entries, and we will come up with no merge base, even
> though there may be one with the current tip of the base.
>
> We can fix this by just adding the current tip to
> our list of collected entries.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It would actually be correct to just unconditionally add the ref tip, as
> add_one_commit already drops duplicates. But it would only be necessary
> in other cases if you have a broken reflog which is missing the entry
> that moved us to the current tip.

Makes sense.  And doing conditionally is not much more work ;-)

Thanks.

>
>  builtin/merge-base.c  | 3 +++
>  t/t6010-merge-base.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index c0d1822..b572a37 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -173,6 +173,9 @@ static int handle_fork_point(int argc, const char **argv)
>  	revs.initial = 1;
>  	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
>  
> +	if (!revs.nr && !get_sha1(refname, sha1))
> +		add_one_commit(sha1, &revs);
> +
>  	for (i = 0; i < revs.nr; i++)
>  		revs.commit[i]->object.flags &= ~TMP_MARK;
>  
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index e0c5f44..31db7b5 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -260,6 +260,12 @@ test_expect_success 'using reflog to find the fork point' '
>  	test_cmp expect3 actual
>  '
>  
> +test_expect_success '--fork-point works with empty reflog' '
> +	git -c core.logallrefupdates=false branch no-reflog base &&
> +	git merge-base --fork-point no-reflog derived &&
> +	test_cmp expect3 actual
> +'
> +
>  test_expect_success 'merge-base --octopus --all for complex tree' '
>  	# Best common ancestor for JE, JAA and JDD is JC
>  	#             JE
