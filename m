Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D14E7C4E5
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 17:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbjJDRBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDRBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 13:01:51 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037CD95
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696438900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q017Ars1eM9i/JU59KGBUcMOOKPgyecPGdmo5nPTCD8=;
        b=W2PLB6egwOOR4ijONesWt+MARvEL/2c+h8AhzJJCOqdRo/VlSrsF/y/S94dDfZbqX8UKYQ
        J26p4K5+rn3kC2/oIQDWzaOWUkQIBvbpQQmGTZaIxt92CHnygpAL+DqXsi7WnRHjRCRfER
        kzymu7R75Z0xVpCVNLE6dHh6rQmKGvUx+mDkWwy3hOHlXYaCItSYb2a8f5bp53bkmosw6o
        /ltLPLU8CllsoYWrH7IXIkVURASlJncxJNHNirnUNYKtjGwqB1sVqaWxch/pAbzUJmBbyt
        GCm9Gq2BW+Sadly2nbE9g/EBTsi8Dg29PC9zzVESHk/EwKJWF37jUa4cth3EbA==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 9bbcc755 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Oct 2023 19:01:40 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <xmqqbkdes6lf.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        04 Oct 2023 09:19:40 -0700")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
        <20231004113413+0200.161419-stepnem@smrk.net>
        <xmqqbkdes6lf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Wed, 04 Oct 2023 19:01:40 +0200
Message-ID: <20231004190140+0200.740775-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 04 Oct 2023 09:19:40 -0700
Junio C. Hamano wrote:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:
>
>> Yes, actually, AFAICT just $(cd . && pwd) fixes things (and saves a few
>> syscalls), and I agree this is a much better approach than my naive fix.
>
> Actually I was still being silly.  We sometimes do
>
> 	val=3D$(cd there && do something there)
>
> so that we can get the output from a command in a different
> directory _without_ having to move our current directory.  But the
> point of this current topic is that we _need_ to convince the shell
> that the path to our current directory is a canonical one without
> trailing slash, so my silly 'cd "$(pwd)/."' (or your "cd .") should
> be done outside the command expansion, or the canonicalized $PWD will
> only appear inside the $() and the next reference to $(pwd) or $PWD
> in the test script will still give the path with the trailing slash,
> that is textually different from $TEST_DIRECTORY.
>
> I wonder if this works better for you.  We would be sure that $PWD
> and $TEST_DIRECTORY (when the latter is not imported from the
> environment) are the same, so "your cwd that does not end with /t
> and has a trailing slash after it" would be gone.  Any $PWD or $(pwd)
> the tests refer to later in the step will also lack the unwanted
> trailing slash.   As long as "cd ." is sufficient to cause the shell
> reexamine and canonicalize the $PWD, that is.
>
> Thanks.
>
>  t/test-lib.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git c/t/test-lib.sh w/t/test-lib.sh
> index 1656c9eed0..a7045e028c 100644
> --- c/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -19,6 +19,11 @@
>  # t/ subdirectory and are run in 'trash directory' subdirectory.
>  if test -z "$TEST_DIRECTORY"
>  then
> +	# It is reported that some shells spawned in tricky ways can
> +	# give $PWD with a trailing slash. An explicit chdir hopefully
> +	# would wake them out of their hallucination.
> +	cd .
> +
>  	# ensure that TEST_DIRECTORY is an absolute path so that it
>  	# is valid even if the current working directory is changed
>  	TEST_DIRECTORY=3D$(pwd)
> @@ -626,7 +631,6 @@ fi
>  # Protect ourselves from common misconfiguration to export
>  # CDPATH into the environment
>  unset CDPATH
> -
>  unset GREP_OPTIONS
>  unset UNZIP

Yes, this is even simpler and more obvious, although for some reason,
the subshell version works just as well, i.e., with just
TEST_DIRECTORY=3D$(cd . && pwd) (no cd in the parent) in test-lib.sh and

cat <<EOF >./tslash.sh
#!/bin/sh
test_description=3D'yada yada'

. ./test-lib.sh

test_expect_success 'check TEST_DIRECTORY for trailing slash' '
        echo "$TEST_DIRECTORY" &&
        test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/}"
'

test_done
EOF

I get

; echo ${TEST_DIRECTORY-unset}
unset
; pwd
/home/stepnem/src/git/t/
; echo $PWD
/home/stepnem/src/git/t/
; sh ./tslash.sh -v
Initialized empty Git repository in /home/stepnem/src/git/t/trash directory=
.tslash/.git/
expecting success of slash.1 'check TEST_DIRECTORY for trailing slash':
        echo "$TEST_DIRECTORY" &&
        test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/}"

/home/stepnem/src/git/t
ok 1 - check TEST_DIRECTORY for trailing slash

# passed all 1 test(s)
1..1
; pwd
/home/stepnem/src/git/t/
; echo $PWD
/home/stepnem/src/git/t/

[and, needless to say, reverting the changes still triggers the panic:
; sh ./tslash.sh
PANIC: Running in a /home/stepnem/src/git/t/ that doesn't end in '/t'?
]

Go figure...

In any case, for what it's worth, any of your versions is
Tested-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n
