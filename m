Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AFF1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbdLLTDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:03:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53174 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752161AbdLLTDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:03:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12B6FBFCCE;
        Tue, 12 Dec 2017 14:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Neqv95tHaUoCdxqs1jqE4oc2YXQ=; b=XpeKmG
        j9B/XjK8pHdo/aF5Yuht3VVjnDP3CfO1zN/nyoulOns6JaHYIrvaT4b7WCEhtQvZ
        115DTwAzYFkptyMWmfzPHXKosh/FL/DEIHrZphgBWCZ2zOceJDnICmq7PrMcrOl2
        GexWhEbuO2kuJvMupgnDoXUpJmScdl46wAHO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sILoVG4jcDbGytvTb0FOZF3xlzywEOjL
        iPxpbaRBlqtIhgn6+vu+5SWPGHEeifJqD2hIiIff1oL5H7Nb1DwIEg5WwX7X3UPy
        m1pJeVXeMvZwcv3TJK1k6w8tloivMTJI2DdJVtRw7POKI9KC5+1ZhJKop7u0MPPg
        wOua0/o6zhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0962BBFCCC;
        Tue, 12 Dec 2017 14:03:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 748E2BFCCB;
        Tue, 12 Dec 2017 14:03:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v2 2/2] t: add tests for pull --verify-signatures
References: <20171209090530.6747-1-hji@dyntopia.com>
        <20171210065358.8156-1-hji@dyntopia.com>
        <20171210065358.8156-2-hji@dyntopia.com>
Date:   Tue, 12 Dec 2017 11:03:47 -0800
In-Reply-To: <20171210065358.8156-2-hji@dyntopia.com> (Hans Jerry Illikainen's
        message of "Sun, 10 Dec 2017 06:53:58 +0000")
Message-ID: <xmqqbmj33h0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F3C20C8-DF6F-11E7-AFB8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> +test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
> +	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
> +	test_i18ngrep "does not have a GPG signature" pullerror
> +'

Note that this is without "when-finished"; if 'git pull' got broken
and does not fail as expected, the next test will start from a state
that it is not expecting.  Same for the ones that run 'git pull'
under test_must_fail.

Interestingly, the tests that do expect 'git pull' to succeed
protect themselves with "when-finished" mechanism correctly [*1*],
like so:

> +test_expect_success GPG 'pull signed commit with --verify-signatures' '
> +	test_when_finished "git checkout initial" &&
> +	git pull --verify-signatures signed >pulloutput &&
> +	test_i18ngrep "has a good GPG signature" pulloutput
> +'
> +

Other than that, looked nicely done.  Thanks.


[Footnote]

*1* I am guessing that the branches that are being pulled in tests
    are designed in such a way to never produce merge conflicts, and
    failures are possible only due to signature verification.  If
    that were not the case, "when-finished" would want to do a hard
    reset before checking out the initial to go back to a known
    state.
