Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8B920899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdHBWof (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:44:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58916 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdHBWof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:44:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 922FB95B9F;
        Wed,  2 Aug 2017 18:44:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hNAEk+k5Z0w3TWXb5PT0oje9S2M=; b=ZLXsWk
        XyswAVp+mksn/ihbPy2iR8rt1cWch/YVZTCFdFN8Q2ki2VL9Cnfivjb71uMTFk5c
        d6hvvPGOCj30Inr325qtWEYFRAtAhyt+gqga7bVQ4PvxmWRDHawqNRf6FgRKiy1Y
        w0YsTioXYQlSJgwlojmNPPKf1gtfVQDwh/M5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mRRuLHZtF85QSpfHvWM3N66bZn8/nB9u
        42ureZqLZKhMKiey4InDjuU5217WLBdz5HEiEdDzSvAp9Sami9nvbOobe3ii7pDg
        8wcQRgoFW3mhyeWv3j+B9Qz/EqND/ZFjvtakRT4S4fpLz/k2V3NxKBHXkhZbkr3a
        Fh0OB53zzl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B22395B9E;
        Wed,  2 Aug 2017 18:44:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 058C395B9D;
        Wed,  2 Aug 2017 18:44:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] revision: do not fallback to default when rev_input_given is set
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
        <20170802223018.h2uabdpmtz3gw27g@sigill.intra.peff.net>
Date:   Wed, 02 Aug 2017 15:44:27 -0700
In-Reply-To: <20170802223018.h2uabdpmtz3gw27g@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 2 Aug 2017 18:30:19 -0400")
Message-ID: <xmqq8tj1r3n8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24AF6C30-77D4-11E7-A299-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If revs->def is set (as it is in "git log") and there are no
> pending objects after parsing the user's input, then we show
> whatever is in "def". But if the user _did_ ask for some
> input that just happened to be empty (e.g., "--glob" that
> does not match anything), showing the default revision is
> confusing. We should just show nothing, as that is what the
> user's request yielded.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The "!got_rev_arg" that's already in the conditional is interesting. I
> wondered if it could be subsumed by the rev_input_given flag. But
> digging in the history, I think it's mostly about doing reflog walks.
> Usually if we see a rev arg it will result either in an object added to
> the pending queue, or a fatal error. But empty reflogs are the
> exception. And since my other nearby series adds a separate check for
> "are we doing an empty reflog walk", I don't think it makes sense to
> tangle this up the new flag I'm adding here.

OK, I'll have to stare at possible merge conflicts to see if I like
this or some other design decision ;-)

This shows one of the reasons why I want consumers of revision
machinery not to be futzing these internal implementation detail
bits in the revs structure, by the way.

>  revision.c     | 2 +-
>  t/t4202-log.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 08d5806b8..ba2b166cd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2316,7 +2316,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		opt->tweak(revs, opt);
>  	if (revs->show_merge)
>  		prepare_show_merge(revs);
> -	if (revs->def && !revs->pending.nr && !got_rev_arg) {
> +	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
>  		struct object_id oid;
>  		struct object *object;
>  		struct object_context oc;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 3f3531f0a..36d120c96 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1523,6 +1523,12 @@ test_expect_success 'log diagnoses bogus HEAD' '
>  	test_i18ngrep broken stderr
>  '
>  
> +test_expect_success 'log does not default to HEAD when rev input is given' '
> +	>expect &&
> +	git log --branches=does-not-exist >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'set up --source tests' '
>  	git checkout --orphan source-a &&
>  	test_commit one &&
