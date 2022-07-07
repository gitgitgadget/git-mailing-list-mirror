Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C243C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiGGQ5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiGGQ5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:57:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5426AD7
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:57:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAFB11453D4;
        Thu,  7 Jul 2022 12:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qRLOnbAOAqKT
        f2nYa4f9zlJYLddlF0hg38JRtMAXRbw=; b=jTM2AGluWsVHmyasjamUVlhdF/GB
        Iu3UbPc8mHniuGqQ6Lc/SMAcAHy4Bi8PbxhZ7rPOjDkeCrJu2rp/CPbLmH+fwerw
        Xoc4iwBmFlYMuKLuMvPG4HIiXrl73vdkbCtuVwU64JVdBjIyksFLqGic5BsUjVWC
        zRO2BKo9ahcORTE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D18D01453D3;
        Thu,  7 Jul 2022 12:57:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDFF31453CF;
        Thu,  7 Jul 2022 12:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Adam Zethraeus <adam.zethraeus@includedhealth.com>
Subject: Re: bug report: pre-commit & pre-push hook output is redirected
 differently
References: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
        <xmqqa69mgdde.fsf@gitster.g>
        <220707.86tu7t84zh.gmgdl@evledraar.gmail.com>
Date:   Thu, 07 Jul 2022 09:57:14 -0700
In-Reply-To: <220707.86tu7t84zh.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 07 Jul 2022 14:40:49 +0200")
Message-ID: <xmqq4jzs3lp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DAC82EA4-FE15-11EC-9719-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I may be missing something, but I think this report has nothing to do
> with any recent changes or regressions, but is merely noting a behavior
> change between pre-push and some other hooks that we've had since 1.8.2=
,
> or since the "pre-push" hook was added in ec55559f937 (push: Add suppor=
t
> for pre-push hooks, 2013-01-13).

"behavior change" meaning a regression of a particular hook, or
"behavior difference" between hooks, each of which never changed the
behavior?

> I tested this with a local v2.30.0, and the behavior was the same.

I guess you meant the latter.  If so, the inconsistency may be
unfortunate, but I agree that it is not cut-and-dried that it is a
good idea to change pre-push to spew its output to standard error
stream.

> It *is* something we need to be careful of when converting the rest of
> the hooks to the hooks API, i.e. we need tests for how stderr/stdout is
> handled for each one.

Absolutely.

> But this being different is just because some hook use the hook.c API
> (and before that the helper in run-command.c), and others use "struct
> child_process" or whatever explicitly (such as "pre-push").
>
> Since it's up to each callsite to set up the "proc" (or equivalent) som=
e
> supply "stdout_to_stderr", some don't.
>
> From some quick grepping it seems the odd ones out are pre-push and
> proc-receive, but I only skimmed a "git grep" to find the second one,
> and may have missed others.

We'd probably need an inventory of them all anyway before we can
push the hook.c API forward.  If the oddball ones are very small
minority, it may be worth having a transition period and make
backward incompatible change to unify where the output goes.  If
they are random mixture, on the other hand, the hook.c API may have
to gain a bit for the caller to tell where the output of the hook
should go.

Thanks.

