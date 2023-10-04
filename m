Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F9E7C4E1
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbjJDQTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbjJDQTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 12:19:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56110F
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 09:19:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 604E33179A;
        Wed,  4 Oct 2023 12:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cX7nQtLAatSA
        V8uSO38cVNQjuNpPf6Lt0ddkeLzlTlg=; b=UoNA+k+VdVSRbm8T2Y1itgZ+8jle
        xnZ21r5JU1SaLl8ctBA/CK+ai0USWRBSQtze10Yi6LDvhMzb7OeRhkwM6mUl/OTH
        jlvEKiHdPlzv+39wc6JbHkPBHpyublG5j7t6mKRlpuTvGNH9iF5fzzxvalSVs3R6
        COleb8hwAaATeic=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5889C31799;
        Wed,  4 Oct 2023 12:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E523F31798;
        Wed,  4 Oct 2023 12:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <20231004113413+0200.161419-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Wed, 04 Oct 2023 11:34:13 +0200")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
        <20231004113413+0200.161419-stepnem@smrk.net>
Date:   Wed, 04 Oct 2023 09:19:40 -0700
Message-ID: <xmqqbkdes6lf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2CEFAF8-62D1-11EE-9E18-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> Yes, actually, AFAICT just $(cd . && pwd) fixes things (and saves a few
> syscalls), and I agree this is a much better approach than my naive fix=
.

Actually I was still being silly.  We sometimes do

	val=3D$(cd there && do something there)

so that we can get the output from a command in a different
directory _without_ having to move our current directory.  But the
point of this current topic is that we _need_ to convince the shell
that the path to our current directory is a canonical one without
trailing slash, so my silly 'cd "$(pwd)/."' (or your "cd .") should
be done outside the command expansion, or the canonicalized $PWD will
only appear inside the $() and the next reference to $(pwd) or $PWD
in the test script will still give the path with the trailing slash,
that is textually different from $TEST_DIRECTORY.

I wonder if this works better for you.  We would be sure that $PWD
and $TEST_DIRECTORY (when the latter is not imported from the
environment) are the same, so "your cwd that does not end with /t
and has a trailing slash after it" would be gone.  Any $PWD or $(pwd)
the tests refer to later in the step will also lack the unwanted
trailing slash.   As long as "cd ." is sufficient to cause the shell
reexamine and canonicalize the $PWD, that is.

Thanks.

 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/t/test-lib.sh w/t/test-lib.sh
index 1656c9eed0..a7045e028c 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -19,6 +19,11 @@
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
 then
+	# It is reported that some shells spawned in tricky ways can
+	# give $PWD with a trailing slash. An explicit chdir hopefully
+	# would wake them out of their hallucination.
+	cd .
+
 	# ensure that TEST_DIRECTORY is an absolute path so that it
 	# is valid even if the current working directory is changed
 	TEST_DIRECTORY=3D$(pwd)
@@ -626,7 +631,6 @@ fi
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-
 unset GREP_OPTIONS
 unset UNZIP
=20
