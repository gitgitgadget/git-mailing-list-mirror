Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC8C433E5
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D8520775
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u9Yh4ILt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgG0RSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:18:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51507 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG0RSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 13:18:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E78E36D1A5;
        Mon, 27 Jul 2020 13:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7YN3zC4yZ8IUVL7UXbL9uvtotLc=; b=u9Yh4I
        Lt/pE+t/rOrxKsPDC8DZq9ogucWae/aoZ+YR68JwbGxW2ZvFYGFLkZ6tzEmTJqQE
        YkDEmKnoOd8IRXTkt2P34v2LwtylD25pIFUVRQ2O7SfahwCL/1WEHipR0P0O4mwb
        h+wNAtqu6BuvquyTyX3xEgNNQFx+RlCHXun/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vpX/FdkvrWoXy/5Qu2lk6cAy3YOivVZY
        2FQUaQmXoAPY8KFg+KO3IlCSdudBaEGHkG2WPOswy924glsztggcSeMNwBvWK6pu
        L0x0Qwqz7T69ryH+JrkK/fvPyx+CyRoSOh6eCAlolxKKB5bX0ENAFwdrbhqBT1Ii
        XXlylckacUw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF6E46D1A4;
        Mon, 27 Jul 2020 13:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 682576D1A3;
        Mon, 27 Jul 2020 13:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Anders Waldenborg <anders@0x63.nu>
Subject: Re: Questions about trailer configuration semantics
References: <87blk0rjob.fsf@0x63.nu>
Date:   Mon, 27 Jul 2020 10:18:39 -0700
In-Reply-To: <87blk0rjob.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 27
        Jul 2020 18:45:24 +0200")
Message-ID: <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3714F1BA-D02D-11EA-ABA6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Redirecting it to the resident expert of the trailers]

Anders Waldenborg <anders@0x63.nu> writes:

> I noticed some undocumented and (at least to me) surprising behavior in
> trailers.c.
>
> When configuring a value in trailer.<token>.key it causes the trailer to
> be normalized to that in "git interpret-trailers --parse".
> E.g:
>  $ printf '\naCKed: Zz\n' | \
>    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
>  will emit: "Acked: Zz"
>
> but only if "key" is used, other config options doesn't cause it to be
> normalized.
> E.g:
>  $ printf '\naCKed: Zz\n' | \
>    git -c 'trailer.Acked.ifmissing=doNothing' interpret-trailers --parse
>  will emit: "aCKed: Zz" (still lowercase a and uppercase CK)
>
>
> Then there is the replacement by config "trailer.fix.key=Fixes" which
> expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
> which seems to be expected and useful behavior (albeit a bit unclear in
> documentation). But it also happens when parsing incoming trailers, e.g
> with that config
>  $ printf "\nFix: 1\n" | git interpret-trailers --parse
>  will emit: "Fixes: 1"
>
> (token_from_item prefers order .key, incoming token, .name)
>
>
> The most surprising thing is that it uses prefix matching when finding
> they key in configuration. If I have "trailer.reviewed.key=Reviewed-By"
> it is possible to just '--trailer r=XYZ' and it will find the
> reviewed-by trailer as "r" is a prefix of reviewedby. This also applies
> to the "--parse". This in makes it impossible to have trailer keys that
> are prefix of each other (e.g: "Acked", "Acked-Tests", "Acked-Docs") if
> there is multiple matching in configuration it will just pick the one
> that happens to come first.
>
> (token_matches_item uses strncasecmp with token length)
>
>
> I guess these are the questions for the above observations:
>
> * Should normalization of spelling happen at all?
>
> * If so should it only happen when there is a .key config?
>
> * Should replacement to what is in .key happen also in --parse mode, or
>   only for "--trailer"
>
> * The prefix matching gotta be a bug, right?
>
>
>
> Here is a patch to the tests showing these things.
>
>
>
> From 49a4bb64a7ebf1f2d50897a024deb86b4f8056b1 Mon Sep 17 00:00:00 2001
> From: Anders Waldenborg <anders@0x63.nu>
> Date: Mon, 27 Jul 2020 18:34:37 +0200
> Subject: [PATCH] trailers: add tests for unclear/undocumented behavior
>
> ---
>  t/t7513-interpret-trailers.sh | 70 +++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 2e6d406edf..d5d19cf89b 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -99,6 +99,64 @@ test_expect_success 'with config option on the command line' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'parse normalizes spelling and separators from configs with key' '
> +	cat >patch <<-\EOF &&
> +		non-trailer-line
> +
> +		ReviEweD-bY :abc
> +		ReviEwEd-bY) rst
> +		ReviEweD-BY ; xyz
> +		aCked-bY: not normalized
> +	EOF
> +	cat >expected <<-\EOF &&
> +		Reviewed-By: abc
> +		Reviewed-By: rst
> +		Reviewed-By: xyz
> +		aCked-bY: not normalized
> +	EOF
> +	git \
> +		-c "trailer.separators=:);" \
> +		-c "trailer.rb.key=Reviewed-By" \
> +		-c "trailer.Acked-By.ifmissing=doNothing" \
> +		interpret-trailers --parse patch >actual &&
> +	test_cmp expected actual
> +'
> +
> +# Matching currently is prefix matching, causing "This-trailer" to be normalized too
> +test_expect_failure 'config option matches exact only' '
> +	cat >patch <<-\EOF &&
> +
> +		This-trailer: a
> +		 b
> +		This-trailer-exact: b
> +		 c
> +		This-trailer-exact-plus-some: c
> +		 d
> +	EOF
> +	cat >expected <<-\EOF &&
> +		This-trailer: a b
> +		THIS-TRAILER-EXACT: b c
> +		This-trailer-exact-plus-some: c d
> +	EOF
> +	git -c "trailer.tte.key=THIS-TRAILER-EXACT" interpret-trailers --parse patch >actual &&
> +	test_cmp expected actual
> +'
> +
> +# Matching currently uses the config key even if key value is different
> +test_expect_failure 'config option matches exact only' '
> +	cat >patch <<-\EOF &&
> +
> +		Ticket: 1234
> +		Reference-ticket: 99
> +	EOF
> +	cat >expected <<-\EOF &&
> +		Ticket: 1234
> +		Reference-Ticket: 99
> +	EOF
> +	git -c "trailer.ticket.key=Reference-Ticket" interpret-trailers --parse patch >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'with only a title in the message' '
>  	cat >expected <<-\EOF &&
>  		area: change
> @@ -473,6 +531,18 @@ test_expect_success 'with config setup' '
>  	test_cmp expected actual
>  '
>
> +# currently this matches the "Acked-by: " value in ack key set by previous test
> +test_expect_failure 'with config setup matches key exactly' '
> +	cat >expected <<-\EOF &&
> +
> +		A: B
> +	EOF
> +	git interpret-trailers --trailer "A=10" empty >actual &&
> +	test_cmp expected actual
> +'
> +
> +
> +
>  test_expect_success 'with config setup and ":=" as separators' '
>  	git config trailer.separators ":=" &&
>  	git config trailer.ack.key "Acked-by= " &&
> --
> 2.25.1
