Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BFC433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B6E60EFE
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 22:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhJJWQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 18:16:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58883 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJJWQF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 18:16:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A694415C11B;
        Sun, 10 Oct 2021 18:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GBtGIDBFP7dQ
        CNPhLwD3CW56K3ooSNps/odmQ8jPrSU=; b=Tuyj5tvHF3XGBaQD4CEVrmelBU9z
        xscEq2ixGCcoE4J6h8PwYiQVWaKVBJ1+KkCslKbkS9MlZqH7v00hpcIREC3Ex5E2
        fEVLaWB0ywttZSKchyHWp1FCkb3TOrVbXMOuFcJE0bVwkHdpT/KhCEN656uUIQfP
        RH4+Z4jrL9bwcqI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F1D315C11A;
        Sun, 10 Oct 2021 18:14:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FB3015C118;
        Sun, 10 Oct 2021 18:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: try to re-chmod & retry on failed trash
 removal
References: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
Date:   Sun, 10 Oct 2021 15:14:02 -0700
In-Reply-To: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 9 Oct
 2021 15:31:02 +0200")
Message-ID: <xmqqee8seded.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 60F30892-2A17-11EC-AFA5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This can be demonstrated as e.g. (output snipped for less verbosity):
>
>     $ ./t0004-unwritable.sh --run=3D3 --immediate
>     ok 1 # skip setup (--run)
>     ok 2 # skip write-tree should notice unwritable repository (--run)
>     not ok 3 - commit should notice unwritable repository
>     [...]
>     $ ./t0004-unwritable.sh --run=3D3 --immediate
>     rm: cannot remove '[...]/trash directory.t0004-unwritable/.git/obje=
cts/info': Permission denied
>     FATAL: Cannot prepare test area
>     [...]
>
> I.e. if any of its tests failed, and the tests were being run under
> "--debug"[2] or "--immediate"[3] (which was introduced after [1]) we
> wouldn't re-chmod the object directory. We'd then fail on the next run
> since the test setup couldn't remove the trash files.

OK, the first thing these scripts do is to create $TRASH_DIRECTORY
for their own use, and that is what fails (hence "Cannot prepare").

And making sure we try harder to prepare would be a good thing.
Given that understanding of the motivation...=20

> @@ -1210,10 +1210,10 @@ test_done () {

...it is puzzling why we are touching the code that happens _after_
a test is run.  If our philosophy is to leave the mess after a test
fails so that the debugging person can take a look without
contaminating the forensics data, but blindly and forcibly clean up
before starting a new round, reusing the "do more than usual to
remove" logic meant to be used for the latter here feels counter
productive and also a bit counter intuitive.

>  			error "Tests passed but trash directory already removed before test=
 cleanup; aborting"
> =20
>  			cd "$TRASH_DIRECTORY/.." &&
> -			rm -fr "$TRASH_DIRECTORY" || {
> +			remove_trash_directory "$TRASH_DIRECTORY" || {
>  				# try again in a bit
>  				sleep 5;
> -				rm -fr "$TRASH_DIRECTORY"
> +				remove_trash_directory "$TRASH_DIRECTORY"
>  			} ||
>  			error "Tests passed but test cleanup failed; aborting"
>  		fi



> +# Try really hard to clean up our mess
> +remove_trash_directory() {
> +	dir=3D"$1"
> +	if ! rm -rf "$dir"
> +	then
> +		say_color info >&3 "Failed to remove trash directory, trying to re-c=
hmod it first..."
> +		chmod -R u+w "$dir" 2>/dev/null

If a test lost searchable bit from directories, "u+wx" may be
necessary to clean fully, no?

> +		rm -rf "$dir"
> +	fi
> +	! test -d "$dir"
> +}
> +

On the other hand...

>  # Are we running this test at all?
>  remove_trash=3D
>  this_test=3D${0##*/}
> @@ -1388,7 +1400,7 @@ GNUPGHOME=3D"$HOME/gnupg-home-not-used"
>  export HOME GNUPGHOME USER_HOME
> =20
>  # Test repository
> -rm -fr "$TRASH_DIRECTORY" || {
> +remove_trash_directory "$TRASH_DIRECTORY" || {

... this one does make sense and matches what the proposed log
message sold us the change as.

>  	GIT_EXIT_OK=3Dt
>  	echo >&5 "FATAL: Cannot prepare test area"
>  	exit 1

Thanks.
