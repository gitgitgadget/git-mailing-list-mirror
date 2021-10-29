Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683DEC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C045603E5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2RYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJ2RYn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 13:24:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4E42FAF42;
        Fri, 29 Oct 2021 13:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DVdRYEFzW0Zx3I585iED78TttDy10sTVraOZG3
        AzhXk=; b=v1Xuvy1g1J4taSHndntSQE0ZcsMtH/3DhAJ/j1dQ2Osb0ofwukaEgQ
        2MFD15HyWpFT9y2f95xgz6nasEp7mSqa1LZ9zFKoq62b+0fH33OKHc+4R5X9bvDQ
        4OY5HDJoWsGtTxM7q0LAHkJuB1/PKfpgtJWjbWMLSbCDF5C2rT6S4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC1B7FAF41;
        Fri, 29 Oct 2021 13:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FA32FAF40;
        Fri, 29 Oct 2021 13:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr> <xmqqilxhq774.fsf@gitster.g>
        <20211029001552.GA29647@dcvr> <xmqqy26cl1zd.fsf@gitster.g>
        <20211029074857.GA9214@dcvr>
Date:   Fri, 29 Oct 2021 10:22:12 -0700
In-Reply-To: <20211029074857.GA9214@dcvr> (Eric Wong's message of "Fri, 29 Oct
        2021 07:48:57 +0000")
Message-ID: <xmqqtugzlpa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C18C3B6E-38DC-11EC-B6CA-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Easy repro+fix, though.  I only tested my final patch with NO_SVN_TESTS :x
> Can you squash this in or do you want a reroll?
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index df5a87a151..6ce2e283c8 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -2274,7 +2274,7 @@ sub use_fsync {
>  	if (!defined($_use_fsync)) {
>  		my $x = $ENV{GIT_TEST_FSYNC};
>  		if (defined $x) {
> -			my $v = command_oneline('git', '-c', "test.fsync=$x",
> +			my $v = command_oneline('-c', "test.fsync=$x",
>  					qw(config --type=bool test.fsync));
>  			$_use_fsync = defined($v) ? ($v eq "true\n") : 1;
>  		}

Yuck, I should have known that command_oneline() does not want the
leading 'git'.

A sad part of the story is that this is not exactly the fault of the
interface, as the full name of the thing is Git::command_oneline(),
which makes it sufficiently clear that it is a "git" specific thing,
and Git::oneline_result_from_git_command_do_not_give_git_at_front()
is not a good sub name X-<.

Thanks for quickly diagnosing.




