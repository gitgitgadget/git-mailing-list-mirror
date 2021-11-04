Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B6C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3666112D
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhKDTwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:52:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhKDTwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 15:52:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58E2316E8ED;
        Thu,  4 Nov 2021 15:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8e/MhHMk/1J4hk2L0+4GVwMBtd/yyACwmqrf8q
        D7jRA=; b=sDYzpvW128Y3FiUmX6xD+PHGCBo9Nrk8a1eOj+S8EKPpyf/JRM1Wmb
        HHJR71NdlUALitwaLjIFWoIe7i1A2I4Gb5qK9djOOV+jD+TM3zMTt3L6+Otp21nn
        a5o26rGSN2cmofav2XbXHqtqu6+lkdHUMLjHOUCBYwRvstUv1NVRk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5163F16E8EC;
        Thu,  4 Nov 2021 15:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FC3E16E8EB;
        Thu,  4 Nov 2021 15:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
Date:   Thu, 04 Nov 2021 12:49:50 -0700
In-Reply-To: <20211104192533.2520-1-adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Thu, 4 Nov 2021 19:25:33 +0000")
Message-ID: <xmqq7ddn3dlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60484DAE-3DA8-11EC-8413-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> SSH keys are expected to be created with very restrictive permissions,
> and SSH commands will fail if the permissions are not appropriate.  When
> creating a directory for SSH keys in test scripts, attempt to clear any
> ACLs that might otherwise cause the private key to inherit less
> restrictive permissions than it requires.

All of the above makes sense as an explanation as to why the
ssh-keygen command may be unhappy with the $GNUPGHOME directory that
is prepared here, but ...

> This change is required in particular to avoid tests relating to SSH
> signing failing in Cygwin.

... I am not quite sure how this explains "tests relating to ssh
signing failing on Cygwin".  After all, this piece of code is
lazy_prereq, which means that ssh-keygen in this block that fails
(due to a less restrictive permissions) would merely mean that tests
that are protected with GPGSSH prerequisite will be skipped without
causing test failures.  After all that is the whole point of
computing prereq on the fly.

> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> Helped-by: Fabian Stelzer <fs@gigacodes.de>

Please order these chronologically, i.e. Fabian helped and the patch
was finished, and finally you sent with your sign off.

> ---
>  t/lib-gpg.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index f99ef3e859..1d8e5b5b7e 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -106,6 +106,7 @@ test_lazy_prereq GPGSSH '
>  	test $? = 0 || exit 1;
>  	mkdir -p "${GNUPGHOME}" &&
>  	chmod 0700 "${GNUPGHOME}" &&
> +	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
>  	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
>  	echo "\"principal with number 1\" $(cat "${GPGSSH_KEY_PRIMARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&

There are other uses of ssh-keygen in the real tests but presumably
they just use the GNUPGHOME directory prepared with this lazy_prereq
block, and "setfacl -k" here would have wiped any possible loosening
of permission, and that is why this is the only place that needs a
change, right?  That fact might deserve recording in the proposed
log message.

Thanks.
