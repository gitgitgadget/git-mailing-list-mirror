Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649BC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 17:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiDVRMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbiDVRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C98D687
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 10:09:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3000A179DD1;
        Fri, 22 Apr 2022 13:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RDbork1jMJ2b
        YjhMuZtFR49fcgKwJn3L0HRZ0PRMUHA=; b=p9+haSg3/yF7XwN652xIYttwpDF2
        Q9JCeunc3fT2cuVtgLe0lA3GYJzruNUWPdZGyP0lawkY3XeD/To8zOHVdCJeYlS/
        T43k6MqA6ui6OMBaAlskMQ8nrbPZExY1gcpTq5sj+q2+kmHL9XHgP9Nyu57hYvaD
        s6Mug/fv9fterGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2887A179DD0;
        Fri, 22 Apr 2022 13:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E5E1179DCF;
        Fri, 22 Apr 2022 13:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] send-email: always confirm by default
References: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
        <20220422083629.1404989-1-hi@alyssa.is>
Date:   Fri, 22 Apr 2022 10:09:09 -0700
In-Reply-To: <20220422083629.1404989-1-hi@alyssa.is> (Alyssa Ross's message of
        "Fri, 22 Apr 2022 08:36:29 +0000")
Message-ID: <xmqq7d7havuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED52D38C-C25E-11EC-A745-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

> For novice users, it can be very intimidating for git send-email to sen=
d
> off a lot of mail without prompting for confirmation.  These users are
> likely to not know it's even possible to configure git to behave
> differently.  So let's set a novice-friendly default =E2=80=94 expert u=
sers who
> don't need to be prompted every time will be able to set
> sendemail.confirm to their preference, although from my small sample it
> sounds plenty of expert users already rely on sendemail.confirm =3D
> always.

One thing the current behaviour of "confirm" makes a bad end-user
experience for recipients is that you can individually say "no, this
message has wrong address on the CC line, do not send it" and the
receivers end up seeing [1/4] [2/4] [4/4] and left wondering what
happend to [3/4], until [3/4] alone is resent.

Iterating over messages and letting the user examine the headers for
each of them is perfectly fine, but it would make it much nicer to
recipients if the choices are collected first and then even a single
NO stops the entire series from getting sent.

	[Side note] As with everything else in Git, which is a tool
	to help people interact with each other better, we give
	priority to avoid wasting time of the more populous side,
	and naturally, we should aim to make it less annoying to
	receivers even if it means that the sender needs to spend a
	bit more time to send the right things to the right people.

And making "confirm" the default before it is fixed may make it
easier to annoy receivers.

> I also think this approach is better than forbidding the all-in-one
> format-patch + send-email, because it wouldn't give an accurate preview
> of recipients, because automatic CCs are added by send-email, not
> format-patch.

I do not think this part matches reality.  format-patch alone does
not manage CC or To at all.  What the separation of send-email and
format-patch does is to train people to actually proofread what they
are going to send out.  Being able to add Cc: and To: at the header
part (instead of adding Cc: to trailers and have send-email to pick
them up, which is error prone and forcing you to advocate this
default change so that you can check at the last minute) of the
generated patch text is icing on the cake ;-)

>  if ($confirm_unconfigured) {
> -	$confirm =3D scalar %suppress_cc ? 'compose' : 'auto';
> +	$confirm =3D 'always';

This got a lot simpler.  I've always wondered why this "if suppress
CC is there, then default to 'compose' and otherwise 'auto'" makes a
sensible default.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 42694fe584..e11730f3dc 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -74,8 +74,8 @@ check_no_confirm () {
>  	return 0
>  }
> =20
> -test_expect_success $PREREQ 'No confirm with --suppress-cc' '
> -	test_no_confirm --suppress-cc=3Dsob &&
> +test_expect_success $PREREQ 'No confirm with --confirm=3Dcompose --sup=
press-cc' '
> +	test_no_confirm --confirm=3Dcompose --suppress-cc=3Dsob &&
>  	check_no_confirm
>  '
> =20
> @@ -1032,16 +1032,10 @@ test_expect_success $PREREQ '--confirm=3Dcompos=
e' '
>  	test_confirm --confirm=3Dcompose --compose
>  '
> =20
> -test_expect_success $PREREQ 'confirm by default (due to cc)' '
> +test_expect_success $PREREQ 'confirm by default' '
>  	test_when_finished git config sendemail.confirm never &&
>  	git config --unset sendemail.confirm &&
> -	test_confirm
> -'
> -
> -test_expect_success $PREREQ 'confirm by default (due to --compose)' '
> -	test_when_finished git config sendemail.confirm never &&
> -	git config --unset sendemail.confirm &&
> -	test_confirm --suppress-cc=3Dall --compose
> +	test_confirm --suppress-cc=3Dall
>  '

It is curious that the change to the test this patch adds are only
to adjust to the fallout the change of the default causes, and there
is no new test to make sure that unconfigured sendemail.confirm
triggers confirmation dialogue.

I still have reservations, as I would eventually have to sell those
existing users that this usability regression [*1*] is worth having
in the new release.  It will need a large backward-compatibility note
in the Release Notes, at least.

But assuming that you can help convince these few dozens of existing
Git users out there that it is worth doing, the implementation seems
correct to me.

Thanks.


[Footnote]

*1* The existing users will be surprised by sudden appearance of
unexpected confirmation dialogue, which they may have never seen,
and have to decide

 (1) keep saying "yes" to send out the current series, or
 (2) abort, read release notes and finally configure the
     sendemail.confirm away before resending

soon after updating their Git.  They will be extremely annoyed if
that happens when they were about to send out a large series.
