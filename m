Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB3AC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B83A613A3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhDETMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:12:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56578 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhDETL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 15:11:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E30F113976;
        Mon,  5 Apr 2021 15:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CGvYHThPxrud
        eY3WSZBdezYyInY=; b=WK9HOCIAdHLC8IE+Z3zY9Dj9uBpqivnSKxMPjB45HxuK
        9WZtaXLkmzOnKPzQZrGz2D5tSwRh85emaCr+XfR5uLXifygkpmVxkGUHPMBedb/L
        idxq/QrkVg7jfdhDICTOKL1tzdxXokNg0YNRdEKjwLia/RY++5srNZ6A9bhY9Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TGQcof
        5nmLqVaafHB/jLdxvzfPyrYelT14hcq08S6tPZugxd9TPEUA25xCd7cisGhI940d
        48Kh8Yb5jQLXi+n2Mxla6JEEMKkQR9m6Tmjg8YMRogD0Eno7spBJezRkye9SNgBR
        MgHqkQ+78hD6xgMzN2WsihXEKeGVbz8V7tARw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2852B113975;
        Mon,  5 Apr 2021 15:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FA5C113971;
        Mon,  5 Apr 2021 15:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
Date:   Mon, 05 Apr 2021 12:11:48 -0700
In-Reply-To: <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 4 Apr
 2021 11:19:44 +0200")
Message-ID: <xmqqmtuc5yx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C659BC80-9642-11EB-8E8F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -1938,6 +1945,12 @@ sub unique_email_list {
>  	return @emails;
>  }
> =20
> +sub validate_patch_error {
> +	my ($fn, $error) =3D @_;
> +	die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
> +		    $fn, $error);
> +}
> +
>  sub validate_patch {
>  	my ($fn, $xfer_encoding) =3D @_;

I like the overall direction of this series, but this change will
soon be reverted back to have the die/sprintf in the two callsite
in 4/4 anyway, so this hunk looks more like "I thought this would
be a good way, but in the end I had to change my mind".

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
> =20
>  	# Any long lines will be automatically fixed if we use a suitable tra=
nsfer
> @@ -1966,7 +1980,7 @@ sub validate_patch {
>  			or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
>  		while (my $line =3D <$fh>) {
>  			if (length($line) > 998) {
> -				return sprintf(__("%s: patch contains a line longer than 998 chara=
cters"), $.);
> +				validate_patch_error($fn, sprintf(__("%s: patch contains a line lo=
nger than 998 characters"), $.));
>  			}
>  		}
>  	}
