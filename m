Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DBBC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 19:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiB1TO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiB1TO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 14:14:26 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2244CD3ADB
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:13:46 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B271319396B;
        Mon, 28 Feb 2022 14:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFT5TkhKcKX2l6Vle/q0pYn16seu69kK6m4Mri
        paYsk=; b=IM6XyYk6GxFApmy+Hvh+D7Mj//f0sz4rARRF5EzTlCj4h3YBtsB4Q6
        PzUhB2c4zCUlTbOEc+QlDp9zKQcfMq+4RtddDqi63f3Ll0XUfNmRRhyGc30BDY4V
        fHn1nmQye+LCX1yKvbslW3CnZWRUyJd1MMQXub+nXT0fGn0FKVGgU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9809419396A;
        Mon, 28 Feb 2022 14:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFE5A193969;
        Mon, 28 Feb 2022 14:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib.sh: Use GLIBC_TUNABLES instead of
 MALLOC_CHECK_ on glibc >= 2.34
References: <20220228160827.465488-1-gitter.spiros@gmail.com>
Date:   Mon, 28 Feb 2022 11:13:40 -0800
In-Reply-To: <20220228160827.465488-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Mon, 28 Feb 2022 16:08:27 +0000")
Message-ID: <xmqq7d9e249n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AA6EE16-98CA-11EC-ADED-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> In glibc >= 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
> variables have been replaced by GLIBC_TUNABLES.  Also the new

Does it hurt to have these older environment variables?  If not,
we would prefer to see redundant but less deeply indented code,
I would imagine.

> +	if type -p getconf >/dev/null 2>&1; then
> +		_GLIBC_VERSION="$(getconf GNU_LIBC_VERSION 2>/dev/null | awk '{ print $2 }')"
> +		if [ -n "$_GLIBC_VERSION" -a $(expr "$_GLIBC_VERSION" \>= "2.34") ]; then
> +			_HAVE_GLIBC_234="yes"
> +		fi
> +	fi

Style.  We prefer "test ..." over "[ ... ]" and more importantly we
don't use "test X -a Y".

Do we absolutely need "test -p getconf" with an extra indentation?
I suspect we don't.

	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
	   test 2.34 \<= "$_GLIBC_VERSION"
	then
		USE_GLIBC_TUNABLES=YesPlease
	fi

perhaps?  I am not sure if glibc 2.4 still matters, getconf reports
it as 2.04 or 2.4, for the above comparison to be OK, though.

In any case, HAVE_GLIBC_234 is a horrible variable name to use for
this purpose, as the primary thing the two use sites care about is
not the version but if they should use the GLIBC_TUNABLES mechanism,
so it would be better to name the variable after the feature.

>  	setup_malloc_check () {
> -		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
> -		export MALLOC_CHECK_ MALLOC_PERTURB_
> +			if test "x$_HAVE_GLIBC_234" = xyes ; then
> +				LD_PRELOAD="libc_malloc_debug.so.0" GLIBC_TUNABLES="glibc.malloc.check=1:glibc.malloc.perturb=165"
> +				export LD_PRELOAD GLIBC_TUNABLES
> +			else
> +				MALLOC_CHECK_=3	MALLOC_PERTURB_=165
> +				export MALLOC_CHECK_ MALLOC_PERTURB_
> +			fi

Avoid overly long lines when you can easily do so.

		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
		export MALLOC_CHECK_ MALLOC_PERTURB_
+		case "$USE_GLIBC_TUNABLES" in
+		YesPlease)
+			g=
+			LD_PRELOAD=libc_malloc_debug.so.0
+			for t in \
+				glibc.malloc.check=1 \
+				glibc.malloc.perturb=165 \
+			do
+				g="$g${g:+:}$t"
+			done
+			GLIBC_TUNABLES=$g
+			;;
+		esac

perhaps?

>  	}
>  	teardown_malloc_check () {
> -		unset MALLOC_CHECK_ MALLOC_PERTURB_
> +			if test "x$_HAVE_GLIBC_234" = xyes ; then
> +				unset LD_PRELOAD GLIBC_TUNABLES
> +			else
> +				unset MALLOC_CHECK_ MALLOC_PERTURB_
> +			fi

Similarly.

>  	}
>  fi
