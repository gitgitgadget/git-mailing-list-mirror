Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC64D1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 20:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbdLMUdS (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 15:33:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752908AbdLMUdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 15:33:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F7CB85EF;
        Wed, 13 Dec 2017 15:33:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5OhNKVC7XZO6JqwPSJ8GEOvrE9o=; b=pzspwu
        XLrybyOJzprHeVbX3F15X9K9he6mxzXoUDqy6Mp3dC7kxW/4WI/OzKk0cVFzTPAD
        +1y/OJYJ0nhpzniOr1ZEy5Hzw6zaTuWdOIDJQdHH6Un3gwIelfiO6gyKTFe9ko0F
        otU0o6ZQhHSbH1RaW1ktdr+3nTH74xXik7a3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oA/biqxRFIuUq2sAlKhr53IDgxqIxoTa
        LqqY0Q0qd8+GZenG4/Fp7b+tiktoYYp95LVeZVbhdqDTDIdMo10csSnCP1j9Y4MO
        v5F7u1PCBRxg7GEA68G5nBet0ICJh7tOpxN3EtyLri/kTsNTevqlpEEjCfC+NJ1O
        0ezoffit4Us=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F00C2B85EE;
        Wed, 13 Dec 2017 15:33:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48C84B85ED;
        Wed, 13 Dec 2017 15:33:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
        <20171213151344.2138-4-chriscool@tuxfamily.org>
Date:   Wed, 13 Dec 2017 12:33:15 -0800
In-Reply-To: <20171213151344.2138-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 13 Dec 2017 16:13:39 +0100")
Message-ID: <xmqqfu8ewepg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9286B52-E044-11E7-9AAF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>  my $resultsdir = "test-results";
> +my $results_section = "";
>  if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
>  	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
> +	$results_section = $ENV{GIT_PERF_SUBSECTION};
>  }

...

> +	my $executable;
> +	if ($results_section eq "") {
> +		$executable = `uname -o -p`;
> +	} else {
> +		$executable = $results_section;
> +		chomp $executable;
> +	}

Aside from portability of 'uname -o' Eric raised, I wonder if the
platform information is still useful even when perf-subsection is
specified.  With the above code, we can identify that a single
result is for (say) MacOS only when we are not limiting to a single
subsection, but wouldn't it be equally a valid desire to be able to
track performance figures for a single subsection over time and
being able to say "On MacOS, subsection A's performance dropped
between release X and X+1 quite a bit, but on Linux x86-64, there
was no such change" or somesuch?

IOW, shouldn't the "executable" label always contain the platform
information, plus an optional subsection info when (and only when)
the result is limited to a subsection?

By the way, $results_section that is not an empty string at this
point must have come from $ENV{GIT_PERF_SUBSECTION}, and from the
way the environment variable is used in t/perf/run, e.g.

		(
			GIT_PERF_SUBSECTION="$subsec"
			export GIT_PERF_SUBSECTION
			echo "======== Run for subsection '$GIT_PERF_SUBSECTION' ========"
			run_subsection "$@"
		)

I do not think we expect it to have a trailing LF.  What's that
chomp doing there?
