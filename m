Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FBC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392563AbiDUUut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392574AbiDUUus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:50:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026E54EA24
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:47:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 293B012960D;
        Thu, 21 Apr 2022 16:47:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h7p9wBrua2nt
        zn7bemgG5GSTLZsR/B6I3O0fRlJbCsc=; b=YxQ3gFbl85frbyHTMjyAxBHtHLce
        /IIiu6ib/47pWdVrsQhIGp3FfN/INGk3RJpocWozTT+NxAkaPYEEFFcIJ9W1zZwi
        ympYCIMSgBHWA4gp1jOcIJqckR0qak7JAQKbtTJFp0+/PxZwQo+CUoNdCORZYOqT
        9oYl7DUVfN/rwDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2169612960C;
        Thu, 21 Apr 2022 16:47:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 502A712960B;
        Thu, 21 Apr 2022 16:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
        <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 13:47:40 -0700
In-Reply-To: <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 14:53:52 +0200")
Message-ID: <xmqqo80uf9jn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4986BD86-C1B4-11EC-AACB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the obscure (but unlikely to ever happen) that the failure is
> specifically because perforce.com published a bad updated package, and
> it a failure that their testing wouldn't have caught, but whoever's
> updating the homebrew SHA-256 recipe would have caught, we will have a
> failure in our p4 tests that we wouldn't have otherwise had.

Or DNS the CI site consults is tainted and we got a bad package from
a fake perforce.com?

> @@ -37,7 +37,13 @@ macos-latest)
>  	test -z "$BREW_INSTALL_PACKAGES" ||
>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> -	brew install perforce
> +	brew install perforce || {
> +		echo Installing perforce failed, assuming and working around SHA256 =
mismatch >&2 &&

I had to read this three times before realizing what you are
"assuming".  You suspect without having a way to verify that SHA-256
mismatch was the reason why the attempt to install failed, and
working it around.  Makes sense.

What does it buy us to do this only as a fallback?  If we munged the
$path to disable sha256 checking before the initial "brew install",
we would install it happily if the package is the correct one, and
if it is not a kosher one, we'd install it anyway.

Is it so that we can tell if we had the checksum mismatch or not?
It is unfortunate that no_check is the only "special" value for the
field (I would have loved to use "warn_only" if it were available).

> +
> +		path=3D$(brew edit --print-path perforce) &&
> +		sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&

"sed -i" is not POSIX and without macOS box I do not know if it
works there.  FreeBSD sed manual seems to indicate they have

	sed -i <extension>

In our current codebase, "sed -i" appears to be used only in vcxproj
part of config.mak.uname

I would usually have said that "I'd rather see us not to use it
here, to prevent others from copying and pasting it, if it can be
helped", but this is very much macOS specific part of an obscure
corner of the source tree, so as long as we are sure it works there,
and if it is too cumbersome to avoid editing in-place, I'd let it
go.

Ah, no, I'd say we should NOT use "sed -i" here, not in the form in
this patch, after seeing

  https://unix.stackexchange.com/questions/401905/bsd-sed-vs-gnu-sed-and-=
i

but that is 4-year old information, so...

> +		brew install perforce
> +	}
> =20
>  	if test -n "$CC_PACKAGE"
>  	then
