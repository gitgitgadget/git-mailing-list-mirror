Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0350C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 23:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiBRXbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:31:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiBRXbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 18:31:11 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D680EB164
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 15:30:54 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CC9511A1C0;
        Fri, 18 Feb 2022 18:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PW4E5uOCleVF
        w16KDHwUqzl7UQCMJB/Lg5ao42cHIfA=; b=fxC8q8gaCiwhc8+naKpwsvPAGBPU
        Ps55f1DZbHtU2NYEDzSvjalAs8VY0FWBOHC0dmkZsLSHqI8z+e9rhML/bheeeXTo
        ESs0MwiJwFhsdNONVMBZWk2AVFkOg2PQnk0k/HJMZ4If3gRswutRwc87B3pk87ew
        kyDQhhDZOvutFds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74CDF11A1B7;
        Fri, 18 Feb 2022 18:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC09C11A1AE;
        Fri, 18 Feb 2022 18:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] test-lib: make $GIT_BUILD_DIR an absolute path
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
        <patch-2.4-4c53c6157ac-20220218T205753Z-avarab@gmail.com>
Date:   Fri, 18 Feb 2022 15:30:51 -0800
In-Reply-To: <patch-2.4-4c53c6157ac-20220218T205753Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 18 Feb
 2022 22:01:43 +0100")
Message-ID: <xmqqee3zycpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D024F31C-9112-11EC-93EE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the GIT_BUILD_DIR from a path like "/path/to/build/t/.." to
> "/path/to/build". The "TEST_DIRECTORY" here is already made an
> absolute path a few lines above this.
>
> This will be helpful to LSAN_OPTIONS which will want to strip the
> build directory path from filenames, which we couldn't do if we had a
> "/.." in there.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3212966a82f..4f523b82ce5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -34,7 +34,7 @@ then
>  	# elsewhere
>  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
>  fi
> -GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
> +GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"

This makes perfect sense in the normal case, but the provision the
code that precedes this part has, i.e.

    if test -z "$TEST_DIRECTORY"
    then
            # We allow tests to override this, in case they want to run t=
ests
            # outside of t/, e.g. for running tests on the test library
            # itself.
            TEST_DIRECTORY=3D$(pwd)
    else
            # ensure that TEST_DIRECTORY is an absolute path so that it
            # is valid even if the current working directory is changed
            TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) || exit 1
    fi

to allow TEST_DIRECTORY to be set externally robs the guarantee that
you can sensibly strip "/t" from its tail and expect everything to
work correctly.  The only thing the original requires on such an
externally given TEST_DIRECTORY is that one level above it is usable
as GIT_BUILD_DIR.

IOW,

	GIT_BUILD_DIR=3D"$(cd "$TEST_DIRECTORY/.." && pwd)"

would give you what you want to achieve in either code path, as long
as the original was working correctly for whatever value that is
given to TEST_DIRECTORY externally.

So, perhaps

	if test -z "$TEST_DIRECTORY"
	then
		TEST_DIRECTORY=3D$(pwd)
		GIT_BUILD_DIR=3D${TEST_DIRECTORY%/t}
	else
		TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) &&
		GIT_BUILD_DIR=3D$(cd "$TEST_DIRECTORY/.." && pwd)
	fi

or something like that?  I dunno.

