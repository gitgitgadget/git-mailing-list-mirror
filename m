Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3E6C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiBRXVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:21:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiBRXVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 18:21:02 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0361A58E4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 15:20:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CABE010F29C;
        Fri, 18 Feb 2022 18:20:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S3emYGcYK4nW
        GnLwmzIYBT8WNNJbxnYJSu1tBoBf2TY=; b=nf+VS5ZfwQSdXekgq1B4UKmGNOyg
        F+udN5z5/T6ODLqHZrPoF+NdFXaJjfXcwb+RiSHhwKX4tjsukmePrm029fDQ274P
        C8F3qNx/bnstUY/yLqf/40ZEp8vjyR7ap2SeNlj/MImYe+V+0/XzOhp5ZneBZFi+
        O+2mYRvrzrypdc8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC0DB10F29B;
        Fri, 18 Feb 2022 18:20:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0713910F29A;
        Fri, 18 Feb 2022 18:20:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
        <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
Date:   Fri, 18 Feb 2022 15:20:41 -0800
In-Reply-To: <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 18 Feb
 2022 22:01:42 +0100")
Message-ID: <xmqqley7yd6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64A21F80-9111-11EC-B48F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
> variables, rather than punting out entirely if we already have them in
> the environment.
>
> We do want to take any user-provided settings over our own, but we can
> do do that by prepending our defaults to the variable. The
> libsanitizer options parsing has "last option wins" semantics.
>
> It's now possible to do e.g.:
>
>     LSAN_OPTIONS=3Dreport_objects=3D1 ./t0006-date.sh
>
> And not have the "report_objects=3D1" setting overwrite our sensible
> default of "abort_on_error=3D1", but by prepending to the list we ensur=
e
> that:
>
>     LSAN_OPTIONS=3Dreport_objects=3D1:abort_on_error=3D0 ./t0006-date.s=
h
>
> Will take the desired "abort_on_error=3D0" over our default.

Makes sense.

> +# Prepend a string to a VAR using an arbitrary ":" delimiter, not
> +# adding the delimiter if VAR is empty. I.e. a generalized:
> +#
> +#	VAR=3D$1${VAR:+$VAR}

This reads: "Begin with the first parameter, and if VAR is set to a
non-empty string, append $VAR immediately after it without any
delimiter".  I would understand if it were

    VAR=3D$1${VAR:+":$VAR"}

(or without the first colon, allowing an empty string as a valid
member of colon-separated list).

> +# Usage (using ":" as a delimiter):
> +#
> +#	prepend_var VAR : $1
> +prepend_var () {
> +	eval "$1=3D$3\${$1:+$2\$$1}"

This one is correct; the above sample, when passed ":" and "VAR" to
$1 and $2, will specialize into the above example.

> +}
> +
> +# If [AL]SAN is in effect we want to abort so that we notice problems.
> +prepend_var XSAN_OPTIONS : abort_on_error=3D1

XSAN_OPTIONS stands for "options that are common to all ?SAN", I
guess.

>  # If we were built with ASAN, it may complain about leaks
>  # of program-lifetime variables. Disable it by default to lower
>  # the noise level. This needs to happen at the start of the script,
>  # before we even do our "did we build git yet" check (since we don't
>  # want that one to complain to stderr).
> -: ${ASAN_OPTIONS=3Ddetect_leaks=3D0:abort_on_error=3D1}
> +prepend_var ASAN_OPTIONS : $XSAN_OPTIONS
> +prepend_var ASAN_OPTIONS : detect_leaks=3D0

This makes me wonder if you want to generalize prepend_var even
further to notice when "$3" is an empty string.  It already avoids
spending an extra colon (and introducing an empty element in the
colon delimited list) by paying attention to the current value of
$1, so it would make sense to do the same for the incoming value.

IOW, the current prepend_var implementation relies on $XSAN_OPTIONS
and detect_leaks=3D0 both being non-empty string.

>  export ASAN_OPTIONS
> =20
> -# If LSAN is in effect we _do_ want leak checking, but we still
> -# want to abort so that we notice the problems.
> -: ${LSAN_OPTIONS=3Dabort_on_error=3D1}
> +prepend_var LSAN_OPTIONS : $XSAN_OPTIONS

But other than that, I think this step makes quite a lot of sense.

>  export LSAN_OPTIONS
> =20
>  if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
