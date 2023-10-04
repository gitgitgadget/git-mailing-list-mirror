Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A998E7B5E0
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbjJDJe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjJDJe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 05:34:27 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D3BB
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696412054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4eMHxd7UApbbuY/az3wsfVDBcWkM1aBmYgGV6R8U3I=;
        b=O5hwjDKWnnJ+c1EYZjQ4V/skvZXJF916jXQtoLTUe+ZX9SdjRYcdZwDs5KoTKbyVQK5GtE
        /5sA0LAG6KZk04BirTI1P73sJ3Jk9yFs7G19SffhFVpCnDBFzh5ktknV6cFLCEnEuwgJbI
        JWMRpsb6XxC8k+QuMKrCkRHLqYQOKtnjp7DqoTf0rhLdvwA+PdURUYm0GKPwZvlHb+EXi4
        2X3nnMrkgKHnmUtuAbiu8m+xWzdwQwTLhJSf58yhP2zFGiBt9fZOSqo3iZN4wyUa8bDENh
        O0oie9Rw1TAL9iyQPzSZc/v0TFW02iEDB3d9gczsra+gqkjIPUBphYKigqjSig==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 23611a1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Oct 2023 11:34:14 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make sure TEST_DIRECTORY has no trailing slash
In-Reply-To: <xmqqjzs3wer0.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        03 Oct 2023 14:57:39 -0700")
References: <20231003082323.3002663-1-stepnem@smrk.net>
        <xmqqwmw3wgeo.fsf@gitster.g> <xmqqjzs3wer0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Wed, 04 Oct 2023 11:34:13 +0200
Message-ID: <20231004113413+0200.161419-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 03 Oct 2023 14:57:39 -0700
Junio C. Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I wonder if this would be a safer alternative, or is it doing too
>> much more than what is necessary?
>
> An alternative with much smaller blast radius would be to do this.
>
> Hopefully, by going "$(pwd)/." before asking the value returned by
> the `pwd` command, we can make sure that the trailing slash is
> removed (or at least $(pwd) and $TEST_DIRECTORY should be identical
> after this is done).
>
>
>
>  t/test-lib.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git c/t/test-lib.sh w/t/test-lib.sh
> index 1656c9eed0..d159358b21 100644
> --- c/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -19,9 +19,13 @@
>  # t/ subdirectory and are run in 'trash directory' subdirectory.
>  if test -z "$TEST_DIRECTORY"
>  then
> -	# ensure that TEST_DIRECTORY is an absolute path so that it
> +	# Ensure that TEST_DIRECTORY is an absolute path so that it
>  	# is valid even if the current working directory is changed
> -	TEST_DIRECTORY=3D$(pwd)
> +	# Some environments can talk the shell into keeping trailing
> +	# slash in $PWD---go there and ask where we are to work it
> +	# around, as we expect TEST_DIRECTORY and PWD are both
> +	# canonical and can textually be compared for equality
> +	TEST_DIRECTORY=3D$(cd "$(pwd)/." && pwd)
>  else
>  	# The TEST_DIRECTORY will always be the path to the "t"
>  	# directory in the git.git checkout. This is overridden by

Yes, actually, AFAICT just $(cd . && pwd) fixes things (and saves a few
syscalls), and I agree this is a much better approach than my naive fix.

And functionally it should be equivalent to your other solution that did
this unconditionally, because the else branch (TEST_DIRECTORY set) was
already cd-ing anyway.

Thanks,

  =C5=A0t=C4=9Bp=C3=A1n
