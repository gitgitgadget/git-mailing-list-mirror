Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2C5C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8285761005
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbhDEXrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:47:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbhDEXrU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 19:47:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BC57B21B8;
        Mon,  5 Apr 2021 19:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=24SASavF8lRa
        mxyW7LO1ZNsoDEM=; b=XzkvyeadMk7U7qZq/kUiRizjSxWDUNpnwTy804Y3ShZ7
        XzNCq2UFPSwkGywb9OrPe8FFLsojSocs9mmiwJWYsQ2QI6pxeVJnW4OBlKCe5KYU
        jp6HUs5sylAhU35Hjk6/QWQzAj+4EOds7ISEyYaLa4VeKmJsfZxxvYjEsVytLBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=X1gyEa
        +7XQl5UcKFonlTIxv2fDZibA7xAaHjJwnB/7V9jXHpw2GCRKsuhKCJQkLpcVDFby
        m4pr90cL+63Mcy6DFUV0GBwRxNIbk3UkPRjnmwyqHhXCvyF8FFEoNRHxM3bEX+AA
        8vIJ0JWK/P6tx8DhenFrekZrx/qpG6sW3lmqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A353B21B7;
        Mon,  5 Apr 2021 19:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01F4AB21B6;
        Mon,  5 Apr 2021 19:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
Date:   Mon, 05 Apr 2021 16:47:09 -0700
In-Reply-To: <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 4 Apr
 2021 11:19:44 +0200")
Message-ID: <xmqqft0447lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D63145E-9669-11EB-94D7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor the duplicate checking of $? into a function. There's an
> outstanding series[1] wanting to add a third use of system() in this
> file, let's not copy this boilerplate anymore when that happens.
>
> 1. http://lore.kernel.org/git/87y2esg22j.fsf@evledraar.gmail.com
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-send-email.perl | 48 +++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)

>  sub validate_patch {
>  	my ($fn, $xfer_encoding) =3D @_;
> =20
> @@ -1952,11 +1965,12 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
> -			$hook_error =3D "rejected by sendemail-validate hook"
> -				if system($validate_hook, $target);
> +			if (my $msg =3D system_or_msg([$validate_hook, $target])) {
> +				$hook_error =3D __("rejected by sendemail-validate hook");
> +			}
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
> -		return $hook_error if $hook_error;
> +		validate_patch_error($fn, $hook_error) if $hook_error;
>  	}

One big thing that is different between this version and the one in
Emily's "config hook" topic is that this is still limited to the
case where $repo exists.  In the new world order, it will not matter
in what directory the command runs, as long as "git hook" finds the
hook, and details of the invocation is hidden behind the command.

I presume that Emily's series is expected to be updated soonish?
Please figure out who to go first and other details to work well
together between you two.

I'd drop the "config hook" topic for now, and I think the endpoint
of these four-patch series (the first "map vs for" can move more or
less independently) are more-or-less in a good shape (even though as
I said already, I think 2/4 and 4/4 want to be updated not to
introduce the intermediate "validate_patch_error()" sub in 2/4 only
to get rid of it in 4/4) and would require only one update.

Thanks.
