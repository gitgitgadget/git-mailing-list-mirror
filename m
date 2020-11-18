Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE59C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C073246C0
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ReAa9Pr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKRUAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:00:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57222 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgKRUAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:00:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 717AB10DA7B;
        Wed, 18 Nov 2020 15:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R4pM7cC/WT5E
        LcWTmn566LN63e8=; b=ReAa9Pr9KM/h45zQiCmmh35w4iPkgmohrrf8fdYOQ6zM
        /lJgpDykgNgvGiv+MBUIA5gdwV8GOCIjvS0MPBvoGg3a6qrG6j18vobDJB1I6dUB
        DXy4hfCOSfQ6CwVwojYh52mqk+3lSfV806qsKT2CzNP3HxX4QQoSBhcR4BDHFTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DCwxka
        /vG/9jCTupNOL0Csed3JYf58+oFrX418RHRg31Md/1tX4iWGGNEXYwtMrTD84B3d
        dXwJwYJxu1NjN1bQRRZDzJWKQtKNU3AkB9XqHEcwE6U2Woi5pk0/TaS2szAvPZfD
        TVE3Dqtj65wG/sxz5smbbbk8LFMpkpgHzKYxU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6997310DA7A;
        Wed, 18 Nov 2020 15:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F6DA10DA76;
        Wed, 18 Nov 2020 15:00:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
References: <20201118190414.32616-1-szeder.dev@gmail.com>
Date:   Wed, 18 Nov 2020 12:00:40 -0800
In-Reply-To: <20201118190414.32616-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 18 Nov 2020 20:04:13 +0100")
Message-ID: <xmqqh7pm1llj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD1283B8-29D8-11EB-A8E4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> This can be problematic, because lazy prereqs are evaluated in the
> '$TRASH_DIRECTORY/prereq-test-dir' directory, which is the same for
> every prereq, and which is automatically removed after the prereq has
> been evaluated.  So if the inner prereq (BAR above) is a lazy prereq
> that hasn't been evaluated yet, then after its evaluation the
> 'prereq-test-dir' shared with the outer prereq will be removed.

OK.

> Consequently, 'check-foo' will find itself in a non-existing
> directory, and won't be able to create/access any files in its cwd,
> which could result in an unfulfilled outer prereq.

I have a feeling that this would be filesystem dependent what
happens in an unlinked directory.  But in any case, if an outer lazy
prereq creates a file in the test directory, tries to evaluate
another lazy prereq (which would use the same directory and then
would remove everything in it and the directory itself when done),
and then expects that the file it created before evaluating the
inner lazy prereq is still there, it would not work, so I think this
is a good change.  I just think "won't be able to" is a bit too
strong here ("may not be able to (depending on the filesystem)", I
would buy).

> +test_lazy_prereq NESTED_INNER '
> +	>inner &&
> +	rm -f outer
> +'
> +test_lazy_prereq NESTED_PREREQ '
> +	>outer &&
> +	test_have_prereq NESTED_INNER &&
> +	echo "can create new file in cwd" >file &&
> +	test -f outer &&
> +	test ! -f inner
> +'

And the existence check for outer is exactly what I wrote above.
That would portably break without separte directory.  I do not know
if "can create new file" step would fail portably.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8d59b90348..94395b9807 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -474,15 +474,15 @@ test_lazy_prereq () {
> =20
>  test_run_lazy_prereq_ () {
>  	script=3D'
> -mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
> +mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&
>  (
> -	cd "$TRASH_DIRECTORY/prereq-test-dir" &&'"$2"'
> +	cd "$TRASH_DIRECTORY/prereq-test-dir-'"$1"'" &&'"$2"'
>  )'

Qoting rules are a bit tricky here, but I think it does not matter
too much, as $1 (name or prereq) won't have $IFS or "'" or anything
funny in it.

>  	say >&3 "checking prerequisite: $1"
>  	say >&3 "$script"
>  	test_eval_ "$script"
>  	eval_ret=3D$?
> -	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
> +	rm -rf "$TRASH_DIRECTORY/prereq-test-dir-$1"

And this is obviously safe no matter what is in $1 ;-)

>  	if test "$eval_ret" =3D 0; then
>  		say >&3 "prerequisite $1 ok"
>  	else

Looks good.
