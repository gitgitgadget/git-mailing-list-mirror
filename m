Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB40DC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFCF60FBF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhKEVGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:06:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60066 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKEVGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:06:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46132153B70;
        Fri,  5 Nov 2021 17:03:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ShWDtRryCOZpISenNr27Qc0iY7uMsd04j7Zcn+
        YZ8+Q=; b=mQTPIjJmxMB8zu1oPoPzwybqJ5yGhrybaO3Ravq41jjBhqMVnw6Kwc
        cIJ1qQBWJ6lLT+7LIIgiolPZbOGeRwzZgS0CSJ4f7RcC5ody/5ScqRZHh1dxH/1G
        iy9Q4TM9HGDMwXi0rS2NrwqO0VbKS6tbuIQ7Dn/o2PPhyDsMR5pHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FA2A153B6F;
        Fri,  5 Nov 2021 17:03:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3769153B6E;
        Fri,  5 Nov 2021 17:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <20211105193106.3195-1-adam@dinwoodie.org>
Date:   Fri, 05 Nov 2021 14:03:47 -0700
In-Reply-To: <20211105193106.3195-1-adam@dinwoodie.org> (Adam Dinwoodie's
        message of "Fri, 5 Nov 2021 19:31:06 +0000")
Message-ID: <xmqqk0hmwc0c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF45F506-3E7B-11EC-AB8E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> As well as checking that the relevant functionality is available, the
> GPGSSH prerequisite check creates the SSH keys that are used by the test
> functions it gates.  If these keys are created in a directory that
> has a default Access Control List, the key files can inherit those
> permissions.
>
> This can result in a scenario where the private keys are created
> successfully, so the prerequisite check passes and the tests are run,
> but the key files have permissions that are too permissive, meaning
> OpenSSH will refuse to load them and the tests will fail.

That may indicate that "private keys are created successfully" is a
bit too optimistic.  A key that did not exist but now exists indeed
was created, but if it cannot be used in tests, calling it
"successfully created" is a bit too charitable, I would say.

    ... where the private keys appear to have been created
    successfully, but at the runtime OpenSSH will refuse to load
    these keys due to permissions that are too loose.  In other
    words, the keys created here are not usable. Yet the lazy_prereq
    is set, pretending all is well, and makes the real tests fail.

And when described that way, we'd realize that "setfacl -k" solution
may be closing one known way that a key, that seemingly was created
successfully, can be unusable in real tests, but it is not
addressing the root cause of the breakage you observed---the
lazy_prereq is not set based on what really matters, i.e. is the key
usable to sign and verify?

> To avoid this happening, before creating the keys, clear any default ACL

"happening" -> "from happening"

> set on the directory that will contain them.  This step allowed to fail;

"allowed" -> "is allowed".

> if setfacl isn't present, that's a very likely indicator that the
> filesystem in question simply doesn't support default ACLs.

True.  Or setfacl command fails to futz with the ACL for whatever
reason, in which case you may still have the "we 'successfully'
created a key, but it turns out that it was unusable in real tests"
problem.  As long as the lazy_prereq is not set to pretend that all
is well, we won't see test breakage noise that distracts those who
are watching for breakage due to "git".  And that is why we want to
add "is the key really usable" check before the lazy_prereq declares
a success.

> Helped-by: Fabian Stelzer <fs@gigacodes.de>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>  t/lib-gpg.sh | 1 +
>  1 file changed, 1 insertion(+)

Other than that, the above explanation reads well.

Thanks.

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
