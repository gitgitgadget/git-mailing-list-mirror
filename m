Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C897CC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E14864EA1
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBASaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:30:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56094 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBASPz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F48B11DA95;
        Mon,  1 Feb 2021 13:15:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Art6g6Np7XJS
        uV0+7Ho2s8OmYDs=; b=ApKuBXVL1oEVpiWOxgQwXpcUN25Foy88iJVwd8xGYxBp
        CpjUBDKVTaWgUTDG6QCkDPcTvyPsVCWdLDVqp79jzgBjBH9cMU40hinLMTDCqbtQ
        T+MMLcsajhmuPFDJ/gmcAFsBgYugqJUW1nhmOgkmn6jVQ1hSrwwVsFjFaIeAZuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MlANlP
        iqVCT8bGIn2XZOF1+oFNnPYm4+YkRqgX8QWc4LBUbyuWgknIUA2QYZuVwgdeCh5d
        9bihMgrZ6rZGCqQQ5TvpaX09FoHgMn6/P4pOG4Pqy0REt6trr/6cZvIESNbCgUGF
        DMdMCqlV5g02q5nB1AgzK8AoSCyXckTf8y4Uc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1748911DA94;
        Mon,  1 Feb 2021 13:15:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A01A11DA93;
        Mon,  1 Feb 2021 13:15:09 -0500 (EST)
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
Date:   Mon, 01 Feb 2021 10:15:06 -0800
In-Reply-To: <20210201144921.8664-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 1 Feb 2021 15:49:21 +0100")
Message-ID: <xmqqbld3mz85.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B1E7348-64B9-11EB-8AAB-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

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

This starts reporting exit status of the pager back to
finish_command() and finish_command_in_signal().  But the code in
pager.c that call the finish_command*() ignore the returned value.

So, is the net result of these three patches just that the trace2
output gives the exit status of the pager, but "git" itself is not
affected otherwise (not a complaint; trying to understand the
intention) ?

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index c60886f43e6..1424466caf5 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -656,31 +656,74 @@ test_expect_success TTY 'git tag with auto-column=
s ' '
>  	test_cmp expect actual
>  '
> =20
> -test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exi=
t' '
> +test_expect_success TTY 'git returns SIGPIPE on early pager exit' '

I somehow find 2/3 of this change belongs to the previous step.
That is, shouldn't this new test added in the previous step without
the !MINGW prerequisite, but without the trace2 bits (i.e. the first
three added lines and the last "grep" of trace.normal), and the change
made in this step limited only to those trace2 bits?

>  	test_when_finished "rm pager-used" &&
>  	test_config core.pager ">pager-used; head -n 1; exit 0" &&
> +	GIT_TRACE2=3D"$(pwd)/trace.normal" &&
> +	export GIT_TRACE2 &&
> +	test_when_finished "unset GIT_TRACE2" &&
> =20
> -	OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> -	test_match_signal 13 "$OUT" &&
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	grep "child_exit.* code:0 " trace.normal &&
>  	test_path_is_file pager-used
>  '

The same comment applies to this new one added in this step.
Shouldn't the bulk of the test (i.e. under !MINGW we get killed with
signal 13) be introduced in the previous step?


> +test_expect_success TTY 'git logs nonexisting pager invocation' '
> +	test_config core.pager "does-not-exist" &&
> +	GIT_TRACE2=3D"$(pwd)/trace.normal" &&
> +	export GIT_TRACE2 &&
> +	test_when_finished "unset GIT_TRACE2" &&
> +
> +	if test_have_prereq !MINGW
> +	then
> +		OUT=3D$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
> +		test_match_signal 13 "$OUT"
> +	else
> +		test_terminal git log
> +	fi &&
> +	grep "child_exit.* code:-1 " trace.normal
> +'
> +
>  test_done
