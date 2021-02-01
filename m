Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD49C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638F564DAE
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBASIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:08:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59694 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBASIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:08:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A08991A19;
        Mon,  1 Feb 2021 13:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EJrTnG6bINcq
        xM/BsExVHQ6wmFI=; b=VWLikOZLdSozkV93KZ3MNknGeTVCSeRmP3+BrMrHpDcd
        DG+fDJjhiCZdNpAwB2hAL37MV35+pFPdHgScYSYFFuA9rMfrcJ0RXWLfveT/cK5w
        3FxBqe1Mj17Z6u5SvPC2qXAiDKFQegNwl1YqWC6oBvswsu4BXE+lBv7hL6DvjAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TB9Yc8
        oSIx+DJLQmaAd724QnpelSMxOoXSHNA7UFG9PUJY6rd2oEzRBKv8xm5bgbCVitUp
        TjZuFSPFZtNeUj9KjKjRlZVxmH6tUb2DV0cWMqNXHwKxMwvbBF5KaIspGosXJ6CI
        PyTnDpmTPGcbkBwDezOaZe0xmdG68yXKXW2EI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F381091A18;
        Mon,  1 Feb 2021 13:07:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E17F91A13;
        Mon,  1 Feb 2021 13:07:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/3] pager: properly log pager exit code when signalled
References: <87im7cng42.fsf@evledraar.gmail.com>
        <20210201144921.8664-4-avarab@gmail.com>
Date:   Mon, 01 Feb 2021 10:07:53 -0800
In-Reply-To: <20210201144921.8664-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 1 Feb 2021 15:49:21 +0100")
Message-ID: <xmqqft2fmzk6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67EE15A8-64B8-11EB-8F6E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When git invokes a pager that exits with non-zero the common case is
> that we'll already return the correct SIGPIPE failure from git itself,
> but the exit code logged in trace2 has always been incorrectly
> reported[1]. Fix that and log the correct exit code in the logs.
>
> Since this gives us something to test outside of our recently-added
> tests needing a !MINGW prerequisite, let's refactor the test to run on
> MINGW and actually check for SIGPIPE outside of MINGW.
>
> The wait_or_whine() is only called with a true "in_signal" from from
> finish_command_in_signal(), which in turn is only used in pager.c.
>
> I'm not quite sure about that BUG() case. Can we have a true in_signal
> and not have a true WIFEXITED(status)? I haven't been able to think of
> a test case for it.
>
> 1. The incorrect logging of the exit code in was seemingly copy/pasted
>    into finish_command_in_signal() in ee4512ed481 (trace2: create new
>    combined trace facility, 2019-02-22)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  run-command.c    |  8 +++++--
>  t/t7006-pager.sh | 61 +++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index ea4d0fb4b15..10e1c96c2bd 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -551,8 +551,12 @@ static int wait_or_whine(pid_t pid, const char *ar=
gv0, int in_signal)
> =20
>  	while ((waiting =3D waitpid(pid, &status, 0)) < 0 && errno =3D=3D EIN=
TR)
>  		;	/* nothing */
> -	if (in_signal)
> -		return 0;
> +	if (in_signal && WIFEXITED(status))
> +		return WEXITSTATUS(status);
> +	if (in_signal) {
> +		BUG("was not expecting waitpid() status %d", status);
> +		return -1;
> +	}

Doesn't BUG die, never to return control back to us?  How about
"warning()" or "error()"?
