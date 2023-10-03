Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B1BE8FDB9
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjJCVV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjJCVV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:21:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E8AF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:21:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C57C51B8D04;
        Tue,  3 Oct 2023 17:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vAJCluA6PLV4
        9XRj5ua9lJksLj0nLtP+pVRZqJ8xei0=; b=RsCLCbb0gkfrenFLtrHMZIuLZevH
        r9wAAFslDAZS87+qGNJxqj2AnJ4hGL1ptdajv+sBJJDLDfBqjC6Uu8dQwD3IV+Bs
        QIhltdBpmkg7CP+dN9VN996apXfsgLjVMkk0Nxi4I96HpvlEAyW8dSX8TQtUFfEe
        0RqDpZxQQ69qQtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC9281B8D03;
        Tue,  3 Oct 2023 17:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 212061B8D02;
        Tue,  3 Oct 2023 17:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <20231003082323.3002663-1-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Tue, 3 Oct 2023 10:23:23 +0200")
References: <20231003082323.3002663-1-stepnem@smrk.net>
Date:   Tue, 03 Oct 2023 14:21:51 -0700
Message-ID: <xmqqwmw3wgeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF6E730A-6232-11EE-A408-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> Turns out having `pwd` (which TEST_DIRECTORY defaults to) print $PWD
> with a trailing slash isn't very difficult, in my case it went somethin=
g
> like
>
>   ; tmux new-window -c ~/src/git/t/
>   [in the new window]
>   ; sh ./t0000-basic.sh
>   PANIC: Running in a /home/stepnem/src/git/t/ that doesn't end in '/t'=
?
>   ; pwd
>   /home/stepnem/src/git/t/
>
> (tmux(1) apparently sets PWD in the environment in addition to calling
> chdir(2), which seems enough to make at least some shells preserve the
> trailing slash in `pwd` output.)
>
> Strip the trailing slash, if present, to prevent bailing out with the
> PANIC message in such cases.
>
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
> ---
>  t/test-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1656c9eed006..3b6f1a17e349 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -35,6 +35,7 @@ else
>  	# needing to exist.
>  	TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) || exit 1
>  fi
> +TEST_DIRECTORY=3D"${TEST_DIRECTORY%/}"
>  if test -z "$TEST_OUTPUT_DIRECTORY"
>  then
>  	# Similarly, override this to store the test-results subdir
>
> base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415

While this would certainly squelch the particular test on TEST_DIRECTORY
I am not sure if a safer fix would be to fix your PWD when it has a
trailing slash.  Your tests with this patch may be taking unintended
branch when they do something like

	if test "$TRASH_DIRECTORY" =3D "$(pwd)"
	then
		...
	fi

as TRASH_DIRECTORY, whose default is derived from TEST_DIRECTORY and
thanks to your fix it now does not have an extra slash in it, does
not have a trailing slash but your $(pwd) or $PWD would have the
trailing slash, simply because the patch only fixes TEST_DIRECTORY
without fixing PWD.

I wonder if this would be a safer alternative, or is it doing too
much more than what is necessary?

 t/test-lib.sh | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index 1656c9eed0..6ec42eab0d 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -22,19 +22,26 @@ then
 	# ensure that TEST_DIRECTORY is an absolute path so that it
 	# is valid even if the current working directory is changed
 	TEST_DIRECTORY=3D$(pwd)
-else
-	# The TEST_DIRECTORY will always be the path to the "t"
-	# directory in the git.git checkout. This is overridden by
-	# e.g. t/lib-subtest.sh, but only because its $(pwd) is
-	# different. Those tests still set "$TEST_DIRECTORY" to the
-	# same path.
-	#
-	# See use of "$GIT_BUILD_DIR" and "$TEST_DIRECTORY" below for
-	# hard assumptions about "$GIT_BUILD_DIR/t" existing and being
-	# the "$TEST_DIRECTORY", and e.g. "$TEST_DIRECTORY/helper"
-	# needing to exist.
-	TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
+
+# The TEST_DIRECTORY will always be the path to the "t"
+# directory in the git.git checkout. This is overridden by
+# e.g. t/lib-subtest.sh, but only because its $(pwd) is
+# different. Those tests still set "$TEST_DIRECTORY" to the
+# same path.
+#
+# See use of "$GIT_BUILD_DIR" and "$TEST_DIRECTORY" below for
+# hard assumptions about "$GIT_BUILD_DIR/t" existing and being
+# the "$TEST_DIRECTORY", and e.g. "$TEST_DIRECTORY/helper"
+# needing to exist.
+#
+# Also, apparently a shell spawned in some tricky way can be
+# talked into keeping a slash at the end of its $PWD.
+#
+# All of the above can be worked around by doing an extra chdir
+# and asking where we ended up to be.
+TEST_DIRECTORY=3D$(cd "$TEST_DIRECTORY/." && pwd) || exit 1
+
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then
 	# Similarly, override this to store the test-results subdir
