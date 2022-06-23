Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C144C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiFWTnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiFWTmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:42:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331E201A8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 12:34:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA6813E18F;
        Thu, 23 Jun 2022 15:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tXd2U7b+z6DB
        7iBfos41BcDVVdDsJeEbfL8PTjvqocc=; b=UP2KgVsShod4WzxGcmCCNp4vzCkH
        YiJSWwX/Od/fZJMn1GLJDKeEKXkvrPR88UcnZxD+Z2celv2LOi8+cUTsBlwePYkp
        MvYGpqZDSkr9iWphbWXVibh2nO9OmUTM6iRfPFFtVdrjlnuPmlu+c6lCLmOp6+dR
        ixNQHFiPO31ZEos=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7740A13E18E;
        Thu, 23 Jun 2022 15:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6B1A13E18D;
        Thu, 23 Jun 2022 15:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH] trace2: don't include "fsync" events in all trace2 logs
References: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
Date:   Thu, 23 Jun 2022 12:34:10 -0700
In-Reply-To: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Jun
 2022 17:51:46 +0200")
Message-ID: <xmqqh74byy19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75503228-F32B-11EC-B3AD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix the overly verbose trace2 logging added in 9a4987677d3 (trace2:
> add stats for fsync operations, 2022-03-30) (first released with
> v2.36.0).
>
> Since that change every single "git" command invocation has included
> these "data" events, even though we'll only make use of these with
> core.fsyncMethod=3Dbatch, and even then only have non-zero values if
> we're writing object data to disk. See c0f4752ed2f (core.fsyncmethod:
> batched disk flushes for loose-objects, 2022-04-04) for that feature.
>
> The result was that e.g. "git version" would previously emit a total
> of 6 trace2 events with the GIT_TRACE2_EVENT target (version, start,
> cmd_ancestry, cmd_name, exit, atexit), but afterwards would emit
> 8. We'd emit 2 "data" events before the "exit" event.
>
> The reason we didn't catch this was that the trace2 unit tests added
> in a15860dca3f (trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
> t0212.sh, 2019-02-22) would omit any "data" events that weren't the
> ones it cared about. Before this change to the C code 6/7 of our
> "t/t0212-trace2-event.sh" tests would fail if this change was applied
> to "t/t0212/parse_events.perl".
>
> Let's make the trace2 testing more strict, and further append any new
> events types we don't know about in "t/t0212/parse_events.perl". Since
> we only invoke the "test-tool trace2" there's no guarantee that we'll
> catch other overly verbose events in the future, but we'll at least
> notice if we start emitting new events that are issues every time we
> log anything with trace2's JSON target.
>
> We exclude the "data_json" event type, we'd otherwise would fail on
> both "win test" and "win+VS test" CI due to the logging added in
> 353d3d77f4f (trace2: collect Windows-specific process information,
> 2019-02-22). It looks like that logging should really be using
> trace2_cmd_ancestry() instead, which was introduced later in
> 2f732bf15e6 (tr2: log parent process name, 2021-07-21), but let's
> leave it for now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
> This is a fix for a v2.36.0 regression/change, so perhaps it's
> categorically out for v2.37.0, but given how isolated the fix is & how
> verbose the new trace2 data is perhaps it's worth including anyway.
>
> Passing CI at: https://github.com/avar/git/actions/runs/2548732003
>
>  t/t0212/parse_events.perl | 17 +++++++++++------
>  wrapper.c                 |  3 +++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
> index b6408560c0c..389cf6f61c4 100644
> --- a/t/t0212/parse_events.perl
> +++ b/t/t0212/parse_events.perl
> @@ -216,12 +216,17 @@
> =20
>      elsif ($event eq 'data') {
>  	my $cat =3D $line->{'category'};
> +	my $key =3D $line->{'key'};
> +	my $value =3D $line->{'value'};
> +	$processes->{$sid}->{'data'}->{$cat}->{$key} =3D $value;
> +    }
> +
> +    elsif ($event eq 'data_json') {
> +	# Ignore due to compat/win32/trace2_win32_process_info.c
> +    }
> +
> +    else {
> +	push @{$processes->{$sid}->{$event}} =3D> $line->{value};
>      }

The special casing is unfortunate, but if it is "let's leave it for
now", probably we should leave a NEEDSWORK comment here to remind
us, instead of giving a false impresion that abusing data_json is
OK?

> diff --git a/wrapper.c b/wrapper.c
> index 1c3c970080b..eebd764131f 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -618,6 +618,9 @@ int git_fsync(int fd, enum fsync_action action)
> =20
>  void trace_git_fsync_stats(void)
>  {
> +	if (!count_fsync_writeout_only && !count_fsync_hardware_flush)
> +		return;
> +

OK, both counters are unconditionally incremented whenever the
corresponding action triggers, so this implementation is probably OK
for now, but I suspect that it would become a maintenance burden if
we were to add more fsync actions later.

>  	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", co=
unt_fsync_writeout_only);
>  	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", c=
ount_fsync_hardware_flush);

If each of these is guarded with "show only when non-zero", that
would become less problematic, though.

A bigger issue is when somebody is debugging the callers of
git_fsync() wondering why they do not trigger.  Getting log entries
that say "no git_fsync() call with these actions have been made"
may be useful (i.e. explicitly negative answer).

I am not sure if it is a good solution in the longer term, but this
implementation may be a good-enough way to squelch the immediate
loudness issue.

Thanks.

